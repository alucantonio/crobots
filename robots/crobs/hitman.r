
/* hitMan */
/* version 1.00 */
/* by John R. Naleszkiewicz */
/* strategy: Scan 360 degree in low resolution, then shoot if in range, */
/* increase scanning resolution until a good shot can be made. */
/* continue shooting as long as possible in the current direction. */
/* This robot is always moving to a new random point. */

/* external variables, that can be used by any function  */

int x,y;               /* traveling toward this location */
int angle;             /* angle of travel for the robot  */
int hitAngle,hitRange; /* used to pin-point opponent     */
int scale;             /* constant used in the plot_course function */

/* main */
main()
{
  scale = 100000;     /* scale for trig functions */
  hitAngle = 50;
  while (1)           /* loop is executed forever */
  {
    evade();          /* make sure movment is in the right direction */
    scan_n_shoot();   /* scan for opponent and shoot if in range */
  }

}  /* end of main */


/* make sure the robot is moving in the right direction */
evade()
{
    x = rand(800) + 100;
    y = rand(800) + 100;
    angle = plot_course(x,y);
    drive(angle,50);
}  /* end of evade */


/* scan with increaseing resolution until a shot can be taken */
scan_n_shoot()
{
  int limit;       /* set the scan limit */

  limit = hitAngle + 360;
  hitAngle -= 60;
  while (((hitRange = scan((hitAngle += 20),10)) == 0 || hitRange > 700) && hitAngle <= limit)
    ;

  if (hitRange < 200 && hitRange > 0)
  {
    cannon(hitAngle,hitRange);
    while ((hitRange = scan(hitAngle,10)) < 200 && hitRange > 0)
      cannon(hitAngle,hitRange);
  }
  else
    if (hitAngle <= limit)
    {
      limit = hitAngle + 20;
      hitAngle =- 30;
      while (((hitRange = scan((hitAngle += 10),5)) == 0 || hitRange > 700) && hitAngle <= limit)
        ;

      if (hitRange < 400 && hitRange > 0)
      {
        cannon(hitAngle,hitRange);
        while ((hitRange = scan(hitAngle,5)) < 400 && hitRange > 0)
          cannon(hitAngle,hitRange);
      }
      else
        if (hitAngle <= limit)
        {
          limit = hitAngle + 20;
          hitAngle -= 24;
          while (((hitRange = scan((hitAngle += 4),2)) == 0 || hitRange > 700) && hitAngle <= limit)
            ;

          if (hitRange > 0)
          {
            cannon(hitAngle,hitRange);
            if ((hitRange = scan((hitAngle -= 10),10)) > 0)
              while ( ! cannon(hitAngle,hitRange) ); /* fire again */
            else
              if ((hitRange = scan((hitAngle += 20),10)) > 0)
                while ( ! cannon(hitAngle,hitRange) ); /* fire again */
          }
        }
    }
} /* end of scan_n_shoot */


/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
/* Improved by John R. Naleszkiewicz */
plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int curx, cury;

  y = (cury = loc_y()) - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value.    */

  /* x is zero, we either move due north or south */
  if ((x = (curx = loc_x()) - xx) == 0)
  {
    if (yy > cury)
      d = 90;        /* north */
    else
      d = 270;       /* south */
  }
  else
  {
    if (xx < curx)
      d = 180 + atan((scale * y) / x);    /* north/south-west, quadrant 2,3 */
    else
    {
      if (yy < cury)
        d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
        d = atan((scale * y) / x);        /* north-east, quadrant 1 */
    }
  }
  return (d);
}
