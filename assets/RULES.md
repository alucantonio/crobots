# CROBOTS — Robot Programming Rules

Complete ruleset for writing a new CROBOTS robot (`*.r` file). A robot is a C program
that is compiled by the CROBOTS compiler and run on a virtual stack CPU competing in
a 1000×1000 m battlefield. Your robot must find, track, and shoot the other robots.
Strategy is decided **before** the match — the program runs autonomously.

---

## 1. Battlefield

- 1000 × 1000 meter square, walls on all four sides.
- Lower-left corner is `x=0, y=0`; upper-right corner is `x=999, y=999`.
- Hitting a wall deals **2% damage** and stops the drive (speed → 0).
- Compass headings: **0 = due east (right)**, 90 = north, 180 = west, 270 = south.
  One degree below east is 359. Headings outside 0–359 are folded by
  `modulo 360` (made positive) by the hardware.

## 2. Robot capabilities

### Offense
- **Cannon**: fires a missile in any chosen heading 0–359 (independent turret —
  fires regardless of robot heading). Range **0–700** (larger values truncated to 700).
  Infinite ammo, but **at most 2 missiles in the air at once**; `cannon()` returns 0
  while reloading.
- **Scanner**: instantly senses any chosen heading 0–359. Returns the range to the
  closest robot in the scan cone, or 0 if none. Max resolution **±10 degrees**, so the
  common tactic is: quick low-resolution sweep, then refine with resolution 0/1.

