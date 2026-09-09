

/*
	             ## **     MISTER3.r     ** ##
		     ## **   versione 1.1    ** ##
		     ## **    12-07-1993     ** ##

Mister3 si muove avanti e indietro su uno dei 4 lati del campo. Se viene colpito cambia lato e ricomincia.

Autore:	Lorenzo Ancarani
	
*/

int ang, range, oldrange;
int d, dmax;

main()  /* Main() routine  data: 18-6-1993 */
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
				if ( ang > 180 ) ang = 0;
	}
	nord1();
}

nord1()
{
	drive(90,0);
	while (speed() > 49) fire();
	drive(90,100); d = damage();
	while (loc_y() < 930)
	{
		fire();
		if ( ang > 90 && ang < 270 ) ang = 270;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() -d;
		est1();
	} else sud1();
}

nord2()
{
	drive(90,0);
	while (speed() > 49) fire();
	drive(90,100); d = damage();
	while (loc_y() < 930)
	{
		fire();
		if ( ang < 90 || ang > 270 ) ang = 90;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() -d;
		est1();
	} else sud1();
}
	
sud1()
{
	drive(270,0);
	while (speed() > 49) fire();
	drive(270,100); d = damage();
	while (loc_y() > 70)
	{
		fire();
		if ( ang > 90 && ang < 270 ) ang = 270;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		est2();
	} else nord1();
}

sud2()
{
	drive(270,0);
	while (speed() > 49) fire();
	drive(270,100); d = damage();
	while (loc_y() > 70)
	{
		fire();
		if ( ang < 90 || ang > 270 ) ang = 90;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		est2();
	} else nord1();
}

est1()
{
	drive(0,0);
	while (speed() > 49) fire();
	drive(0,100); d = damage();
	while (loc_x() < 930)
	{
		fire();
		if ( ang < 180 || ang > 360 ) ang = 180;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		sud2();
	} else ovest1();
}

est2()
{
	drive(0,0);
	while (speed() > 49) fire();
	drive(0,100); d = damage();
	while (loc_x() < 930)
	{
		fire();
		if ( ang > 180 ) ang = 0;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		nord2();
	} else ovest2();
}

ovest1()
{
	drive(180,0);
	while (speed() > 49) fire();
	drive(180,100); d = damage();
	while (loc_x() > 70)
	{
		fire();
		if ( ang < 180 || ang > 360 ) ang = 180;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		sud1();
	} else est1();
}

ovest2()
{
	drive(180,0);
	while (speed() > 49) fire();
	drive(180,100); d = damage();
	while (loc_x() > 70)
	{
		fire();
		if ( ang > 180 ) ang = 0;
	}
	if ((damage() - d) > dmax)
	{
		dmax = damage() - d;
		nord1();
	} else est2();
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