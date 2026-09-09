# Building CROBOTS on modern Linux

CROBOTS is 1985 C written for 16-bit DOS and Xenix. It needs a handful of
changes to build and *run correctly* on a 64-bit toolchain. This tree has
those changes applied; `src/Makefile` is a new, portable makefile (the
original Xenix one is untouched as `src/makefile.unx`).

## Build

    cd src
    make            # needs a C compiler and ncurses headers (ncurses/libncurses-dev)
    ./crobots -m10 rabbit.r sniper.r rook.r counter.r

`make static` links ncurses statically if you want a binary that travels
between distros. `make clean` removes objects and the binary.

The prebuilt `./crobots` at the top of this tree was compiled this way with
ncurses linked statically, so it only needs glibc (2.34 or newer) at runtime.

## Running

    ./crobots robot1.r robot2.r [...]        # single match, curses display
    ./crobots -m50 robot1.r robot2.r [...]   # 50 matches, no display, score table

Sample robots are in `src/` (`rabbit.r`, `sniper.r`, `rook.r`, `counter.r`,
`target.r`). The manual is `docs/crobots_manual.html` and `src/crobots.doc`.
Display mode wants at least an 80x24 terminal.

## What had to change

Four fixes, all marked with `patched` comments in the source.

1. **`crobots.h` -- `struct instr`: `var1` and `var2` are now `unsigned short`.**
   This is the one that actually matters. Variable slots are tagged with
   `#define EXTERNAL 0x8000`, and the interpreter recovers the index with
   `var1 & ~EXTERNAL`. On the original 16-bit compiler `int` was 16 bits and
   `~EXTERNAL` was `0x7fff`. On a 32/64-bit `int`, the signed `short` 0x8000
   sign-extends to `0xffff8000`, `~EXTERNAL` is `0xffff7fff`, and the index
   comes out around -65536 -- so every access to an external variable read
   about 512 KB below the pool. Result: a segfault the moment match play
   started. Making the fields unsigned fixes all the masking sites at once.

2. **`src/Makefile` force-includes `<stdlib.h>` and `<string.h>`.** The sources
   predate those headers, so `malloc`, `strrchr`, `atol` and friends were
   implicitly declared as returning `int` -- which truncates a 64-bit pointer.
   The three old K&R declarations that conflict with the real prototypes
   (`char *malloc();` in `compiler.c`, `int srand();` in `main.c` and
   `intrins.c`) were removed.

3. **`lexanal.c`: `FILE *yyin = {stdin}, *yyout = {stdout};`** is not a
   constant initializer in ISO C. They are now set on entry to `yylex()`.
   (CROBOTS overrides `input`/`output`/`ECHO` to use its own `f_in`/`f_out`,
   so these only matter for lexer debug output.)

4. **`main.c`: `fprintf("\n\nReady to debug...")`** was missing its stream
   argument -- changed to `printf`. It sits on the `-d` debug path.

The makefile also drops the Xenix-only `cc` flags (`-K -i`), replaces
`-lcurses -ltermlib` with `-lncurses`, and compiles the checked-in
`grammar.c` / `lexanal.c` instead of regenerating them, so yacc and lex
are not needed.

Verified with 30 matches of all four sample robots under
`-fsanitize=address` with no reports, plus a full curses-display match.
