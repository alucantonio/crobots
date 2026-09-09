# wall-e_vii — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 7 of 24**, total 49.23 % won
(F2F 71.41 %, 3v3 43.42 %, 4v4 32.87 %)
**Author:** Maurizio Camangi
**Class:** Micro (tightest size class) — **v7.0**, from Wall-E VI
**Local file:** `robots/2025/wall-e_vii.r` (174 lines, ~80 of them header ASCII art)

## Core idea

wall-e_vii is a **corner ping-pong**: it alternates between two opposite corners,
running the full X/Y spans between them while firing, with a "recovery scan" to
re-locate any target lost in transit. The header states the only change from v6:

> *"Wall-E VII inherits (almost) everything from Wall-E VI because its author is lazy.
> This version changes the length of its movement based on the damage %."*

That single change — `timer = 9 - damage()/25` — is the whole v7; the rest is the
proven V line (Wall-E has won or placed for the 2020 season: `robots/2020/.r` era).

## State machine

```
spawn ─► corner by quadrant (deg = 90*((posy<<1)|(posx^posy)))
  └─► while(1):
        1. run the X-then-Y (or Y-then-X, alternating) corner-to-corner span, firing
        2. RECOVERY: sweep 20° cones from the spawn corner direction until 2 targets
           are seen (or 140° swept)
        3. AGGRESSIVE LOOPS: if <2 targets known, chase/escape around the field
        4. approach the OPPOSITE corner (flag^=1), firing `timer` consecutive runs —
           timer = 9 - damage()/25   ← the v7 change
        5. go to 1
```

### Corner runs — the one-liner wall trick

The span runs stop "near either wall" with a single modular condition — no need to know
which wall you're approaching, because field width 1000 = 880 + 120:

```c
runX()
{
    dir=180*!posx;
    while( (loc_x()%880) > 120) fire(dir,100);
    fire(dir,0);
}
```

`loc_x()%880 > 120` is true exactly while `x ∈ (120,1000]` minus the `(880,1000)` tail —
i.e. until the robot is **≤120 px from whichever wall it is heading for** (the `[0,120]`
or `[880,1000]` bands both fail the test). `runY` is the same for `y`. Alternation is
`flag^posx^posy`:

```c
        if (flag^posx^posy) runY(runX()); else runX(runY());
```

### The `fire(d,v)` routine — Camangi's "one-step doubling"

This is the shared Camangi fire core found (in the same shape) in [gerty6](gerty6.md),
[hal9025](hal9025.md), [thor_25](thor_25.md) (Fuoco/Radar) and gerty6's fire2:

```c
fire(d,v)
int d,v;
{
    int oang;
	drive(d,v);
	if (range=scan(oang=ang,10)) {
		if (scan(ang-8,5)) {
			if (scan(ang-=5,2)) ;
			else ang-=4;
		} else {
			if (scan(ang+8,5)) {
				if (scan(ang+=5,2)) ;
				else ang+=4;
			} else {
				if (scan(ang,1)) ;
				else if (scan(ang-=3,2)) ; else ang+=6;
			}
		}
		return(cannon((ang<<1)-oang, (scan(ang,10)<<1)-range));
	} else {
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else if(range=scan(ang+=60,10)) cannon(ang,range);
		else if(range=scan(ang-=80,10)) cannon(ang,range);
		else ang+=120;
	}
}
```

Two things to note:

1. **The shot model** — extrapolate the target *one step* along its last observed
   motion, and fire at that predicted point:
   angle `ang<<1 - oang` (= `2*ang - oang`), range `(scan<<1) - range` (= `2*range -
   now`). Cheap, no trig, and robust when the target moves in straight lines — which
   most of the corner-patrolling robots of this era are.
2. **The `else` branch does nothing (`;` after the `cannon(...)`)** — the `range` set
   here is *discarded*; the actual fire happens in the next call. It only serves to
   keep `ang` advanced toward the target across iterations — a subtle stateful search.

### The v7 change — damage-scaled approach

```c
        dir=(deg+(30<<flag));
        if (scan(tmp=deg+90*flag,10)) ang=tmp;
        timer=9 - (damage()/25);
        while(--timer) fire(dir,100);
        i=0; flag^=1;
```

It pre-aims at the *opposite* corner (`deg + 90*flag`), then fires a **number of
consecutive full-speed runs** scaled by how damaged it is: at 0 % damage,
`timer=9` runs; at 75+ % damage, `timer=6`. A hurt Wall-E shortens its own travel —
less exposure time in transit, the exact "length of movement based on damage %" the
header advertises.

### The `flag` alternation

`flag` toggles every cycle, and `30<<flag` biases the approach 30° (flag 0) or 60°
(flag 1) from the pure corner diagonal — so the two opposite corners are approached on
slightly different angles, breaking perfect periodicity that an adaptive opponent could
exploit.

## Why a Micro robot makes the top 8

- **Tight, deterministic loop** with no state machine beyond `flag` — few branches,
  few failure modes, tiny code.
- **Always driving at 100** (the span runs) so it is hard to predict and hard to
  corner; it only stops to fire or change axis.
- The **%880 wall trick** makes it immune to "which wall am I near?" mistakes that
  plague corner-chasers.
- The damage-scaled approach is the only place it spends cycles on "tactics", and it
  does it in one line.

## Notable traits / quirks

- The big ASCII header + Asimov's-Laws + "100 % bits" block are Camangi's recurring
  signature (see jedi15, hal9025) — it's decoration, not function.
- `runX`/`runY` end with `fire(dir,0)` — a **fired stop**, so the robot keeps hunting
  even as it brakes to a corner.
- Recovery scan: `while((timer<2) && (i < 140)) { timer+=(scan(deg+i,10)>0); i+=20; }`
  — a bounded 7-cone (140°) sweep for targets; if it finds fewer than 2, the
  aggressive `while(timer<2)` loop takes over (perimeter run / orbit / zig-zag by
  `range`), same shape as the other Camangi robots' "go crazy" loops.

## How to test locally

```sh
./crobots -c robots/2025/wall-e_vii.r
./crobots -m200 robots/2025/wall-e_vii.r robots/2025/kerberos.r   # two Micro corner-huggers
./crobots -m100 robots/2025/wall-e_vii.r robots/2020/wall-e_vi.r  # the direct parent (if present)
```
