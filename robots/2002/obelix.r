/*
Nome            : Obelix
Versione        : Ob_As_2
Autore		: Simone Ascheri


Commento
========

Obelix è una banalisima modifica di Asterix, da cui differisce solo per l'attacco finale.
Il risultato in termini di efficienza e', stranamente, il medesimo, pero' questa routine dà il 
peggio di se' contro robot che spero non verranno mai piu' progettati in tutta la futura storia
della crobotica..

Strategia
=========

Identica ad Asterix

Note Tecniche
=============

Nuovo attacco, che varia dal tema Rudolf6, utilizzando oscllazioni piu' lunghe:
Non cambia direzione finche' non ha sparato.

*/

int ang, dx, dy, r_coord, y_coord, x_coord;
int a, oa, r, or, s_lim, i_lim;
int h, mx, my, nx, ny, flag1;
int ang_pref,ang_base,clock,discr,z;
int timmax,time,run;
int dor,dvor,dan,y;
main()
{
Doom(Asterix(ang_pref=180*((dy=(loc_y(timmax=9)>500)*960+20)>500)+90*((dx=(loc_x()>500)*960+20)!=dy)));
}

Asterix()                             
{

  while (drive (ang=(loc_x()>dx)*180+atan(((dy-loc_y())*100000)/((dx-loc_x())+(dx==loc_x()))),100))
      {

	 s_lim=(i_lim=ang_pref-35)+160;
         while ((Dista(dx,dy)>4400))
              if (h>6500) PallaDiFuoco(h<25000);

             if ((timmax+=Stop(flag1=8))%10);
             else
               {

                while ((i_lim+=20)<=s_lim) flag1-=(scan(i_lim,10)>0);
                while (flag1>6)
                     {	
			dy=1000-dy;
			while((loc_y()>dy)==(z=(dy<500))) 
			{
				
				if(loc_x()>500)
				{
					Fuoco(175+10*z);
				}
				else
				{
					Fuoco(365-10*z);
				}
			}
		      }
		if ((time)<9) return;
               }

	     if ((dan=damage())>80) 
		{
			clock=0;
			time=10;
		}

             if (clock=32000-clock)
		{
		  ang=45;
		}
             else
		{
               	  ang_base=ang_pref+(ang=90*(dor<dvor));
		}

	     ang+=ang_pref;		

             while ((Dista(dx,dy)<43000-clock)){
                  if ((clock)) Fuoco(ang);else PallaDiFuoco();}

		  if (ang==ang_pref) dvor+=(damage(--dor)-dan);
		  else if (ang==ang_pref+90) dor+=(damage(--dvor)-dan);

             Stop();
      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Stop()
{
         PallaDiFuoco(PallaDiFuoco(drive(ang+=180,0)));
}

PallaDiFuoco(meglio)
int park,meglio;
{
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<850));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang_base,10))) a=ang_base;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

Fuoco(verso)
{
	drive (verso,100);
    if (or=scan(a,10)) {
           if (scan(a,2))		{if (cannon(a+0+0+0+0,3*scan(a,10)-2*or)) return;}
           else if (scan(a-=7,6))	{if (cannon(a-6,2*scan(a,10)-or)) return;}
           else if (scan(a+=14,6))	{if (cannon(a+6,2*scan(a,10)-or)) return;}
	   return Fuoco(verso);
    } 
    else {
        if (or=scan(a+=339,10))		cannon(a,or);
        else if (or=scan(a+=42,10))	cannon(a,or);
        else if (or=scan(a+=297,10))	cannon(a,or);
        else if (or=scan(a+=84,10))	cannon(a,or);
        else {a+=65;return Fuoco(verso);}
    }
}
Doom()
{
	r_coord=822;
	while(1)
	{
                y_coord=(loc_y(x_coord=(loc_x(run=10)<500)*(r_coord-=10*(++time>5)))<500)*r_coord;

                while (--run)
                     { 
                        while(loc_y() <910-y_coord) CucchiaioKender(90);
                        while(loc_x() >r_coord-x_coord+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-y_coord+90) CucchiaioKender(270);
                        while(loc_x() <910-x_coord) CucchiaioKender(0);
                     }
		Stop(ang=0);
		Asterix(timmax=9);
	}
}

CucchiaioKender(dir)
int dir;
  {
     drive (dir,100);
     if((or=scan(oa=a,10))&&(or<850))
        {
           if (r=scan(a,3));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return a+=21;
	   cannon (a,r);
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
           if(scan(dir,10)) a=dir;
           else
             return (a+=84);
  }  

