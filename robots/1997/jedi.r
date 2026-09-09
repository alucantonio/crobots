/*

        JEDI ver.1.0 del 15/03/97

	Autore: Maurizio Camangi

Strategia:
        Si sposta nell'angolo a sud-est del campo di battaglia.
        Oscilla a ovest ed a nord, restando vicino all'angolo.

	La funzione di fuoco in movimento e' piuttosto complessa
	e si basa sulla correzione dell'angolo e della gittata in base allo
        spostamento proprio e dell'avversario, ispirata dal crobot TOX.

        Dopo un numero prefissato di cicli JEDI attacca un crobot
	utilizzando una routine tratta dal crobots LEADER.

*/

int ang,        /* Angolo di scanning                           */
    dir,        /* Direzione del cammino                        */
    count,      /* Contatore                                    */
    curx,cury,  /* Variabili temporanee salvaposizione          */
    maxcount,   /* Massimo numero di oscillazioni               */
    maxdamage;  /* Massimo danni consetiti per attaccare        */

main()
{
	ang=0;
	count=0;
        maxcount=150;
	maxdamage=80;

	drive(dir=270,100);
	while (loc_y() > 200) fire();
	stop();
        drive(dir=0,100);
        while(loc_x() < 800) {
		fire();
	}
	stop();
	while(1)
	{
                drive(dir=90,100);
                while (loc_y() < 400)
		{
                        fire();
		}
                stop();
                drive(dir=270,100);
		while (loc_y() > 200)
		{
                        fire();
		}
                stop();
                drive(dir=180,100);
                while(loc_x() > 600)
                {
                        fire();
                }
                stop();
                drive(dir=0,100);
                while(loc_x() < 800)
                {
                        fire();
                }
                stop();
	}
}

/* Le routines d'attacco, le piu' importanti */

int   oang,range,orange,aa,rr,diff;

scan_()
{
	if(scan(ang-5,1)) ang-=5;
	if(scan(ang+5,1)) ang+=5;
	if(scan(ang-3,1)) ang-=3;
	if(scan(ang+3,1)) ang+=3;
	if(scan(ang-1,1)) ang-=1;
	if(scan(ang+1,1)) ang+=1;
}

fire()       
{
        if(range=scan(ang,5))
	{
                cannon(ang,range);
		scan_();
		if (range=scan(ang,5))
		{
			orange=range;
			oang=ang;
			scan_();
			if (range=scan(ang,10))
			{
				aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14));
				rr=(range*160/(160+orange-range-(cos(ang-dir)>>12)));
				while(!cannon(aa,rr));
				if (range>700) ang+=30;
			}
			else if(scan(ang-=10,10));
			else if(scan(ang+=20,10));
			else ang+=40;
		}
		else if(scan(ang-=10,10));
		else if(scan(ang+=20,10));
		else ang+=40;
	}
	else if(scan(ang-=10,10));
	else if(scan(ang+=20,10));
	else ang+=40;
}

attack() {

	if (speed()) drive(dir,0);
	while (speed()) ;
	drive(180*(loc_x()>500),100);
	ang=336;
	diff=50;
	while(1)
	{
		ang+=328;
		while(!(range=scan(ang+=16,8)));
		cannon(ang,range);
		if(range>200) drive(dir=ang,100);
			while (range)  /* && range<700 */
			{
				if (range>200)
				{
					oang=ang;
					orange=range;
					ang+=4-(scan(ang-4,4) != 0)*8;
					ang+=2-(scan(ang-2,2) != 0)*4;
					ang+=1-(scan(ang-1,1) != 0)*2;
					if (range=scan(ang,10))
						cannon(ang+(ang-oang)*range/200,range+(range-orange+diff)*range/275);
					if (speed()<51 || ((ang-dir)*(ang-dir)>400))
					{
						drive(dir=ang,100);
						diff=25;
					}
					else diff=50;
				}
				else
				{
					ang+=20;
					while(range<300)
					{
						ang+=320;
						while(!(range=scan(ang+=20,10)));
						cannon(ang,range);
						if(speed()<50 || range>200) drive(dir=ang,100);
					}
				}
			}
	}
}

/* Utilities per raccogliere il codice */

stop()                                /*  Fermati! */
{
	if ((++count >= maxcount) && (damage() < maxdamage))
		attack();
	drive(dir,0);
	while(speed() > 49) ;
	curx = loc_x();
	cury = loc_y();
}
