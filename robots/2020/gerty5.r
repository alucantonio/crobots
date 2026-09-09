/*
G E R T Y

“I hope life on Earth is everything you remember it to be.”

Crobots  : Gerty
Version  : 5.0
Type     : Midi
Author   : Olga S
Begin    : 07-08-2020
Revision : 07-08-2020

That's basically a copy of Gerty4. Difference: play the game "spot the difference".
*/


int ang,oang,range,orange,
dir,posx,posy,deg,enemy,dist,l,zdeg,timer,n,m;
int x0,y0,xd,yd,b;
/* These were local. As global now this should be more... efficient? */
int orange1, orange2, oang1, oang2, l;

wall(m,n,x) /* inspired by the check routine of Gantu */
{
  if(m) l=loc_y(); else l=loc_x();
  if(n) return l-x; else return x-l;
}

goto_(x,d) {
 dir=d;
 m=dir&320; n=dir&384;
 while((dist=wall(m,n,x))>80) fire3(drive(dir,100));
 fire2(drive(dir,0));
}

scan_()   
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}

fire()
{
   if (orange1=scan(oang1=ang,10)) {
      if (orange>700) return fire2();
      else {
         scan_();
         if (orange2=scan(oang2=ang,5))
           {
              scan_();
              return cannon(((ang<<2)+oang2-(oang1<<1))/3,
                                 (((scan(ang,10))<<2)+orange2-(orange1<<1))/3);
           } else return fire2();
      }
   } else {
		if (range=scan(ang+=340,10));
		else if (range=scan(ang+=40,10));
		else if (range=scan(dir,10))
		 ang=dir;
		else
		  return (ang+=40);
		return cannon(ang,(scan(ang,10)<<1)-range);
	}
}

fire2()
{
	if (range=scan(oang=ang,10)) 
	{
		if (scan(ang-8,5))  
		{ 	
			if (scan(ang-=5,2)) ; 
			else ang-=4; 
		}
		else
		{
			if (scan(ang+8,5))  
			{
				if (scan(ang+=5,2)) ; 
				else ang+=4; 
			}
		      else
		      {
				if (scan(ang,1)) ;
				else if (scan(ang-=3,2)) ; else ang+=6;
			}
		}
		return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range));
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
	}
}

fire3()
{
  if (dist <= 160);
  else if (scan(ang,10))
    {
      if ((orange=scan_(/*drive(dir,100)*/))<850)
        {
          if (range=scan_())                
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*200/(200+orange-range-(cos(ang-dir)/4167))));
        }
    }      
  if((range=scan(ang,10))&&(range<850));
  else
    if((range=scan(ang+=339,10)));
    else
      if((range=scan(ang+=42,10)));
      else
        if((range=scan(dir,10))) ang=dir;
        else
          return (ang+=40);
  cannon (ang,(scan(ang,10)<<1)-range);
}

main()
{
 goto_(y0=1000*(posy=loc_y(posx=loc_x(timer=1)>499)>499),yd=(270 - 180*posy));
 goto_(x0=1000*posx,xd=180*!posx);
 l=(zdeg=(90*((posy<<1)|(posx^posy))+320))+131;
 while (deg=zdeg)
 {
  while (--timer) {
   if ((damage()<70 /*60*/) || (orange && (orange<740))) {
     goto_(350+300*posx,180*posx);
     goto_(x0,xd);
     goto_(350+300*posy,90 + 180*posy);
     goto_(y0,yd);
   } else fire();
  }
  while((deg<l)&&(timer<2)) timer+=(scan(deg+=20,10)>0);
  if(timer<2)
  {
    while(1)
    {
      if (((posx=loc_x())%880)<120) dir=180*(posx>500);
      else if (((posy=loc_y())%880)<120) dir=90+180*(posy>500);
  		else if (range>600) dir=ang+25;
  		else if (range<180) dir=ang+195;
  		else dir=ang+180*(b^=1);
  				
  		fire2(drive(dir,100));
  		fire2(drive(dir,100));
  		fire2(drive(dir,100));
    }
  }
 }
}
