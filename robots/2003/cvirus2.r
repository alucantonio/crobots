/* 

   cRobot categoria Midi 
   
   Martino Candon

*/


int deg,rng,dir,odeg,orng,dam;
int x1,y1,x2,y2;
int asb,asa,b,ll,ul,flag,flag1;



main()
{
  
   while(1) {
   	if (rng>300){
		while (loc_x()<500) Missile(drive(0,100));
		Missile(drive(90,0)); 
		while (loc_y()<500) Missile(drive(90,100));
		Missile(drive(180,0)); 
		while (loc_x()>499) Missile(drive(180,100));
		Missile(drive(270,0)); 
		while (loc_y()>499) Missile(drive(270,100));
		Missile(drive(0,0));   
         } else {
      		
      		if (rng>250){
       		    	while (loc_x()<550) Missile(drive(0,100));
		    	Missile(drive(90,0)); 
		    	while (loc_y()<550) Missile(drive(90,100));
		    	Missile(drive(180,0)); 
		    	while (loc_x()>450) Missile(drive(180,100));
		    	Missile(drive(270,0)); 
		    	while (loc_y()>450) Missile(drive(270,100));
			Missile(drive(0,0));   
       		} else {
       		
       		    	while (loc_x()<600) Missile(drive(0,100));
		    	Missile(drive(90,0)); 
		    	while (loc_y()<600) Missile(drive(90,100));
		    	Missile(drive(180,0)); 
		    	while (loc_x()>400) Missile(drive(180,100));
		    	Missile(drive(270,0)); 
		    	while (loc_y()>400) Missile(drive(270,100));
			Missile(drive(0,0));   
 		}  
       }
  }
 
  
}









Missile()
{
  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg+=355; else deg+=5;
    if (scan(deg+350,10)) deg+=357; else deg+=3; 
    cannon((deg<<1)-odeg+1,(scan(deg,10)<<1)-rng); 
  } else {
        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        if (rng=scan(deg+=80,10))  return cannon(deg,rng);
        if (rng=scan(deg+=260,10)) return cannon(deg,rng);
        if (rng=scan(deg+=120,10)) return cannon(deg,rng);
        if (rng=scan(deg+=220,10)) return cannon(deg,rng);
        if (rng=scan(deg+=160,10)) return cannon(deg,rng);
        if (rng=scan(deg+=180,10)) return cannon(deg,rng);

        if (rng=scan(deg+=200,10)) return cannon(deg,rng);
        if (rng=scan(deg+=140,10))  return cannon(deg,rng);
        if (rng=scan(deg+=240,10)) return cannon(deg,rng);
        if (rng=scan(deg+=100,10))  return cannon(deg,rng);
        if (rng=scan(deg+=280,10)) return cannon(deg,rng);
        if (rng=scan(deg+=60,10)) return cannon(deg,rng);
        if (rng=scan(deg+=320,10)) return cannon(deg,rng);
        if (rng=scan(deg+=20,10)) return cannon(deg,rng);
 
        deg+=270; 
        
        

  }
}

