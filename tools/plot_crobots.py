#!/usr/bin/env python3
"""plot_crobots.py - render each robot's trajectory from a traced CROBOTS match.

Usage:
    python3 plot_crobots.py [prefix] [match]

Reads  <prefix>_robots.csv   (default prefix: traces/cro)
Writes <prefix>_match<N>.png

The robot CSV (see src/trace.h) has columns
    match,step,id,name,x,y,heading,speed,damage,alive
where x,y are game units of ~1/100 meter.  One polyline is drawn per robot;
the start is marked, a red X marks the death spot, a green dot marks a
winner's final position.
"""

import csv
import os
import sys
import tempfile

# point matplotlib's config/cache at a writable dir before importing it
os.environ["MPLCONFIGDIR"] = os.path.join(tempfile.gettempdir(), "mpl_config")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

SCALE = 100.0  # game units per meter


def read_table(path):
    with open(path, newline="") as f:
        r = csv.reader(f)
        header = next(r)
        return [dict(zip(header, row)) for row in r]


def series_for(rows, matchno, ids):
    """Per-robot ordered list of (x_m, y_m, alive) for the given match."""
    out = {i: [] for i in ids}
    for row in rows:
        if row["match"] != str(matchno):
            continue
        i = int(row["id"])
        if i not in out:
            continue
        out[i].append((
            float(row["x"]) / SCALE,
            float(row["y"]) / SCALE,
            row["alive"] == "1",
        ))
    return out


def main():
    prefix = sys.argv[1] if len(sys.argv) > 1 else "traces/cro"
    matchno = int(sys.argv[2]) if len(sys.argv) > 2 else 1

    rows = read_table(prefix + "_robots.csv")
    names = {
        int(r["id"]): r["name"].rsplit("/", 1)[-1]
        for r in rows if r["match"] == str(matchno)
    }
    if not names:
        sys.exit(f"no rows for match {matchno} in {prefix}_robots.csv")

    series = series_for(rows, matchno, names)
    colors = [
        plt.cm.tab10(i % 10) for i in sorted(names)
    ]
    color = {i: c for i, c in zip(sorted(names), colors)}

    fig, ax = plt.subplots(figsize=(8, 8), dpi=110)
    for i in sorted(names):
        pts = series[i]
        if not pts:
            continue
        xs = [p[0] for p in pts]
        ys = [p[1] for p in pts]
        c = color[i]
        if len(pts) > 1:
            ax.plot(xs, ys, color=c, lw=1.3, alpha=0.85, zorder=2)
        # start
        ax.plot(xs[0], ys[0], "o", color=c, ms=9, zorder=4,
                markeredgecolor="black", markeredgewidth=0.6)
        # outcome
        if pts[-1][2]:
            ax.plot(xs[-1], ys[-1], "o", mfc="none", mec="lime",
                    ms=14, mew=2, zorder=3)
        else:
            dead = next((p for p in pts if not p[2]), pts[-1])
            ax.plot(dead[0], dead[1], marker="X", ms=14,
                    mec="red", mew=2.2, zorder=5)
        ax.annotate(names[i], (xs[0], ys[0]), textcoords="offset points",
                    xytext=(8, -14), color=c, fontweight="bold", zorder=6)
        ax.plot([], [], color=c, lw=2, label=f"{names[i]} (robot {i})")

    # padded bounds
    allx = [p[0] for pts in series.values() for p in pts]
    ally = [p[1] for pts in series.values() for p in pts]
    padx = (max(allx) - min(allx)) * 0.06 or 5.0
    pady = (max(ally) - min(ally)) * 0.06 or 5.0
    ax.set_xlim(min(allx) - padx, max(allx) + padx)
    ax.set_ylim(min(ally) - pady, max(ally) + pady)

    # symbol key, appended to the robot legend
    ax.plot([], [], "o", color="0.55", ms=9,
            markeredgecolor="black", markeredgewidth=0.6,
            label="start position")
    ax.plot([], [], "o", mfc="none", mec="lime", ms=13, mew=2,
            label="final position (survivor)")
    ax.plot([], [], marker="X", ms=13, mec="red", mew=2.2,
            label="destruction point")

    ax.set_aspect("equal")
    ax.grid(True, alpha=0.35)
    ax.set_xlabel("x (m)")
    ax.set_ylabel("y (m)")
    ax.set_title(f"CROBOTS trajectories - match {matchno} "
                 f"(from {os.path.basename(prefix)}_robots.csv)")
    ax.legend(loc="upper left", framealpha=0.9)

    out = f"{prefix}_match{matchno}.png"
    fig.tight_layout()
    fig.savefig(out)
    # per-robot summary line
    for i in sorted(names):
        pts = series[i]
        end = "survived" if pts and pts[-1][2] else "destroyed"
        print(f"  robot {i} {names[i]:<12} steps={len(pts):>5}  {end}")
    print(f"saved: {out}")


if __name__ == "__main__":
    main()
