/*
			###      Flash       ###
			###   versione 5.0   ###
			###  23 - 06 - 1996  ###

Autore: Lorenzo Ancarani

	Flash5 si sposta percorrendo in senso antiorario il perimetro
	del campo di battaglia.
	L'algoritmo di fuoco e' stato completamente mutuato da Tox
	per cui la documentazione relativa e' reperibile nella scheda
	tecnica di tale crobot.
*/

int ang, dir;

main()
{
	ang=11;
	drive(dir=180,100);
	while (loc_x() > 200) fuoco();
	drive(dir=270,0);
	while (speed() > 49) ;
	while (1)
	{
		drive(dir,100);
		while (loc_y() > 200)  {
			fuoco();
		}
		drive(dir=0,0);
		while (speed() > 49) ;
		drive(dir,100);
		while (loc_x() < 800) {
			fuoco();
		}
		drive(dir=90,0);
		while (speed() > 49) ;
		drive(dir,100);
		while (loc_y() < 800) {
			fuoco();
		}
		drive(dir=180,0);
		while(speed() > 49) ;
		drive(dir,100);
		while(loc_x() > 200)   {
			fuoco();
		}
		drive(dir=270,0);
		while(speed() > 49) ;
	}
}

/* Le routines d'attacco, le piu' importanti */

int   oang,range,orange,aa,rr;

fuoco() /* fuoco() - routine di gestione del tiro in moto */        
{
	if(scan(ang,5))
	{
		if(scan(ang-5,1)) ang-=5;
		if(scan(ang+5,1)) ang+=5;
		if(scan(ang-3,1)) ang-=3;
		if(scan(ang+3,1)) ang+=3;
		if(scan(ang-1,1)) ang-=1;
		if(scan(ang+1,1)) ang+=1;
		if (range=scan(ang,5))
		{
			orange=range;
			oang=ang;
			if(scan(ang-5,1)) ang-=5;
			if(scan(ang+5,1)) ang+=5;
			if(scan(ang-3,1)) ang-=3;
			if(scan(ang+3,1)) ang+=3;
			if(scan(ang-1,1)) ang-=1;
			if(scan(ang+1,1)) ang+=1;
			if (range=scan(ang,10))
			{
				aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14));
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
