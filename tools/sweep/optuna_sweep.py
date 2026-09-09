#!/usr/bin/env python3
"""Optuna sweep of hulk_25 Tier-1 shot-model hyperparameters — plain interval sampling.

Per the design constraint: NO seeding from previous results and NO caching of
attempts.  TPE proposes parameter points over the suggest_int intervals,
adapting from the observations collected inside the run itself (the usual
random-startup phase first); nothing is persisted between runs.

Each evaluation: manifest-anchored substitution -> variant file -> compile gate
("compiled without errors" AND NOT "could not compile") -> N-match battle vs
each opponent, parsing the last wins line of robot (1) (name-agnostic: the
engine truncates long robot names).  Objective = mean (wins + ties/2)/N over
the 8 core pool siblings (N=1000 per pair by default); the HoF suite is
reported per trial as a generalization probe.  robots/ is never modified.
The reported per-trial scores are noisy (N=5000 per pair); judge finalists at
higher N.

Shared modules here: manifest.py (parameter patterns/values), sub.py (the
count-verified substitution).  This file is the only sweep tool left.

Usage:
    python3 tools/sweep/optuna_sweep.py [--trials 200] [--n 5000]
                                  [--jobs 12] [--cores 12] [--seed 25] [--test]
        --test   run acceptance tests (golden identity, compile gate, mutant,
                 dry-pair parse) and exit

Writes (no cache is kept or read; the history file is a record only and is
never fed back into sampling):
    tools/sweep/results/optuna_history.csv  (every tried parameter combo + objective)
    tools/sweep/results/optuna_results.csv  (top-15 table)
    tools/sweep/results/optuna_best.json
    tools/sweep/results/hulk_25_optuna.r    (best parameters substituted in)
"""
import argparse
import csv
import json
import os
import re
import subprocess
import sys
import time
import threading
from concurrent.futures import ProcessPoolExecutor

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import optuna
import optuna.logging

import manifest as M
import sub as S

ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
SY = os.path.join(ROOT, "crobots")                 # ./crobots build, run from repo root
RDIR = os.path.join(HERE, "results")
VDIR = os.path.join(HERE, "variants")

# Fitness: primary = 2025 pool siblings that compile in the LOCAL (1985 midi-class)
# compiler; reported = Hall-of-Fame generalization.  NOTE: ironman_25 (1993 instr),
# jedi15 (1248), thor_25 (1632) exceed the local 1000-instruction / function-table
# limits and cannot be hosted here (verified FAIL locally); the pool siblings that do
# compile are used instead.
CORE = ["robots/2025/%s.r" % n for n in (
    "gerty6", "wall-e_vii", "hal9025", "kerberos",
    "hydra", "meeseeks2", "rabbitc", "supremo")]
HOF = [
    "robots/2020/loneliness.r",
    "robots/2020/hulk_20.r",
    "robots/1999/dav46.r",
    "robots/2013/leopon.r",
    "robots/2015/coppi15md1.r",
    "robots/2020/hal9020.r",
]

# Intervals each parameter is sampled uniformly from.
SPACE = {
    "A1": (300, 550),        # far/near regime threshold
    "B1_off": (900, 1600),   # lead offset
    "B1_shift": (7, 11),     # lead shift  ((off+rng) >> shift)
    "B3": (120, 300),        # precise-shot shrink base
    "D1": (80, 250),         # fast-shot shrink base
}


def variant_id(values):
    d = dict(values)
    b1 = d.pop("B1")
    return "hulk25_A1%d_B1o%d_B1s%d_B3%d_D1%d" % (d["A1"], b1[0], b1[1], d["B3"], d["D1"])


def materialize(values, outdir):
    """substitute -> write variants/<id>.r -> compile gate. returns (path, ok, instr)."""
    src = open(os.path.join(ROOT, M.ORIGINAL), encoding="utf-8").read()
    text = S.substitute(src, values)
    vid = variant_id(values)
    path = os.path.join(outdir, vid + ".r")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(text)
    r = subprocess.run([SY, "-c", path], cwd=ROOT, input=b"", capture_output=True)
    out = (r.stdout + r.stderr).decode(errors="replace")
    ok = ("compiled without errors" in out) and ("could not compile" not in out)
    m = re.search(r"\((\d+)\s*/\s*1000\)", out)
    return path, ok, (int(m.group(1)) if m else None)


