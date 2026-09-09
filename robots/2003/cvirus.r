/* 

   cRobot categoria Micro 
   
   Martino Candon

*/

int deg,rng,dir,odeg,orng,dam;
int x1,y1,x2,y2;
int asb,asa,b,ll,ul,flag,flag1;


main()
{
 
 
   while(1) {
   	if (rng>300){
   	            x1=y1=500;x2=y2=499;
 	            Loop();
         } else {
      		
      		if (rng>250){
      		    x1=y1=550;x2=y2=450;
       		    Loop();
       		} else {
       		    x1=y1=600;x2=y2=400;
       		    Loop();
 		}  
       }
  }
  
}




Loop()
{
	while (loc_x()<x1) Missile(drive(0,100));
	Missile(drive(90,0)); 
	while (loc_y()<y1) Missile(drive(90,100));
	Missile(drive(180,0)); 
	while (loc_x()>x2) Missile(drive(180,100));
	Missile(drive(270,0)); 
	while (loc_y()>y2) Missile(drive(270,100));
	Missile(drive(0,0));   
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
        deg+=270; 
  }
}

