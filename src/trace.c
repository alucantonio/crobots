
/*****************************************************************************/
/*                                                                           */
/*  trace.c - CSV state tracing (instrumentation, not part of the            */
/*            original CROBOTS; see trace.h for the file formats)            */
/*                                                                           */
/*  Design notes:                                                            */
/*    - All entry points are no-ops (return/exit on the first line) unless   */
/*      main() set trace_prefix via "-t <prefix>".                           */
/*    - One row per motion step; robot damage/death events are derived by    */
/*      diffing consecutive rows, so no hooks are needed in motion.c.        */
/*    - Files are opened lazily and shared across all matches of a run;      */
/*      each row carries the match number.                                   */
/*    - If any file cannot be created, tracing silently disables itself.     */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>
#include <string.h>

#include "crobots.h"
#include "trace.h"

char *trace_prefix = (char *) 0;   /* storage, read by main()'s parser */

static FILE *robots_f   = (FILE *) 0;
static FILE *missiles_f = (FILE *) 0;
static FILE *events_f   = (FILE *) 0;
static int   disabled   = 0;
static int   cur_match  = 0;
static long  step       = 0L;
static int   last_alive[MAXROBOTS];
static int   last_dam[MAXROBOTS];


/* trace_on - cheap gate used by all call sites */

int trace_on()
{
  if (disabled)
    return 0;
  return (trace_prefix != (char *) NULL && trace_prefix[0] != 0);
}


/* csv_field - emit a string as a safe CSV field (quote if it needs it) */

static void csv_field(f, s)
FILE *f;
char *s;
{
  static char out[64];
  char *t;
  int n;

  if (strpbrk(s, ",\"\n") == (char *) NULL && strlen(s) < 60) {
    fputs(s, f);
    return;
  }
  /* copy and double any embedded quotes */
  out[0] = 0;
  n = 0;
  for (t = s; *t && n < 58; t++) {
    if (*t == '"')
      out[n++] = '"';
    out[n++] = *t;
  }
  out[n] = 0;
  fputc('"', f);
  fputs(out, f);
  fputc('"', f);
}


/* open_files - create the three output files and write headers */

static void open_files()
{
  char name[1024];

  strncpy(name, trace_prefix, 512);
  name[512] = 0;
  strcat(name, "_robots.csv");
  robots_f = fopen(name, "w");

  strncpy(name, trace_prefix, 512);
  name[512] = 0;
  strcat(name, "_missiles.csv");
  missiles_f = fopen(name, "w");

  strncpy(name, trace_prefix, 512);
  name[512] = 0;
  strcat(name, "_events.csv");
  events_f = fopen(name, "w");

  if (robots_f == (FILE *) NULL || missiles_f == (FILE *) NULL ||
      events_f == (FILE *) NULL) {
    /* partial or failed open - abandon tracing instead of half files */
    if (robots_f)   fclose(robots_f);
    if (missiles_f) fclose(missiles_f);
    if (events_f)   fclose(events_f);
    robots_f = missiles_f = events_f = (FILE *) NULL;
    disabled = 1;
    return;
  }
  fprintf(robots_f,   "match,step,id,name,x,y,heading,speed,damage,alive\n");
  fprintf(missiles_f, "match,step,owner,x,y,heading,state\n");
  fprintf(events_f,   "match,step,kind,actor,target,detail\n");
}


/* ensure_open - first-use setup; non-zero means "do not write" */

static int ensure_open()
{
  if (!trace_on())
    return 1;
  if (robots_f == (FILE *) NULL)
    open_files();
  return (robots_f == (FILE *) NULL);
}


/* event - one row in the events file, dated at the current step */

static void event(kind, actor, target, detail)
char *kind;
int actor;
int target;
int detail;
{
  fprintf(events_f, "%d,%ld,%s,%d,%d,%d\n",
	  cur_match, step, kind, actor, target, detail);
}


/* trace_motion_step - the main per-step hook (see trace.h for formats) */

void trace_motion_step(matchno)
int matchno;
{
  int i, j;
  int st;

  if (ensure_open())
    return;

  if (matchno != cur_match) {
    cur_match = matchno;
    step = 0L;
    for (i = 0; i < MAXROBOTS; i++) {
      last_alive[i] = 1;
      last_dam[i] = 0;
    }
  }
  step++;

  /* robots, plus death / damage events derived from the delta */
  for (i = 0; i < MAXROBOTS; i++) {
    if (robots[i].name[0] == 0)
      continue;
    if (last_alive[i] && robots[i].status == DEAD)
      event("death", 0, i + 1, robots[i].damage);
    else if (robots[i].damage > last_dam[i])
      event("damage", 0, i + 1, robots[i].damage - last_dam[i]);
    last_alive[i] = (robots[i].status != DEAD);
    last_dam[i] = robots[i].damage;
    fprintf(robots_f, "%d,%ld,%d,", matchno, step, i + 1);
    csv_field(robots_f, robots[i].name);
    fprintf(robots_f, ",%d,%d,%d,%d,%d,%d\n",
	    robots[i].x, robots[i].y,
	    robots[i].heading, robots[i].speed,
	    robots[i].damage, (robots[i].status != DEAD));
  }

  /* missiles that are actually flying or exploding */
  for (i = 0; i < MAXROBOTS; i++) {
    for (j = 0; j < MIS_ROBOT; j++) {
      st = missiles[i][j].stat;
      if (st == AVAIL)
	continue;
      if (st == FLYING)
	fprintf(missiles_f, "%d,%ld,%d,%d,%d,%d,flying\n",
		matchno, step, i + 1,
		missiles[i][j].cur_x, missiles[i][j].cur_y,
		missiles[i][j].head);
      else if (st == EXPLODING)
	fprintf(missiles_f, "%d,%ld,%d,%d,%d,%d,exploding\n",
		matchno, step, i + 1,
		missiles[i][j].cur_x, missiles[i][j].cur_y,
		missiles[i][j].head);
    }
  }
}


/* trace_fire - called from c_cannon() after a missile is set in flight */

void trace_fire(degree)
int degree;
{
  int r;

  if (ensure_open())
    return;
  r = cur_robot - &robots[0];
  event("fire", r + 1, 0, degree);
}


/* trace_match_end - outcome event, then flush everything */

void trace_match_end(matchno, winner)
int matchno;
int winner;
{
  if (ensure_open())
    return;
  cur_match = matchno;
  step++;
  event("match_end", winner, 0, (int) step);
  fflush(robots_f);
  fflush(missiles_f);
  fflush(events_f);
}


/* trace_close - flush and close (called once at program exit) */

void trace_close()
{
  if (robots_f == (FILE *) NULL)
    return;
  fflush(robots_f);
  fflush(missiles_f);
  fflush(events_f);
  fclose(robots_f);
  fclose(missiles_f);
  fclose(events_f);
}

/* end of trace.c */