def battle_one(args):
    """(variant_rel, opp_rel, n) -> (opp, wins, ties)  robot (1) = the variant."""
    variant, opp, n = args
    r = subprocess.run(
        [SY, "-m%d" % n, os.path.join(ROOT, variant), os.path.join(ROOT, opp)],
        cwd=ROOT, input=b"", capture_output=True, timeout=1200)
    out = r.stdout.decode(errors="replace")
    mm = re.findall(r"\(\s*1\s*\)[^:]*:\s*wins=(\d+)\s+ties=(\d+)", out)
    if not mm:
        if "could not compile" in out or "Cannot play" in out:
            raise RuntimeError("opponent compile/play failure: %s vs %s\n%s" % (variant, opp, out[-400:]))
        raise RuntimeError("no robot-1 wins line: %s vs %s\n%s" % (variant, opp, out[-800:]))
    w, t = map(int, mm[-1])
    return opp, w, t


def battle_variant(variant_rel, n, cores):
    jobs = [(variant_rel, o, n) for o in CORE + HOF]
    res = {}
    with ProcessPoolExecutor(max_workers=cores) as pool:
        for opp, w, t in pool.map(battle_one, jobs):
            res[opp] = (w, t)

    def grp(paths):
        ws = sum(res[p][0] for p in paths)
        ts = sum(res[p][1] for p in paths)
        return (ws + 0.5 * ts) / (n * len(paths))
    return {"core": grp(CORE), "hof": grp(HOF), "detail": res}


