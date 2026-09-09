# ironman_25 — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 2 of 24**, total 59.30 % won
(F2F 80.16 %, 3v3 56.22 %, 4v4 41.52 %)
**Author:** Franco Cartieri
**Class:** Macro (header: *1993 istruzioni* — the largest code budget of the eight)
**Local file:** `robots/2025/ironman_25.r` (450 lines)

## Core idea

ironman_25 is a **three-phase state machine**: a corner-triangle *defensive patrol* for
multi-robot matches (the Coppi school), with a hard trigger into the **Hulk F2F engine**
(verbatim shared with its siblings) once the field has thinned to one opponent.
The header says it all:

> *"At the start it positions in the nearest corner and moves along two triangles drawn on
> the two sides of the corner. If one of the two adjacent corners is free, the movement
> becomes asymmetric toward it. If both adjacent corners are occupied, or after more than
> 10 cycles, the movement becomes symmetric. After 25 cycles it starts the Hulk final
> attack anyway. Each cycle it checks the number of opponents; if only one remains, it
> starts the final attack."*

The budget story is the mirror image of [hulk_25](hulk_25.md): where hulk_25 *is* the
engine (999 instructions, Midi), ironman_25 spends its Macro budget on a defensive
front end that hands off to exactly the same engine.

## Phase diagram

```
main ──► initial full-circle sweep (21° steps), firing at anything found
  │        (the moment a target has been seen TWICE: e > 1  ──►  phase 2)
  ▼
Phase 2: corner-triangle patrol (near its home corner)
  │        each cycle: Look() probes toward the two adjacent corners →
  │        triangle offsets bias toward the free one (asymmetric),
  │        symmetric after nc ≥ 10
  │        Radar() counts enemies on the corner arc every cycle
  │
  ├── enemies < 2  ──────────────────────────┐
  ├── nc > 25  ──────────────────────────────┤   phase 3
  └── damage() > 75 ─────────────────────────┘   (F2F engine)

Phase 3: F2f() — the Hulk engine, identical to hulk_25's main loop
```

## Phase 1 — opening sweep

A 21°-step full-circle scan (17 cones cover 360°), firing on first contact; the `e`
counter is what promotes to phase 2:

```c
main()
{
  while (deg < 360)
  {
    if (rng = scan(deg += 21, 10))
    {
      cannon(deg, rng);
      if ((++e) > 1)
      {
        ...
```

## Phase 2 — the two triangles

All movement is decomposed into axis leg-drivers — "run along this axis until the
distance threshold, while firing; then stop and settle" — parameterized by target
distance, heading, and a *testf2f* flag (whether to do the enemy-counting Radar after
the leg):

```c
Ymin(dis, dir, testf2f)
{
  while (loc_y() < dis)
    Spara(dir);
  Stop(dir, testf2f);
}

Xmax(dis, dir, testf2f)
{
  while (loc_x() > dis)
    Spara(dir);
  Stop(dir, testf2f);
}
```

The patrol loop (main, lines 47-98) alternates two offset sets via `t % 2` — the
**asymmetric triangle** (offsets 325/675, biased toward the free adjacent corner found
by `Look()`) and the **symmetric one** (825/175). `xmd/ymd` are the inner triangle
vertices, `xdr/ydr` the outer:

```c
          if ((nc += 1) < 10)
          {
            if (t % 2)
            {
              if (!Look(xd))
                t += 1;
            }
            else
            {
              if (!Look(yd))
                t += 1;
            }
          }
          else
          {
            t += 1;
            if ((nc > 25) || (damage() > 75))
              F2f();
          }
```

`Look()` is the corner occupancy probe — a ±10° double cone around the adjacent
corner's bearing:

```c
Look(d) { return (scan(d - 10, 10) + scan(d + 10, 10)); }
```

and `Radar()` is the enemy counter over the 80° corner arc (`dmin..dmax`), the trigger
for the F2F hand-off:

```c
Radar()
{
  int ang, en;
  ang = dmin;
  while (ang <= dmax)
    en += (scan(ang += 20, 10) > 0);
  if (en < 2)
    F2f();
}
```

`Stop()` shows a habit the sibling robots disagree on: here it *waits out the coast*
after braking (`jedi15`'s `stop()` has the exact same line **commented out**):

```c
Stop(dir, testf2f)
{
  drive(dir, 0);
  if (testf2f)
    Radar();
  else
    while (speed() > 59)
      ;
}
```

## Phase 3 — the F2F engine

`F2f()` is line-for-line the same engine [hulk_25](hulk_25.md) runs from spawn:
quadrant → opposite corner (`210/300/120/30`), central-square patrol while the target
is beyond 425 m, oscillation + *double firing* (`Raggio(); Raggio();`) up close.
The routines are renamed siblings of hulk_25's: `Missile() ≡ Rompi()`,
`Raggio() ≡ Spacca()`, `Affina()` and `Ritrova()` identical.

## The two firing models

**Patrol-phase shot `Spara()`** — and here ironman_25 switches to the *other* family of
lead models, the Tobey-family (shared with [kerberos](kerberos.md) and
[hal9025](hal9025.md); cf. `robots/2007/tobey.r`):

```c
    asin = (sin(deg - dir) / 14384);
    acos = (cos(deg - dir) / 3796) - 230;
    ...
      cannon(deg + (deg - odeg) * ((880 + (rng = scan(deg, 10))) / 482) - asin, rng * 230 / (orng - rng - acos));
```

- angle lead: `(deg - odeg) * (880 + rng) / 482` (≈ 1.8+ range-scaled) minus
  `sin(Δ)/1.64°` own-motion term;
- range: `rng * 230 / (orng - rng - acos)` — shrink when closing, *overshoot* when the
  target is fleeing.

**Recovery `Cerca()/Raffica()`** — a 7-step relative sweep (−350, −20, −320, −60, −280,
−100, −240), then the "one-step doubling" shot (same model as
[wall-e_vii](wall-e_vii.md)'s `fire2`):

```c
    return cannon(deg + (deg - odeg), 2 * scan(deg, 10) - rng);
```

**F2F-phase shots** — the Cartieri lead (`((1200+rng)>>9)` angle extrapolation + 192-shrink)
and the 145-shrink fast shot, identical to hulk_25 — see that file for a full explanation.

## Notable traits

- **Deliberate multi-robot awareness**: it is the only one of the three Cartieri robots
  with an explicit enemy-counting routine (`Radar`) and cycle counters (`nc`, `t`).
- **Two different lead models in one robot** — Tobey-family while patrolling,
  Cartieri-family in F2F. The best of both schools in a single program.
- The 245-line "engine" overlap with hulk_25/thor_25 is a strong hint that the 2025
  Cartieri entrants were developed from a common kernel; ironman_25 is the most
  complete of the family.
- **Damage as a trigger, not a state**: `damage() > 75` force-commits to F2F (the
  "enough is enough" clause), the only hard damage use among the three.

## How to test locally

```sh
./crobots -c robots/2025/ironman_25.r
./crobots -m200 robots/2025/ironman_25.r robots/2025/hulk_25.r robots/2025/jedi15.r   # real 3v3
./crobots -m100 robots/2025/ironman_25.r robots/2020/coppi20ma2.r                     # vs. 2020 macro champion
```
