# gerty6 — Strategy Analysis

**Tournament:** Crobots 2025 (40th Anniversary), "Macro" pool — **rank 5 of 24**, total 49.76 % won
(F2F 68.26 %, 3v3 45.70 %, 4v4 35.33 %)
**Author:** Olga S
**Class:** Midi — **v6.01** in the long Gerty line (began 13-10-2024)
**Local file:** `robots/2025/gerty6.r` (151 lines)

## Core idea

The header is refreshingly honest:

> *"Gerty6 is one of the previous Gerty's with a **funny way of computing the movement
> direction using an array of four elements**."*

That array is the robot's soul: a 4-entry direction table **bit-packed into one integer**
(two bits per entry), cycled at low speed whenever the robot reaches a corner. The rest
is a wall corridor with a safe-band test (same bit-decoding trick as
[kerberos](kerberos.md)), a three-tier firing stack (fire3 → fire2 → scan_), and — the
part that makes Gerty *Gerty* — a **one-way "terminal dance"** state it commits to in
head-to-head matches.

## The four-element direction array

```c
    array = (2*posx)|          /* 0 or 180 */
            ((2*!posx)<<2)|    /* 180 or 0 */
            ((1+(2*posy))<<4)| /* 90 or 270 */
            ((3-(2*posy))<<6); /* 270 or 90 */
```

Each 2-bit field is a heading (`0/2 → 0°/180°`, `1/3 → 90°/270°`). For a spawn in the
SW quadrant the table reads `[0, 180, 90, 270]` — **two opposite pairs**, exactly the
perpendicular alternation the corridor needs. The fields are extracted with a
mask-and-shift *at the field's own index*:

```c
          if ((index+=2)>6) { drive(dir,index=0); ++timer; }
          fire2(drive(dir=90*((array&(3<<index))>>index),0));
```

`index` walks 0→2→4→6→0, so one full cycle visits all four headings at **0 % speed** —
the robot *crawls*: `drive(dir, …, 0)` stops it and the `fire2()` passed as its
argument takes **one shot per field**, while it reconsiders direction, until `index`
wraps and `timer` (a "time spent in corner" tick) goes positive. That is the
"funny" part: a state machine whose state is encoded in the *bit layout* of a variable
rather than in branches.

## Movement state machine

```
spawn ─► zdeg = corner heading + 320;  l = zdeg + 131   (scan budget, 131°)
  └─► while(deg=zdeg):          ← infinite loop written as an assignment test
        SAFE band  (still outside the corner box, see below)
          ► fire3 while driving at 100 %
        CORNER band (inside the safe box)
          ► crawl the 4-direction array at 0 % speed (index dance, timer++)
          ► RECOVERY SWEEP: deg from zdeg, +20° steps, until 2 targets or deg≥l
          ► if still <2 targets: THE TERMINAL DANCE (no exit — see below)
          ► else: timer=-2; maybe fire() (the big shot, damage-gated)
```

The safe band is decided with the same `dir&320 / dir&384` bit decoding
kerberos uses, but with Gerty's own margins (650 / 100 / 250):

```c
    if(dir&320) { y=loc_y(x=param2); } else { y=loc_x(x=param1); }
    if(dir&384) { safe=y-(x+100);    } else { safe=(x+250)-y;   }
    if(safe>0) {
        fire3(drive(dir,100));
    } else {
```

