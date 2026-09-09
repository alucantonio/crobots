/*
T A N T A L O

Crobots 	: Tantalo
Type			: Macro
Version 	: 1.01
Author		: Olga S
Begin			: 22-12-2010
Revision	: 28-12-2010

Tantalo is an enhancement of a Jedi10 branch version (my husband' macro).
Due to this disadvantageous legacy, Tantalo will get odd results.
Better than Jedi10 anyway...
Differences: I don't really know. Jedi10 is still under review...
This bot “swings” using a triangle shape. Its width depends on the enemy
distance.
*/

int
	ang,oang,range,orange,d,dmax,dir,posx,posy,dist,flag,timer,sk,fp,enemies,
	t,b,td,tl,deg1,deg2,dscan,dvector;

stop()
{
  spara(drive(dir,t=0));  
  while(speed()>59) ;
}

int radar() /* Count enemies */
{
int deg, brange; deg=deg1-20; brange=1500; enemies=3;
  while((deg<=deg2)&& enemies)
    if (range=scan(deg+=20, 10))
    {
      --enemies;
      if (range<brange)
      {
        ang=deg;
        brange=range;
      }
    }
  if (enemies>1)
  {
    sk=fp=5;
    if (scan(deg1+45,10)) dir=ang=deg1+45; else dir=deg1+15;
    while(1)
    {
      if(t%2) {
              if ((posx=loc_x(posy=loc_y()))>860) dir=155+50*(posy>500);
              else if (posx<140) dir=335+50*(posy<500);
              else if (posy>860) dir=245+50*(posx<500);
              else if (posy<140) dir=65+50*(posx>500);
              else {
                      if(orange<210) dir=(ang/90)*90;
                      else if (orange<680) dir=ang+80+(b^=1)*190; 
                      else dir=ang+25+(b^=1)*235;
              }
              spara(drive(dir,100));
      } else {
              if(orange>370) {
                      spara(drive(dir,100));
                      fuoco(drive(dir,100));
              }
              else spara(drive(dir,100));
      }
    }  
  }
}

fuoco() {
  t+=2;
  if (scan(ang,10));
  else { if (scan(ang+=20,10));
        else { if (scan(ang-=40,10));
                else { if (scan(ang+=60,10));
                        else { if (scan(ang-=80,10));
                                else {
                                        if (scan(ang+=100,10)) return;
                                        else if (scan(ang-=120,10)) return;
                                        return ang+=180;
                                }
                        }
               }
       }
  }

  if (scan(ang-10,8)) ang-=8;
  if (scan(ang+10,8)) ang+=8;
  if (scan(ang+13,10)) ang+=5; if (scan(ang-13,10)) ang-=5;
  if (scan(ang+12,10)) ang+=3; if (scan(ang-12,10)) ang-=3;
  if (scan(ang+10,10)) ang+=1; if (scan(ang-10,10)) ang-=1;

  if (orange=scan(oang=ang,10)) {
    if (scan(ang+13,10)) ang+=5; if (scan(ang-13,10)) ang-=5;
    if (scan(ang+12,10)) ang+=3; if (scan(ang-12,10)) ang-=3;
    if (scan(ang+10,10)) ang+=1; if (scan(ang-10,10)) ang-=1;

    if (range=scan(ang,10))
      return cannon(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14),
                    range*192/(192+orange-range-(cos(ang-dir)>>12)));
  }
}

search()
{
  if (scan(ang-=350,10)) return fire();
  if (scan(ang-=20,10))  return fire();
  if (scan(ang-=320,10)) return fire();
  if (scan(ang-=60,10))  return fire();
  if (scan(ang-=280,10)) return fire();
  if (scan(ang-=100,10)) return fire();
  if (scan(ang-=240,10)) return fire();
  if (scan(ang-=140,10)) return fire();
  if (scan(ang-=200,10)) return fire();
  if (scan(ang-=180,10)) return fire();
  if (scan(ang-=160,10)) return fire();
  if (scan(ang-=220,10)) return fire();
  if (scan(ang-=120,10)) return fire();
  if (scan(ang-=260,10)) return fire();
  if (scan(ang-=80,10))  return fire();
  if (scan(ang-=300,10)) return fire();
  if (scan(ang-=40,10))  return fire();
  if (scan(ang-=340,10)) return fire();
}

