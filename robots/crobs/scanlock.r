/*                     ScanLock.R

                       Brian West
                      [70003,3275]

ScanLock was a test to see how much damage you could do
with a good scan routine.  This robot never moves.  It just
scans til it finds a target, then it clamps down.  If the robot
moves, I fall out of one level of the below While() loops, and then
relock on target.
This robot is extremely effective against any robot which moves at
speed=50 or less.  Faster robots move too quickly for my routine to
lock in.
*/

main()
{
int d;

d = 0;
while (1)
{     while (scan(d,10)== 0)
           d += 15;

      while (scan(d,10))
      {     if (scan(d-5,5))  d -= 5;
            else
            if (scan(d+5,5))  d += 5;
            while (scan(d,5))
            {     if (scan(d-3,3))  d -= 3;
                  else
                  if (scan(d+3,3))  d += 3;
                  while (scan(d,3))
                  {     if (scan(d-1,1))  d -= 1;
                        else
                        if (scan(d+1,1))  d += 1;
                        while (scan(d,1)) cannon(d,scan(d,3));
                   }
             }
      }
}
}
