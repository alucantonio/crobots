/* Tweedlee Dee */
/* By Eric Maddox */
/* This moves to bottom wall then moves left and right while it fires up */
main (){
 while (loc_y() > 60 ) drive (270,100);
 while (loc_y() > 30 ) drive (270,50);  /* go down to bottom wall */
 while (loc_y() > 15 ) drive (270,25);
 while (loc_y() > 6  ) drive (270,10);
 drive (90,0); /* stop */ 
     while (1) /* infinite loop */
           {
           while (loc_x() < 900)
                 {
                  drive (0,100); /* go east */
                  fire();   /* scan and fire up */
                 }
           while (loc_x() > 100)
                 {
                  drive (180,100);  /* go west */
                  fire();  /* scan and fire up */
                 }
           }
} /*main*/
fire ()
{int range;
range=scan(85,5);
while ((range > 0) && (range < 700) && (loc_x() < 950))
      {cannon(85,range);range=scan(85,5);}
range=scan(90,5);
while ((range > 0) && (range < 700)) {cannon(90,range);range=scan(90,5);}
range=scan(95,5);
while ((range > 0) && (range < 700) && (loc_x() > 50 ))
      {cannon(95,range);range=scan(95,5);}
}
