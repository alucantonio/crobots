main()
{
  int angle, range, dir, resdiv2, lastrange;
  int res;
  register int d;
  long i;
 
  d = damage();
  angle = rand(360);
  while(1) {
    res = 10;
    while ((range = scan(angle,res)) > 0)
      {
      if (range > 700)   /* out of range, head toward it */
        {
        drive(angle,100);
        i = 1;
        while (++i < 40) /* use a counter to limit move time */
          ;
        drive (angle,0);
        if (d != damage())
          {
          run();
          d = damage();
          }
        angle -= 5;
        }
      else
        {
        /* narrow down with binary search */
          dir = angle;
          res = 10;
          lastrange = 0;
          while (res > 2)
            {
            if ((res % 2) == 0)
              resdiv2 = res/2;
            else
              resdiv2 = (res/2) - 1;
            range = scan(dir-resdiv2,resdiv2);
            if (range > 0)
              {
              lastrange = range;
              dir -= resdiv2;
              }
            else
              dir += resdiv2;
            res = resdiv2;
            }
 
          if (lastrange < 701 && lastrange > 15)
              {
              cannon(dir,lastrange);
              while (!cannon(dir,lastrange));
              }
        if (d != damage())
              {
              run();
              d = damage();
              }
        angle = dir - 20;
        }
    }
    if (d != damage())
      {
      run();
      d = damage();
      }
    angle += 20;
    angle %= 360;
  }
}
 
 
int last_dir;
 
/* run moves around the center of the field */
 
run()
{
  int x, y;
  int i;
 
  x = loc_x();
  y = loc_y();
 
  if (last_dir == 0) {
    if (y > 512) {
      last_dir = 1;
      drive(270,100);
      while (y -100 < loc_y() && i++ < 100)
	;
      drive(270,0);
    } else {
      last_dir = 1;
      drive(90,100);
      while (y +100 > loc_y() && i++ < 100)
	;
      drive(90,0);
    }
  } else {
    if (x > 512) {
      last_dir = 0;
      drive(180,100);
      while (x -100 < loc_x() && i++ < 100)
	;
      drive(180,0);
    } else {
      last_dir = 0;
      drive(0,100);
      while (x +100 > loc_x() && i++ < 100)
	;
      drive(0,0);[
    }
  }
}
 
/* end of quikshot.r */
