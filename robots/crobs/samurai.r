/* samurai
   Thom Henderson, 107/8

   This is an attempt to get fancy and predict the motions of a target.
   Since the robot computer has no clock, we attempt to make do using
   the cannon reload cycle.
*/

int scale;                             /* trig function scaling value */
int lastx, lasty;                      /* last known position of target */
int thisx, thisy;                      /* current position of target */
int range, bearing;                    /* range and bearing of target */

main()
{
    int n;

    scale = 100000;                    /* scale for trig functions */

    while(1)
    {    go(400,600);

         n = 9;                        /* drift correction factor */
         while(--n)
         {    while(loc_x()<800 && loc_y()<800)
              {    if(!speed())
                        drive(45,100);
                   fight();
              }
              drive(0,0);
              while(speed());

              while(loc_x()>200 && loc_y()>200)
              {    if(!speed())
                        drive(225,100);
                   fight();
              }
              drive(0,0);
              while(speed());
         }
    }
}

go(dest_x,dest_y)                      /* go to a specified point */
int dest_x, dest_y;
{
    while(distance(dest_x,dest_y) > 100)
    {    if(!speed())
              drive(direct(dest_x,dest_y),100);
         fight();
    }

    drive(0,0);
    while(speed());
}

distance(xx,yy)                        /* calculate distance */
int xx,yy;                             /* to point */
{
    int x, y;

    x = loc_x() - xx;
    y = loc_y() - yy;
    return sqrt((x*x) + (y*y));
}

direct(xx,yy)                          /* calculate direction */
int xx, yy;                            /* to point */
{
    int d;
    int x,y;
    int curx, cury;

    curx = loc_x();
    cury = loc_y();
    x = curx - xx;
    y = cury - yy;

    if(x == 0)
    {    if(yy > cury)
              d = 90;
         else d = 270;
    }
    else
    {    if(yy < cury)
         {    if(xx > curx)
                   d = 360 + atan((scale * y) / x);
              else d = 180 + atan((scale * y) / x);
         }
         else
         {    if(xx > curx)
                   d = atan((scale * y) / x);
              else d = 180 + atan((scale * y) / x);
         }
    }
    return d;
}

his_x()                                /* calculate his X position */
{
    return cos(bearing)*range/scale + loc_x();
}

his_y()                                /* calculate his Y position */
{
    return sin(bearing)*range/scale + loc_y();
}

int find()                             /* find a target */
{
    int off;                           /* offset */
    int dir;                           /* direction; 0=CW, 1=CCW */
    int pb;                            /* previous bearing */

    off = 0; pb = bearing;

    while(off<=180)                    /* scan the horizon */
    {    if(scan(bearing,10))          /* see anyone? */
              return lock();           /* nail him! */

         if(dir = !dir)
              bearing = pb + (off += 20);
         else bearing = pb - off + 360;
         bearing %= 360;
    }

    return 0;                          /* no targets found */
}

int lock()                             /* lock onto a target */
{
    int mesh, dm;                      /* scan mesh, delta mesh */
    int tb, tr;                        /* trial bearing, range */

    mesh = 6; dm = 4;                  /* start with coarse mesh */

    while(--dm)                        /* lock on target */
    {    if(tr=scan(tb=bearing+mesh,mesh))
              ;
         else if(tr=scan(tb=bearing-mesh,mesh))
              ;
         else return 0;                /* lost the target */

         bearing = tb; range = tr;     /* we fined it down a bit */
         mesh -= dm;                   /* fine it down some more */
    }

    return 1;                          /* a solid lock! */
}

int fight()                            /* find a target and kill it */
{
    int predx, predy;                  /* predicted location */

    find();

    thisx = his_x(); thisy = his_y();
    predx = thisx + (thisx-lastx) * rand(110)/100;
    predy = thisy + (thisy-lasty) * rand(110)/100;

    if(cannon(direct(predx,predy),distance(predx,predy)))
    {    lastx = thisx;                /* should be self correcting */
         lasty = thisy;                /* based roughly on range */
         return 1;
    }
    return 0;
}

