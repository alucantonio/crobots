 

/*
		        ## **      MISTER2.r    ** ##
			## **    versione 1.3   ** ##
			## **     03-07-1993    ** ##

Mister2 percorre uno per volta i lati sinistro e basso e la loro diagonale, spostandosi se viene colpito.

Autore:	Lorenzo Ancarani

*/

int ang, range, oldrange;
int d, dmax;

main()  /* Main() routine  data: 11-6-1993 */
{
	ang = 0;
	drive(270,100);
	dmax=0;
	while (loc_y() > 70) fire();
	drive(180,0);
	while (speed() > 49) fire();
	drive(180,100);
	while(loc_x() > 70) {
				fire();
				if (ang > 180) ang = 0;
	}
	l1su();
}

l1su()
{
	drive(90,0);
	while (speed() > 49) fire();
	drive(90,100); d=damage();
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
	drive(270,0);
	while (speed() > 49) fire();
	drive(270,100); d=damage();
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
	drive(0,0);
	while (speed() > 49) fire();
	drive(0,100); d=damage();
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
	drive(180,0);
	while (speed() > 49) fire();
	drive(180,100); d=damage();
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
	drive(315,0);
	while (speed() > 49) fire();
	drive(315,100); d=damage();
	while (loc_x() < 930 && loc_y() > 70) fire();
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l2six();
	} else dig2();
}

dig2()
{
	drive(135,0);
	while (speed() > 49) fire();
	drive(135,100); d=damage();
	while (loc_x() > 70 && loc_y() < 930) fire();
	if ((damage() - d) > dmax) {
		dmax=damage() - d;
		l1giu();
	} else dig1();
}
	
fire()     /* Fire() routine  data: 29-06-1993 */
{
	if (range=scan(ang,8)) {
		if (range > oldrange)
			cannon(ang ,8 * range / 7);
		else cannon(ang ,7 * range / 8);
		oldrange=range;
		ang-=(scan(ang - 16,8) != 0)*16;
	} else ang+=16;
}
