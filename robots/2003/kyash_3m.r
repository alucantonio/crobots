/*
Nome: 		Kyash_3m.r (micro)
Autore: 	Franco Cartieri

Torneo 2003

Kyash_3m.r e' un microcrobots che deriva da Kyash_2.r che ha partecipato al torneo 2002.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo i lati di un triangolo.
Ad ogni ciclo controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
La routine di attacco finale e' un ciclo in cui il robot si muove in senso antiorario 
lungo il quadrato che si ottiene, unendo i punti centrali dei lati del campo di gioco.
Le differenze rispetto a Kyash_2.r sono:
	Il controllo degli avversari rimasti viene effettuato ad ogni ciclo invece che ogni dieci cicli.
	Il controllo degli avversari rimasti viene effettuato su 100 gradi invece che 360 gradi.
	E' stata migliorata la routine di fuoco.
	E' stato eliminato il cambio dell'angolo in caso di danni superiori al 50%.
*/

int ff,n,angdir,dx,dy,deg,odeg,oldr,sc1,sc2,angs,angf;

main()
{
	ff=0;sc1=3;sc2=2;
	dx=900*(loc_x()>500);
	dy=900*(loc_y()>500);
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
			goymag(100,270);
		else	goymin(900,90);

		drive(angdir,n=0);
		odeg=angs;
		while((odeg+=20)<=angf) if(scan(odeg,10)) ++n;
		if(n<2) ff=1;
	}
	sc1=5;sc2=3;
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
	drive(angdir=ang,100);
 	if(oldr=scan(odeg=deg,10))
  	{    
    		if(scan(deg+350,10)) deg-=sc1; else deg+=sc1;
    		if(scan(deg+350,10)) deg-=sc2; else deg+=sc2; 
    		cannon(deg+(deg-odeg),(scan(deg,10)<<1)-oldr); 
		if (!ff&&(oldr>850))
        	 	deg=angdir;
	}
	else 
	{
		if(ff==0)
		{
			if(oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        		if(oldr=scan(deg+=40,10))  return cannon(deg,oldr);
			if(oldr=scan(angdir,10))   return cannon(deg=angdir,oldr);
			deg+=40;
		}
		else
		{
			while(!(oldr=(scan(deg+=20,10)))); cannon(deg,oldr);
		}
  	}
}
