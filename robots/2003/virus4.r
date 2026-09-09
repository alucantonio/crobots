/* ===================================================================
   cRobot categoria Macro	anno: 2003
  
   Candon Roberto
   
   ===================================================================== */


int deg,rng,dir,odeg,orng,dam;
int xs,ys,nemici,wnemici,xd,yd,dd;
int rd;
int timer,tempo;
int x1,y1,x2,y2,t;
int asb,asa,b,ll,ul,flag,flag1;


main()
{
if ((asb=(loc_y()>500)))     up(920); else dn(80);
if ((asa=(loc_x()>500))) dx(920); else sx(80);
b=asb*2+(asb!=asa);
ll=90*b-35;
ul=ll+142;
flag=ll;
flag1=2;
while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);

if (flag1==0) {
  xs=loc_x()>499;  
  ys=loc_y()>499;
 
  xd=180*xs;
  yd=90+180*ys;
  Stop(90);
  nemici=3;

  while(nemici>1) {
    if (xs) {
      Run(180); while (loc_x()>945) RadarX(); Stop(180);
      Run(0);   while (loc_x()<950) Sonar();  Stop(0);
    } else {
      Run(0);   while (loc_x()<55)  RadarX(); Stop(0);
      Run(180); while (loc_x()>50)  Sonar();  Stop(180);
    }
      
    if (ys) {
      Run(270); while (loc_y()>945) RadarY(); Stop(270);
      Run(90);  while (loc_y()<950) Sonar();  Stop(90);
    } else {
      Run(90);  while (loc_y()<55)  RadarY(); Stop(90);
      Run(270); while (loc_y()>50) Sonar();   Stop(270);
    }
   
    if (damage()>60) nemici=1;
    
  }
  
   Prepara();
   Attacco();

}
  
 F2F();
  
  
}


up(limt) {while(loc_y()<limt) {drive(90,100);Missile();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Missile();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Missile();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Missile();}drive(180,0);}


Prepara()
{
 if (  (scan(yd,10))|| (scan(yd+20,10))  || (scan(yd+30,10))   )  {
   	deg=yd;
	if (b==2) {
		x1=910; y1=900;
		x2=900; y2=800;
		while(y1>500) {
			y1-=80;
			y2-=80;
			Loop();
		}
        }
  	if (b==1) {
       		x1=910; y1=200;
       		x2=900; y2=100;
       		while(y1<500) {
			y1+=80;
			y2+=80;
			Loop();
          	}
          }
  	if (b==3) {
       		x1=110;y1=900;
       		x2=100;y2=800;
       		while(y1>500) {
			y1-=80;
			y2-=80;
			Loop();
          	} 
	}
  	if (b==0) {
       		x1=110;y1=200;
       		x2=100;y2=100;
       		while(y2<500) {
 			y1+=80;
			y2+=80;
			Loop();
	        }
     
  	}
 
 return; 
 
 } 
 
 if (  (scan(xd,10))|| (scan(xd+20,10))  || (scan(xd+30,10))   )  {
 	deg=xd;
 	if (b==2) {
 			x1=900; y1=910;
 			x2=800; y2=900;
 			while(x2>500) {
 			x1-=80;
 			x2-=80;
 			Loop();
 		}
         }
   	if (b==1) {
        		x1=900; y1=110;
        		x2=800; y2=100;
        		while(x2>500) {
 			x1-=80;
 			x2-=80;
 			Loop();
           	}
           }
   	if (b==3) {
        		x1=200;y1=910;
        		x2=100;y2=900;
        		while(x2<500) {
 			x1+=80;
 			x2+=80;
 			Loop();
           	} 
 	}
   	if (b==0) {
	        	x1=200;y1=110;
	        	x2=100;y2=100;
	        	while(x2<500) {
	 		x1+=80;
	 		x2+=80;
	 		Loop();
	           	} 
 	}
 
 }
 
 

}


Attacco()
{
tempo=2;
  while(--tempo) {
     if (rng>330){
	      while (loc_x()<500) Missile(drive(0,100));
	      Missile(drive(90,0)); 
	      while (loc_y()<500) Missile(drive(90,100));
	      Missile(drive(180,0)); 
	      while (loc_x()>499) Missile(drive(180,100));
	      Missile(drive(270,0));     
	      while (loc_y()>499) Missile(drive(270,100));
	      Missile(drive(0,0)); 
     } else {
      	     if (++t>1) {
			while (loc_x()<700) Missile(drive(0,100));
			Missile(drive(90,0)); 
			while (loc_y()<700) Missile(drive(90,100));
			Missile(drive(180,0)); 
			while (loc_x()>300) Missile(drive(180,100));
			Missile(drive(270,0)); 
			while (loc_y()>300) Missile(drive(270,100));
      			Missile(drive(0,0));
      	      } else {
			while (loc_x()<550) Missile(drive(0,100));
			Missile(drive(90,0)); 
			while (loc_y()<550) Missile(drive(90,100));
			Missile(drive(180,0)); 
			while (loc_x()>450) Missile(drive(180,100));
			Missile(drive(270,0)); 
			while (loc_y()>450) Missile(drive(270,100));
			Missile(drive(0,0)); 
	      }
      }
  }
 
x1=y1=600;x2=y2=400;
 deg+=180;
while(1) {  Loop(); }
       
}

F2F()
{
 while(1) {
     if (rng>330){
		x1=500;y1=500;
		x2=499;y2=499;
		Loop();
     } else {
     		
     		if (rng>200) {
   		       	x1=600;y1=600;
   	        	x2=400;y2=400;
	        	Loop();
     		} else {
  		       	x1=700;y1=700;
 	        	x2=300;y2=300;
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

  if (dd=scan(xd,10)) {
    if (dd<scan(yd,10)) deg=xd; else deg=yd; 
  } else deg=yd;
   
        if (++timer>350)  
            if (timer<395) 
                { if (damage()<60) nemici=1;  } 
           
}


RadarY()
{
  if (dd=scan(yd,10)) {
    if (dd<scan(xd,10)) deg=yd; else deg=xd;  
  } else  deg=xd;
   
       
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
  else if (rng=scan(deg+=300,10)) cannon(deg,rng);
  else if (rng=scan(deg+=80,10))  cannon(deg,rng); 
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

