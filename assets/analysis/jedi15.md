# jedi15 — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 3 of 24**, total 57.65 % won
(F2F **81.23 %** — 2nd best in the pool, 3v3 53.61 %, 4v4 38.12 %)
**Author:** Maurizio Camangi
**Class:** Macro; **Version 15.05** (from Jedi 14)
**Local file:** `robots/2025/jedi15.r` (409 lines)

## Core idea

jedi15 is a **count-based state machine** with three distinct strategies, one per
opponent-count band (F2F / 3v3 / 4v4), plus a two-tier firing stack (fast `qfire` /
precise `fire`). The header is explicit about its F2F origin:

> *"As usual, this robot is an older version of a Jedi (in this case, 14) with its fire
> routines replaced and a different F2F, obviously, inspired by the leaders of the KoTH."*

The KOTH leaders referenced are **loneliness** and **carillon** (`robots/2020/`, 2020
season) — and their signature "wall band" (`x>840 || x<160 || y>840 || y<160` → run
along the wall at 165/345/255/…) is visible in jedi15's F2F loop (`%840 < 160`).

## Enemy counting — the state selector

On arrival at the first corner, `fastradar()` counts how many opponents are on the
corner's 100° arc by *subtracting* detections from 3:

```c
fastradar() /* Count enemies */
{
  return enemies=3
  -(scan(deg1+100,10)!=0)
  -(scan(deg1+80, 10)!=0)
  -(scan(deg1+60, 10)!=0)
  -(scan(deg1+40, 10)!=0)
  -(scan(deg1+20, 10)!=0)
  -(scan(deg1,    10)!=0)
  ;
}
```

The three bands (main loop):

| condition | meaning | strategy |
| --- | --- | --- |
| `enemies > 1` | 0-1 opponents visible (effectively F2F) | aggressive dart/orbit loop |
| `enemies == 1` | 2 opponents (3v3 match) | corner ping-pong with slow radar |
| `enemies < 1` | 3+ visible from the corner (effectively 4v4) | 4-corner chase, re-escalate |

Bands escalate automatically with time and health:

```c
              if ((++timer%2)&&(range>400))
              {
                  if ((timer>64)&&(damage()<40)) enemies=2;   /* promote -> F2F loop */
                  else slowradar(skip);
              }
```

## F2F loop — "inspired by loneliness and carillon"

Direction is chosen per tick, wall-band first, then by target distance:

```c
        while(1) /* F2F inspired by loneliness and carillon */
        {
            if(range>459) fire();
            if (((posx=loc_x(posy=loc_y()))%840)<160) dir=20+320*(posy>=500)+180*(posx>=500);
            else if ((posy%840)<160)  dir=70+40*(posx>=500)+180*(posy>=500);
            else if (range<149) dir=((ang/90)+(b^=1))*90+180*(dam>85);
            else if (range<640) dir=ang+80+(b^=1)*200+180*(dam>79);
            else                dir=ang+24+(b^=1)*(299-dam);
            dam=damage(qfire(dir,100));
```

Reading the bands:

- **near a wall** (`%840 < 160`) → run *along* the wall toward the next corner
  (the loneliness/carillon wall-hug, 840/160 = 80 px margin either side);
- **range < 149** (target on top) → **perpendicular dart**: head off-axis at a 90°
  multiple, flipping side with `b^=1`, and 180° if badly hurt (`dam>85`);
- **range < 640** → oblique escape `ang+80/+280` with side flip (also damage-flipped at
  `dam>79`);
- **open field** → `dir = ang + 24 + (b^=1)*(299-dam)` — an orbit whose sweep angle is
  **the damage value itself**: hurt less → wider orbits; badly hurt → tighter, more
  evasive weaving.

`dam=damage(qfire(dir,100))` is the classic "fire while driving, sample damage in the
same statement" idiom.

## 3v3 band — corner ping-pong

Fire at the diagonal corner, and if it's still there, drain it, then hop to the
opposite corner:

