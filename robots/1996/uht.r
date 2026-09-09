/*

	U.H.T. ovvero il Crobots a lunga conservazione ... ;)

	U.H.T. Untouchable HAL9000 Twin ver. 1.10 del 05/08/96

	Autore: Maurizio Camangi

        Home Page disponibile su http://gulliver.unian.it/~camangi
        Crobots Home Page disponibile su http://gulliver.unian.it/~camangi/crobots.html

Strategia:
	Si posiziona nell'angolo di coordinate (850,850).
	Da questo punto esegue il seguente loop:
		Rimane fermo finche' non e' colpito sparando con
		molta precisione, utilizzando la routine di fuoco di Tox.
		Si muove in modo oscillatorio in direzione dello spigolo,
		sparando con una semplice routine di fuoco derivata da
		quella di B52, finche' subisce danni.
		Si riposiziona sullo stesso angolo se l'incremento di danni
		non supera il 25%, altrimenti sceglie l'angolo a Sud se non
		non e' occupato da altri robots o l'angolo ad Est, per poi
		ritornare in ogni caso in (850,850).
*/

int ang,     /* Angolo di scanning                           */
    dloc,    /* Danni massimi subiti in ogni ciclo di fuoco  */
    loc_dam, /* Danni locali subiti in ogni angolo           */
    dir,     /* Direzione del cammino                        */
    count,   /* Contatore                                    */
    x,
    y,
    bouncx,
    bouncy,
    curx,
    cury,    /* Variabili posizione                          */
    maxdist, /* Massima distanza consentita dall'angolo      */
    tmp;     /* Variabile temporanea                         */

main()
{
	ang=0;

/* Vai nell'angolo a nord-est del campo di battaglia */

	attack(850,850);
	if (scan(270,10))
		l2left();
	else l1down();
}

/*

	Routines di movimento

*/

l1up()                                  /* Lato Est, direzione Nord */
{
	attack(850,850);                      /* Ok, direzione Nord */
	if (scan(270,10))
		l2left();
	else l1down();
}

l1down()                                /* Lato Est, direzione Sud */
{
	attack(850,150);
	l1up();
}

l2right()                               /* Lato Nord, direzione Est */
{
	attack(850,850);
	if (scan(270,10))
		l2left();
	else l1down();
}

l2left()                                /* Lato Nord, direzione Ovest */
{
	attack(150,850);
	l2right();
}

/*

	Utilities per raccogliere il codice 

*/

route(xx, yy) /* Routine standard per il calcolo della direzione */
{             /* da seguire per il punto (xx,yy)                 */
	curx = loc_x();
	x = curx - xx;
	y = (loc_y() - yy) * 100000;
	if (xx > curx)
		tmp = 360 + atan(y / x);
	else
		tmp = 180 + atan(y / x);
	return (tmp);
}

stop()                               /* Fermati! */
{
	drive(dir,0);
	fire1();
	while(speed() > 49) ;
}

dist(xx1, yy1) /* Routine standard per il calcolo della distanza tra */
{              /* i punti (loc_x(),loc_y()) e (xx1,yy1)              */
	x = xx1 - loc_x();
	y = yy1 - loc_y();
	tmp = (x * x) + (y * y);
	return(tmp);
}

/*

	Routines d'attacco

*/

int   oang,range,orange,aa,rr;

scan_()
{
	if(scan(ang-5,1)) ang-=5;
	if(scan(ang+5,1)) ang+=5;
	if(scan(ang-3,1)) ang-=3;
	if(scan(ang+3,1)) ang+=3;
	if(scan(ang-1,1)) ang-=1;
	if(scan(ang+1,1)) ang+=1;
}


fire1()    /* fire1() - routine di sparo in movimento */        
{
	if (orange=scan(ang,10)) {
		oang=ang;
		if (scan(ang+5,5)) ang+=5; else ang-=5;
		if (scan(ang+3,3)) ang+=3; else ang-=3;
		if (range=scan(ang,10)) {
			aa=ang+(ang-oang);
			rr=range+(range-orange);
			cannon(aa,rr);
		}
	} else if (scan(ang-=20,10)) ;
		  else if (scan(ang+=40,10)) ;
			else ang+=20;
}

fire2() /* Routine di sparo da fermo */
{
dloc=damage();
while(damage() == dloc) /* Finche' non sei colpito */
 {
     if(scan(ang,5))
      {
       scan_();
       if (range=scan(ang,5))
	 {
	   orange=range;
	   oang=ang;
	     scan_();
	     if (range=scan(ang,10))
	       {
		 aa=(ang+(ang-oang)*((1200+range)>>9));
		 rr=(range*165/(165+orange-range));
		 while(!cannon(aa,rr));
		 if (range>700) ang+=30;
	       }
	     else if(scan(ang-=10,10));
		  else if(scan(ang+=20,10));
		       else while ((scan(ang+=15,10))== 0);
	 }
       else if(scan(ang-=10,10));
	    else if(scan(ang+=20,10));
		 else while ((scan(ang+=15,10))== 0);
      }
    else if(scan(ang-=10,10));
	 else if(scan(ang+=20,10));
	      else while ((scan(ang+=15,10))== 0);
 }
}

bouncer()                       /* Movimento ondulatorio in direzione */
{                               /* dell'angolo (bouncx,bouncy)        */
	dir = route(bouncx,bouncy);
	maxdist = (dist(bouncx,bouncy) >> 2);
	curx=loc_x();
	cury=loc_y();
	dloc=damage() - 1;
	while (damage() > dloc) /* Finche' subisci danni ... */
	{
		dloc=damage();
		count=4;
		while(--count) /* Esegui almeno tre movimenti ... */
		{
			drive(dir+=180,100); 
			while (dist(bouncx,bouncy) < (maxdist << 2)) fire1();  
			stop();
			drive(dir-=180,100);
			while (dist(bouncx,bouncy) > maxdist) fire1();
			stop();
		}
	}
}

goto(xx,yy)                     /* Vai alle coordinate (xx,yy) */
{                               /* con molta precisione ...    */
	if (dist(xx,yy) > 4000) {
		drive(dir=route(xx,yy),100);
		while (dist(xx,yy) > 4000) fire1();
		stop();
	} 
	if (dist(xx,yy) > 1000) {
		while (dist(xx,yy) > 1000) { drive(dir=route(xx,yy),25); fire1(); }
		stop();
	}
}

attack(ax,ay) /* Esegue il loop di attacco nell'angolo (ax,ay) */
{
	if (ax == 150) bouncx=0;
		else bouncx=1000;
	if (ay == 150) bouncy=0;
		else bouncy=1000;
	loc_dam=damage();
	while (damage() < (loc_dam + 25)) {
		goto(ax,ay);
		fire2();
		bouncer();
	}
}
