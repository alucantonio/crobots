/*
         ## **     MISTER3.r     ** ##
		     ## **   versione 2.1    ** ##
		     ## **    27-01-2012     ** ##

Mio cuggino mi ha "obbligato" a partecipare al torneo. Con sommo stupore ho
scoperto che i robot della famiglia Flash, miei cavalli di battaglia, erano già
stati prenotati (ma come si sono permessi?).
Allora ho preso i miei Mister2 e Mister3 (del 1993!) e li ho "riammodernati" con
l'utilizzo di una funzione di fuoco più "moderna", presa dal vincitore dello
scorso anno.
Mister3 si muove avanti e indietro su uno dei 4 lati del campo. Se viene colpito cambia lato e ricomincia.

Autore:	Lorenzo Ancarani
http://www.foto-f.it/
*/

int ang, oang, range, orange;
int d, dmax;

main()  /* Main() routine  data: 18-6-1993 */
{
	drive(270,100);
	dmax=0;
	while (loc_y() > 80) fire();
	drive(180,0);
	while (speed() > 49) fire();
	drive(180,100);
	while(loc_x() > 80) {
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
	while (loc_y() < 920)
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
	while (loc_y() < 920)
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
	while (loc_y() > 80)
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
	while (loc_y() > 80)
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
	while (loc_x() < 920)
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
	while (loc_x() < 920)
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
	while (loc_x() > 80)
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
	while (loc_x() > 80)
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

fire()
{
 if (range=scan(oang=ang,10))
  {
   if (scan(ang-=7,4))
    {
     if (!(scan(ang+=2,2))) ang-=4;
     cannon(ang+(ang-oang),2*scan(ang,10)-range);
    }
   else if (scan(ang+=14,4))
    {
     if (!(scan(ang-=2,2))) ang+=4;
     cannon(ang+(ang-oang),2*scan(ang,10)-range);
    }
   else if (scan(ang-=7,4))
    {
     if (!(scan(ang+=2,2))) ang-=4;
     cannon(ang+(ang-oang),2*scan(ang,10)-range);
    }
  }
 else
  {
   if (range=scan(ang+=340,10)) return cannon(ang,range);
   if (range=scan(ang+=40,10)) return cannon(ang,range);
   if (range=scan(ang+=300,10)) return cannon(ang,range);
   if (range=scan(ang+=80,10)) return cannon(ang,range);
   if (range=scan(ang+=260,10)) return cannon(ang,range);
   if (range=scan(ang+=120,10)) return cannon(ang,range);
   ang+=80;
  }
}