fire()
{
  if (range=scan(oang=ang,10))  
  {    
		if (scan(ang+350,10)) ang-=1; else ang+=1;
    		if (scan(ang+10,10)) ang+=1; else ang-=1; 
		      cannon(ang,(scan(ang,10)<<1)-range);
 	} 
	else search();
}

spara()
{
        ++t;
        if ((orange=scan(ang, 10)) ) { 
                if (scan(ang-9,4)) { 
                        if (scan(ang-=13,4)) { 
                                if(scan(ang-3,fp)) ang-=fp;
                                else ++ang;
                        }  else if (scan(ang-fp,fp)) ang-=fp;
                } else if(scan(ang+9,fp)) { 
                        if (scan(ang+=13,fp)) ang+=fp;
                        else --ang;
                }  else if(scan(ang+4,fp)) ang+=fp;
                else ang-=fp;

        }  else if ((orange=scan(ang-=20,10))) { 
                if (scan(ang-9,10)) { 
                        if (scan(ang-=13,fp)) ang-=fp;
                        else ++ang;
                } else if(scan(ang+9,10)) ang+=6; 
        }  else if ((orange=scan(ang+=40,10))) { 
                if (scan(ang+9,10)) ang+=12;
        }  else if ((orange=scan(ang+=20,10)));
	else if(sk) {
		if ((orange=scan(ang-=80,10))) return cannon(ang,orange);
		else if ((orange=scan(ang-=20,10))) return cannon(ang,orange);
		else if ((orange=scan(ang+=120,10))) return cannon(ang,orange);
		else if ((orange=scan(ang+=20,10))) return cannon(ang,orange);
		else if ((orange=scan(ang-=160,10))) return cannon(ang,orange);
		else return ang+=260;
	} else if ((orange=scan(dir,10))) {
        	if (orange>850) {
                        return ang+=40;
                } else ang=dir;
        } else { 
                if ((orange=scan(ang+=20,10))) return cannon(ang,orange); 
                return ang+=40;  
	} 
        if (range=scan(ang,10)){  
                cannon (ang, range*145/(145+orange-range) ); 
                if(sk); else if(range>740) if(range>orange || range>900) {
                                return ang+=40;
                        }
        }  else if(scan(ang-20,10)) ang-=20; 
        else if(scan(ang+=20,10));
	else ang+=40; 
} 

runX() /* x-axis */
{
  dir=180*!posx;
  if(posx) { while(loc_x()<905) fire(drive(dir,100)); while(loc_x()<950) drive(dir,100); }
  else     { while(loc_x()> 95) fire(drive(dir,100)); while(loc_x()> 50) drive(dir,100); }
  stop();
}

runY() /* y-axis */
{
  dir=270-180*posy;
  if(posy) { while(loc_y()<905) fire(drive(dir,100)); while(loc_y()<950) drive(dir,100); }
  else     { while(loc_y()> 95) fire(drive(dir,100)); while(loc_y()> 50) drive(dir,100); }  
  stop();
}

corner()
{
  if (speed()) stop(); if ((flag>>4)^posx^posy) runY(runX()); else runX(runY());
}

main() /* Setup main variables  */
int dperf,l;
{
  posx=loc_x(posy=(loc_y(tl=td=32))>499)>499;
  corner(dmax=fp=3);
  radar(deg2=(dvector=(dscan=deg1=(90*((posy<<1)+(posx^posy))))+30)+70);
  dvector|=((dvector+30)<<16);
  dscan|=((dscan+70)<<16);
  while (1)
  {
    dperf=((dscan>>flag)&65535)+1;
    drive(dir=(dvector>>flag)&65535,100);
    if (scan(dperf,10))
    {
      l=600+damage(ang=dperf);
      while(scan(ang, 10)>l) fire();
      corner();
      if ((d=damage()-d)>dmax)
      {
        dmax=d; flag^=16;
      }
    }
    else
    {
      d=damage();
      while((t<14) && (damage()==d)) spara(); if (t<14) fuoco(spara());
      corner(tl=timer);
    }
    if (++timer>tl)
  	{
  	    radar(tl=timer+(td>>=1)+1);
    }
  }
}
