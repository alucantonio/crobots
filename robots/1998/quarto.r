/* - quarto.r, BySte'97 - Stefano Marago`
 *   utilizza una routine di movimento prefissata (a quadri concentrici) che
 *   gli permette di eseguire velocemente ed evitare molti colpi;
 *   si allontana dalla posizione acquisita o dopo un tempo massimo
 *   (avversario codardo!) o se si sono subiti troppi danni (mica scemi!);
 *   la routine di sparo e` di tipo veloce anche se abbastanza precisa
 */


int sc_dir , sc_dist ;


main() {

   int d , t , dam_step , timeout ;

   dam_step = 15 ;
   timeout = 10 ;
   sc_dir = 430 ;

   while( loc_y() > 30 ) { drive( 270 , loc_y() ); fire(); }
   while( loc_x() > 30 ) { drive( 180 , loc_x() ); fire(); }

   while( 1 ) {

      d = damage() + dam_step ;
      t = 0 ;
      while( ( damage() < d ) && ( ++t < timeout ) ) {
         while( loc_y() < 250 ) { drive(  90 , 300 - loc_y() );  fire(); }
         while( loc_x() < 250 ) { drive(   0 , 300 - loc_x() );  fire(); }
         while( loc_y() >  50 ) { drive( 270 , loc_y() );        fire(); }
         while( loc_x() >  50 ) { drive( 180 , loc_x() );        fire(); }
      }

      /* while( loc_y() < 970 ) { drive( 90 , 1000 - loc_y() ); fire(); } */
      while( loc_x() < 250 ) { drive(  45 , 300 - loc_x() );  fire(); }
      while( loc_x() >  50 ) { drive( 135 , loc_x() );        fire(); }
      while( loc_y() < 740 ) { drive(  45 , 790 - loc_y() );  fire(); }
      while( loc_y() < 950 ) { drive( 135 , 999 - loc_y() );  fire(); }

      d = damage() + dam_step ;
      t = 0 ;
      while( ( damage() < d ) && ( ++t < timeout ) ) {
         while( loc_x() < 250 ) { drive(   0 , 300 - loc_x() );  fire(); }
         while( loc_y() > 750 ) { drive( 270 , loc_y() - 700 );  fire(); }
         while( loc_x() >  50 ) { drive( 180 , loc_x() );        fire(); }
         while( loc_y() < 950 ) { drive(  90 , 1000 - loc_y() ); fire(); }
      }

      /* while( loc_x() < 970 ) { drive( 0 , 1000 - loc_x() ); fire(); } */
      while( loc_y() > 760 ) { drive( 315 , loc_y() - 710 );  fire(); }
      while( loc_y() < 950 ) { drive(  45 , 1000 - loc_y() ); fire(); }
      while( loc_x() < 750 ) { drive( 315 , 800 - loc_x() );  fire(); }
      while( loc_x() < 950 ) { drive(  45 , 1000 - loc_x() ); fire(); }

      d = damage() + dam_step ;
      t = 0 ;
      while( ( damage() < d ) && ( ++t < timeout ) ) {
         while( loc_y() > 750 ) { drive( 270 , loc_y() - 700 );  fire(); }
         while( loc_x() > 750 ) { drive( 180 , loc_x() - 700 );  fire(); }
         while( loc_y() < 950 ) { drive(  90 , 1000 - loc_y() ); fire(); }
         while( loc_x() < 950 ) { drive(   0 , 1000 - loc_x() ); fire(); }
      }

      /* while( loc_y() > 30 ) { drive( 270 , loc_y() ); fire(); } */
      while( loc_x() > 760 ) { drive( 225 , loc_x() - 710 );  fire(); }
      while( loc_x() < 950 ) { drive( 315 , 1000 - loc_x() ); fire(); }
      while( loc_y() > 250 ) { drive( 225 , loc_y() - 200 );  fire(); }
      while( loc_y() >  50 ) { drive( 315 , loc_y() );        fire(); }

      d = damage() + dam_step ;
      t = 0 ;
      while( ( damage() < d ) && ( ++t < timeout ) ) {
         while( loc_x() > 750 ) { drive( 180 , loc_x() - 700 );  fire(); }
         while( loc_y() < 250 ) { drive(  90 , 300 - loc_y() );  fire(); }
         while( loc_x() < 950 ) { drive(   0 , 1000 - loc_x() ); fire(); }
         while( loc_y() >  50 ) { drive( 270 , loc_y() );        fire(); }
      }

      /* while( loc_x() > 30 ) { drive( 180 , loc_x() ); fire(); } */
      while( loc_y() < 250 ) { drive( 135 , 300 - loc_y() );  fire(); }
      while( loc_y() >  50 ) { drive( 225 , loc_y() );        fire(); }
      while( loc_x() > 250 ) { drive( 135 , loc_x() - 200 );  fire(); }
      while( loc_x() <  50 ) { drive( 225 , loc_x()       );  fire(); }

   }

}


fire() {

   int r ;

   if( sc_dist = scan( sc_dir , 10 ) ) ; else
      if( sc_dist = scan( sc_dir += 19 , 10 ) ) ; else
         if( sc_dist = scan( sc_dir -= 38 , 10 ) ) ; else {
            sc_dir -= 57 ;
            return ;
         }

   if( scan( sc_dir -= 7 , 5 ) ) ; else sc_dir += 10 ;
   if( scan( sc_dir -= 2 , 2 ) ) ; else sc_dir += 5 ;

   if( r = scan( sc_dir , 10 ) ) cannon( sc_dir , r+r-sc_dist );

   if( r > 710 ) sc_dir -= 59 ;

}

