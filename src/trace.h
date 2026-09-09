
/*****************************************************************************/
/*                                                                           */
/*  trace.h - CSV state tracing (instrumentation, not part of the            */
/*            original CROBOTS)                                              */
/*                                                                           */
/*  Run with "-t <prefix>" and three files are written:                      */
/*    <prefix>_robots.csv    one row per motion step, per robot:             */
/*                           match,step,id,name,x,y,heading,speed,damage,    */
/*                           alive                                           */
/*    <prefix>_missiles.csv  one row per motion step per missile in flight   */
/*                           (exploding or flying):                          */
/*                           match,step,owner,x,y,heading,state              */
/*    <prefix>_events.csv    discrete events:                                */
/*                           match,step,kind,actor,target,detail             */
/*    kinds: fire (detail=degree), damage (detail=damage delta),             */
/*           death (detail=final damage), match_end (detail=total steps)     */
/*                                                                           */
/*  "step" is the motion-step index (a match's counted cycles are            */
/*  step * MOTION_CYCLES).  Coordinates are in the game's internal units,    */
/*  about 1/100 of a meter (the field is 0..1000 x 0..1000 meters).          */
/*                                                                           */
/*  Without "-t" none of the module's code is ever called and the program    */
/*  behaves exactly as before.                                               */
/*                                                                           */
/*****************************************************************************/

/* set by the command line parser in main() when -t is given */
extern char *trace_prefix;

int  trace_on();                 /* non-zero if tracing is enabled and usable */
void trace_motion_step(int matchno);    /* log one motion step's robot + missile state */
void trace_fire(int degree);     /* actor determined from cur_robot */
void trace_match_end(int matchno, int winner);   /* winner 1-based id, 0 = draw */
void trace_close();              /* flush and close the output files */

/* end of trace.h */
