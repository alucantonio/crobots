#!/usr/bin/env python3
"""Scorecard for benchmark traces: blue.r (robot 1) vs one opponent (robot 2)."""
import csv, glob, os, sys

prefix = sys.argv[1] if len(sys.argv) > 1 else 'traces/bench_*'
files = sorted(glob.glob(prefix + '_events.csv'))

print(f"{'opponent':<12} {'result':<7} {'blue dmg (avg/max)':<21} {'opp dmg (avg/max)':<20} {'shots b/o':<13} {'match steps'}")
print("-" * 90)
tots = {'bw': 0, 'm': 0, 'bsteps': 0}
for f in files:
    opp = os.path.basename(f).replace('_events.csv', '')
    if opp.startswith('bench_'):
        opp = opp[6:]
    n, blue_w, permatch_b, permatch_o = 0, 0, [], []
    shots = {1: 0, 2: 0}
    cur, mb, mo = 0, 0.0, 0.0
    dead_b = dead_o = None  # final clamped damage of a dead robot (blue/opponent)
    msteps = []
    with open(f) as fh:
        r = csv.reader(fh)
        next(r)
        for row in r:
            m, step, kind = int(row[0]), int(row[1]), row[2]
            if m != cur:
                cur = m
                n += 1
                mb = mo = 0.0
                dead_b = dead_o = None
            if kind == 'damage':
                if row[4] == '1':
                    mb += float(row[5])
                else:
                    mo += float(row[5])
            elif kind == 'fire':
                shots[int(row[3])] = shots.get(int(row[3]), 0) + 1
            elif kind == 'death':
                # trace.c's if/else swallows the fatal hit's delta into the
                # death event: detail = final clamped damage of the victim
                if row[4] == '1':
                    dead_b = float(row[5])
                else:
                    blue_w += 1
                    dead_o = float(row[5])
                msteps.append(step)
            elif kind == 'match_end':
                permatch_b.append(dead_b if dead_b is not None else mb)
                permatch_o.append(dead_o if dead_o is not None else mo)
    if not n:
        continue
    ba, bm = (sum(permatch_b) / len(permatch_b), max(permatch_b))
    oa, om = (sum(permatch_o) / len(permatch_o), max(permatch_o))
    avgst = sum(msteps) / len(msteps) if msteps else 0
    print(f"{opp:<12} {blue_w}-{n-blue_w:<5} {ba:8.1f} / {bm:4.0f}       "
          f"{oa:8.1f} / {om:4.0f}      {shots.get(1,0):4d}/{shots.get(2,0):4d}     {avgst:8.0f}")
    tots['bw'] += blue_w
    tots['m'] += n
print("-" * 90)
print(f"blue.r overall: {tots['bw']}/{tots['m']} wins ({tots['bw']/tots['m']*100:.0f}%)")
