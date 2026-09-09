/* a sitting duck... */
/* uses improved scan routines of the infamous rabbit8.r */

int ang,range,course,ang1,ang2,range1,range2,sang;

main() {
    ang = 78;  /* 94 - 16 */
    course = plot_course (1000,500);
    drive (course,100); 
    while (1) {
        ang += 16;
        if (ang > 274) ang = 94;
        range = scan(ang,8);
        if (range && (range <= 700)) {
            sang = ang;
            if (!shoot()) ang -= 32;
        }
    }
} /* end of main */ 

shoot()
{
    int count;

/* scan 8ø at a time */
    sang -= 4;
    count = 2;
    while (count && !(range = scan(sang,4))) {
        sang += 8;
        --count;
    }
    if (!range) return 0;
/* now 4ø at a time */
    sang -= 2;
    count = 2;
    while (count && !(range = scan(sang,2))) {
        sang += 4;
        --count;
    }
    if (!range) return 0;
    cannon(sang,range);
/* now 2ø at a time */
    sang -= 1;
    count = 2;
    while (count && !(range = scan(sang,1))) {
        sang += 2;
        --count;
    }
    if (!range) return 0;
    while (!cannon(sang,range));
/* now 1ø at a time */
    --sang;
    count = 2;
    while (count && !(range = scan(sang,1))) {
        ++sang;
        --count;
    }
    if (!range) return 0;
    while (!cannon(sang,range));
    return 1;
}

distance(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  int x,y,d;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}

/* plot_course - figure out which heading to go */

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

/* end of rabbit.r */
