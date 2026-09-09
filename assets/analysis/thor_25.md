# thor_25 — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 4 of 24**, total 56.37 % won
(F2F 79.30 %, 3v3 49.91 %, 4v4 39.90 %)
**Author:** Franco Cartieri
**Class:** Macro (header: *1632 istruzioni*)
**Local file:** `robots/2025/thor_25.r` (367 lines)

## Core idea

thor_25 is the middle child of the Cartieri 2025 trio: **Coppi's opening + Hulk's
finale**, in the author's own words:

> *"I took inspiration from Coppi's initial movement and Hulk's final attack. At the
> start of the match, if it's not F2F, it moves along the edges; after 7 laps, or if
> it's hit, it switches to the final attack."*

Compared with its siblings:

| robot | phase 1 (defensive) | phase 2 (attack) |
| --- | --- | --- |
| [hulk_25](hulk_25.md) | *none* — spawns straight into attack | Hulk engine |
| [thor_25](thor_25.md) | **border patrol** (Coppi-style, 75 px from walls) | Hulk engine |
| [ironman_25](ironman_25.md) | corner-triangle patrol (175-825 box) | Hulk engine |

The common *Hulk engine* — quadrant → opposite corner, central-square patrol when the
target is beyond 425 m, oscillation + double-firing up close, the
`((1200+rng)>>9)` lead shot and the `145` shrink shot — is analyzed in
[hulk_25.md](hulk_25.md); thor_25's phase 2 is line-for-line the same code
(rename map: `Fulmine ≡ Spacca`, `Martello ≡ Rompi`, `Vai` identical).

## Phase 1 — border patrol

### Opening sweep

Same 21° full-circle scan as ironman_25; the `e > 1` condition (target seen twice)
promotes to patrol — in F2F this fires on the first sighting and immediately goes to
the F2F engine. Even with the extra phase, thor_25 stays 4th in F2F (79.30 %), just
3.7 pt behind hulk_25 (82.99 %) and ~1 pt behind jedi15 (81.23 %) and ironman_25
(80.16 %).

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
```

### The four walls as a pipeline

Each edge is one function — *run along this edge while firing, then settle* — with the
Coppi-family margins (75 px short of the wall; `925/75`):

```c
Up()
{
  while (loc_y() < 925)
    Fuoco(90);
  Saetta(90);
}

Dn()
{
  while (loc_y() > 75)
    Fuoco(270);
  Saetta(270);
}

Dx()
{
  while (loc_x() < 925)
    Fuoco(0);
  Saetta(0);
}
```

The quadrant decides the *order* in which the four walls are visited (nested pipeline
calls, e.g. from the SW corner: `Dn(Sx(Up(Dx())))`), so the robot always starts on
the edge closest to its spawn corner and walks the perimeter — the recognizable "Coppi
movement" referenced in the header (the coppi family are the all-time 1990-2025
champions, see `robots/2015/coppi15*.r`, `robots/2020/coppi20*.r`).

Patrol runs are bounded by three exits:

```c
  if (loc_x(t = 7) < 500)
    ...
        dmax = ((dmin = -15) + 80);
        while ((damage() < 40) && (--t))
          RadarF2f(Dn(Sx(Up(Dx()))));
```

- **`t = 7` laps** max (the header's "after 7 laps"),
- **`damage() ≥ 40`** — *if it is hit*, commit to the attack early,
- **`RadarF2f()`** — the enemy counter over its 80° corner arc; fewer than 2 opponents → `F2f()` immediately.

```c
RadarF2f()
{
  int ang, en;
  ang = dmin;
  while (ang <= dmax)
    en += (scan(ang += 20, 10) > 0);
  if (en < 2)
    F2f();
}
```

## Phase 1 firing — the "one-step doubling" model

Unlike ironman_25 (which patrols with the Tobey-family lead), thor_25 patrols with the
**extrapolation shot** also used by [wall-e_vii](wall-e_vii.md) and [gerty6](gerty6.md):
predict the target one step of its own last movement and fire there —
`2*ang - oang` for the angle, `2*range - now` for the distance:

```c
Fuoco(d)
{
  drive(d, 100);
  if ((rng = scan(odeg = deg, 10)) && (rng < 825))
  {
    if (scan(deg - 8, 5))
    {
      if (scan(deg -= 5, 2))
        ;
      else
        deg -= 4;
    }
    ...
    return cannon((deg + deg - odeg), (2 * scan(deg, 10) - rng));
  }
  else
    Radar();
}
```

The refinement chain is a small search tree: probe `±8` → confirm at `5` → fine at `2`
(or ±4 fallback), with an innermost `scan(deg,1)` single-degree probe before giving up.
`Radar()` is the patrol fallback: a ±20/40/60 cone sweep and then **double-fire** on
the hit (fire at the sighting angle, re-scan and fire at the refined one):

```c
Radar()
{
  if (rng = scan(deg += 20, 10))
    ;
  else if (rng = scan(deg -= 40, 10))
    ;
  else if (rng = scan(deg += 60, 10))
    ;
  else
    return deg += 40;
  cannon(deg, rng);
  return cannon(deg, 2 * scan(deg, 10) - rng);
}
```

## Phase 2 — the shared Hulk engine

Identical to hulk_25's main loop; the only thor-specific detail is the spawn-corner
pick, mirrored across the quadrant:

```c
F2f()
{
  int b, x, y;
  if (loc_y(x = (loc_x() > 500)) > 500)
  {
    if (x)
      Fulmine(dir = deg = 210);
    else
      Fulmine(dir = deg = 300);
  }
  ...
  Martello();
  while (1)
  {
    if (orng > 425)
    {
      Fulmine(dir = 180);
      while (Vai(loc_x() > 300))
        ;
      ...
```

See [hulk_25.md](hulk_25.md) for the full state machine, the `145`/`192` shrink
models, the lead formula, and the `Ritrova()` recovery sweep (identical here).

## Notable traits

- **The "if hit" clause**: unlike hulk_25 (no damage logic at all) and ironman_25
  (damage is only a *force-commit* at 75), thor_25 treats damage as an *early
  promote* signal (≥40 during patrol → drop the perimeter and attack).
- **75 px walls**: its patrol hugs closer to the perimeter than ironman's 175 px box —
  Coppi's signature geometry.
- The cleanest "two-schops" decomposition of the trio: phase 1 =
  `Up/Dn/Dx/Sx` (movement) + `Fuoco/Saetta/Radar` (fire), phase 2 = shared engine.
  Reading thor_25 is the shortest path to understanding all three Cartieri robots.
- 1632 instructions: ~20 % of the Macro budget headroom — the whole robot is a
  hand-optimized assembly of proven parts rather than a new idea.

## How to test locally

```sh
./crobots -m200 robots/2025/thor_25.r robots/2025/ironman_25.r
./crobots -m100 robots/2025/thor_25.r robots/1998/coppi.r        # the original Coppi
./crobots -m50  robots/2025/thor_25.r robots/2020/coppi20ma2.r   # vs. 2020 macro champion
```
