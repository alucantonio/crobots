/* ===================================================================
   cRobot categoria Micro 		anno: 2003
  
   Candon Roberto
   
   ===================================================================== */

int deg,rng,dir,odeg,orng,dam;
int timer;
int x1,y1,x2,y2;
int asb,asa,b,ll,ul,flag,flag1;


main()
{

b=(loc_y(flag1=2)>500)*2+((loc_y()>500)!=(loc_x()>500));
flag=90*b-35;
ul=flag+142;
if (b==0) {x1=y1=90; x2=y2=89;}
if (b==1) {x1=910; y1=90; x2=909; y2=89;}
if (b==2) {x1=y1=910;      x2=y2=909;}
if (b==3) {x1=90; y1=910; x2=89; y2=909;}

while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);
if (flag1==0){
    while(!( (damage()>80) || (++timer>190) )) { Loop();}
}

while(1) {
  if (rng>330)
  	{ x1=y1=500;x2=y2=499;
	  Loop();
        } else {
          x1=y1=550;x2=y2=450;
          Loop();
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
        deg+=270; 
  }
}

