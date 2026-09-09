/*
Nome: 		Kyash_2.r
Autore: 	Franco Cartieri

Torneo 2002

Kyash_2.r e' un microcrobots che deriva da Kyashan.r che ha partecipato al torneo 2001.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo i lati di un triangolo.
Ogni 10 cicli controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
Se subisce piu' del 50% di danni cambia angolo.
La routine di attacco finale e' un ciclo in cui il robot si muove in senso antiorario 
lungo il quadrato che si ottiene, unendo i punti centrali dei lati del campo di gioco.
*/

int tim,fasefinale,n,angdir,dx,dy,dam;
int deg,odeg,oldr;

main()
{
	fasefinale=tim=0;
	/* si sposta nell'angolo più vicino */
	dx=50+900*(loc_x()>500);
	dy=50+900*(loc_y()>500);
	dam=50;
	while(fasefinale==0)
	{
		/* si muove lungo un triangolo */
		if(dx<500)
		{
			goxmin(250-damage(),0);
			if(dy<500)
				goxmag(100,135);
			else	goxmag(100,225);
		}
		else
		{
			goxmag(750+damage(),180);
			if(dy<500)
				goxmin(900,45);
			else	goxmin(900,315);
		}
		if(dy<500)
			goymag(100,270);
		else	goymin(900,90);

		++tim;
		if((tim%5)==1)
		{
			drive(angdir,0);
			/* controlla i danni subiti */
			if(dam < damage())
			{
				/* cambia angolo orizzontale */
				dx=50+900*(loc_x()<500);
				dam=100;
			}
			n=odeg=0;
			while((odeg+=20)<=360) if(scan(odeg,10)) ++n;
			if ((n<2)||(tim>100)) fasefinale=1;
		}
	}
	goymag(100,270);	
	goxmag(500,180);
	goxmin(500,0);
	/* attacco finale */
     	while(1)
     	{
		goxmin(900,45);
		goymin(900,135);
		goxmag(100,225);
		goymag(100,315);
 	}
}

/* routine per cambiare direzione */
turn(d)
int d;
{
  	while (speed()>65) drive(angdir,0);
  	angdir=d;
}

goxmin(xx,ang)
int xx,ang;
{
	turn(ang);
	while(loc_x()<xx) fuoco();
}

goxmag(xx,ang)
int xx,ang;
{
	turn(ang);
	while(loc_x()>xx) fuoco();
}

goymin(yy,ang)
int yy,ang;
{
	turn(ang);
	while(loc_y()<yy) fuoco();
}

goymag(yy,ang)
int yy,ang;
{
	turn(ang);
	while(loc_y()>yy) fuoco();
}

fuoco()
{
	drive(angdir,100);
    	if(oldr=scan(odeg=deg,10)) 
	{
        	if (!scan(deg+=355,5)) deg+=10;
        	if (!scan(deg+=357,3)) deg+=6;
		cannon(deg+(deg-odeg)*fasefinale,2*scan(deg,10)-oldr); 
		if (!fasefinale&&oldr>850)
        	 	deg=angdir;
    	} 
    	else 
	{
        	if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
	        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        	deg+=40;
    	}
}

