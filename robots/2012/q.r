/*
Q
  “I'm not good in groups. It's difficult to work in a group when you're omnipotent.”

Crobots  : Q
Version  : 1.0
Type     : Midi
Author   : Olga S
Begin    : 12-12-2011
Revision : 14-12-2011

E' una versione migliorata di Borg (2011). Differenze: f2f moderno alla Boom e
qualche leggera modifica alle routine di sparo e movimento.

*/

int ang,        /* Angolo di scanning                                   */
    oang,       /* Angolo di scanning precedente                        */
    range,      /* Gittata corrente                                     */
    orange,     /* Gittata precedente                                   */
    drange,
    spd,        /* 1 se in movimento, 0 altrimenti                      */
    dam,        /* Variabile temporanea salva danni subiti              */
    dir,        /* Direzione del cammino                                */
    ang_1,
    ang_2,      /* Direzioni d'attacco statiche dei quattro lati        */
    posx,
    posy,       /* Variabili temporanee ad un bit salva posizione       */
    deg,enemy,dist,deg,f2f,m,n,
    timer;      /* Massimo numero di cicli virtuali                     */

va(x,d)
{
 int lim;
 if ((d == ang_1) || (d == ang_2)) lim=0;
 else lim=70;
 drive(dir=d,100);
 if (dir==90) while((x - loc_y()) > lim) fire3();
 else if (dir == 270) while((loc_y() - x) > lim) fire3();
 else if (dir == 180) while((loc_x()-x) > lim) fire3();
 else while((x-loc_x()) > lim) fire3();
 stop();
}

scan_() {

        if(scan(ang+352,4)) ang+=352;
        if(scan(ang+8,4)) ang+=8;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+359,1)) ang+=359;
        if(scan(ang+1,1)) ang+=1;
}

/* fuoco veloce */
fire3() {
  --timer;
  if (orange=scan(ang,10)) {
         if (range=scan(ang,1))   return cannon(ang,range);
    else if (range=scan(ang-5,4)) return cannon(ang-=3,range);
    else if (range=scan(ang+5,4)) return cannon(ang+=3,range);
  }
  else if (range=scan(ang-=20,10)) return cannon(ang,range);
  else if (range=scan(ang+=40,10)) return cannon(ang,range);
  else return ang+=40;
}

search()
{
             if (range=scan(ang+=340,10));
             else if (range=scan(ang+=40,10));
             else if (range=scan(dir,10))
                 ang=dir;
             else
                  return (ang+=40);
             return cannon(ang,(scan(ang,10)<<1)-range);
}

radar(x) /* Restituisce 1 se la direzione x e` occupata da nemici       */
{
        return(scan(x+351,10) || scan(x+9,10));
}

dista(x,y)
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()          /*  Fermati!      */
{
 drive(dir,0);
 while (speed() > 50) {
    if (orange=scan(ang,10)) {
      oang=ang;
      if (scan(ang+=5,5)); else ang-=10;
      if (scan(ang+=3,3)); else ang-=6;

      if (range=scan(ang,10))
        cannon(ang+(ang-oang),range+(range-orange)<<1);
    }
    else search();
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
		}
		return(cannon(ang+f2f*(ang-oang),(scan(ang,10)<<1)-range)); 
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
	}
}

main() /* Inizializza alcune variabili ed innesca la routine principale */
{
 int x,b,l,zdeg;
 
 posx=loc_x(posy=loc_y(timer=1)>499)>499;
 l=(zdeg=(90*((posy<<1)+(posx^posy))+320))+131;

 ang_1 = 90 + 180*posy;
 ang_2 = 360 - 180*posx;

 va(1000*posy,270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 while (deg=zdeg)
 {
        while (timer>0)
        {
           if (radar(ang_2)) ang = ang_2;
           va(150+700*posx,ang_2);
           va(150+700*posy,ang_1);
           if (radar(ang_1)) ang = ang_1;
           va(1000*posx,180+180*posx);
           va(1000*posy,270 - 180*posy);
        }
        enemy=0;
        while((deg<l)&&(enemy<2)) enemy+=(scan(deg+=20,10)>0);
        if (enemy<2)
            if (damage() < 80)
            {
              f2f=1;
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
            else timer=9999;
        else timer=4;
 }
}