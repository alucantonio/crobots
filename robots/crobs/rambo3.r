/* Rambo's strategy: */
/* 1. Always move (so that you are difficult to hit) */
/* 2. Shoot like crazy */
/* 3. Don't bother aiming */
/* Twice the velocity of Rambo2 */
/* Version 3.1 by Neil Fraser, July 1996 */

int range, angle; /* range & angle to target */

main()
{
  int x,y,z;  /* x is loc_x(), y is loc_y(), z is direction */
  while(loc_x()<205)  /* move away from EAST wall */
  {
    drive(0,100);
    turret();
  }
  while(loc_x()>795)  /* move away from WEST wall */
  {
    drive(180,100);
    turret();
  }
  while(loc_y()<255)  /* move away from SOUTH wall */
  {
    drive(90,100);
    turret();
  }
  while(loc_y()>745)  /* move away from NORTH wall */
  {
    drive(270,100);
    turret();
  }

  drive((z = 60),100);  /* start moving */

  while(1)  /* Main loop */
  {
    if(200>(x=loc_x()) || x>800)  /* bounce away from EAST/WEST walls */
    {
      drive((z=(540-z)%360),100);
      while(205>(x=loc_x()) || x>795)
      {
        turret();
        drive(z,100);
      }
    }
    turret();

    if(250>(y=loc_y()) || y>750)  /* bounce away from NORTH/SOUTH walls */
    {
      drive(z=(360-z)%360,100);
      while(255>(y=loc_y()) || y>745)
      {
        turret();
        drive(z,100);
      }
    }

    if(speed()==0) drive(z,100);  /* robot-robot collision recovery */
    turret();
  }
}


turret()
{
  if(20<(range=scan(angle,10)) && range<700)  /* Are you still there? */
    cannon(angle, range);
  else
    if(20<(range=scan(angle-20,10)) && range<700)  /* Scan 140 degrees. */
      cannon(angle-=20,range);
    else
      if(20<(range=scan(angle+20,10)) && range<700)
        cannon(angle+=20, range);
      else
        if(20<(range=scan(angle-40,10)) && range<700)
          cannon(angle-=40,range);
        else
          if(20<(range=scan(angle+40,10)) && range<700)
            cannon(angle+=40,range);
          else
            if(20<(range=scan(angle-60,10)) && range<700)
              cannon(angle-=60,range);
            else
              if(20<(range=scan(angle+60,10)) && range<700)
                cannon(angle+=60, range);
              else
                angle+=140;
  /* Rambo's moto: "Aiming is for sissies!" */
}
