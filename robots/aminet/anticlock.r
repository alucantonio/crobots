/*Me myself and I
laza
 clockwork.r
 main */
main()
{
   int   range, sangl, angl, nx, ny, radius, rot;

   angl = plot_course(500, 500) + 180; 
   rot = angl + 10;
   sangl = rand(360);
   while(1)
   {
      if (rot >= 360)
         rot -= 360;
      radius = 300;
      nx = 500 + (radius * cos(rot)) / 100000;
      ny = 500 + (radius * sin(rot)) / 100000;
      angl = plot_course(nx, ny);
      drive(angl, 49);
      while((loc_x() - nx > 3) || (nx - loc_x() > 3))
      {
         range = scan(sangl, 10);
         if (range != 0 && range < 700)
         {
            cannon(sangl, range);
            sangl -= 20;
         }
         sangl += 10;
      }
      rot += 20;
   }
}

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
  return(d);
}
