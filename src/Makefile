# Makefile for CROBOTS on modern Linux/Unix (64-bit, gcc/clang)
#
# The original Xenix makefile is kept as makefile.unx. This one drops the
# Xenix-only cc flags (-K -i), links against ncurses instead of the long-gone
# "-lcurses -ltermlib" pair, and compiles the pre-generated grammar.c and
# lexanal.c so that yacc and lex are not required.
#
#   make            build ./crobots (dynamic ncurses -- the normal case)
#   make static     link ncurses statically (portable across distros)
#   make clean      remove objects and the binary
#
# Override the ncurses flags if your headers live somewhere unusual:
#   make NCURSES_CFLAGS=-I/opt/foo/include NCURSES_LIBS="-L/opt/foo/lib -lncurses"

CC       = cc

# -std=gnu89           : this is 1985 K&R-ish C
# -fno-strict-aliasing : the robot VM plays type games the optimiser must not
#                        exploit
# -include stdlib.h/string.h : the sources predate those headers; without real
#                        prototypes, pointer-returning libc calls are truncated
#                        to int on LP64 and the interpreter crashes
CFLAGS   = -O2 -std=gnu89 -fno-strict-aliasing -DUNIX \
           -include stdlib.h -include string.h

NCURSES_CFLAGS  =
NCURSES_LIBS    = -lncurses
NCURSES_LDFLAGS =	# e.g. -L/opt/foo/lib, used by the `static' target

LIBS     = $(NCURSES_LIBS) -lm

OBJS     = main.o grammar.o lexanal.o compiler.o cpu.o intrins.o \
           display.o screen.o motion.o

HDRS     = crobots.h compiler.h tokens.h

all: crobots

crobots: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LIBS)

static: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o crobots $(NCURSES_LDFLAGS) \
	  -Wl,-Bstatic -lncurses -ltinfo -Wl,-Bdynamic -lm

%.o: %.c $(HDRS)
	$(CC) $(CFLAGS) $(NCURSES_CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) crobots

.PHONY: all static clean