(`param1/param2 = 650` when the robot is in the far half on that axis, `0` otherwise —
the corner box is the 250-100 px zone around the spawn corner's far edge.)

### The terminal dance

```c
          if (timer>0) {
            while((deg<l)&&(e<2)) e+=(scan(deg+=20,10)>0);
            while(e<2)
            {
                if (((posx=loc_x())%880)<120) dir=180*(posx>500);
                else if (((posy=loc_y())%880)<120) dir=90+180*(posy>500);
                else if (range>600) dir=ang+25;
                else if (range<180) dir=ang+195;
                else dir=ang+180*(b^=1);

                fire2(drive(dir,100));
                fire2(drive(dir,100));
                fire2(drive(dir,100));
            }
```

Per-tick policy: near a wall (`%880<120`, same 880+120=1000 trick as
[wall-e_vii](wall-e_vii.md)) → run **along** the wall; target far (>600) → orbit
`ang+25`; target close (<180) → back away `ang+195`; mid-range → **zig-zag**
`ang±180` flipping side (`b^=1`). Three full-speed fired drives per tick.

**Critical observation:** in a 2-robot match the recovery sweep can find at most one
target, so `e<2` is *still true* here and `e` is never written inside the body —
`while(e<2)` is an **exitless loop**. Gerty6 commits to this dance *permanently* the
first time it reaches a corner in F2F. It is not a bug that costs it: the dance is
aggressive, evasive, and fires three times per tick — it's just a *one-way door*, and
no state "after" the dance exists. (In a 3-robot match, finding both opponents makes
`e==2`, skips the dance, resets `timer=-2` and may take the big shot.) When analyzing
or modifying Gerty, remember: **there is no code after `while(e<2)` in F2F**.

The big-shot gate, right after:

```c
            timer=-2;
            if ((damage(e=0)<70) || (orange && (orange<740))) ;
            else fire();
```

— take the precise `fire()` only when badly hurt (`damage≥70`) **or** the last known
target is far (740 ≤ orange); `e=0` is reset as a side-channel in the call argument.

## Firing stack

### `fire3` — the entry point (with two "empty ifs")

```c
fire3()
{
  if (safe<=80);
  else if (scan(ang,10))
    {
      if ((orange=scan_())<850)
        {
          if (range=scan_())
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),
                           (range*200/(200+orange-range-(cos(ang-dir)/4167))));
        }
    }
  if((range=scan(ang,10))&&(range<850));
  else
    if((range=scan(ang+=339,10)));
    else if((range=scan(ang+=42,10)));
    else
      if((range=scan(dir,10))) ang=dir;
      else
        return (ang+=40);
  fire2();
}
```

- `if (safe<=80);` — an **empty-body if** *deliberately* swallows the precise shot when
  close to a wall (the else-chain is suppressed): near walls Gerty falls through to the
  coarse `fire2`.
- The lead model is the **Tobey family rescaled** (cf.
  [kerberos.md](kerberos.md)): 3× extrapolation of the last angular delta
  (`oang+(ang-oang)*3`) minus `sin(Δ)/19500`; range `range*200/(200+Δ−cos/4167)` —
  same base-200 shrink/overshoot shape as the 230 base in Tobey/kerberos/hal9025.
- The middle block's **three empty ifs** each *advance* `ang` (+339, +42, or to `dir`,
  else +40) as the state of a multi-tick search, then always end in `fire2()` — a
  *stateful coarse tracking* pattern (the `/*cannon ...*/` line above it shows the
  abandoned alternative).

### `fire2` — the shared Camangi/Olga core (identical shape)

The one-step **doubling shot** `cannon((ang<<1)-oang, (scan(ang,10)<<1)-range)` with a
±8→±5/±4 (or ±2→±3/±6) refinement tree, and a ±20/40/60/80 fallback cascade. Same
model as [wall-e_vii](wall-e_vii.md)'s `fire2` and [thor_25](thor_25.md)'s
`Fuoco`/`Saetta`:

```c
 	if (range=scan(oang=ang,10))
	{
		if (scan(ang-8,5))
		{
			if (scan(ang-=5,2)) ;
			else ang-=4;
		}
		...
		return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range));
	}
```

### `scan_` — the fine refiner (±7/±4/±2)

```c
scan_()
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}
```

Resolutions 3°/2°/1° — the only Gerty routine that dips *inside* the ±10° scan cone
with sub-degree probes.

## Notable traits / quirks

- **Duplicate global**: `int range, dir, safe, ang, oang, orange, safe;` — `safe`
  declared twice (harmless; the compiler keeps one slot).
- **`debug` local, never used** — lineage leftover (v6.01 = Gerty VI, revision 21-10-2024).
- **The one-way door** (`while(e<2)` in F2F) is the single biggest behavioral
  difference from its siblings: Gerty never returns to safe-band travel once committed.
- **Damage gates offense** (`<70 → skip big shot`) and **range gates geometry**
  (25 / 195 / zig-zag) — a compact evasiveness model in 5 lines.
- Two "empty if" tricks in `fire3` make it the most *read-undrunk*-difficult routine in
  the pool; both are deliberate state-machines, not bugs — the comments and the
  commented-out `cannon` above `fire2()` tell the history.

## How to test locally

```sh
./crobots -c robots/2025/gerty6.r
./crobots -m200 robots/2025/gerty6.r robots/2025/kerberos.r    # two Olga-S corner robots
./crobots -m100 robots/2025/gerty6.r robots/2025/hulk_25.r     # vs. the F2F king
```
