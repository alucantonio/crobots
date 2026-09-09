# hulk_25 — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 1 of 24**, total 64.17 % won
(best in every format: F2F 82.99 %, 3v3 63.15 %, 4v4 46.36 %)
**Author:** Franco Cartieri
**Class:** Midi (header: *999 istruzioni* — right at the 1000-instruction ceiling)
**Lineage:** stated in the header as "a refinement — or degradation — of Hulk_20" (`robots/2020/hulk_20.r`)
**Local file:** `robots/2025/hulk_25.r` (219 lines)

## Core idea

hulk_25 is a **pure head-to-head weapon**: it has *no* multi-robot defensive phase at all. It
assumes an opponent, heads straight at the "final attack", and never calls `damage()`.
Its entire behavior is one state machine with two motion modes (far → square patrol,
near → oscillation) and two firing routines (slow/precise vs. fast/coarse).
Fitting that whole arsenal into a **Midi-sized** program is why it wins F2F so convincingly:
small, reactive, always firing.

## State machine

```
spawn ──► pick opposite corner by quadrant ──► drive there (210/300/120/30)
  │
  └─► while(1):
        if last-known target is far (orng > 425 or lost)
            ► patrol the CENTRAL SQUARE  x∈[300,700], y∈[300,700]
              (drive 180 → 270 → 0 → 90 in sequence, bailing on each leg
               as soon as a target is acquired)
        else (target near, orng ≤ 425)
            ► OSCILLATION: weave ±105° around the last target bearing
              ► if against a wall (x/y > 850 or < 150) run along the wall
            ► fire with Spacca() TWICE per tick ("faster fire routine")
```

Quadrant → opposite-corner choice (line 20-33):

```c
main()
{
  if (loc_y(x = (loc_x() > 500)) > 500)
  {
    if (x)  Spacca(dir = deg = 210);   /* NE quadrant  -> SW corner */
    else    Spacca(dir = deg = 300);   /* SE quadrant  -> NW corner */
  }
  else
  {
    if (x)  Spacca(dir = deg = 120);   /* NW quadrant  -> SE corner */
    else    Spacca(dir = deg = 30);    /* SW quadrant  -> NE corner */
  }
  Rompi();
```

Central-square patrol (lines 37-59) — note the pattern: drive one leg of the square;
`Vai()` aborts the leg the instant the last-known target is lost or beyond 425 m:

```c
    if (orng > 425)
    {
      Spacca(dir = 180);
      while (Vai(loc_x() > 300))
        ;
      if (!orng || (orng > 425))
      {
        Spacca(dir = 270);
        while (Vai(loc_y() > 300))
          ;
```

```c
Vai(c)
{
  if (c && ((!orng || orng > 425)))
  {
    Rompi();
    return 1;
  }
  else
    return 0;
}
```

Near-range oscillation (lines 63-74): the heading alternates two bearings 210° apart
around the last target angle `deg` — a weaving "figure-eight" that stays inside cannon
range while keeping the target in front:

```c
      else
        dir = deg + 75 + (b ^= 1) * 210;
      Spacca();
      Spacca();
```

## Firing routines

**`Rompi()` — slow & precise** (used when the target is far). Coarse chase → ±17 probe →
bisection refinement (`Affina()`, repeated) → the full lead shot:

```c
  if ((orng = Affina()))
  {
    if ((rng = Affina(odeg = deg)))
      return cannon(deg + (deg - odeg) * ((1200 + rng) >> 9) - (sin(deg - dir) >> 14), rng * 192 / (192 + orng - rng - (cos(deg - dir) >> 12)));
```

**`Spacca()` — fast & coarse** (used when the target is close, called twice per tick).
One refinement pass and a "shrink shot": fire *shorter than the target* because a
closing target will meet the missile early:

```c
  if ((rng = scan(deg, 10)))
    cannon(deg, rng * 145 / (145 + orng - rng));
```

**Bisection refinement** (`Affina()`) — successive halving inside the 10° scan cone:

```c
Affina()
{
  if (scan(deg + 13, 10))  deg += 4;
  if (scan(deg - 13, 10))  deg -= 4;
  if (scan(deg + 12, 10))  deg += 2;
  if (scan(deg - 12, 10))  deg -= 2;
  if (scan(deg + 10, 10))  ++deg;
  if (scan(deg - 10, 10))  --deg;
  return scan(deg, 10);
}
```

## Targeting model (the "Cartieri lead")

The lead prediction uses the *delta* between two consecutive observations
(`odeg/orng` = previous sighting, `deg/rng` = current):

- **Angle:** `deg + (deg - odeg) * ((1200 + rng) >> 9)` — extrapolate the target's angular
  motion, scaled roughly with range (longer flight → more lead), `≈ 2.3 + rng/512`.
- **Motion correction:** `- (sin(deg - dir) >> 14)` — largest when the target's bearing is
  perpendicular to own velocity, i.e. when own motion changes the apparent angle most.
- **Range:** `rng * 192 / (192 + orng - rng - cos(deg - dir) >> 12)` — shrink the impact
  point when the target *closes* (`orng > rng`) and when it moves toward own heading.

The same model powers its siblings [ironman_25](ironman_25.md) (F2F phase) and
[thor_25](thor_25.md) (F2F phase), and shows up in [jedi15](jedi15.md)'s `fire()` —
the 2025 pool literally converged on this lead shot.

## Target-acquisition pattern

Every firing routine uses the same "last look first" chase, a 4-cone sweep around the
last known angle, then progressively wider steps:

```c
  drive(dir, 100);
  if (scan(deg, 10))
    ;
  else if (scan(deg -= 21, 10))
    ;
  else if (scan(deg += 42, 10))
    ;
  else if (scan(deg += 21, 10))
    ;
  else
    return Ritrova();
```

`Ritrova()` is the lost-target recovery: fixed *relative* steps (-84, -21, +126, +21, -168)
that, combined with the next iteration's `deg += 264`, guarantee full-circle coverage in a
bounded number of scans:

```c
Ritrova()
{
  if ((orng = scan(deg -= 84, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg -= 21, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg += 126, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg += 21, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg -= 168, 10)))
    return cannon(deg, orng);
  else
    return deg += 264;
}
```

## Notable traits

- **No `damage()` calls at all** — pure scan-driven reaction; saves code budget and
  never "reacts to being hurt" (it only changes behavior when its target tracking
  changes, which is what actually correlates with survival in F2F).
- **999 instructions**: the whole strategy is budgeted to one instruction under the
  Midi ceiling — hulk_25 is effectively an engine distilled until it fits.
- Because it skips defensive phases, it *suffers* in 4v4 (46.36 %) versus F2F (82.99 %) —
  the spread across formats is the signature of a duelist.

## How to test locally

```sh
./crobots -c robots/2025/hulk_25.r            # expect: compiled, code utilization ~99 %
./crobots -m200 robots/2025/hulk_25.r robots/2015/coppi15md1.r   # vs. the all-time classic champ
./crobots -m200 robots/2025/hulk_25.r robots/2025/jedi15.r       # top-1 vs. top-3
```
