
main()
{
  int count;
  int angle, range;
  int res;
  register int d;
  long i;

  count = 0;
  res = 1;
  d = damage();
  angle = rand(360);
  while(1) {
    if (((range = scan(angle,res)) <= 0) && ( count / 2 == 0)){
      shoot(rand(359),rand(700)); 
      run();}
    while ((range = scan(angle,res)) > 0) {
      if (range > 700) { /* out of range, head toward it */
        drive(angle,100);
        i = 1;
        while (i++ < 10) /* use a counter to limit move time */
        shoot(rand(359),rand(700))
          ;
        drive (angle,0);
        if ( (damage() - d) > 2 ) { 
  	  d = damage();
          run();
	}
	angle -= 3;
      } else {
	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;

	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;

	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;
	while (shoot(angle,range) == 0)
	  ;
        if ( (damage() - d) >= 8 ) { 
  	  d = damage();
          run();
	}
	angle -=15;
      }
    }
    if (  (damage() - d) > 4 ) { 
      d = damage();
      run();
    }
    angle += res;
    angle %= 360;
    ++count;
  }
}


int last_dir;

/* run moves around the center of the field */

run()
  {
  int dest_x, dest_y;   
  int course;
  
  dest_x = (rand(940) +20);
  dest_y = (rand(940) + 20);

  course = plot_course(dest_x,dest_y);
  drive(course,100);
  while((distance(loc_x(),loc_y(),dest_x,dest_y) > 80) && (speed() != 0 ))
    shoot(rand(359),rand(700))
    ;
  drive(course,0);
  while (speed() > 0)
    shoot(rand(359),rand(700))
    ;

  }


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
    shoot(rand(359),rand(700));

  return(d);
}


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
shoot (  dir,  range )
  int dir,range;
  {
    if (range > 50 )
      return cannon (dir,range);
    else 
      return cannon (dir, range + 50);
  }