### Defense (there is no armor)
- **Motor drive**: engage on any heading 0–359 at 0–100% speed, with
  acceleration/deceleration. A speed of 0 disengages the drive; the robot decelerates
  and coasts to a stop (per the `src/sniper.r` comment: "should coast in the rest of
  the way"). **Headings can be turned at 50% speed or less, in any direction**;
  above that you go straight and may slide into walls.
- **Status registers**: `damage()`, `speed()`, `loc_x()`, `loc_y()` (see §4).

### Damage model (cumulative, unrepairable)
| Cause | Damage |
| --- | --- |
| Collision with another robot (both take it) or with a wall | 2% |
| Missile exploding within 40 m radius | 3% |
| Missile exploding within 20 m radius | 5% |
| Missile exploding within 5 m radius | 10% |

- A robot is **dead at 100% damage** and drops out of the match.
- Damage does **not** degrade performance: a robot at 99% damage is as fast and
  deadly as an undamaged one. (Use damage only to detect that *you* were hit.)

### Match rules
- Up to 4 robots per match. If you pass only one program, it is "cloned" into
  another, so two robots running the same program compete.
- CPU cycle limit per match applies in `-m` mode (default 500,000 when `-m` is
  used, override with `-l`): the match ends when the limit is hit — **keep your
  per-tick work small**.

## 3. The language (CROBOTS C subset)

The compiler accepts a **limited subset of K&R C** in a **single file**:

**Not available** (do not use — compilation fails or it is ignored):
- floating point (integer math only)
- structures, unions, pointers, arrays
- character data, `typedef`
- `for`, `do..while`, `switch..case`
- `goto`/labels (syntax error)
- `break` (parsed with an "unsupported break" warning and *silently ignored* — it does nothing)
- `continue` **dangers**: it slips through as an *undeclared variable name* → one
  "1 undeclared variables" warning and a **silent no-op** — a loop you think skips
  actually runs straight through. Do not use.
- initializers at declaration (`int x = 5;` → warning, initializer dropped)
- ternary `?:`, comma operator, octal/hex constants
- **all preprocessor directives** (`#define`, `#include`, … — nothing)
- `main()` takes no parameters
- no separate compilation — everything in one file

**Available** (use freely):
- `if (expr) STMT else STMT` (nest up to 16), `while (expr) STMT` (nest up to 16)
- arbitrary function definitions with parameters (return values optional — the
  compiler inserts a dummy return if you omit `return`), and **recursion**
- full expression evaluation and all usual arithmetic/bitwise/logical/comparison
  operators, assignments (`= += -= *= /= %= &= ^= |= <<= >>=`), prefix and postfix
  `++`/`--`
- `int` (or `long`, same thing), `auto`, `register` (ignored)
- `/* ... */` comments (not nestable)

**Deviations from standard C — important:**
- **Undeclared variables are auto-promoted to locals** (no "unknown variable"
  error) — a typo silently creates a garbage (zero-initialized) variable.
- Postfix `var++` has the **same semantics as prefix** `++var`.
- **Intrinsic function names are reserved** — never name a function
  `scan`, `cannon`, `drive`, `damage`, `speed`, `loc_x`, `loc_y`, `rand`, `sqrt`,
  `sin`, `cos`, `tan`, `atan`. (Calling them is of course fine; *defining* a
  function with one of these names crashes the patched compiler — it segfaults
  instead of printing the manual's "function definition same as intrinsic" error.)
- Identifiers are significant to 7 characters (longer is allowed but truncated) —
  **and collisions are silent**: `abcdefg1` and `abcdefg2` compile as the *same*
  symbol `abcdefg`. Keep name prefixes distinct.
- Order of precedence/evaluation is the same as K&R C.
- The compiler stops at the **first error**; no error recovery.

### Size limits (hard)
| Limit | Value |
| --- | --- |
| Machine instructions (code space) | **1000** |
| Data + call/return stack | 500 words (3 words per function call) |
| Integer range (32-bit) | −2,147,483,648 … 2,147,483,647 |
| Defined functions | 64 |
| Local variables per function | 64 |
| External (global) variables | 64 |
| `if` / `while` nesting | 16 |

Stack overflow **restarts the robot at `main()` with a zeroed stack** — you lose all
state. Keep call depth modest (each call costs 3 words) and global count under 64.

## 4. Intrinsic (hardware) functions

All intrinsics are pre-linked; they cost no code space (only the 3-word call/return).

| Function | Meaning |
| --- | --- |
| `int scan(degree, resolution)` | 0 = no robot in cone, else range to closest robot (m). `degree` 0–359, `resolution` ≤ 10. (The manual gives no maximum scan range.) |
| `int cannon(degree, range)` | Fire at `degree` (any heading) and `range` (0–700). Returns 1 = fired, 0 = reloading (max 2 in flight). |
| `int drive(degree, speed)` | Drive on heading `degree` at `speed` 0–100%. 0 = brake/disengage. Turn only ≤ 50%. |
| `int damage()` | Current damage 0–99 (100 = dead, you stop running). |
| `int speed()` | Current speed 0–100% (may lag the last `drive()` due to accel/decay; 0 after a collision/wall hit). |
| `int loc_x()` / `int loc_y()` | Current position 0–999. |
| `int rand(limit)` | Random integer 0…limit (limit ≤ 32767). |
| `int sqrt(number)` | Integer square root (argument made positive first). |
| `int sin(deg)`, `int cos(deg)`, `int tan(deg)` | Trig values × **100,000** (e.g. sin(90) ≈ 100000). Degrees. |
| `int atan(ratio)` | Ratio already scaled × 100,000 → returns degrees **−90…+90**. |

**Trig scaling rule:** compute everything in scaled integers (×100,000) and divide
by 100,000 **only at the end**, to avoid integer truncation error.
`atan` only covers −90…+90, so for a bearing to a point you must choose the quadrant
yourself (see the `plot_course()` example in `src/sniper.r`).

## 5. Program structure

```c
/* external variables: visible to ALL functions, must not exceed 64 */
int global1;
int global2;

/* functions: K&R style parameter list, parameters declared on the next line */
helper(a,b)
int a;
int b;
{
  int local;      /* locals auto-zeroed; undeclared names become locals too */
  return (a + b);
}

/* mandatory entry point — no parameters */
main()
{
  /* forever loop your strategy here */
  while (1)
  {
    ...
  }
}
```

- `main()` is **required** ("main not defined" error otherwise).
- Declare all globals **before** you use them (compiler lists the 64-external pool).
- K&R function syntax: parameter list with bare names, then one declaration line per
  parameter on the following line(s).

## 6. Proven tactics (from the sample robots in `src/` and `robots/`)

1. **Damage-reaction loop** (counter, sniper, most robots): remember the last
   `damage()` value; every tick compare `if (d != damage())` → you got hit, so
   immediately reposition (drive somewhere else) and update `d`.
2. **Corner sniping** (sniper): park in a corner and sweep only the 90° quadrant
   that covers the whole field — fastest possible full-field scan. After firing,
   **back the scan pointer up a few degrees** to catch fleeing targets.
3. **Scanning styles** (manual §9-2, sample robots): counter uses a *slow incremental
   scan* — keep a state variable for the next scan degree, advance it a fixed step
   each tick instead of busy-looping; rook restricts its scan to the *four compass
   points* for a very fast sweep. Spreading the work over cycles matters under the
   cycle limit.
4. **Lead the target when firing**: per `src/motion.c`, missiles fly in a straight
   line at the fired heading until the commanded `range`, then explode — they do not
   home. `cannon(degree, range)` therefore hits a *point*; for a moving target, aim
   where it will be (compute bearing with `atan`). (Also, missiles explode when they
   hit a wall — don't fire across corners recklessly.)
5. **Approach safely**: drive at ≤50% while turning; coast to a stop (drive at 0
   leaves residual momentum) and check `speed() == 0` before assuming you stopped.
6. **Useful helper routines** to borrow from `src/sniper.r`:
   - `distance(x1,y1,x2,y2)` — integer Pythagoras via `sqrt`.
   - `plot_course(x,y)` — bearing (0–359) to reach a coordinate, with quadrant logic.
7. **Never rely on walls** for positioning: 2% every touch adds up; at the end a
   robot that touched walls many times can be killed by its own scrap damage.

## 7. Build & test (this repository)

This tree is the original 1985 implementation (GPLv2) with an added `-t` tracing
flag (see `README.md`).

```sh
make -C src                 # builds ./crobots
./crobots                  # single match with live display (default mode)
./crobots myrobot.r enemy1.r enemy2.r
./crobots -c myrobot.r      # compile only; prints VM asm listing (check code %)
./crobots -d myrobot.r      # machine-level single-step debugger (needs -c listing)
./crobots -m50 -l200000 myrobot.r robots/crobs/hunter.r
                            # 50 matches, 200k cycle limit, winners table only
./crobots -m10 -t/traces/x myrobot.r src/sniper.r
                            # also records CSV traces; plot with tools/plot_crobots.py
```

- **Exit code is not a reliable compile signal** in this build (exit 0 can occur
  alongside `** Error **`, and some error paths crash with 139/134). Judge by the
  printed text: success = `…r compiled without errors` and no `** Error **` lines.
- Some paths wait at `Press <enter> to continue` — run with a terminal or a fed
  stdin (`</dev/null`).
- Only **one file per robot**; all of its code in that one file.
- If one program is given, it is **cloned** — to test against itself use
  `./crobots myrobot.r myrobot.r` (or any second program).
- Use `>file` redirection to save compile listings or match results.
- `Ctrl-Break` stops a live match at any time.

### Checklist before shipping a robot
- [ ] File contains exactly `main()` + helpers, no preprocessor, at most 64 globals
- [ ] No reserved intrinsic names; no floating point, arrays, pointers, `for`
- [ ] `while (1)` loop with a bounded amount of work per iteration
- [ ] Damage detection (`d != damage()`) triggers a move
- [ ] Cannon range is 0–700 (values above are truncated to 700); reload returns handled
  (returns 0 while the 2-missile reload limit is in effect)
- [ ] Compiles: `./crobots -c myrobot.r` → no errors, `code utilization` comfortably below 100%
- [ ] Survives a full `-m100` series against at least the sample robots in `src/`
      and a few in `robots/`
