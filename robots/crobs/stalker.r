/* Robot Name .: STALKER.R                                  */
/* Programmer .: Dave Richardson                            */
/*             : Rancho Penasquitos                         */
/*             : 619-484-0287  619-458-7966                 */
/* Strategy ...: Run the perimeter looking fore/side/back   */
/*               If too much damage, change course          */
/*                                                          */
/* Notes ......: This robot uses some of the code of the    */
/*               sniper.r and mad_max2.r robots             */

/* external variables, that can be used by any function */
int corner;           /* current corner 0, 1, 2, or 3 */
int c0x, c0y;         /* corner 0 x and y */
int c1x, c1y;         /*   "    1 "  "  " */
int c2x, c2y;         /*   "    2 "  "  " */
int c3x, c3y;         /*   "    3 "  "  " */
int x, y;

int s0, s1, s2, s3;   /* starting scan position for corner 0 - 3 */
int d;                /* last damage check        */
int fdir;             /* first dir for scan sweep */
int curx, cury;
int scale;
int range;            /* range to target */
int tgtx, tgty;
int scan_angle;
int fwd1;
int mid1;
int bak1;
int tdist;
int fang;
int inrange;
int endgame;
int stalker;


/* main */
main()
{
  /* initialize the corner info */
  /* x and y location of a corner, and starting scan degree */

  c0x = 50;  c0y = 40;  s0 = 530;   /* corner 0 lower left  */
  c1x = 40;  c1y = 950; s1 = 440;   /* corner 1 upper left  */
  c2x = 950; c2y = 960; s2 = 350;   /* corner 2 upper right */
  c3x = 960; c3y = 50;  s3 = 620;   /* corner 3 lower right */

  scale = 100000;  /* scale for trig functions */

  if (loc_x() > 500)
     {
     if (loc_y() > 500)
        {
        corner = 2;
        }
     else
        {
        corner = 3;
        }
     }
  else /* curx <= 500 */
     {
     if (loc_y() > 500)
        {
        corner = 1;
        }
     else
        {
        corner = 0;
        }
     }
  stalker = endgame = inrange = 0;

  while (1)           /* loop is executed forever */
  {
     move_out();      /* Head toward next corner */
  }

}                     /* end of main */

