/* ===================================================================
   cRobot categoria Midi 		anno: 2003
  
   Candon Roberto
   
   ===================================================================== */


int deg,rng,dir,odeg,orng,dam;
int xs,ys,nemici,wnemici,xd,yd,dd,rd;
int timer;
int x1,y1,x2,y2,tempo;
int flag,flag1;


main()
{


flag1=2;
flag=0;
while (flag<360&&flag1) flag1-=(scan(flag+=20,10)>0);
if (flag1==0){


  xd=180*(xs=loc_x(yd=90+180*(ys=(loc_y(nemici=3))>499))>499);

  while(nemici>1) {
    if (xs) {
      Run(180); while (loc_x()>945) RadarX(); Stop(180);
      Run(0);   while (loc_x()<950) Sonar();  Stop(0);
    } else {
      Run(0);   while (loc_x()<55)  RadarX(); Stop(0);
      Run(180); while (loc_x()>50)  Sonar();  Stop(180);
    }
      
    if (ys) {
      Run(270); while (loc_y()>945) RadarXY(yd,xd); Stop(270);
      Run(90);  while (loc_y()<950) Sonar();  Stop(90);
    } else {
      Run(90);  while (loc_y()<55)  RadarXY(yd,xd); Stop(90);
      Run(270); while (loc_y()>50)  Sonar();  Stop(270);
    }
   
  if (damage()>50) nemici=1;   
   
  }
  

   
  /*----- Routine offensiva di 4vs4 ------ */
 
 Attacco(tempo=2);
 x1=y1=600;x2=y2=400;
 deg+=180;
 while(1) { Loop(); } 
  
 }
 
 /* ----- Routine offensiva di F2F  ------- */
  Attacco(tempo=999999);
 
}


Attacco()
{

   while(--tempo) {
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


RadarX()
{

 RadarXY(xd,yd);
         if (++timer>305)  
            { if (damage()<60) nemici=1; } 



}




RadarXY(v1,v2)
{
  if (dd=scan(v1,10)) {
    if (dd<scan(v2,10)) deg=v1; else deg=v2;  
   } else  deg=v2;
   
   
       
}


Sonar()
{
  if (rd==380) { 
    nemici=wnemici;
    rd=wnemici=0;
  } else {
    if (scan(rd+=20,10)) wnemici+=1;
  }  	
}

Run(d)
{
  drive(d,100);
  while(speed()<70) drive(d,100);	
}

Stop(d)
{
  drive(d,0);
  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg+=357; else deg+=3;
    if (scan(deg+350,10)) deg+=358; else deg+=2; 
    cannon(deg,(scan(deg,10)<<1)-rng); 
  }   
  else if (rng=scan(deg+=340,10)) cannon(deg,rng);
  else if (rng=scan(deg+=40,10))  cannon(deg,rng);
  else if (rng=scan(xd,10)) cannon(xd,rng);
  else if (rng=scan(yd,10)) cannon(yd,rng);
  
  while(speed()>59) drive(d,0);	
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

