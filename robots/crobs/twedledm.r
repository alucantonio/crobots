/* Tweedlee Dum */
/* By Eric Maddox */
/* This goes to the east wall then moves up and down while it */
/* scans and fires west. */
main (){
 while (loc_x() < 940 ) drive (0,100);
 while (loc_x() < 950 ) drive (0,50);  /* go to east wall */
 while (loc_x() < 985 ) drive (0,25);
 while (loc_x() < 994  ) drive (0,10);
 drive (180,0); /* stop */
     while (1) /* infinite loop */
           {
           while (loc_y() < 900)
                 {
                  drive (90,100); /* go up */
                  fire();   /* scan and fire west */
                 }
           while (loc_y() > 100)
                 {
                  drive (270,100);  /* go down */
                  fire();  /* scan and fire west */
                 }
           }
} /*main*/
fire ()
{int range;
range=scan(175,5);
while ((range > 0) && (range < 700) && (loc_y() < 950))
      {cannon(175,range);range=scan(175,5);}
range=scan(180,5);
while ((range > 0) && (range < 700)) {cannon(180,range);range=scan(180,5);}
range=scan(185,5);
while ((range > 0) && (range < 700) && (loc_y() > 50))
      {cannon(185,range);range=scan(185,5);}
}
