/* Corner Killer */
/* By Eric Maddox */
/* moves to the center and shoots into the corners */
main ()
{
int dam; /* damage */
if (loc_x()<500)
  {
   while (loc_x() < 400)
        drive (0,100);                                     /* goto x center */
   while (loc_x() < 440)
        drive (0,50);
   drive (0,0);                                                     /* stop */
  }  
  else                                       /* if robot is right of center */
      {
       while (loc_x() > 600)                                      /* go left*/
            drive (180,100);
       while (loc_x() > 560)
            drive (180,50);
       drive(180,0);                                                /* stop */
      }
if (loc_y()<500)
  {
   while (loc_y() < 400)
        drive (90,100);                                    /* goto y center */
   while (loc_y() < 440)
        drive (90,50);
   drive (0,0);                                                     /* stop */
  }
  else                                       /* if robot is above of center */
      {
       while (loc_y() > 600)
            drive (270,100);                                     /* go down */
       while (loc_y() > 560)
            drive (270,50);
       drive(270,0);                                                /* stop */
      }
                        /* Now the robot should be very close to the center */
while (1)                                                  /* infinite loop */
{ 
 dam=damage();
 while (damage()-3 < dam)               /* while robot is not taking damage */
      {
       fire (37);
       fire (45);                             /* fire in upper right corner */
       fire (53);
       fire (127);
       fire (135);                             /* fire in upper left corner */
       fire (143);
       fire (217);
       fire (225);                             /* fire in lower left corner */
       fire (233);
       fire (307);
       fire (315);                            /* fire in lower right corner */
       fire (325);
      }                                                        /* end while */
 while (loc_x() < 600)                             /* dodge by moving right */
      drive (0,100);
 while (speed() > 0)
      drive (0,0);
 while (loc_x() > 560)
      drive (180,100);                                          /* recenter */
 while (loc_x() > 530)
      drive (180,50);
 drive(180,0);                                                      /* stop */
}                                                      /* end infinite loop */
}                                                               /* end main */
fire (dir)
int dir;
{int
     range,
     exact, /* percision of scanner */
     dam;
exact=10;
range=scan(dir,exact);
dam=damage();
while ((range > 1) && (damage()-1 < dam))
     {
      if (exact > 1)
        --exact;                                         /* decrement exact */
      if (exact = 0)
        cannon (0,0);
      if ((scan(dir,exact)==0) && (scan(dir,exact+1) > 0))
        dir=dir+1;
      if (scan(dir,exact)==0)
        dir=dir-2;
      range=scan(dir,exact);
      if ((range > 50) && (range < 750))
        cannon(dir,range);
     }
return;
} /* end fire */
