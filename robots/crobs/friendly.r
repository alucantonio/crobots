int fireang;
int x,y;

main()
  {
  int by,b1,range1,range;
  int temp;
  int rrate,brate;
  int fudge;
  int driveang;
  int xaxis,xinc,yinc;
  int count;

  if (loc_x() > 500)
    {
    x = 850;
    xinc = -100;
    }
  else
    {
    x = 150;
    xinc = 100;
    }
  if (loc_y() > 500)
    {
    y = 850;
    yinc = -100;
    }
  else
    {
    y = 150;
    yinc = 100;
    }
  if (xinc==yinc)
    xaxis = 1;
  else
    xaxis = 0;
  while(1)
    {
    count = 0;
    while (count < 7)
      {
      gohome();
      fireang = 0;
      driveang = 0;
      fudge = 17;
      while (fireang < 360)
        {
        while (speed() > 42);
        drive(driveang,100);
        range = scan(fireang,8);          /* Wide angle scan */
        if (range > 0 && range < 720+fudge)
          {
          range = zoom();                 /* Zoom in on victim */
          b1 = fireang;
          range1 = zoom();                  /* Zoom in on victim */
          brate = fireang - b1;            /* Calculate bearing rate */
          rrate = range1-range+fudge;    /* Calculate range rate */
          by = fireang + (range1*brate)/110;  /* Determine cannon bearing */
          if (rrate > 0)                  /* Calculate fudge factor */
            temp = 85;
          else
            temp = 125;
          range1 += (range1*rrate)/temp;  /* Determine cannon range */
          if (range1 > 40 && range1 < 721)
            cannon(by,range1);        /* WASTEM!!! */
          drive(driveang,40);
          if (fudge > 0)
            driveang = (fireang+180) % 360;
          else
            driveang = fireang;
          fudge = -fudge;
          fireang += 2*brate;
          }
        else
          {
          drive(driveang,40);
          fireang += 17;
          driveang = fireang;
          }
        }
      if (xaxis)
        x += xinc;
      else
        y += yinc;
      ++count;
      }
    if (xaxis)
      xinc = -xinc;
    else
      yinc = -yinc;
    xaxis = 1 - xaxis;
    }
  }

zoom()
int rng;
int width;

/* Binary search algorithm used to zoom in on a robot
   which is within a 17 degree arc centered on FIREANG.
   The algorithm pinpoints the target's position (exact
   range and bearing) and requires, on the average, be-
   tween four and five scans to grab the target.        */

  {
  if ( scan(fireang,4) )
    {
    if ( scan(fireang,2) )
      width = 1;
    else
      width = 3;
    }
  else
    {
    if ( scan(fireang,6) )
      width = 5;
    else
      width = 7;
    }
  if (rng=scan(fireang,width))
    {
    if (width == 1)
      {
      ++width;++width;++width;
      return(rng);
      }
    }
  else
    ++width;
  fireang -= width;
  if ( rng = scan(fireang,1) )
    return(rng);
  else
    {
    fireang += 2*width;
    return( scan(fireang,1) );
    }
  }

gohome()

  {
  while (speed() > 42);
  if (loc_x() > x)
    {
    drive(180,100);
    while (loc_x() > x);
    drive(180,0);
    }
  else
    {
    drive(0,100);
    while (loc_x() < x);
    drive(0,0);
    }
  while (speed() > 42);
  if (loc_y() > y)
    {
    drive(270,100);
    while (loc_y() > y);
    drive(270,0);
    }
  else
    {
    drive(90,100);
    while (loc_y() < y);
    drive(90,0);
    }
  }