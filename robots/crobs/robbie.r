
/* robbie the robot                                            */
/*                                                             */
/* Programmer: Bob Guerin                                      */
/*             4935 Niagara Ave, No. 13                        */
/*             San Diego, CA 92107                             */
/*                                                             */
/* Strategy:                                                   */
/*           1. Robot moves in clockwise square pattern and    */
/*              moves diagonally when nearing walls.           */
/*           2. Robot speed is 100, except when turning, when  */
/*              speed is reduced to 49.                        */
/*           3. Robot scans in 20 degree increments until a    */
/*              target is located.                             */
/*           4. When target is located, a second scan is done  */
/*              to narrow the target bearing to +/- 5 degrees. */
/*           5. Robot calculates firing range based on the     */
/*              range difference of the two scans and (range   */
/*              at last scan / 256).                           */
/*           6. When target is found, the robot will "lock" on */
/*              to it by constantly changing its scan angle.   */
/*           7. When target lost during scan, robot checks 180 */
/*              degrees behind direction of movement.          */

/* external variables (can be used by any function) */

int x, y;           /* current x,y position of robot */
int range;          /* range to target */
int dir;            /* direction of movement */
int quadrant;       /* quadrant robot is located */
int scandir;        /* scan direction */
int vel;            /* velocity */


/* main */
main()
{

  /* set initial course */
  new_course();

  while (1)                        /* loop is executed forever */
  {
    check_pos();
    range = scan(scandir,10);
    if (range > 0)
    {
      shoot();
    }
    scandir = (scandir + 20) % 360;
  } 
}  /* end of main */

/* check for side wall */
check_pos()
{
  if (speed() == 0)
    drive(dir,vel);
  if (quadrant == 0)
  {
    x = loc_x();
    if (x > 850)
      if (x > 900 || speed() < 50)
      {
        drive(90,100);
        quadrant = 1;
        dir = 90;
        vel = 100;
      }
      else
      {
        drive(45,49);
        dir = 45;
        vel = 49;
      }
  }
  else
    if (quadrant == 1)
    {
      y = loc_y();
      if (y > 850)
        if (y > 900 || speed() < 50)
        {
          drive(180,100);
          quadrant = 2;
          dir = 180;
          vel = 100;
        }
        else
        {
          drive(135,49);
          dir = 135;
          vel = 49;
        }
    }
    else
      if (quadrant == 2)
      {
        x = loc_x();
        if (x < 150)
          if (x < 100 || speed() < 50)
          {
            drive(270,100);
            quadrant = 3;
            dir = 270;
            vel = 100;
          }
          else
          {
            drive(225,49);
            dir = 225;
            vel = 49;
          }
      }
      else
      {
        y = loc_y();
        if (y < 150)
          if (y < 100 || speed() < 50)
          {
            drive(0,100);
            quadrant = 0;
            dir = 0;
            vel = 100;
          }
          else
          {
            drive(315,49);
            dir = 315;
            vel = 49;
          }
      }
}

/* new course function to find direction to move */
new_course()
{

  x = loc_x();
  y = loc_y();
  if (x > 500)
    if (y > 500)
      dir = 180;
    else
      dir = 90;
  else
    if (y > 500)
      dir = 270;
    else
      dir = 0;
  drive(dir,100);

  /* initialize variables */
  scandir = dir;
  quadrant = dir / 90;
  vel = 100;

}  /* end of new_course */

/* shoot at target while in range */
shoot()
{
  int angle;                    /* fire angle */
  int dif;                      /* range difference */
  int range1;                   /* range for second shot */
  int range2;                   /* range at second scan */
  while (range > 0)             /* keep firing while in range */
  {
    angle = scandir+5;
    range2 = scan(angle,5);
    if (range2 == 0)
    {
      angle = scandir-5;
      range2 = scan(angle,5);
    }
    if (range2 > 0)
    {
      dif = range - range2;
      range = range2 - ((range2 * dif) / 256);
      range1 = range - dif;
      if (range <= 700)
      {
        if (range < 41) range = 41;
        cannon(angle,range);        /* fire */
      }
      if (range1 <= 700)
      {
        if (range1 < 41) range1 = 41;
        cannon(angle,range1);       /* fire */
      }
    }
    range = scan(scandir,10);
    check_pos();
    if (range == 0)
    {
      scandir = (dir + 180) % 360;
      range = scan(scandir,10);
      if (range == 0)
        scandir = angle;
    }
    else
      scandir = angle;
  }
}
