  /*{   Author  : Marco Varagnolo                                      }
    {   Robot   : Nemesi                                               }

                              ¯ STRATEGY ®

    {  La strategia di Nemesi è  molto semplice, si  sposta lungo la   }
    {  diagonale (non quella principale) e spara a tutto quello che    }
    {  trova nel suo range. Per eseguire il movimento ho usato due     }
    {  funzioni distance(x1,y1,x2,y2) e plot_course(xx,yy) che sono    }
    {  reperibili nella documentazione di C-ROBOTS.                    }

                                ¯ NOTE ®

    {     Beh.....visto che il sonno avanza (sono circa le 2 della     }
    {     mattina.....il nome del robot è il piu' adatto.....Nemesi    }
    {     per chi non lo sapesse nella mitologia era la figlia della   }
    {     Notte.....umh...si vede che è tardi, sto' delirando.         }
    {     Purtroppo ho avuto solo una sera da  dedicare alla program-  }
    {     mazione dei robot, percui  dubito sulla loro efficenza, no-  }
    {     nostante tutto sono contento di poter dire "C'ero anch'io".  }*/



int d;                                  /* last damage check */
main()
{
 goto(5,995);                           /* Go to upper left corner */
  while (damage() != 0)
    {
      while (loc_y() > 150)
         {
          drive(315, 100);              /* Go diagonally down and right */
          check();
         }

      drive(315, 0);                    /* Near bottom, slow down */
      while (speed() > 50)              /* Wait for slow to 50 */
               ;
      while (loc_y() < 850)             /* Check for top */
       {
        drive(135, 100);                /* Go diagonally up and left */
        check();
       }

      drive(135, 0);                    /* Slow down */
      while (speed() > 50)              /* Wait for 50 */
               ;
  }
}

check()
{
    if (scan(0, 10) > 0)
      cannon(0, scan(0, 10));     /* Shoot if you see anything */
    if (scan(90, 10) > 0)
      cannon(90, scan(90, 10));   /* Shoot if you see anything */
    if (scan(270, 10) > 0)
      cannon(270, scan(270, 10)); /* Shoot if you see anything */
    if (scan(180, 10) > 0)
      cannon(180, scan(180, 10)); /* Shoot if you see anything */
}

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

goto(dest_x, dest_y)
{
  while (distance(loc_x(), loc_y(), dest_x, dest_y) > 100)
       {
        if (speed() == 0)
                {
                 drive(plot_course(dest_x, dest_y), 100);
                }
        while (speed() > 0)               /*nothing...i.e., slow down*/ ;
                  ;
       }
}