```c
          if (look(deg1))
          {
              dir=deg1+(30<<flag);
              if (look(deg1+(70*flag)))
              {
                  fire();
                  while(scan(ang,10)>680) fire();
                  corner();
                  flag^=1;
              }
              ...
              if ((++timer%2)&&(range>400))
              {
                  if ((timer>64)&&(damage()<40)) enemies=2;
                  else slowradar(skip);
              }
          }
```

Corner runs use tighter wall hugging than [wall-e_vii](wall-e_vii.md) (88/950 margin):

```c
xmax() { while(loc_x()>88) qfire(dir,100);   while(loc_x()>50) drive(dir,100);   stop(); }
xmin() { while(loc_x()<912) qfire(dir,100);  while(loc_x()<950) drive(dir,100);  stop(); }
```

and it **switches corners when hit** (`if (damage()>d) flag^=1;`), keeping a moving
"hit budget" `d = damage() + 4`.

`slowestradar()` is the re-aim routine: sweep the corner arc in 20° steps, stop as
soon as one opponent is found, keep the nearest one (`brange`), and set `ang` for the
next firing round:

```c
slowradar(s)
int s;
{
  int deg,brange;
  if (s) return;
  deg=deg1-20; brange=1500; enemies=3;
  while( (deg<=deg2) && enemies)
  if (range=scan(deg+=20, 10))
  {
      --enemies;
      if (range<brange)
      {
          ang=deg;
          brange=range;
      }
  }
}
```

4v4 band — chase all four corners in turn with diagonal-biased headings, then promote to
the 3v3 band after 32 timer ticks:

```c
              if (posy) {
                  ymin(move(dir=300-60*(posx)));
              }
              else {
                  ymax(move(dir=60+60*(posx)));
              }
```

## Firing stack — two tiers

**`qfire(d,v)` — fast tier.** Drive + last-look chase (angle ±21/+42 pattern), a
*shallow* refinement pass, and the 145-shrink shot:

```c
            if (range=scan(ang,10)){
                    cannon (ang, range*145/(145+orange-range) );
```

The refinement depth is data-driven via the global `fp` (3 at F2F start, 5 later) —
sub-degree probes get cheaper or sharper depending on the phase.

**`fire()` — precise tier** — the full "Cartieri lead" (shared word-for-word with
[hulk_25](hulk_25.md)'s `Rompi`):

```c
  if (orange=refine()) {
    if (range=refine(oang=ang))
      cannon(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14),
                    range*192/(192+orange-range-(cos(ang-dir)>>12)));
```

followed by the same `±21` fallbacks, and finally `search()` — a 9-step relative
sweep that is the pool's longest lost-target recovery (offsets −84, −21, +126, +21,
−168, −21, +210, −231, +252).

Gating: `qfire` fires every tick; the precise `fire()` only when `damage() < 60`
(line 176) — precision is reserved for a healthy robot.

## Notable traits

- The only top-8 robot with a **true three-way state machine** (F2F / 3v3 / 4v4) —
  the most "multi-robot aware" of the pool, matching its 2nd-place 3v3 showing.
- **Damage drives geometry**: orbit width = `299 - damage`, dart direction flips at
  `dam>79/85` — a continuous evasiveness model rather than a trigger.
- The `fp` variable threads *scan resolution policy* through the firing stack — a
  global tuning knob most robots hardcode.
- `stop()` shows the coast debate in the negative: `/*while(speed()>59) ;*/` — jedi15
  does **not** wait for the coast; [ironman_25](ironman_25.md) does.
- Camangi's trademark header (ASCII "JEDI" art + Asimov's laws + "100 % bits" warning)
  appears in every one of his 2025 robots.

## How to test locally

```sh
./crobots -m200 robots/2025/jedi15.r robots/2025/hulk_25.r
./crobots -m100 robots/2025/jedi15.r robots/2013/leopon.r robots/2012/lamela.r  # 3v3 vs. 2012/2013 champs
```
