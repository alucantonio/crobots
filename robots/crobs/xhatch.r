/*  XHATCH        */
/*                */
/* Strategies:    */
/*                */
/*  Movement: Diamond pattern as close to the border as possible           */
/*      to maximize the amount of time the robot moves at top speed.       */
/*                                                                         */
/*                                                                         */
/*                */
int range;
int angle;
int count;
int delta;
int resolution;
int var;
int backward_step;
/* main */
main(){
  int speed;
  int border;
  angle=0;
  backward_step=5;
  speed=100;
  resolution=10;
  var=resolution;
  border= 55;          /* Change movement border    */

    drive (180,speed);                /* go west, young robot        */
    while (loc_x()>border && speed() > 0 ) attack();  /* Keep-a-goin */
    drive (180,0);                                    /* STOP        */
    while (speed() > 49) attack();                    /* wait        */

    drive (90,speed);         /* north */
    while (loc_y()<1000-border && speed() > 0 ) attack();
    drive (90,0);
    while (speed() > 49) attack();

    /*  Now we are in upper left corner, begin Hourglass pattern */

 while (1) {

    drive (315,speed);                /* SouthEast                   */
    while (loc_x()<1000-border && loc_y()>border && speed() > 0 ) attack();  /* Keep-a-goin */
    drive (315,0);                                    /* STOP        */
    while (speed() > 49) attack();                    /* wait        */

    drive (90,speed);         /* north */
    while (loc_y()<1000-border && speed() > 0 ) attack();
    drive (90,0);
    while (speed() > 49) attack();

    drive (225,speed);         /* SouthWest  */
    while (loc_x()>border && loc_y()>border && speed() > 0 ) attack();
    drive (225,0);
    while (speed() > 49) attack();

    drive (90,speed);       /* North */
    while (loc_y()<1000-border && speed() > 0 ) attack();
    drive (90,0);
    while (speed() > 49) attack();

 };                        /* forever */
}
attack(){
     int cannon_yet;
     angle+=2*var;
     cannon_yet=0;
     while (!cannon_yet && (range = scan(angle,var ))>0 ) {
        if (range<740) cannon_yet=cannon(angle,range);
        else  cannon_yet=1; }  
   if (cannon_yet)  {
        if (var>1) {
       	var>>=1;
       	angle-=3*var;
       	count=0;          }
        else  angle-=2*var;
                      }
     else {
        if ((++count)==2) { var=resolution;
		                  angle-=backward_step*var;
                            }
           } 
        }


