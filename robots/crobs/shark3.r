/* shark3.r  -  SHARK circles continuously looking for a kill
                Version 3 with simplified aim & fire routine

                Written by David Meyers - 6362 Amberly St. - SD 92120
*/

/* main */

int dir,range,drv,r1,r2;

main()
{
  int cnt;
  drv = plot_course(0,0);  /* run to corner at full speed */
  while (loc_x() > 50 || loc_y() > 50)  /* wait 'till we get there */
      drive (drv,100);
  drive(drv,0);
  drv = 0;  r1 = 0;  r2 = 180;
  while (speed() >= 50)
      ;
  drive(drv,100);

  while (1) {         /* loop is executed forever */
    dir = r1;  cnt = 0;
    while (dir < r2) {
      ++cnt;
      range = scan(dir,10);
      if (range > 0 && range < 700)
         shoot();
      dir += 45;
    }
  check();
  }
}  /* end of main */


shoot()
{
   int cnt, fudge;
   cnt = 0;
   if (range > 40)
      cannon (dir,range);
   while (1) {
     ++cnt;
     dir -= 5;         /* back up & scan again */
     range = scan(dir,5);
     if (range == 0) {
        dir += 10;
        range = scan(dir,5);
        if (range == 0) {
           dir -= 40; /* set to re-scan area */
           check();
           return;    /* missed it, so return to main scan again */
        }
     }
     if (range > 700) {
        check();
        return;
     }
     fudge = 0;
     if (range > 450)
        fudge = 100;
     if (range < 400 && range > 100)
        fudge = -75;
     if (range+fudge > 40)
        cannon (dir,range+fudge);
     check();
   }
}


/* check to see if we nearing wall to change course */
check()
{
   int x,y;
   x = loc_x();
   y = loc_y();
   drive (drv,100);
   if ((drv == 0 && x > 850) || (drv == 90 && y > 850) || (drv == 180 && x < 150) || (drv == 270 && y < 150)) {
      drive (drv,0);
      while (speed() >= 50) ;
      drv += 90;
      drv = drv % 360;
      if (drv ==   0) { r1=000; r2=180;}
      if (drv ==  90) { r1=090; r2=270;}
      if (drv == 180) { r1=180; r2=360;}
      if (drv == 270) { r1=270; r2=450;}
      drive(drv,100);
   }
   return;
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



