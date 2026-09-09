/* WATCHDOG.R     */
/*                */
/* Strategies:    */
/*                */
/*  Movement: Square pattern as close to the border as possible            */
/*      to maximize the amount of time the robot moves at top speed.       */
/*                                                                         */
/*  Attack: Check for enemy and fire in one direction. Then increment      */
/*         the direction 90 degrees for next attack().                     */
/*                                                                         */
/*  Spin: Attack the Corner sitters. Spin axis of attack 45 deg.           */
/*                                                                         */
/*  B. Sanguinet                                                           */
/*
/*                */

int range;
int angle;
int cangle;
int resolution;

/* main */
main(){
  int border;
  angle=5;            /* Change offset angle to allow robot to lead shots. */
  cangle=45;          
  resolution=5;       /* Change firing precision.   */
  border=100;         /* Change movement border.    */
 while (1) {

    drive (180,100);                 /* go west, young robot */
    attack();                        /* cuts down on needless oscillation */ 
    while (loc_x()>border && speed() > 0 ) attack();  /* Keep-a-goin */
    drive (180,0);                                    /* STOP */
    while (speed() > 50) spin();                      /* wait */

    drive (90,100);         /* north */
    attack(); 
    while (loc_y()<1000-border && speed() > 0 ) attack();
    drive (90,0);
    while (speed() > 50) spin();   

    drive (0,100);         /* east  */
    attack(); 
    while (loc_x()<1000-border && speed() > 0 ) attack();
    drive (0,0);
    while (speed() > 50) spin();
 
    drive (270,100);       /* south */
    attack(); 
    while (loc_y()>border && speed() > 0 ) attack();
    drive (270,0);
    while (speed() > 50) spin();

 };                        /* forever */

}
attack(){  
     if ((range=scan((angle+=90),resolution)) > 0 && range <=700 )
      while (! cannon(angle,range)); 
    }

spin(){  
     if ((range=scan((cangle+=90),resolution)) > 0 && range <=700 ) cannon(cangle,range); 
    }
  
