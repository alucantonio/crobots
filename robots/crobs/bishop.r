/*  BISHOP        */
/*                */
/*    Walter D. Thompson, Jr.  */
/*                */
/* Strategies:    */
/*                */
/*  Movement: Diagonal pattern as close to the center as possible          */
/*      to maximize the amount of time the robot moves at top speed.       */
/*      This strategy statistically reduces the accuracy of the opponent   */
/*      robots shots.  Meanwhile, a tight loop scan and fire method is     */
/*      employed to shoot as often as possible at any target in range.     */
/*                                                                         */
/*      This is a modest enhancement to the robot file SPINNER.R           */
/*                                                                         */
/*                */
int range;          /*  stores the range to opponent robot  */
int angle;          /*  current scan direction              */
int count;          /*  */
int delta;          /*  */
int resolution;     /*  scanning resolution, kept at maximum  */
int var;            /*  */
int backward_step;  /*  */
/* main */
main(){
  int speed;        /*  driving speed, constant 100  */
  int border;       /*  meters from border before starting deceleration */
  angle=0;          /*  initial scan angle  */
  backward_step=5;  /*  */
  speed=100;        /*  initialize at maximum speed  */
  resolution=10;    /*  initialize at maximum speed  */
  var=resolution;
  border= 55;       /*  Border distance initialized  */

    drive (180,speed);                /*  west   */
    while (loc_x()>border)            /*  until border distance from wall  */
    {
       attack();                      /*  Continuously call attack module  */
       if( !speed() )                 /*  if collision w/ robot, restart   */
	  drive( 180, speed );
    }
    drive (180,0);                    /* STOP        */
    while (speed() > 49) attack();    /* wait until at turning speed       */

    drive (90,speed);                 /* north */
    while (loc_y()<1000-border)       /* until border distance from wall   */
    {
       attack();
       if( !speed() )
	  drive( 90, speed );
    }
    drive (90,0);
    while (speed() > 49) attack();

    /*  Now we are in upper left corner, begin Diagonal pattern */

 while (1) {

    drive (315,speed);                /* SouthEast                   */
    while (loc_y()>border && speed()>0 ) attack();
    drive (315,0);
    while (speed() > 49) attack();

    drive (135,speed);               /* NorthWest  */
    while (loc_x()>border && speed()>0 ) attack();
    drive (135,0);
    while (speed() > 49) attack();

 };                        /* forever */
}
attack()
{
   int cannon_yet;       /*  Flag for Cannon: non-zero cannon has fired */
   angle+=2*var;         /*  change scan angle by twice resolution      */
   cannon_yet=0;         /*  initialize cannon flag to not fired        */

   /*  Loops if robot is scan range but cannon is reloading  */
   while (!cannon_yet && (range = scan(angle,var ))>0 )
   {
      if (range<740)                       /* enemy robot sighted in range */
	 cannon_yet=cannon(angle,range);   /* attempt to fire cannon */
      else                                 /* otherwise robot not in range */
	 cannon_yet=1;                     /* exit to adjust angle of scan */
   }

   if (cannon_yet)                         /* robot was sited in scan range */
   {
      if (var>1)                           /* current resolution > 1        */
      {
	 var>>=1;                          /* reduce resolution size        */
	 angle-=3*var;                     /* turn angle back (adj. for speed */
	 count=0;                          /* initialize search count       */
      }
      else                                 /* current resolution smallest   */
	 angle-=2*var;                     /* adjust scan angle             */
   }
   else                                    /* no robot in scan angle        */
   {
      if ((++count)==2)                    /* if searched twice             */
      {
	 var=resolution;                   /* reset resolution to max       */
	 angle-=backward_step*var;         /* adjust scan angle             */
      }
   }
}


