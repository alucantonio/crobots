/*
                            Converted by Karl-Heinz Mauerlich from NOVA.PR

Selected from a zip archive containing the P-ROBOTS simulator (Crobots clone in Pascal)

*/


int Dir;
int Ang;
int Dist;
int Width;
int Incr;

/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
int plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */
  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {      /* x is zero, we either move due north or south */
    if (yy > cury)
      d = 90;        /* north */
    else
      d = 270;       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
        d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */ 
    } else {
      if (xx > curx)
        d = atan((scale * y) / x);        /* north-east, quadrant 1 */
      else
        d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (d);
}

 main() {                           /* Main routine */

  Dir = 0;
  Width = 10;
  Incr = 20;
  Ang = plot_course(1000, 1000);

  while(1) {                        /* Main loop */

    while (loc_y() < 900) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(500, 0);
    while (speed() > 40) Ang = plot_course(500, 0);

    while (loc_y() > 200) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(0, 1000);
    while (speed() > 40) Ang = plot_course(0, 1000);

    while (loc_x() > 100) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(1000, 500);
    while (speed() > 40) Ang = plot_course(1000, 500);

    while (loc_x() < 800) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(0, 0);
    while (speed() > 40) Ang = plot_course(0, 0);

    while (loc_y() > 100) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(500, 1000);
    while (speed() > 40) Ang = plot_course(500, 1000);

    while (loc_y() < 800) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(1000, 0);
    while (speed() > 40) Ang = plot_course(1000, 0);

    while (loc_x() < 900) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(0, 500);
    while (speed() > 40) Ang = plot_course(0, 500);

    while (loc_x() > 200) {
      drive(Ang, 100);
      Dist = scan(Dir, Width);
      if (Dist > 50) {
        cannon(Dir, Dist);
        cannon(Dir, Dist);
      }
      else
        Dir = Dir + Incr;
    }
    drive(Ang, 40);
    Ang = plot_course(1000, 1000);
    while (speed() > 40) Ang = plot_course(1000, 1000);

  }
}