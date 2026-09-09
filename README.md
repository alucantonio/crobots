CROBOTS
=======

Visit the CROBOTS web pages at [http://tpoindex.github.io/crobots/](http://tpoindex.github.io/crobots/)

----------------------------

This is the source code of the original CROBOTS game that I wrote in 1985, now
released under GPLv2.   

I probably will **not** be updating CROBOTS, so feel free to fork the code.

## Tracing robot state (added by this tree)

This build adds an optional `-t<path>` flag that records robot and missile state to
CSV files while matches run, one row per motion update:

    ./crobots -m5 -t/traces/cro src/sniper.r src/rook.r

Note the 1985-style argument: the path is *appended* to the `-t` character, not
passed as a separate word. Three files are written:

| file                | contents                                                        |
| ------------------- | --------------------------------------------------------------- |
| `<path>_robots.csv` | `match,step,id,name,x,y,heading,speed,damage,alive` per step    |
| `<path>_missiles.csv` | one row per missile in flight: `match,step,owner,x,y,heading,state` |
| `<path>_events.csv` | `match,step,kind,actor,target,detail`: `fire`, `damage` (delta), `death`, `match_end` |

Coordinates are in the game's internal units (divide by 100 for metres; the
battlefield is 1000 × 1000 m). One `step` is one motion update, so
`step × 15` equals the cycle count printed for each match. Without `-t` the
program behaves exactly as before; the feature lives in `src/trace.c`, kept
out of the 1985 logic.

To visualise a match, `tools/plot_crobots.py` renders each robot's trajectory
from the robot CSV, with start points, survivor end points and destruction markers:

    python3 tools/plot_crobots.py traces/cro 1   # writes traces/cro_match1.png

Original Readme
---------------

CROBOTS ("see-robots") is a game based on computer programming.
Unlike arcade type games which require human inputs controlling
some object, all strategy in CROBOTS must be complete before the
actual game begins.  Game strategy is condensed into a C language
program that you design and write.  Your program controls a robot
whose mission is to seek out, track, and destroy other robots,
each running different programs.  Each robot is equally equipped,
and up to four robots may compete at once.  CROBOTS is best
played among several people, each refining their own robot
program, then matching program against program.

CROBOTS consists of a C compiler, a virtual computer, and
battlefield display (text graphics only, monochrome or color).
The CROBOTS compiler accepts a limited (but useful) subset of
the C language.  The C robot programs are aided by hardware
functions to scan for opponents, start and stop drive mechanisms,
fire cannons, etc.  After the programs are compiled and loaded
into separate robots, the battle is observed.  Robots moving,
missiles flying and exploding, and certain status information are
displayed on the screen, in real-time.

CROBOTS is distributed under terms of the GNU General Public
License, version 2.


