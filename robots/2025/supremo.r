/*
                            Converted by Karl-Heinz Mauerlich from SUPREMO.PR

Selected from a zip archive containing the P-ROBOTS simulator (Crobots clone in Pascal)

*/


int Deg, Dir, Spd;

/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
int plot_course(xx,yy)
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

 Shoot(Dir, Spd) {  /*Track and shoot*/
   int Range;
   drive(Dir, Spd);
   Range = scan(Deg, 10);
   if (Range > 39) {
      cannon(Deg, Range);
   }
   else {
      Deg = Deg + 20;
      if (scan(Deg, 10) == 0) {
         Deg = Deg - 40;
         if (scan(Deg, 10) == 0) {
            Deg = Deg + 60;
            if (scan(Deg, 10) == 0) {
               Deg = Deg - 80;
               while (scan(Deg, 10) == 0)
                  Deg = Deg + 20;
            }
         }
      }
      cannon(Deg, scan(Deg, 10));
   }
}

 main() {
   Dir = plot_course(0, 999);
   while ((loc_x() > 230) && (loc_y() < 770)) { /*Travel to upper left*/
      Shoot(Dir, 100); /*Shoot the whole way, of course!*/
   }
   drive(Dir, 0); /*Need this to slow down in time.*/
   while (speed() > 50) { /*Slow down*/
      Shoot(Dir, 0); /*Still shooting*/
   }

   while(1) { /*Go down left side*/
      while (loc_y() > 230) {
         Shoot(270, 100);
      }
      drive(270, 0); /*Need this to slow down in time*/
      while (speed() > 50) { /*Slow down*/
         Shoot(270, 0);
      }

      /*Go across bottom*/
      while (loc_x() < 770) {
         Shoot(0, 100);
      }
      drive(0, 0);
      while (speed() > 50) {
         Shoot(0, 0);
      }

      /*Go up right side*/
      while (loc_y() < 770) {
         Shoot(90, 100);
      }
      drive(90, 0);
      while (speed() > 50) {
         Shoot(90, 0);
      }

      /*Go from upper right to lower left*/
      while (loc_y() > 230) {
         Shoot(225, 100);
      }
      drive(225, 0);
      while (speed() > 50) {
         Shoot(225, 0);
      }

      /*Go up left side*/
      while (loc_y() < 770) {
         Shoot(90, 100);
      }
      drive(90, 0);
      while (speed() > 50) {
         Shoot(90, 0);
      }

      /*Go from upper left to lower right*/
      while (loc_x() < 770) {
         Shoot(315, 100);
      }
      drive(315, 0);
      while (speed() > 50) {
         Shoot(315, 0);
      }

      /*Go up right side*/
      while (loc_y() < 770) {
         Shoot(90, 100);
      }
      drive(90, 0);
      while (speed() > 50) {
         Shoot(90, 0);
      }

      /*Go across top*/
      while (loc_x() > 230) {
         Shoot(180, 100);
      }
      drive(180, 0);
      while (speed() > 50) {
         Shoot(180, 0);
      }

    }
}