
/*  h-k.r     Hunter-Killer

    Robot source by John Hardin           02/27/86
                    Westminster College
                    1840 South 1300 East
                    Salt Lake City, Utah  84105
                    [74076,22]

    strategy: Move at medium speed in the direction of the last detected
              robot while scanning 360 degrees quickly. If a robot is
              detected, charge at it at high speed, firing when in range.
              If hit while scanning, run to a random location and resume.
              Don't worry about running into a wall or another robot, since
              that only causes 2% damage.  */

/* globals */
int d;                /* last damage check */
int dir;              /* direction looking & firing */
int range;


/* main */
main()
{
  d = damage();      /* get starting damage */
  dir = 0;           /* starting scan direction */

  while (1)          /* loop is executed forever */
  {
    sweep();         /* sweep arena at high speed */
    target();        /* acquire and attack detected robot */
  }
}                    /* end of main */


/* sweepscan arena for target */
sweep()
{
int range;

  drive(dir,40);     /* drive at medium spped towards last target */
  dir /= 10;         /* scan only even 10-degree slices */
  dir *= 10;
  while (1)          /* scan until we see another robot */
  {
    d = damage();           /* save current level of damage */
    while (damage() == d)   /* scan until we take a hit */
    {
       dir += 10;               /* increment scan direction */
       dir %= 360;              /* MOD 360 */
       range = scan(dir,10);    /* wide-range scan */
       if (range > 0) return;   /* GOT ONE! */
    }                       /* continue scanning */
    run();                  /* Ouch! let's get out of here! */
  }
}                    /* end of sweep */


/* search for and attack target */
target()
{
int startdir;        /* direction robot originally seen at */
int curdir;          /* direction we're currently looking */

  d = damage();      /* save current damage */
  startdir = dir;    /* save original direction */
  curdir = dir - 5;  /* back up 5 degrees */
  while (curdir < startdir + 7)  /* until we've looked through ten degrees */
  {
    if (attack(curdir) > 0) /* is somebody there? */
    {
      startdir = dir;           /* yes - Blast him! */
      curdir = startdir - 6;    /* back up the scanner again so we don't */
    }                           /* lose him and keep looking */
    curdir += 2;                /* increment scan direction */
    if (d != damage()) return;  /* Ouch! Start scanning again */
  }                         /* We've looked ten degrees and seen nothing */
}                    /* start scanning again */


/* attack robot at direc */
attack(direc)
{
int gotone;          /* got robot flag */

  gotone = 0;        /* don't got one */
  dir = direc;       /* look in direc */
  range = scan(dir,3);  /* narrow resolution */
  while (range > 0)     /* keep attacking while he's there */
  {
    if (range > 150) drive(dir,100);   /* charge! */
       else drive(dir + 180,100);      /* we're too close - back up! */
    if (range < 701) cannon(dir + 3,range);   /* fire! */
    range = scan(dir,3);               /* check target again */
    gotone = 1;                        /* flag that we've a target */
  }
  if (gotone > 0) drive(dir,50);   /* if we've lost him, trundle along */
  return(gotone);                  /* towards where we last saw him */
}                                  /* end of attack */


/* RUN AWAY!! */ /* this code taken almost verbatim from rabbit.r */
run()
{
  go(rand(1000),rand(1000));
} /* end of run */

/* go to the point specified */
go (dest_x, dest_y)
int dest_x, dest_y;
{
int course;

  course = plot_course(dest_x,dest_y);
  drive(course,100);     /* full speed ahead! */
  while(distance(loc_x(),loc_y(),dest_x,dest_y) > 30 && speed() > 0);
                         /* fatal bug in rabbit.r: speed check ^ missing */
}                        /* speed check absolutely necessary! Without it,
                            what happens if we run into another robot?   */

/* distance formula */

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));

  return(d);
}

/* figure out which heading to go */
plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */

  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {
    if (yy > cury)
       d = 90;
    else
       d = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
         d = 360 + atan((scale * y) / x);
      else
         d = 180 + atan((scale * y) / x);
    } else {
      if (xx > curx)
         d = atan((scale * y) / x);
      else
         d = 180 + atan((scale * y) / x);
    }
  }
  return (d);
}
