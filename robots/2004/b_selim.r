/*

B_selim ver. 1.0 (C) Lorenzo Ancarani 2004

Architettura: Midibot
Strategia   : Robot derivato da Selim_B, raggiunge l'angolo piu' vicino e poi oscilla
              alternativamente in direzione dei due angoli adiacenti e di quello opposto. 
              La lunghezza dell'attacco è variabile e dipende dai danni subiti;
              Controlla sempre il numero dei nemici superstiti, e se ne trova solo 1, attacca
	      utilizzando cvirus.r.

*/



int tempo,b,clock,d,dx,dy,dir,p1,p2,a,oa,or,r,ext,str;
int a,r,dir,oa,or,n,xm,ym,t,clk,limite,n_limite,fx,fy,en_dis;
int un1,un2,d1,incremento;

int deg,rng,dir,odeg,orng,dam;
int x1,y1,x2,y2;
int asb,asa,b,ll,ul,flag,flag1;



main() {
   
dy=40+920*(p2=(loc_y(dx=40+920*(p1=(loc_x(limite=7000)>500)))>500));
dir=(360+((fx=dx-loc_x(b=(p2)*180+(p1!=p2)*90))<0)*180+atan(((dy-loc_y())*100000)/(fx+(fx==loc_x()))));

   while (1) { 
	n=(limite==7000);

	while (((d=((fx=dx-loc_x(drive(dir,100)))*fx+(fy=dy-loc_y(shot(d<28000)))*fy))>limite)==n) ;

	drive(dir+=180,0);shot(shot(oa=b-40));

	if (n)
	{

        	while((oa+=20)<=b+130) limite+=(scan(oa,10)>0);	
	  	while (limite<=7001) 
			{
		   		if (rng>300)
				{
   	        		    	x1=y1=500;x2=y2=499;
 	         		   	Loop();
         			} 
				else 
				{
      		
      					if (rng>250)
					{
		      			    x1=y1=550;x2=y2=450;
       				    		Loop();
		       			} 
					else
					{
			       		    x1=y1=600;x2=y2=400;
			       		    Loop();
			 		}  
			       }
			}
			dir=b+(incremento+=45)%135;
			n_limite=55000+150*(100-damage());

			limite=n_limite;

	}
	else limite=7000;
	d1=dir;
   }
}


int shot(best)
int best;
{
 
 if (best);
 else if (scan(a,10))
    {
      if ((or=Rivela())<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+or-r-(cos(a-dir)/4167))));
        }
    }      
  if ((r=scan(a,10))&&(r<850));

  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(d1,10))) a=d1;
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
    cannon((deg<<1)-odeg+0+0+0+0,(scan(deg,10)<<1)-rng); 
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

