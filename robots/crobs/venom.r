
/*
 *      Venom.r  -  Warrior Of Doom
 *
 *  Spawned by Rob S. Cowan  -  8812.25
 */

int angle, secondangle;
int heading, range, lastrange;
int point;
int xoy, yox;
int tx, ty;
int x, y;
int mod, mod2;

main()
{
   xoy = 149;  yox = 849;  point = 0;  mod = 45;  mod2 = 0;

   while(1)
   {
      problems();
      while(lastrange = scan(angle,10))
      {
         if (scan(angle + 9,4))
         {
            mod = -45;
            mod2 = 8;
            secondangle = (angle += 14) + 5;
         }
         else if (scan(angle - 9,4))
         {
            mod = 45;
            mod2 = -8;
            secondangle = (angle -= 14) - 5;
         }
         if (scan(secondangle, 5))
         {
            angle = secondangle;
         }
         if (range = scan(angle,10))  cannon(angle,range + (range-lastrange));
         if (scan(angle + mod2, 4))   angle += mod2;
         mod2 = 0;
         problems();
      }
      angle += mod;
      if (angle >= 360 || angle < 0)  angle %= 360;
   }
}


/*
 *  Check for reason to move; if problem, go..
 */
problems()
{
   if (sqrt(((x = loc_x() - tx) * x) + ((y = loc_y() - ty) * y)) < 90 ||
       speed() == 0)
   {
      drive(heading,10);
      if (point)
      {
         ty = tx = xoy;
         point = 0;
      }
      else
      {
         ty = tx = yox;
         point = 1;
      }
      drive(heading = get_angle(),90 + rand(10));
      if (scan(angle,10) == 0)
         angle = heading;
   }
}


/*
 *  Calculates angle via atan() from global target coords
 */
get_angle()
{
   int curx, cury;
   int change;

   y = (cury = loc_y()) - ty;

   if (x = ((curx = loc_x()) - tx))
   {
      if (tx > curx)
         change = 360;
      else
         change = 180;
      if (ty >= cury)  change = 0;

      return (change + atan((100000 * y) / x));
   }
   else
   {
      if (ty > cury)
         return 90;
      else
         return 270;
   }
}
