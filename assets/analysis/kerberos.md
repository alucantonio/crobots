# kerberos — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 8 of 24**, total 46.85 % won
(F2F 63.09 %, 3v3 45.87 %, 4v4 31.57 %) — it is in fact the **Micro-class champion of
the Hall of Fame for 2025**
**Author:** Olga S
**Class:** Micro (the tightest size class of the pool)
**Local file:** `robots/2025/kerberos.r` — **71 lines, the smallest code of the top 8**

## Core idea

Kerberos is a **corner-hugger**: it walks a fixed corridor band toward a home corner,
and when it reaches the corner's "safe box" it turns 90° and walks the next wall band —
permanently circling the corner while firing from both legs. The header is explicit:

> *"Kerberos is a remake of Tobey (2007) with different movement and fire routines."*

The fire routine, however, is inherited *verbatim* from Tobey (2007): `robots/2007/tobey.r`
contains the identical `asin/acos/230/482` lead lines (lines 45-52). The "different routines" are the movement
and the wide-search sequence. Hal9025's `fire()` ([hal9025.md](hal9025.md)) contains
the same routine — the only difference is that HAL puts the look-ahead line inside
`fire()` where kerberos has it in `main()` — so the two are siblings of the same
Tobey lineage.

## State machine

```
spawn ─► pick corner by quadrant (90*((posy<<1)|(posx^posy)))
  └─► while(1):
        SAFE zone  (still >200 px from the next wall on the travel axis)
          ► drive at 100 %
          ► fire: look-ahead at own heading, then the target routine
        CORNER zone (inside the safe band)
          ► turn 90° (left) — drive(dir+=270, 59) forces the decel that the turn needs
          ► fire the corner routine (refined 2-step or wide search)
          ► re-accelerate to 100 %
          ► repeat → circuit around the corner box
```

### Corner pick & axis decoding (lines 38-44)

The spawn quadrant selects one of four corners; then, each tick, the travel axis is
decoded from the heading with **bit tests instead of branches** (a trick this robot
shares with [gerty6](gerty6.md)):

```c
  param1=375*(posx=loc_x()>499);
  param2=375*(posy=loc_y()>499);
  drive(dir=90*((posy<<1)|(posx^posy)),100);
  while(1) {
    if(dir&320) { l=loc_y(x=param2); } else { l=loc_x(x=param1); }
    if(dir&384) { safe=l>(x+200); } else { safe=(x+425)>l; }
```

`dir&320` distinguishes x- vs y-travel (0/180 vs 90/270); `dir&384` decides which side
of the corridor band you're on (approaching vs leaving the corner), yielding the two
safe tests — `l < param+425` or `l > param+200` — without a single comparison on `dir`
itself.

### The corner turn at 59 %

```c
    else {
      drive(dir+=270,59);
      if((range=scan(oang=ang,10))&&(range<808))
      {
         if (!scan(ang-=5, 5)) ang+=11;
         if (!scan(ang-=3, 2)) ang+=5;
         cannon(ang<<1-oang,scan(ang,10)<<1-range);
      } else search();
      drive(dir%=360,100);
    }
```

