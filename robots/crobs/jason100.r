

/*  JASON.R  */

/*    This robot uses a high-speed, accurate, variable resolution     */
/*  scanning process to locate it's targets.  A variable tolerance    */
/*  damage monitor tells Jason when to flee.  If a target disappears  */
/*  from the current resolution scan, Jason will do a wider scan of   */
/*  the general area.  If a target is not found in a 360 degree       */
/*  scan, Jason will move closer to the last remembered sighting,     */
/*  or move randomly about the field.                                 */

/*    Unfortunately, all the intelligence programmed into Jason makes */
/*  him a bit slower to react occasionally.  I am relying on the      */
/*  superior algorithms to make him an overall tougher opponent that  */
/*  doesn't suffer from predicatability flaws.                        */

/*    This robot is brought to you by Chris Magyar, Sysop of Fido     */
/*  109/615 - IBM_Wasteland.  (301) 428-3418.  1200/8/N/1             */

/*    If you have written a robot, please feel free to call and put   */
/*  it in competition with the others here.  We could use the variety.*/

/*    I have borrowed routines from the robots supplied with the      */
/*  C-Robots package.  My thanks to the original author.              */

main() 
{
    int coarse,medium,fine;       /* direction of enemy from scans */
    int chase_dir;                 /* angle to nearest enemy        */
    int range;                    /* distance to enemy             */
    int d;                        /* damage total as of last check */
    int seek_cnt;                 /* is enemy out of range?        */
    int flee_x,flee_y,flee_to;    /* coords, position to flee to   */         
    int max_dam;                  /* maximum damage before flee    */

    d = damage();
    seek_cnt = 0;                 /* assume enemy is within range  */
    chase_dir = 999;
    while(1) {

        coarse = 369;    
        if (damage() < 85)        /* variable damage monitor based */
            max_dam = 5;          /* on current scan resolution    */
        else                      /* and critical damage level     */
            max_dam = 1;
        /* endif */

        flee_x = rand(450) + 50;  /* always know where to run to   */
        flee_y = rand(500) + 450;
        flee_to = plot_course(flee_x,flee_y);

        if (seek_cnt == 1) {      /* if enemy out of range, chase  */
            chase(chase_dir);
            chase_dir = 999;
            d = damage();
            seek_cnt = 0;
        } /* end_if */

        seek_cnt = 1;
        while (coarse >= 29) {                        /* coarse res scan */

            coarse -= 20;
            range = scan(coarse,10);

            if ((damage() >= d+max_dam) ||            /* damaged or too  */
               ((range != 0) && (range <= 40))) {     /* close to shoot  */
                   flee(flee_to,flee_x,flee_y);       /* w/out blasting  */
                   d = damage();                      /* self. run away  */
                   chase_dir = 999;
                   coarse = 0;  
                   range = 0;  
                   seek_cnt = 0;
            } /*endif */

            if ((range != 0) && (range <= 700)) {

                chase_dir = coarse;                   /* remember enemy */
                seek_cnt = 0;                         /* position       */
                coarse += 10;
                medium = coarse + 3;
                if (damage() < 85)                    /* damage monitor */
                    max_dam = 8;
                else
                    max_dam = 3;
                /* endif */
                while (medium >= coarse - 20) {       /* medium res scan */

                    medium -= 6;
                    range = scan(medium,3);

                    if ((damage() >= d+max_dam) ||           /* damage   */
                       ((range != 0) && (range <= 40))) {    /* monitor  */
                           flee(flee_to,flee_x,flee_y);
                           d = damage();
                           chase_dir = 999;
                           medium = -500;  
                           coarse = 0;  
                           range = 0;
                    } /* endif */

                    if ((range != 0) && (range <= 700)) {

                        chase_dir = medium;           /* remember position */
                        medium += 3;
                        fine = ++medium;
                        if (damage() < 85)            /* damage monitor */
                            max_dam = 10;
                        else
                            max_dam = 5;
                        /* endif */
                        while (fine >= medium - 6) {  /* fine res scan   */

                            --fine;
                            range = scan(fine,0);

                            if ((range != 0) && (range <= 700)) {
                                if (range > 40) {
                                    cannon(fine,range);
                                    ++fine;

                                    if ((damage() >= d+max_dam) || 
                                       ((range != 0) && (range <= 40))) {
                                           flee(flee_to,flee_x,flee_y);
                                           d = damage();
                                           chase_dir = 999;
                                           fine = -999;  
                                           medium = -500;  
                                           coarse = 0;
                                    } /* endif */

                                } /* endif */

                            } /* endif */
                        
                        } /* end while fine */
                        medium += 9;                  /* escaped fine res  */
                        coarse = medium + 10;         /* scan, do a medium */
                                                      /* scan              */
                    } else
                        if (range != 0)
                            chase_dir = medium;       /* out of range      */
                        /* endif */                   /* remember angle    */
                    /* endif */

                } /* end while medium */
                coarse += 40;                         /* escaped med res   */
                                                      /* scan, do a coarse */
            } else                                    /* scan              */
                if (range != 0)
                    chase_dir = coarse;               /* out of range      */
                /* endif */                           /* remember angle    */
            /* endif */

        }  /*  end while coarse */                    /* reset scan       */

    }  /*  end while(1)  */

}  /*  end main  */


flee(angle,x,y)                   /* damaged, run to new location  */
int angle,x,y;
{
  drive(angle,100);
  while (distance(loc_x(),loc_y(),x,y) > 100 && speed() > 0);
  drive(angle,0);
  return; 

}  /*  end flee  */


chase(chase_dir)                   
int chase_dir;                    /* did a 360 degree scan, and no */
{                                 /* enemy robots showed up.  move */
    int range,angle;              /* towards last robot we spotted */
    int i;                        /* otherwise move randomly       */

    if ((chase_dir >= 0) && (chase_dir <=359)) {
        drive(chase_dir,100);
        i = 1;
        while (++i < 100);
        drive(chase_dir,0);

    } else {
        angle = plot_course(rand(600)+200,rand(600)+200);
        drive(angle,100);
        i = 1;
        while (++i < 75);
        drive(angle,0);

    } /* endif */
    return;

} /* end chase */


plot_course(xx,yy)                /* this function used to obtain  */
int xx, yy;                       /* the proper angle to a given   */
{                                 /* x,y coordinate                */
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;                 /* scale for trig functions      */
  curx = loc_x();                 /* get current location          */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use        */
  /* the atan() value                                              */

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

}  /* end plot_course */


distance(x1,y1,x2,y2)             /* determine distance between 2  */
int x1,y1,x2,y2;                  /* x,y coordinates               */
int d;
{
  int x, y;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);

}  /* end distance */
