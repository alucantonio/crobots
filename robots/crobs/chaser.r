/* Chaser */
/* By Eric Maddox (Origional idea by Dan Manty) */
/* finds enemy then moves twards him while fireing */
main()
{int direction, /* suspected direction to enemy */
     y,         /* direction + 10 */
     range,     /* distance to enemy */
     dam,       /* damage taken so far */
     ctr;       /* delay counter */
direction=0;
dam=0;
y=10;
range=0;
ctr=0;
while (1)
{
 while (scan(direction+5,5)==0)                      /* find aprox. position */
      {
       direction=direction+10;
       if ((direction>355) || (direction<5) || damage() > dam)
         {                                   /* if damage is being taken or */
          drive (rand(360),100);   /* if he wasn't found in that sweep move */
          while (ctr < 10)                                         /* delay */
               ++ctr;
          ctr=0;
          drive (0,0);                                              /* stop */
         }
       dam=damage();
       if (direction>359)
         direction=direction-360;
      }
 y=direction+10;
 while ((scan(direction,1)==0) && (direction < y))
      direction=direction+1;             /* Locate exact direction to enemy */
 while (scan(direction,1)>0)
      {                                        /* fire as often as possible */
       range=scan(direction,1);                      /* find range to enemy */
       if (range > 1)
         {
          if (range < 707) cannon(direction,range);                 /* Fire */
          if (range > 100) drive (direction,50);             /* move closer */
          if (range < 100) drive (direction,0);     /* do not get too close */
         }                                                            /* if */
      }
 drive (direction,0);                              /* when we lost him stop */
 if (scan(direction,2)==0)
   direction=y-10;                           /* if we lost him search again */
}                                                   /* end of infinite loop */
}                                                                   /* main */

