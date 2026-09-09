/*

	HAL9000 ver.3.06 del 05/08/96

	Autore: Maurizio Camangi

	Home Page disponibile su http://gulliver.unian.it/~camangi
	Crobots Home Page disponibile su http://gulliver.unian.it/~camangi/crobots.html

Strategia:
	Si sposta poi nell'angolo a sud-ovest del campo di battaglia.
	Il percorso che puo' compiere e' di forma triangolare (i cateti sono
	a ovest e a sud).
	
	Rimane fermo su ogni vertice finche' non viene colpito da una bomba
	o passano alcuni cicli CPU. Sceglie l'angolo successivo dove
	spostarsi se non e' occupato da un altro robot.

	Le funzioni di fuoco da fermo e in movimento sono piuttosto complesse
	e si basano sulla correzione dell'angolo e della gittata in base allo
	spostamento proprio e dell'avversario, utilizzando una versione piu'
	compatta delle routines di fuoco di Tox, l'ultimo vincitore.

*/

int ang,     /* Angolo di scanning                           */
    loc_dam, /* Danni locali relativi ad ogni ciclo di fuoco */
    dir,     /* Direzione del cammino                        */
    count;   /* Contatore                                    */

main()
{
	ang=11;
	drive(dir=270,100);
	while (loc_y() > 250) fire2();
	drive(dir,0);
	while(speed() > 49) ;
	drive(dir=180,100);
	while(loc_x() > 250) {
		fire2();
	}
	stop();
	if (scan(90,10))
		l2right();
	else l1up();
}

l1up()                                  /* Lato Est, direzione Nord */
{
	drive(dir=90,100);                    /* Ok, direzione Nord */
	while (loc_y() < 750) {
		fire2();
	}
	stop();
	if (scan(270,10))
		dig1();
	else l1down();
}

l1down()                                /* Lato Est, direzione Sud */
{
	drive(dir=270,100);  
	while (loc_y() > 250) {
		fire2();
	}
	stop();
	if (scan(90,10))
		l2right();
	else l1up();
}

l2right()                               /* Lato Nord, direzione Est */
{
	drive(dir=0,100);
	while (loc_x() < 750) {
		fire2();
	}
	stop();
	if (scan(180,10))
		dig2();
	else l2left();
}

l2left()                                /* Lato Nord, direzione Ovest */
{
	drive(dir=180,100);
	while (loc_x() > 250) {
		fire2();
	}
	stop();
	if (scan(90,10))
		l2right();
	else l1up();
}

dig1()
{
	drive(dir=315,100);
	while ((loc_x() < 750) && (loc_y() > 250)) {
		fire2();
	}
	stop();
	if (scan(180,10))
		dig2();
	else l2left();
}

dig2()
{
	drive(dir=135,100);
	while ((loc_x() > 250) && (loc_y() < 750)) {
		fire2();
	}
	stop();
	if (scan(270,10))
		dig1();
	else l1down();
}

/* Utilities per raccogliere il codice */

stop()                               /* Fermati! */
{
	drive(dir,0);
	while(speed() > 49) ;
	count=100 + (loc_dam=damage());
	fire1();
}

/* Le routines d'attacco, le piu' importanti */

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

fire1()    /* fire1() - routine di gestione del tiro da fermo */        
{
while( (loc_dam == damage()) && (--count) ) {
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
				aa=(ang+(ang-oang)*((1250+range)>>9));
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

fire2() /* fire2() - routine di gestione del tiro in moto */        
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
				aa=(ang+(ang-oang)*((1250+range)>>9)-(sin(ang-dir)>>14));
				rr=(range*160/(160+orange-range-(cos(ang-dir)>>12)));
				while(!cannon(aa,rr));
				if (range>700) ang+=30;
			}
			else if(scan(ang-=10,10));
			else if(scan(ang+=20,10));
			else while ((scan(ang+=11,10))== 0);
		}
		else if(scan(ang-=10,10));
		else if(scan(ang+=20,10));
		else while ((scan(ang+=11,10))== 0);
	}
	else if(scan(ang-=10,10));
	else if(scan(ang+=20,10));
	else while ((scan(ang+=11,10))== 0);
}
