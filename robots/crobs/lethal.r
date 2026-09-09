int fireang;

main()
  {
  int by,b1,range1,range;
  int temp,escape;
  int rrate,brate;
  int strt,end;
  int count,d;
  int run;

  d = 20;      /* Initialize delta damage variable */
  count = 0;   /* Initialize no action counter */
  run = 1;
  if (loc_y() < 500)    /* Move to nearest corner */
    {
    if (loc_x() < 500)
      {
      escape = 0;
      drive(plot_course(0,0),100);
      }
    else
      {
      escape = 1;
      drive(plot_course(999,0),100);
      }
    }
  else
    {
    if (loc_x() > 500)
      {
      escape = 2;
      drive(plot_course(999,999),100);
      }
    else
      {
      escape = 3;
      drive(plot_course(0,999),100);
      }
    }
  escape *= 90;        /* Initialize escape route */
  strt = escape + 8;   /* Initialize starting and */
  end = escape + 98;   /* ending scan values      */
  while(1)
    {
    fireang = strt;
    while (fireang < end)
      {
      range = scan(fireang,8);          /* Wide angle scan */
      if (range > 0 && range < 740)
        {
        range = zoom();                 /* Zoom in on victim */
        b1 = fireang;
        range1 = zoom();            /* and zoom when found */
        if (range1)
          {
          brate = fireang - b1;           /* Calculate bearing rate */
          rrate = range1 - range;         /* Calculate range rate */
          if (run)                        /* If we're moving, adjust */
            rrate -= 22;                  /* range rate (major fudge) */
          by = fireang+(range1*brate)/105;  /* Determine cannon bearing */
          if (rrate > 0)                  /* Calculate fudge factor */
            temp = 74;
          else
            temp = 127;
          range1 += (range1*rrate)/temp;  /* Determine cannon range */
          if (range1 < 721)
            {
            cannon(by,range1);       /* WASTEM!!! */
            cannon(by+brate,range1+rrate);
            count = 0;                    /* Clear no action counter */
            }
          fireang += brate;
          }
        }
      else
        fireang += 17;
      if (speed() == 0)            /* Check if not moving */
        run = 0;
      ++count;                     /* Increment no action counter */
      if (damage() > d || count > 250)
        {                          /* Check dD (delta damage) & no action */
        drive(escape,0);           /* Disegage motor (CPU bug!) */
        strt = (strt + 90) % 360;  /* Adjust start & end scan values */
        end = (end + 90) % 370;
        d = damage() + 20;         /* New damage threshold */
        count = 0;                 /* Clear no action counter */
        drive(escape,100);         /* See ya!! */
        escape = (escape + 90) % 360;
        run = 1;                   /* Indicate that we're moving */
        }
      }
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
  if ( rng=scan(fireang,width) )
    {
    if (width==1)
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

plot_course(xx,yy)
int xx,yy;

/* Modified plot course which uses less space than the provided
   routine because it makes only one ATAN call instead of four. */

  {
  int d;
  int x,y;
  int curx,cury;

  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if ( x==0 )
    {
    if ( yy > cury )
      d = 90;
    else
      d = 270;
    }
  else
    {
    d = atan((100000*y)/x);
    if ( yy < cury )
      {
      if ( xx > curx )
        d += 360;
      else
        d += 180;
      }
    else
      {
      if ( xx <= curx )
        d += 180;
      }
    }
  return(d);
  }
