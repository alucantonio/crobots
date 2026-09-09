/****************************************************************/
/*                          McEnrobo                            */
/*                          --------                            */
/* Author:   Alex Paci                                          */
/* Date  :   1990-1999                                          */
/*                                                              */
/* if you like CRobots, you may visit TpT (Tennis pro           */
/* Tournament) site, the first italian sport related PBeM where */
/* you've to "program" your tennis player at                    */
/* http://space.tin.it/io/rpaci                                 */
/*                                                              */
/* Strategy is to move around the ring at maximum speed         */
/* until damages become too high. At this point he moves with   */
/* rectangular path near the corners changing corner if         */
/* threatened. Fire routine is quicker as much as possible,     */
/* being the robot in a continuous run.                         */
/****************************************************************/

                       /* Global Variables */

int direction;         /* Running Direction       */
int d;                 /* Distance to the Border  */
int gradi;             /* Turning Degrees         */
int old_damage;        /* Suffered Damages        */
int sc_dir;            /* Scanning Direction      */
int upx;               /* Auxiliar Variables      */
int downx;
int upy;
int downy;
int high1;
int high2;
int low1;
int low2;
int changed;



/* MAIN ROUTINE */

main() {

  /* Variables Initialization  */
  direction  = 0;
  old_damage = 0;
  sc_dir     = 0;

  /* Rectangle is Whole Screen with Deceleration Margins */
  high1      = 950;
  high2      = 50;
  low1       = 950;
  low2       = 50;
  changed    = 0;

  upx        = high1;
  downx      = low2;
  upy        = high1;
  downy      = low2;

  /* Main Cycle */
  while (1)  {

    if (!changed && damage()>75) {
      /* Rectangle is Near Corner        */
      high1 = 950;
      high2 = 700;
      low1  = 300;
      low2  = 50;
      /* Select Nearest Rectangle Corner */
      upx   = high1;
      downx = high2;
      if (loc_x()<=500) {
        upx   = low1;
        downx = low2;
      }
      upy   = high1;
      downy = high2;
      if (loc_y()<=500) {
        upy   = low1;
        downy = low2;
      }

      changed=1;
    }

    if (direction==0)
      d=(upx-loc_x());
    else if (direction==90)
      d=(upy-loc_y());
    else if (direction==180)
      d=(loc_x()-downx);
    else if (direction==270)
      d=(loc_y()-downy);

    /* Decelate if Too Close to Border */
    drive(direction,d);

    if (d<20)
      d=20;

    if (d<=20) {
      /* Turn 90 Degrees Rightwards    */
      gradi=90;
      /* Turn 90 Degrees More if Still no much Damaged and Safe Border */
      if (damage()<=75 && damage()==old_damage)
         gradi+=90;
      else
         old_damage=damage();
      change_direction();
    }

    /* Change Corner if Not Safe */
    if (damage()>=old_damage+10 && damage()>75) {
       old_damage=damage();
       cambia_angolo();
    }

    /* Quick Scan and Fire */
    fire();
            
  }
}



/* Change Direction Function */
change_direction() {
    direction=(direction+gradi)%360;
    drive(direction,d);
}

/* Change Corner Function    */
cambia_angolo() {
  if (upx==high1) {
    if (upy==high1) {
      upx=low1;
      downx=low2;
    }
    else {
      upy=high1;
      downy=high2;
    }
  }
  else {
    if (upy==high1) {
      upy=low1;
      downy=low2;
    }
    else {
      upx=high1;
      downx=high2;
    }
  }
}


/* Quick Scan and Fire Routine */
fire() {

   int r ;
   int sc_dist;

   if( sc_dist = scan( sc_dir , 10 ) ) ; else
      if( sc_dist = scan( sc_dir += 20 , 10 ) ) ; else
         if( sc_dist = scan( sc_dir -= 40 , 10 ) ) ; else {
            sc_dir -= 60 ;
            return ;
         }

   if(r= scan( sc_dir -= 7 , 5 ) ) cannon(sc_dir,2*r-sc_dist) ; else sc_dir += 10 ;
   if(r= scan( sc_dir -= 2 , 2 ) ) cannon(sc_dir,2*r-sc_dist); else sc_dir += 4 ;

   if( r = scan( sc_dir , 10 ) ) cannon( sc_dir , 2*r-sc_dist );

   if( r > 700 ) sc_dir -= 60 ;

}

