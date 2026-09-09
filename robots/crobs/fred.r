/* C-bots Tournament 8th place: Fred.r */
/*
** fred.r CROBOTS program
**
** fred is a simple variant of rabbit - it mainly wanders around
** randomly, but when it finds a target to fire at, fred will
** track, fire at, chase, and hopefully destroy the target.
**
** The wide_scan() routine scans an area within 10 degrees,
** and gradually narrows it down until it knows the target
** within 1 degree - then it fires almost continuously.
** Fred also reverses direction when hit.  Note that
** fred keeps on firing at its target when it does this.
** Fred isn't too sophisticated, but he usually pummels other
** 'subtle' programs pretty well.  However, Fred has some
** real trouble against other offensive-oriented programs.
*/

int curface;

main()
{
  int tx,ty;

  curface=0;

  while(1) {
    /* move randomly */
    tx=rand(800)+100;
    ty=rand(800)+100;
    go (tx,ty);
  }

}  /* end of main */



/* go - go to the point specified */

go (dest_x, dest_y)
int dest_x, dest_y;
{
  int course,dist,curd,targ;

  /* find the destination */
  course = plot_course(dest_x,dest_y);
  dist=5;
  curd=damage();
  drive(course,50);
  while (--dist>0)
    {
       /* if a target in range, fire until it leaves our scanner */
       while (((targ=wide_scan(curface)) != -1)
                && (curd==damage()))
       {
         curface=targ;
         while (((targ=scan(curface,1)) >10)
                && (targ<700))
         {
           drive(curface,50); /* chase and fire */
           cannon(curface,targ);
         }
       }
       if (curd < damage())
       {
         course=course+180; /* reverse direction if hit */
         drive(course,100);
         dist=dist+3;
         curd=damage();
       }
       curface=curface+20; /* couldn't fire - look elsewhere */
    }
  drive(course,0);
  while (speed() > 10)
    ;
}

/* distance forumula */

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y,d;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));

  return(d);
}

/*
** wide scan - given an angle, finds robot (if any) within 10 degrees,
** and narrows it down to 1 degree accuracy
** ignores robots outside 700 range
*/
wide_scan(scanangle)
int scanangle;
{
  int scanrange,try1,try2,r1,r2;

  /* trivial checks - for speed */
  if ((r1=scan(scanangle,10)) == 0)
    return -1;
  if (r1 >699)
    return -1;

  scanrange=20;
  while (scanrange>1) /* scan until within 1 degree accuracy */
  {
    scanrange=scanrange/2;
    try1=scanangle-scanrange;
    try2=scanangle+scanrange;
    r1=scan(try1,scanrange);
    if (r1==0) r1=1000;
    r2=scan(try2,scanrange);
    if (r2==0) r2=1000;
    if (r1<r2)
      {scanangle=try1;cannon(try1,r1);}
    else {scanangle=try2;cannon(try2,r2);}
  }
  if (scanangle<0) scanangle=scanangle+360;

  return scanangle;
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
/* end of fred.r */


