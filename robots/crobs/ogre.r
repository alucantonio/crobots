/*

    =====================================================
    =                                                   =
    =                       O G R E                     =
    =                                                   =
    =   ogre (o*ger) n. 1. in fairy tales and           =
    =        folklore, a man-eating giant.  2. a        =
    =        hideous, cruel man.  3. a slightly         =
    =        improved (compared to Hack_Atak) C         =
    =        robot program, with a greater deal of      =
    =        complexity and, hopefully,                 =
    =        survivability.                             =
    =                                                   =
    =         written by John Nordlie on 3/26/91        =
    =                                                   =
    =====================================================

*/


/* Procedures ... */


/* classical pythagorean distance formula */

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


/* tracking subroutine */

track(d,r,l)
int d,r,l;
{
  if (r > l)
    {
      if (scan(d-r,r) > 0)
        return(track(d-r,r/2,l));
      else
        if (scan(d+r,r) > 0)
          return(track(d+r,r/2,l));
        else
          if (scan(d,r) > 0)
            return(track(d,r/2,l));
          else
            return (d);
    }
  else
    return(d);
}



/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */

plot_course(xx,yy)
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



/*  Main program (as if you needed to be reminded) */

main() {
int x, y, x1, y1, range, velocity, resolution, max_cannon, dist, angle;

    max_cannon = 700;
    angle = 0;
    resolution = 10;
    x1 = rand(900) + 50;
    y1 = rand(900) + 50;
    drive((plot_course(x1, y1)), 100);
    while (1) {
        x = loc_x();
        y = loc_y();
        range = scan(angle, resolution);
        while ((range > 40) && (range < max_cannon)) {
            angle = track(angle, resolution, 2);
            range = scan(angle, 10);
            if (range > 40) {
                cannon(angle, range);   }
            angle = track(angle, resolution, 2);
            range = scan(angle, 10);
            if (range > 40) {
                cannon(angle, range);   }
            x = loc_x();
            y = loc_y();
            if (((distance(x,y,x1,y1)) < 100) || ((speed()) == 0)) {
                x1 = rand(900) + 50;
                y1 = rand(900) + 50;
                drive((plot_course(x1,y1)), 100);
                }
            }
        angle = angle + 19;
        if (angle > 360)
            angle = angle - 360;
        if (((speed()) == 0) || ((distance(x,y,x1,y1)) < 100)) {
            x1 = rand(900) + 50;
            y1 = rand(900) + 50;
            drive((plot_course(x1,y1)), 100);
        }
    }
}
