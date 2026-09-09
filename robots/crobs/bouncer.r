/*  BOUNCER.R  by Terry Donahue  (TERENCE at YKTVMH)	       */
/*  moves as a newtonian particle, bouncing around the screen  */
main() {
   int x,dir,range,flag;
   if(loc_y()>500) drive(dir=180+(loc_x()<500)*90+rand(90),100);
   else 	   drive(dir=	 (loc_x()>500)*90+rand(90),100);
   while(1) {
      if(damage()>dam) {
	 drive(x,0);
	 while(speed()>49);
	 drive(x,100);
	 dam=damage(); }
      if(speed()<40) {
	 drive(x,100);
	 flag=0; }
      if(flag>3) {
	 if(loc_x()<100 || loc_x()>900) {
	    drive(dir=(540-dir)%360,flag=0);
	    while(speed()>49);
	    drive(dir,100); }
	 if(loc_y()<100 || loc_y()>900) {
	    drive(dir=(360-dir)%360,flag=0);
	    while(speed()>49);
	    drive(dir,100); } }
      ++flag;
      while(!(scan(x+=20,10)));
      x+=5-(scan(x-5,5)!=0)*10;
      x+=3-(scan(x-3,3)!=0)*6;
      if(range=scan(x,10)) cannon(x,range);
      if(range<700) x+=320; } }
