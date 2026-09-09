/*Sirius Cybernetic
Felix Buebl & Michael Balser
 This robot does
   a) move randomly
   b) search vor the enemy (360 degree scan!)
   c) try to watch() it where it is moving to (calculate it's heading)
   d) fire at it

*/

/* the robot's own data: */
int degree, turn;
/* enemies has the following meaning:
     0:  Robot is searching for an enemie
   ++1:  Robot has found  # enemies
   */
int enemies;
/* this "array" stores the coords where the current enemie has been last */
int x1, y1, x2, y2;


main()
{
/* initialize */
enemies = turn = degree = x1 = y1  = y2 = 0;
x2 = 1234;

while (666 != 42) /* for ever */
      {
       move();  /* is invoked EVERY loop! */

       if (!enemies)
          search();
       else
          {
           if (x2 == 1234)
              watch();
           else
              terminate();
          }
      }
}

move ()
{
/* IF we are close to a wall: Retreat 8c) */


if (loc_x() > 700)
   {
    degree =  160 + rand(40);
       drive (degree, 100);
    return;
   }

if (loc_x() < 300)
   {
    degree =  -20 + rand(40);
    drive (degree, 100);
    return;
   }

if (loc_y() > 700)
   {
    degree =  250 + rand(40);
    drive (degree, 100);
    return;
   }

if (loc_y() < 300)
   {
    degree =  70 + rand(40);
    drive (degree, 100);
    return;
   }

/* if the ran into some enemie, retreat */

if (!speed())
   {
    degree -= 180;
    drive (degree, 100);
    return;
   }

/* if we are not close to a wall, PERHAPS change movent */



/* if we want to turn, do it */

if (turn && speed() >= 50 )
    drive (degree, 42);

if (turn && speed() < 50)
   {
   degree += turn;
   turn = 0;
   drive (degree, 100);
   }

if (!turn && x2 != 1234)
   {
    drive (degree, 100);
   }


if (rand(21) == 1  && !turn  )
   {
   if (degree > 180)
      turn = (-1)*rand(10)*6 + 30;
   else
      turn = rand (10)*6 -30;
   }
return;
}


search ()
{
int i, range, dir;

/* do a 360 degrees scan first in order to find a enemie */
i=18;

while (i > 0)
    {
     if (range = scan ( i*20, 10) )
     if (range < 850 )
        {
         dir =  i*20;
         enemies = 1;
         i=0; /*break*/
        }
     --i;
    }

if (!enemies)
    return;

/* now get the exact position */

i= -6;
while ( i<= 6)
  {
   if ( range = scan ( dir + i*3, 1))
      {
       dir += i*3;
       i = 42; /* break */
      }
   ++i;
  }
/* if it is close enough, fire your guns! (not included in competition)*/

if ( range < 100)
   {
    cannon (dir, range);
    return;
   }

/* evaluate the coords */

x1 = loc_x() + cos(dir)*range/100000;
y1 = loc_y() + sin(dir)*range/100000;
x2 = 1234;
return;

}

watch()
{
 int scandir, newrange, i;
 int xh,yh;

 xh=loc_x()-x1;
 yh=loc_y()-y1;

 if (xh>0)
     scandir = atan (yh*100000/xh) + 180; /* +-90 */
 else
     scandir = atan (yh*100000/xh);

 if (scandir < 0)
    scandir += 360;

 i=0;
 while ((! (newrange = scan (scandir+i*10, 5)) ) &&  i< 3 )
       {
        if (i <= 0)
           i  = -i+1;
        else
           i *= -1;

       }

 if (!newrange)
    {
     enemies = 0;
     return;
    }
 scandir += i*10;

 i=0;
 while (( ! (newrange = scan (scandir + i*3, 1)) ) && i < 2)
       {
        if ( i <= 0)
           i = -i +1;
        else
           i *= -1;
       }
 scandir += i*3;
/*  too high cost
 if ( sqrt ((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)) > 123)
    {
    enemies = 0;
    x2 = 1234;
    }
*/
   x2 = loc_x() + cos (scandir)*newrange/100000;
   y2 = loc_y() + sin (scandir)*newrange/100000;
 drive (degree, 0);

 return; 
}

terminate()
{
int xt, yt, xh, yh, shootdir, shootrange;

xt = x2 + x2-x1;
yt = y2 + y2-y1;

 if (xt-loc_x() < 0)
     shootdir = atan ((yt-loc_y())*100000/(xt-loc_x())) + 180; /* +-90 */
 else
     shootdir = atan ((yt-loc_y())*100000/(xt-loc_x()));

 if (shootdir < 0)
    shootdir += 360;

 xh=xt-loc_x();
 yh=yt-loc_y();
 if ( (shootrange = sqrt(xh*xh + yh*yh)) > 721)
    {
     y1 = y2;
     x1 = x2;
     return;
    }


 cannon (shootdir, shootrange);
 y1 = y2;
 x1 = x2;
 x2 = 1234;

 return; 
}