/* move_out function to move to a different corner */
move_out() {
  int angle;
  int forwards;
  int backwards;
  int loop;
  int sighted;

  if (corner == 3)
     corner = 0;
  else
     corner = corner + 1;
                           /* first scan 10 deg to right */
  if (corner == 0) {       /* set new x,y and scan start */
    x = c0x;
    y = c0y;
    fdir = s0;            /* 180 left -10 */
  }
  else if (corner == 1) {
    x = c1x;
    y = c1y;
    fdir = s1;            /* 90 up -10 */
  }
  else if (corner == 2) {
    x = c2x;
    y = c2y; 
    fdir = s2;            /* 0 right -10 */
  }
  else { /* corner == 3 */
    x = c3x;
    y = c3y;
    fdir = s3;            /* 270 down -10 */
  }

  /* find the heading we need to get to the desired corner */
  angle = plot_course(x,y);

  /* start drive train, full speed */
  drive(angle,100);

  /* keep traveling until we are close to the turn point */

  forwards = angle;
  fwd1 = 9999;
  backwards = fdir - 170;
  bak1 = 0;
  if (stalker == 0 && inrange == 0)
    {
    scan_angle = fdir;
    mid1 = 9999;
    fang = 0;
    }
  else
    {
    scan_angle = plot_course(tgtx,tgty);
    while (scan_angle < backwards) scan_angle += 360;
    }
  inrange = 0;
  d = damage();

  while (ok_to_run())
     {
     range=scan(scan_angle,10);
     if ( ((range > 40) && (range <= 740)) || (stalker && range > 40) )
        {
        scan_angle -= 15;
        loop = 7;
        sighted = 0;
        while ((sighted == 0 || sighted > 740) && loop && ok_to_run())
          {
          scan_angle += 2;
          sighted = scan(scan_angle,1);
          if (sighted > 740 && stalker) sighted = 740;
          --loop;
          }
        if (sighted)
          {
          range = sighted;
          if (mid1<range)
            {
            tdist = range+(range/4);
            }
          else
            {
            if (mid1>range)
              {
              tdist = range-(range/5);
              }
            else /* mid1 == range */
              {
              tdist = range+(range/6);
              }
            }
          if (fang)
            {
            if (fang<scan_angle)
              {
              while(cannon(scan_angle+5,tdist)==0);
              }
            else if (fang>scan_angle)
              {
              while(cannon(scan_angle-4,tdist)==0);
              }
            else
              {
              while(cannon(scan_angle+1,tdist)==0);
              }
            }
          else
            {
            while(cannon(scan_angle,tdist)==0);
            }
          inrange = range;
          if (--endgame <0) endgame = 0;
          }
        fang = scan_angle;
        mid1 = range;
        scan_angle += 30;
        }
     scan_angle -= 20;
     if (scan_angle <= backwards)
        {
        scan_angle = fdir;
        }

     if (ok_to_run())
       {
       range=scan(forwards,5);
       if ((range > 40) && (range <= 740))
          {
          if (fwd1<range)
            {
            tdist = range+(range/5);
            }
          else
            {
            if (fwd1>range)
              {
              tdist = range;
              }
            else /* fwd1 == range */
              {
              tdist = range+(range/6);
              }
            }
          while (cannon(forwards,tdist)==0);
          fwd1 = range;
          }
       range=scan(backwards+90,15);
       if ((range > 40) && (range <= 740))
          while(cannon(backwards+90,range)==0);
          
       range=scan(backwards,10);
       if ((range > 40) && (range <= 740))
          {
          if (bak1<range)
            {
            tdist = range;
            }
          else
            {
            if (bak1>range)
              {
              tdist = range-(range/5);
              }
            else /* bak1 == range */
              {
              tdist = range-(range/6);
              }
            }
          while(cannon(backwards,tdist)==0);
          bak1 = range;
          }
       }
       if (speed()==0)
         {
         angle = plot_course(x,y);
         drive(angle,100);
         }
     } /* end while distance */

  /* stop drive, should coast in the rest of the way */
  drive(angle,10);
  if (inrange == 0)
    {
    ++endgame;
    if (endgame > 3) stalker = 1;
    }
  else
    {
    find_loc(scan_angle,mid1);
    }
  while (speed() > 50)
  {  range=scan(backwards,10);                 /* 180 degrees, reverse scan */
     if ((range > 40) && (range <= 740))
	cannon(backwards,range);
  }
}  /* end of move_out */

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
  return( sqrt((x*x) + (y*y)) );
}

/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
plot_course(xx,yy)
int xx, yy;
{
  int x,y;

  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {      /* x is zero, we either move due north or south */
    if (yy > cury)
      return(90);        /* north */
    else
      return(270);       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
        return(360 + atan((scale * y) / x));  /* south-east, quadrant 4 */
      else
        return(180 + atan((scale * y) / x));  /* south-west, quadrant 3 */ 
    } else {
      if (xx > curx)
        return(atan((scale * y) / x));        /* north-east, quadrant 1 */
      else
        return(180 + atan((scale * y) / x));  /* north-west, quadrant 2 */
    }
  }
}

/* find_loc */
/* find x,y coordinates of target given angle and range */

find_loc(tgt_ang,tgt_rng)
int tgt_ang;
int tgt_rng;
{
tgtx = ((cos(tgt_ang)*tgt_rng)/scale) + loc_x();
tgty = ((sin(tgt_ang)*tgt_rng)/scale) + loc_y();
}

/* ok to run */

ok_to_run()
{
return(distance(loc_x(),loc_y(),x,y) > 130 && damage() < d + 6);
}
