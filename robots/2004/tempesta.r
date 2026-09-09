/*
Nome: 	tempesta.r	(macro)
Autore: 	Franco Cartieri

Torneo 2004

Tempesta.r e' un crobots che deriva da Mystica.r.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo due triangoli disegnati 
sui lati dell'angolo.
Se uno dei due angoli adiacenti e' libero il movimento di mystica.r diventa asimmetrico verso questo angolo.
Se i due angoli adiacenti sono entrambi occupati o se sono stati effettuati piu' di 50 cicli il movimento
diventa simmetrico.
Ad ogni ciclo controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
La routine di attacco finale consiste in un movimento oscillatorio perpendicolare all'avversario.
L'unica differenza rispetto a Mystica.r e' che se i danni subiti sono superiori al 50 perc. cambia angolo.
*/

int ang_pref, dx, dy, angdir, s_lim, i_lim, cr;
int a, oa, r, or, i, t, h, rng, deg, odeg, i, f2f, nc, dam;

main()
{
	s_lim=(ang_pref=180*((dy=(loc_y(nc=f2f=0)>500)*960+20)>500)+90*((dx=(loc_x(dam=50)>500)*960+20)!=dy))+110;
    	while(f2f==0)
      {
		if((angdir=ang_pref+180+90*((t+=1)%2))%180)
			while(((loc_y(Fuoco(drive(angdir,100)))%930)>75));
		else	while(((loc_x(Fuoco(drive(angdir,100)))%930)>75));
		angdir=ang_pref+270-90*(t%2);
		Stop(cr=1);
		drive(angdir,100);
     	 	while ((Distanza(dx,dy)>3400))
			if (h>6500) Fuoco(h<25000);
		Stop(i_lim=ang_pref-40);
		while((i_lim+=20)<=s_lim) 
			cr+=(scan(i_lim,10)>0);
		if (cr<3)
		{
			f2f=1;
			drive(angdir=ang_pref+45,100);
		      while(Distanza(dx,dy)<330000) 
				FuocoCen(h>250000);
		}
		else
		{
			if(damage()>dam)
			{
				if(anglibero(ang_pref-5))
					goang(ang_pref);
				else	if(anglibero(ang_pref+170))
						goang(ang_pref+180);
			}
			if((nc+=1)<50)
			{
				if(!anglibero(ang_pref-5+80*(t%2)))
					t=t+1;	
			}
			drive(angdir=ang_pref+20+50*(t%2),100);
  			while(Distanza(dx,dy)<250000) 
				FuocoCen(h>200000);
		}
	} 
	FuocoF2f();
	angdir=deg;
	while(1)
	{
		drive(angdir,i=0);		
		if(scan(deg,10) > 400)
			angdir=deg;
		else	angdir=deg+90;
		while((i+=1)<5)  FuocoF2f(drive(angdir,100));
		drive(angdir,i=0);
		if(scan(deg,10) > 400)
			angdir=deg;
		else	angdir=deg+270;
		while((i+=1)<5)  FuocoF2f(drive(angdir,100));
	}
}

Distanza(nx,ny)
int nx, ny;
{
   	return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
}
 
Stop()
{
	Fuoco(Fuoco(drive(angdir,0)));
}

Fuoco(meglio)
int meglio;
{
  	if (meglio);
  	else if (scan(a,10))
    	{
      	if ((or=Rivela(drive(angdir,100)))<850)
        	{
          		if (r=Rivela())                
             		return cannon((oa+(a-oa)*3-(sin(a-angdir)/19500)),(r*220/(220+or-r-(cos(a-angdir)/4167))));
        	}
    	}      
  	if((r=scan(a,10))&&(r<850));
  	else 	if((r=scan(a+=339,10)));
    		else	if((r=scan(a+=42,10)));
      		else	if(r=scan(angdir,10)) a=angdir;
        			else	return (a+=43);
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

FuocoF2f() 
{
	if (rng=scan(odeg=deg,10))
  	{    
    		if (scan(deg+350,10)) deg+=355; else deg+=5;
    		if (scan(deg+350,10)) deg+=357; else deg+=3; 
   		cannon((deg<<1)-odeg+3,(scan(deg,10)<<1)-rng); 
  	}
	else 
	{
      	if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        	if (rng=scan(deg+=40,10))  return cannon(deg,rng);
      	if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        	if (rng=scan(deg+=80,10))  return cannon(deg,rng);
		while((rng=scan(deg+=20,10))==0);
		return cannon(deg,rng);
	}
}

FuocoCen(meglio)
int meglio;
{
  	if (meglio);
  	else if (scan(a,10))
    	{
      	if ((or=Rivela(drive(angdir,100)))<850)
        	{
          		if (r=Rivela())                
             		return cannon((oa+(a-oa)*3-(sin(a-angdir)/19500)),(r*220/(220+or-r-(cos(a-angdir)/4167))));
        	}
    	}      
  	if((r=scan(a,10))&&(r<850));
  	else 	if((r=scan(a+=339,10)));
    		else	if((r=scan(a+=42,10)));
      		else	while((r=scan(a+=20,10))==0);
	cannon (a,2*scan(a,10)-r);
}

anglibero(ang)
int ang;
{
	return ((scan(ang,10)==0) && (scan((ang+20),10)==0));
}

angolo(x, y)
int x,y;
{     
	return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); 
}

goang(ang)
int ang;
{
	ang=(ang%360);
	s_lim=(ang_pref=180*((dy=((ang==180)||(ang==270))*960+20)>500)+90*((dx=((ang==90)||(ang==180))*960+20)!=dy))+110;
	drive(angdir=angolo(dx,dy),100);
 	while ((Distanza(dx,dy)>4000))
		if (h>8000) Fuoco(h<25000);
	Stop(dam=damage()+25);
}
