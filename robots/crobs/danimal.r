/* Danimal */
/* silly runs around the field, randomly */
/* and scans randomly firing when stumbling upon a robot*/


main()
{
  int da;
  int guess;
  guess = 0;
  da = 0;
  while(1)
   {
    guess = go(rand(1000),rand(1000),guess);  /* go somewhere in the field */
   }

}  /* end of main */



/* go - go to the point specified */

go (dest_x, dest_y, guess)
int dest_x, dest_y, guess;
{
  int course;
  int range;
  int degree;
  int times;
  int degree1;
  int degree2;
  int number;
  int range1;
  int range2;
  int running;

  course = plot_course(dest_x,dest_y);
  running = 0;
  sidtrack = 0;
  drive(course,50);
  while((distance(loc_x(),loc_y(),dest_x,dest_y) > 150) && (sidtrack == 0))
  {
  guess = guess + 77;
  d = damage();
  if (d != damage())
    {
      drive(course,100);
      running = 1;
      d = damage();
    }
  degree = guess % 360;
  degree1 = (degree + 5) % 359;
  degree2 = (degree + 354) % 359;
  if (((range = scan(degree,2)) > 2) && (range < 700))
    {
      running = 0;
      sidtrack = 1;
      drive(degree,50);
      cannon(degree,range);
      times = 0;
      while ((++times < 100)&&(running == 0))
        {
          if (((range1 = scan(degree1,2)) > 2) && (range1 < 700))
           {
             drive(degree1,50);
             while(cannon(degree1,range1)!=0);
             degree1 = (degree1 + 5) % 359;
           }
          else
           {
             degree1 = (degree1 + 354) % 359;
          if (((range2 = scan(degree2,2)) > 2) && (range2 < 700))
           {
             drive(degree2,50);
             while(cannon(degree2,range2)!=0);
             degree2 = (degree2 + 354) % 359;
           }
          else
           {
             degree2 = (degree2 + 5) % 359;
          if (((range = scan(degree,2)) > 2) && (range < 700))
            {
             drive(degree,50);
             while(cannon(degree,range)!=0);
            }
          else
            {
              drive(course,0);
            }
        }  }  }
     }
     if (speed() == 0)
      {
        drive(course,50);
      }
   }
  drive(course,0);
  while (speed() > 0)
    ;
  return (guess);
}

/* distance forumula */

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


/* end of Danimal.r */
