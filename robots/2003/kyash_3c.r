/*
Nome: 		Kyash_3c.r (classic)
Autore: 	Franco Cartieri

Torneo 2003

Kyash_3c.r e' un crobots che deriva dal microcrobots Kyash_3m.r.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo i lati di un triangolo.
Ad ogni ciclo controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
La routine di attacco finale e' un ciclo in cui il robot si muove in senso antiorario 
lungo il quadrato che si ottiene, unendo i punti centrali dei lati del campo di gioco.
L'unica differenza rispetto a kyash3_m.r è la routine di fuoco. Utilizzo due routine differenti a seconda
se sono nella routine di attacco finale o no.
*/

int ff,n,dx,dy,deg,odeg,oldr,angs,angf;

main()
{
	ff=0;
	dx=50+900*(loc_x()>500);
	dy=50+900*(loc_y()>500);
	if(loc_x() > 500)
	{
		if(loc_y() > 500)
			angs=155;
		else	angs=65;
	}
	else
	{
		if(loc_y() > 500)
			angs=245;
		else	angs=-25;
	}
	angf=angs+120;
	while(ff==0)
	{
		if(dx<500)
		{
			goxmin(250-damage(),0);
			if(dy<500)
				goxmag(75,135);
			else	goxmag(75,225);
		}
		else
		{
			goxmag(750+damage(),180);
			if(dy<500)
				goxmin(925,45);
			else	goxmin(925,315);
		}
		if(dy<500)
		{
			goymag(100,270);
			drive(270,n=0);
		}
		else	
		{
			goymin(900,90);
			drive(90,n=0);
		}
		odeg=angs;
		while((odeg+=20)<=angf) if(scan(odeg,10)) ++n;
		if (n<2) ff=1;
	}
	goymag(100,270);
	goxmag(550,180);
	goxmin(450,0);
     	while(1)
     	{
		goxmin(900,45);
		goymin(900,135);
		goxmag(100,225);
		goymag(100,315);
 	}
}

goxmin(xx,ang) { while(loc_x()<xx) fuoco(ang);}

goxmag(xx,ang) { while(loc_x()>xx) fuoco(ang);}

goymin(yy,ang) { while(loc_y()<yy) fuoco(ang);}

goymag(yy,ang) { while(loc_y()>yy) fuoco(ang);}

fuoco(ang)
{
	drive(ang,100);
  	if(ff==0)
	{
	    	if(oldr=scan(odeg=deg,10))
  		{    
    			if(scan(deg+350,10)) deg-=3; else deg+=3;
	    		if(scan(deg+350,10)) deg-=2; else deg+=2; 
    			cannon(deg+(deg-odeg),(scan(deg,10)<<1)-oldr); 
			if(oldr>850)
        	 		deg=ang;
		} else 
		{
			if(oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        		if(oldr=scan(deg+=40,10))  return cannon(deg,oldr);
        		if(oldr=scan(ang,10))      return cannon(deg=ang,oldr);
        		deg+=40;
		}
 	}
	else
	{
		if (oldr=scan(odeg=deg,10))
		{
	        	if (!scan(deg+=355,5)) deg+=10;
	        	if (!scan(deg+=357,3)) deg+=6;
		        cannon(deg+(deg-odeg),2*scan(deg,10)-oldr);        
		} 
	    	else 
		{
        		if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
		        if (oldr=scan(deg+=40,10))  return cannon(deg,oldr);
        		if (oldr=scan(deg+=300,10)) return cannon(deg,oldr);
	        	if (oldr=scan(deg+=80,10))  return cannon(deg,oldr);
	        	deg+=60;
		}
    	}
} 