The requested speed (59) is *above* the turning threshold (≤50 in this build,
see `assets/RULES.md`), so the robot first decelerates; the heading snaps as soon as
speed ≤50 and it then re-accelerates. In effect: **brake-to-turn-fire-restart** in one
three-line block. The corner shot itself is the "one-step doubling" model (shared with
[wall-e_vii](wall-e_vii.md)'s `fire2`): extrapolate one step of the target's last
movement — `ang<<1 - oang` for angle, `scan<<1 - range` for distance. The two `if (!scan(...))`
lines are a small *repeller*: nudge *away* from the beam edge rather than chasing it
inside.

## The safe-zone fire routine (the Tobey inheritance)

```c
    if (safe) {
        if (speed()<100) drive(dir,100); else { if (range=scan(dir,10)) ang=dir; if (range>850) { ang+=120; } }
        if (scan(ang,10)) {
                asin=(sin(ang-dir)/14384);
                acos=(cos(ang-dir)/3796)-230;

                find();
                if (orange=scan(oang=ang,3)) {
                        find();
                        cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin,
                        range*230/(orange-range-acos));
                }  else search();
        } else search();
    }
```

Reading top to bottom:

1. **Look-ahead**: if coasting past 100 %, peek at own heading; if the last target is
   very far (>850) pre-rotate the search direction 120° ahead.
2. **Lead constants**: `asin = sin(Δ)/1.64°`, `acos = cos(Δ)/0.038° − 230` — the
   classic Tobey pair (Δ = target bearing − own heading).
3. **Refine twice** (`find()` below) — before and after the narrow confirmation scan.
4. **Confirm at resolution 3°** (`scan(oang=ang,3)`) — the *narrow* confirm beats the
   ±10° cone on speed; only then is the expensive lead computed.
5. **The lead shot**:

```
angle  = ang + (ang-oang) * (880 + range) / 482  − asin
range  = range * 230 / ( (orange − range) − acos )
```

   - angle lead scales with range (≈1.8→3.3× the observed angular motion), minus the
     own-motion term `asin`;
   - range shrinks when the target closes (Δ=orange−range>0) and *overshoots* when it
     flees; the `acos` bias (−230→0) softens both.

### `find()` — two-pass ±13/±12/±11 refinement

```c
find()
{
  if(scan(ang-13,10)) ang-=5;
  else if(scan(ang+13,10)) ang+=5;
  if(scan(ang+12,10)) ang+=4;
  else if(scan(ang-12,10)) ang-=4;
  if(scan(ang-11,10)) ang-=2;
  if(scan(ang+11,10)) ang+=2;
}
```

Six probes at just outside the 10° cone; corrections are asymmetric (5/4/2) to bias
toward the target quickly.

### `search()` — fixed-sequence full-circle recovery

```c
search()
{
  if (range=scan(ang+=350,10)) return cannon(ang,range);
  if (range=scan(ang+=20,10))  return cannon(ang,range);
  if (range=scan(ang+=320,10)) return cannon(ang,range);
  if (range=scan(ang+=60,10))  return cannon(ang,range);
  if (range=scan(ang+=280,10)) return cannon(ang,range);

  search(ang-=220);
}
```

Each attempt is a *relative* rotation from the previous one (−10, +30, −50, +20, −180,
then −220+...); because the sequence is fixed, coverage of the full circle is
guaranteed in a bounded number of calls — a **stateless deterministic sweep**.
(identical in hal9025 — see that file.)

## Why a 71-line Micro outperforms several Macro robots

- **One job, done perfectly**: no state machine, no enemy counting, no multi-phase
  logic — a corner circuit plus two fire routines. Less code = fewer failure modes.
- **It is in the *Macro* pool on purpose**: the tournament ran it alongside the 24
  biggest robots; the Micro-class discipline (small, reactive, always firing)
  transfers directly to F2F, where kerberos reaches 63 %.
- **Every tick either drives or fires** — there is literally no branch in the main
  loop that does neither.

## Notable traits / quirks

- `dir` is allowed to grow unbounded (`dir+=270` with no `mod` until the re-accelerate
  `dir%=360`). The axis-decoding bit tests (`&320`, `&384`) still work for the
  accumulated values because they only distinguish 0/90/180/270 mod 360 — a subtle
  invariant that *must* stay 90° increments.
- The `range<808` guard in the corner fire avoids firing a >700 m shot from the corner
  (and keeps the doubling model within sane numbers).
- Shared DNA: same fire core as [hal9025](hal9025.md) (`/14384`, `/3796-230`,
  `*230/(Δ−acos)`, same `find`/`search`) → both descend from
  `robots/2007/tobey.r`'s routine; gerty6's fire3 uses the same geometry with
  rescaled constants.

## How to test locally

```sh
./crobots -c robots/2025/kerberos.r
./crobots -m200 robots/2025/kerberos.r robots/2025/hulk_25.r
./crobots -m100 robots/2025/kerberos.r robots/2007/tobey.r     # the ancestor
./crobots -m100 robots/2025/kerberos.r robots/2025/hal9025.r   # the sibling
```
