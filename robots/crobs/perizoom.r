/*                     ****************
                       *  PeriZoom.R  *
                       ****************
                         v2.0, 1/4/87

                          Brian West
                         [70003,3275]


     PeriZoom, as the name implies, runs at maximum speed around
the perimeter of the arena, scanning in a wide path, and firing
if a target is within range.
It's only defense is it's speed, which makes it a very elusive target.

     This newest version uses a few different routines.
First, PeriZoom starts off by running to either the right wall
or the bottom-right corner.  I gave myself the option of both
since my start position is random.  I pick the path to the right
which I feel is harder to track (knowing I'll soon be going up,
then left around the field).

Second, there is a quicker movement routine in main().  It may look a
little redundant, but I keeping everything inline makes that part of
the program run a bit quicker.

Third, the scan routine has been changed so that if I find a
target when I scan @ resolution of 10,  I take 1-5 more looks at
him to decide if he's   1) in my path,  2) behind me,  3) moving with me,
4) stationary, or 5) moving in the opposite direction.  Knowing this
is very important, since PeriZoom is moving along the wall at speed=100.
Angles of firing and ranges are then adjusted based upon those scans
to TRY to maximize the effectiveness of the shot.  It doesn't work
all the time, but works enough of the time.

I welcome your comments and your challengers.
Let me know how it runs for you.


                                       Brian

*/


int d, plug, rng, rng2, found;

/********************************************************************/
main()
{
if ((loc_y()>500)&&(loc_x()<600)) go_corner();
else go_side();

while (1)
    {drive(90,100);
     d=90;
     while (loc_y()<920) skan();     /* up */
     drive(90,50);
     while (speed()>50);
     drive(180,50);
     drive(180,100);
     if((found)&&(plug>90))  plug -= 90;
     else plug = 0;

     d=180;
     while (loc_x()>80) skan();     /* left */
     drive(180,50);
     while (speed()>50);
     drive(270,50);
     drive(270,100);
     if((found)&&(plug>90))  plug -= 90;
     else plug = 0;

     d=270;
     while (loc_y()>80) skan();     /* down */
     drive(270,50);
     while (speed()>50);
     drive(0,50);
     drive(0,100);
     if((found)&&(plug>90))  plug -= 90;
     else plug = 0;

     d=0;
     while (loc_x()<920) skan();     /* right */
     drive(0,50);
     while (speed()>50);
     drive(90,50);
     if((found)&&(plug>90))  plug -= 90;
     else plug = 0;
    }
} /*  main */
/********************************************************************/

skan()
{drive(d,100);
 if ( (rng=scan(d+plug,10)) == 0 )
      {found = 0;  plug += 10;
       if (plug>180) plug=0;}
 else  /* in range */
    {found = 1;
    if (plug == 0) in_path();
    else
    {if (plug > 165) behind();
     else
         {if ((rng2=scan(d+plug,4)) > 5)   with_me();
         else
              {if ((rng2=scan(d+plug+5,3)) > 5)  still();
               else
                    {if ((rng2=scan(d+plug+9,5)) > 5)  opposite();
                       }/* opposite */
                }/* with_me */
          }/* still */
        }
     }/*in range */
}/* end skan */


in_path()
{rng2=scan(d,10);
 if (rng2>5)
    cannon(d,rng2-speed()/9);}

behind()
{if (rng>30) cannon(d+175,rng-35);
 else        cannon(d+175,rng   );}

still()
{cannon(d+plug+(90-atan(150000*rng2/speed())),rng2+(plug/20)*(rng2-rng));}

with_me()
{int rng3;
 if(rng3=scan(d+plug-4,2))
   cannon(d+plug-5,rng3+3*(rng3-rng));
 else
   cannon(d+plug,  rng2+3*(rng2-rng));}

opposite()
{cannon(d+plug+11,rng2+2*(rng2-rng));}

go_side()
{drive(0,100);
while(loc_x() < 960) ;
drive(0,50);
while(speed()>50);
drive(90,50);
drive(90,100);}

go_corner()
{int angle;
  angle = plot_course(990,10);
  drive(angle,100);
  while (loc_x() < 965)   ;
  drive(angle,50);
  while(speed()>50)       ;
  drive(90,50);
  drive(90,100);}

plot_course(xx,yy)
int xx, yy;
{int dir,x,y,scale,curx,cury;
  scale = 100000;
  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;
  if (x == 0) {
    if (yy > cury)
      dir = 90;
    else
      dir = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
        dir = 360 + atan((scale * y) / x);
      else
        dir = 180 + atan((scale * y) / x);
    } else {
      if (xx > curx)
        dir = atan((scale * y) / x);
      else
        dir = 180 + atan((scale * y) / x);
    }
  }
  return (dir);}