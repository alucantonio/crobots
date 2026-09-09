# Crobots 2025 — top-8 Macro-pool strategy analyses

Per-robot strategy files for the eight strongest robots of the **Crobots 2025**
(40th Anniversary) "Macro" pool, from the standings at
<https://crobots.deepthought.it/home.php> (211,646 games/robot). Every robot is in the
local tree under `robots/2025/`; language and simulator facts are documented in
[../RULES.md](../RULES.md).

## The eight (rank order)

| # | robot | total % | F2F % | 3v3 % | 4v4 % | author | class | file |
| - | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | hulk_25 | **64.17** | 82.99 | 63.15 | 46.36 | Franco Cartieri | Midi (999 instr) | [hulk_25.md](hulk_25.md) |
| 2 | ironman_25 | 59.30 | 80.16 | 56.22 | 41.52 | Franco Cartieri | Macro (1993 instr) | [ironman_25.md](ironman_25.md) |
| 3 | jedi15 | 57.65 | **81.23** | **53.61** | 38.12 | Maurizio Camangi | Macro v15.05 | [jedi15.md](jedi15.md) |
| 4 | thor_25 | 56.37 | 79.30 | 49.91 | 39.90 | Franco Cartieri | Macro (1632 instr) | [thor_25.md](thor_25.md) |
| 5 | gerty6 | 49.76 | 68.26 | 45.70 | 35.33 | Olga S | Midi v6.01 | [gerty6.md](gerty6.md) |
| 6 | wall-e_vii | 49.23 | 71.41 | 43.42 | 32.87 | Maurizio Camangi | Micro v7.0 | [wall-e_vii.md](wall-e_vii.md) |
| 7 | hal9025 | 48.60 | 71.00 | 43.05 | 33.46 | Maurizio Camangi | Midi v13.04 | [hal9025.md](hal9025.md) |
| 8 | kerberos | 46.85 | 63.09 | 45.87 | 31.57 | Olga S | Micro, 71 lines | [kerberos.md](kerberos.md) |

kerberos is the 2025 **Micro Hall-of-Fame** winner; hulk_25 is the pool winner in
every format.

## Shared DNA (read these first)

The eight are not eight independent designs — they are **five proven routines reassembled
in different ways**:

### 1. The Cartieri F2F engine

```
hulk_25 main loop  ≡  ironman_25 F2f()  ≡  thor_25 F2f()
```
(only the function names change)

| hulk_25 | ironman_25 | thor_25 | role |
| --- | --- | --- | --- |
| `Rompi()` | `Missile()` | `Martello()` | precise lead shot, `(1200+rng)>>9` model |
| `Spacca()` | `Raggio()` | `Fulmine()` | fast shot, `rng*145/(145+Δ)` shrink |
| `Affina()` | `Affina()` | `Affina()` | ±13/12/10→1 refinement (identical) |
| `Ritrova()` | `Ritrova()` | `Ritrova()` | −84/−21/+126/+21/−168 recovery (identical) |
| — | `Vai()` | `Vai()` | `orng > 425` "keep patrolling" gate |

The geometry: quadrant pick (`90*((posy<<1)|(posx^posy))`), opposite corner at
210/300/120/30, central-square legs while the target is beyond 425 m, oscillation
`deg + 75 + (b^=1)*210` up close, and a double-fire on entry. See
[hulk_25.md](hulk_25.md) for the full state machine — one read covers all three.

### 2. The Tobey (2007) fire

```c
asin = sin(Δ)/14384;   acos = cos(Δ)/3796 - 230;
cannon(ang + (ang-oang)*((880+range)/482) - asin,
       range*230/(orange - range - acos));
```

- **kerberos** (`fire`, in `main`) — verbatim, plus `find()` ±13/12/11 and the
  5-step + recursive `search()`;
- **hal9025** (`fire()`) — same routine, only the look-ahead line moved inside the
  function;
- **ironman_25** (`Spara`) — same constants, adapted to the patrol legs.

Ancestor: `robots/2007/tobey.r` (lines 45-52 are identical). See
[kerberos.md](kerberos.md) and [hal9025.md](hal9025.md).

### 3. The one-step "doubling" shot

`cannon(2*ang - oang, 2*range - now)` — extrapolate the target one step of its last
movement, no trig:

- thor_25 `Fuoco()` (while driving) and `Saetta()` (while stopping),
- wall-e_vii `fire(d,v)`,
- gerty6 `fire2()`.

See [thor_25.md](thor_25.md) and [wall-e_vii.md](wall-e_vii.md).

### 4. Corner-hugging families

- **Bit-axis decode** `dir&320` / `dir&384` — kerberos, gerty6 (axis and side from the
  heading, no branches);
- **Wall-band tricks** `%880 < 120` (880+120 = 1000) — wall-e_vii runs, gerty6 dance,
  hal9025 crazy loop; `%840 < 160` — jedi15 F2F, inherited from **loneliness /
  carillon** (2020, `robots/2020/`);
- **Terminal doors** with no exit: gerty6's `while(e<2)` dance (F2F), hal9025's
  `while(1)` crazy loop — both entered once, never left;
- **Coasting split**: ironman_25/thor_25 `while (speed() > 59) ;` (wait) vs jedi15's
  `/* while(speed()>59); */` (don't wait).

### 5. Enemy-count gates (what promotes them to attack)

| robot | gate |
| --- | --- |
| hulk_25 / ironman_25 / thor_25 | `Radar()`-style 80° corner arc, `< 2 → F2f()` |
| jedi15 | `enemies = 3 − (6 scans)`, bands `>1 / ==1 / <1` |
| hal9025 | `radar(deg1+70*clock)` + 6-cone count every 12th arrival (`timer%12`) |
| wall-e_vii | `timer < 2` recovery sweep, 7 cones of 20° |
| gerty6 | `e < 2` after the 131° recovery sweep (→ terminal dance in F2F) |

## Suggested reading order

1. [hulk_25.md](hulk_25.md) — the champion's engine, the shortest path to the trio;
2. [thor_25.md](thor_25.md) — same engine plus the defensive patrol;
3. [ironman_25.md](ironman_25.md) — same engine, biggest codebase, Tobey patrol fire;
4. [kerberos.md](kerberos.md) — the smallest robot, the cleanest Tobey fire;
5. [wall-e_vii.md](wall-e_vii.md) — the doubling-fire and `%880` idiom;
6. [gerty6.md](gerty6.md) — the bit-packed state machine and the terminal dance;
7. [hal9025.md](hal9025.md) — explicit attack/defence state bits over the same fire core;
8. [jedi15.md](jedi15.md) — the count-based state machine and its 2020 inspirations.

## Where to try them

```sh
cd /home/alucantonio/crobots
make -C src            # builds ./crobots
./crobots -m200 robots/2025/hulk_25.r   robots/2025/kerberos.r
./crobots -m100 robots/2025/hal9025.r   robots/2007/tobey.r   # …and the ancestor
```

Each file above ends with robot-specific `./crobots -m …` recipes.

## Data gap

The site's deep `sql2html` report pages (e.g. the 1990–2025 all-time Macro final,
`id=1g2f9bh`) return **403** and could not be pulled; only the 2025 pool standings and
the 2025 Hall of Fame (all 44 winners verified present locally) were usable.
