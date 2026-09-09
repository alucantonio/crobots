/*
      ## **      MISTER2.r    ** ##
			## **    versione 2.0   ** ##
			## **     27-01-2012    ** ##

Mio cuggino mi ha "obbligato" a partecipare al torneo. Con sommo stupore ho
scoperto che i robot della famiglia Flash, miei cavalli di battaglia, erano già
stati prenotati (ma come si sono permessi?).
Allora ho preso i miei Mister2 e Mister3 (del 1993!) e li ho "riammodernati" con
l'utilizzo di una funzione di fuoco più "moderna", presa dal vincitore dello
scorso anno.
Mister2 percorre uno per volta i lati sinistro e basso e la loro diagonale, spostandosi se viene colpito.

Autore:	Lorenzo Ancarani
http://www.foto-f.it/
*/

int ang, oang, range, orange;
int d, dmax, dir;

main()  /* Main() routine  data: 11-6-1993 */
{
	drive(dir=270,100);
	dmax=0;
	while (loc_y() > 70) fire();
	drive(dir=180,0);
	while (speed() > 49) fire();
	drive(dir=180,100);
	while(loc_x() > 70) {
				fire();
				if (ang > 180) ang = 0;
	}
	l1su();
}

l1su()
{
	drive(dir=90,0);
	while (speed() > 49) fire();
	drive(dir=90,100); d=damage();
	while (loc_y() < 930) {
		fire();
		if (ang > 90 && ang < 270) ang=270;
	}
	if ((damage() - d) > dmax) {
		dmax=damage - d;
		dig1();
	} else l1giu();
}

l1giu()
{
	drive(dir=270,0);
	while (speed() > 49) fire();
	drive(dir=270,100); d=damage();
	while (loc_y() > 70) {
		fire();
		if (ang > 90 && ang < 270) ang=270;
	}
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l2dex();
	} else l1su();
}

l2dex()
{
	drive(dir=0,0);
	while (speed() > 49) fire();
	drive(dir=0,100); d=damage();
	while (loc_x() < 930) {
		fire();
		if (ang > 180) ang=0;
	}
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		dig2();
	} else l2six();
}

l2six()
{
	drive(dir=180,0);
	while (speed() > 49) fire();
	drive(dir=180,100); d=damage();
	while (loc_x() > 70) {
		fire();
		if (ang > 180) ang=0;
	}
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l1su();
	} else l2dex();
}

dig1()
{
	drive(dir=315,0);
	while (speed() > 49) fire();
	drive(dir=315,100); d=damage();
	while (loc_x() < 930 && loc_y() > 70) fire();
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l2six();
	} else dig2();
}

dig2()
{
	drive(dir=135,0);
	while (speed() > 49) fire();
	drive(dir=135,100); d=damage();
	while (loc_x() > 70 && loc_y() < 930) fire();
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l1giu();
	} else dig1();
}
	
fire()
{
	if (range=scan(oang=ang,10))
        {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))   { if (scan(ang-=2,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
	}
	else if(scan(ang+=20,10));
	else if(scan(ang-=40,10));
	else if(scan(dir,10)) ang=dir;
	else while(!scan(ang,10))ang+=19;
}
