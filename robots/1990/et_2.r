/* et_2.r - Luigi Morelli */

int d;


main()

int degree;
int range;
int gradi;

{
  while (1) {
    d = damage();
    degree = plot_course(rand(1000), rand(1000));
    gradi = degree;
    drive (degree,50);
    while ((loc_x() >=13) && (loc_x() <=983) && (loc_y() >=15) && (loc_y() <=984))
    {
      gradi += 15;
      while ((range = scan (gradi,6)) > 0) {
        cannon (gradi,range);
        drive (gradi,50);
      }
      if (d != damage())
        fuga();
    }
    drive (degree,0);
  }
}


/* fuga function, permette il rientro qualora il danno */
/* diventi ingente */
fuga()
int direz;

{
  direz = plot_course (512,487);
  while ((loc_x() > 50) && (loc_y() > 50) && (loc_y()< 950) && (loc_x() < 950))
    drive (direz,100);
  drive (direz,20);
  d = damage();
}

/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
plot_course(xx,yy)
int xx, yy;

{
  int dd;
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
      dd = 90;        /* north */
    else
      dd = 270;       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
        dd = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
        dd = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
    } else {
      if (xx > curx)
        dd = atan((scale * y) / x);        /* north-east, quadrant 1 */
      else
        dd = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (dd);
}

