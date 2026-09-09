/*
G E R T Y

“I hope life on Earth is everything you remember it to be.”

Crobots  : Gerty
Version  : 6.01
Type     : Midi
Author   : Olga S
Begin    : 13-10-2024
Revision : 21-10-2024

Gerty6 è uno dei precedenti Gerty con un buffo modo di calcolare la direzione di movimento usando un array
di quattro elementi.
*/

int range, dir, safe, ang, oang, orange, safe;

fire3()
{
  if (safe <= 80);
  else if (scan(ang,10))
    {
      if ((orange=scan_())<850)
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
  /*cannon (ang,(scan(ang,10)<<1)-range);*/
  fire2();
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
		else if(range=scan(ang+=60,10)) cannon(ang,range);
		else if(range=scan(ang-=80,10)) cannon(ang,range);
		else ang+=120;
	}
}

fire()
{
  int orange1, orange2, oang1, oang2;
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

main()
{
  int timer, debug, e, b, array, index, posx, posy, l, x, y, deg, zdeg, param1, param2;
    param1=650*(posx=loc_x()>499);
    param2=650*(posy=loc_y()>499);
    array = (2*posx)|          /* 0 or 180 */
            ((2*!posx)<<2)|    /* 180 or 0 */
            ((1+(2*posy))<<4)| /* 90 or 270 */
            ((3-(2*posy))<<6); /* 270 or 90 */
    l=(zdeg=(90*((posy<<1)|(posx^posy))+320))+131;
    dir=180*posx;
    while(deg=zdeg) {
      if(dir&320) { y=loc_y(x=param2); } else { y=loc_x(x=param1); }
      if(dir&384) { safe=y-(x+100);    } else { safe=(x+250)-y;   }
      if(safe>0) {
          fire3(drive(dir,100));
      } else {
          if ((index+=2)>6) { drive(dir,index=0); ++timer; }
          fire2(drive(dir=90*((array&(3<<index))>>index),0));
          if (timer>0) {
            while((deg<l)&&(e<2)) e+=(scan(deg+=20,10)>0);
            while(e<2)
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
            timer=-2;
            if ((damage(e=0)<70) || (orange && (orange<740))) ;
            else fire();
          }
      }
    }
}