def run_acceptance_test():
    vdir = VDIR
    src = open(os.path.join(ROOT, M.ORIGINAL), encoding="utf-8").read()
    # 1) golden: no overrides -> identical; CURRENT values -> byte-identical to the original
    assert S.substitute(src, {}) == src, "golden: empty substitution changed text"
    assert S.substitute(src, M.CURRENT) == src, "golden: CURRENT values != original bytes"
    # 2) compile gate on the original
    r = subprocess.run([SY, "-c", M.ORIGINAL], cwd=ROOT, input=b"", capture_output=True)
    out = (r.stdout + r.stderr).decode(errors="replace")
    assert "compiled without errors" in out, "compile gate failed on original"
    m = re.search(r"\((\d+)\s*/\s*1000\)", out)
    print("golden OK; original compiles at %s/1000 intr" % m.group(1))
    # 3) a mutant must still substitute & compile within budget
    vals = dict(M.CURRENT); vals["A1"] = 450
    text = S.substitute(src, vals)
    assert text != src and "orng > 450" in text
    p, ok, instr = materialize(vals, vdir)
    assert ok and instr is not None and instr <= 1000, "mutant failed compile gate"
    print("mutant A1=450 OK: %s at %s/1000" % (os.path.basename(p), instr))
    # 4) dry pair parse vs printed block
    r = subprocess.run([SY, "-m20", M.ORIGINAL, "src/rook.r"],
                       cwd=ROOT, input=b"", capture_output=True)
    out = r.stdout.decode(errors="replace")
    mm = re.findall(r"\(\s*1\s*\)[^:]*:\s*wins=(\d+)\s+ties=(\d+)", out)
    w, t = map(int, mm[-1])
    tail = out.strip().splitlines()[-1]
    print("dry pair hulk_25 vs rook N=20 -> parsed robot1 wins=%d ties=%d" % (w, t))
    print("printed final: %r" % tail)
    print("ACCEPTANCE: PASS")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--trials", type=int, default=200, help="number of trials")
    ap.add_argument("--n", type=int, default=5000, help="matches per pair")
    ap.add_argument("--jobs", type=int, default=12, help="parallel optuna trials")
    ap.add_argument("--cores", type=int, default=12, help="battle-pool workers per trial")
    ap.add_argument("--seed", type=int, default=25, help="RNG seed for the sampler")
    ap.add_argument("--test", action="store_true", help="run acceptance tests and exit")
    a = ap.parse_args()

    if a.test:
        os.makedirs(VDIR, exist_ok=True)
        run_acceptance_test()
        return

    os.makedirs(VDIR, exist_ok=True)
    src = open(os.path.join(ROOT, M.ORIGINAL), encoding="utf-8").read()

    study = optuna.create_study(
        study_name="hulk25_tier1_tpe",
        direction="maximize",
        sampler=optuna.samplers.TPESampler(seed=a.seed),
    )
    print("study %s created: TPESampler over intervals, no external seeds, no cache"
          % study.study_name, flush=True)

    scored = []        # in-memory only: (params, core, hof, instr)
    scored_lock = threading.Lock()

    def objective(trial):
        p = {
            "A1": trial.suggest_int("A1", *SPACE["A1"]),
            "B1_off": trial.suggest_int("B1_off", *SPACE["B1_off"]),
            "B1_shift": trial.suggest_int("B1_shift", *SPACE["B1_shift"]),
            "B3": trial.suggest_int("B3", *SPACE["B3"]),
            "D1": trial.suggest_int("D1", *SPACE["D1"]),
        }
        values = {"A1": p["A1"], "B1": (p["B1_off"], p["B1_shift"]),
                  "B3": p["B3"], "D1": p["D1"]}
        path, ok, instr = materialize(values, VDIR)
        if not ok:
            print("#%3d %s -> compile FAIL" % (trial.number, p), flush=True)
            return 0.0
        res = battle_variant(os.path.relpath(path, ROOT), a.n, a.cores)
        rec = (p, res["core"], res["hof"], instr)
        with scored_lock:
            scored.append(rec)
        print("#%3d A1=%-4d B1o=%-4d B1s=%-2d B3=%-3d D1=%-3d"
              " core=%.4f hof=%.4f (intr=%s)" %
              (trial.number, p["A1"], p["B1_off"], p["B1_shift"],
               p["B3"], p["D1"], res["core"], res["hof"], instr), flush=True)
        return res["core"]

    optuna.logging.set_verbosity(optuna.logging.WARNING)
    study.optimize(objective, n_trials=a.trials, n_jobs=a.jobs)

    # ---- finalize (in-memory scored list only) ----
    if not study.best_trial:
        print("no completed trials; nothing to report")
        return
    best = study.best_trial
    bp = best.params
    print("\nBEST: A1=%d B1o=%d B1s=%d B3=%d D1=%d  core=%.4f" %
          (bp["A1"], bp["B1_off"], bp["B1_shift"], bp["B3"], bp["D1"], best.value),
          flush=True)

    values = {"A1": bp["A1"], "B1": (bp["B1_off"], bp["B1_shift"]),
              "B3": bp["B3"], "D1": bp["D1"]}
    text = S.substitute(src, values)
    os.makedirs(RDIR, exist_ok=True)
    opt = os.path.join(RDIR, "hulk_25_optuna.r")
    with open(opt, "w", encoding="utf-8") as fh:
        fh.write(text)

    # full history: every attempted parameter combo with its objective value
    hof_by_key = {}
    for p, _c, h, _i in scored:
        hof_by_key[(p["A1"], p["B1_off"], p["B1_shift"], p["B3"], p["D1"])] = h
    with open(os.path.join(RDIR, "optuna_history.csv"), "w", newline="") as fh:
        wtr = csv.writer(fh)
        wtr.writerow(["trial", "state", "A1", "B1o", "B1s", "B3", "D1",
                      "objective_core", "hof"])
        for t in sorted(study.trials, key=lambda t: t.number):
            if not t.params:
                wtr.writerow([t.number, t.state.name])
                continue
            k = (t.params["A1"], t.params["B1_off"], t.params["B1_shift"],
                 t.params["B3"], t.params["D1"])
            wtr.writerow([t.number, t.state.name, k[0], k[1], k[2], k[3], k[4],
                          t.value, hof_by_key.get(k, "")])

    ranked = sorted(scored, key=lambda r: -r[1])[:15]
    with open(os.path.join(RDIR, "optuna_results.csv"), "w", newline="") as fh:
        wtr = csv.writer(fh)
        wtr.writerow(["A1", "B1o", "B1s", "B3", "D1", "core", "hof"])
        for p, core, hof, _instr in ranked:
            wtr.writerow([p["A1"], p["B1_off"], p["B1_shift"], p["B3"], p["D1"],
                          core, hof])

    best_rec = next((c, h) for p, c, h, _i in scored
                    if (p["A1"], p["B1_off"], p["B1_shift"], p["B3"], p["D1"]) ==
                    (bp["A1"], bp["B1_off"], bp["B1_shift"], bp["B3"], bp["D1"]))
    with open(os.path.join(RDIR, "optuna_best.json"), "w") as fh:
        json.dump({
            "values": {"A1": bp["A1"], "B1_off": bp["B1_off"],
                       "B1_shift": bp["B1_shift"], "B3": bp["B3"], "D1": bp["D1"]},
            "core_score": best_rec[0], "hof_score": best_rec[1],
            "n_per_pair": a.n, "trials": a.trials,
            "sampler": "TPESampler",
            "opt_file": "tools/sweep/results/hulk_25_optuna.r",
        }, fh, indent=2)

    print("top-10 by core:", flush=True)
    for p, core, hof, _i in ranked[:10]:
        print("  A1=%d B1o=%d B1s=%d B3=%d D1=%d  core=%.4f hof=%.4f" %
              (p["A1"], p["B1_off"], p["B1_shift"], p["B3"], p["D1"], core, hof),
              flush=True)
    print("wrote results/{optuna_history.csv,optuna_results.csv,optuna_best.json,"
          "hulk_25_optuna.r} (no cache)")


if __name__ == "__main__":
    main()
