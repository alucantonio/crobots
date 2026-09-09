/*
Nome del robot  : Pizarro' s horse
Nome del file	: pizarro.r
Autore          : Gianni Ino

Il robot non e' altro che una riedizione di Jedi del 1997.
Il movimento e' stato reso ad esso speculare rispetto alla mediana dall' arena (in pratica si muove nell' angolo in alto a destra) ed e' stata accorciata l' oscillazione orizzontale, in modo da rendere il moto simile a quello del pezzo del cavallo negli scacchi.
Ogni 30 oscillazioni controlla i sopravvissuti, e se ne trova solo uno perte all' attaco con una routine tratta da Sottolin.r
Le routine di fuoco ora soo due: quella base e ua tratta da Arale.

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
        maxcount=30;
	maxdamage=90;

	while (loc_y() < 800){drive(dir=90,100);
		fire();
	}
	while (loc_y() < 920){drive(dir=90,100);
		fire1();
	}
	stop();

        while(loc_x() < 800) {drive(dir=0,100);
		fire();
	}
        while(loc_x() < 920) {drive(dir=0,100);
		fire1();
	}
	stop();
	while(1)
	{
                while (loc_y() > 700)
		{
	                drive(dir=270,100);
                        fire();
		}
                stop();
		while (loc_y() < 850)
		{
	                drive(dir=90,100);
                        fire();
		}
		while (loc_y() < 920)
		{
	                drive(dir=90,100);
                        fire1();
		}
                stop();
                while(loc_x() > 750)
                {
	                drive(dir=180,100);
                        fire();
                }
                stop();
                while(loc_x() < 750)
                {
	                drive(dir=0,100);
                        fire();
                }
                while(loc_x() < 920)
                {
	                drive(dir=0,100);
                        fire1();
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
        if(range=scan(ang,10))
	{
                if (range>700) return fire1();
                if (!scan(ang-=5,5)) ang+=10;
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
				cannon(aa,rr);
			}
			else if(scan(ang-=20,10));
			else if(scan(ang+=40,10));
			else ang+=80;
		}
		else if(scan(ang-=10,10));
		else if(scan(ang+=20,10));
		else ang+=40;
	}
	else if(scan(ang-=20,10));
	else if(scan(ang+=40,10));
	else ang+=80;
}

fire1()
{
   if ((range=scan(ang,10))&&(range<800))
     cannon (ang+=(scan(ang+5,5)>0)*5-(scan(ang-5,5)>0)*5,2*scan(ang,10)-range);
   else if ((range=scan(ang+20,10))&&(range<800)) cannon (ang+=20,range);
   else if ((range=scan(ang+40,10))&&(range<800)) cannon (ang+=40,range);
   else if ((range=scan(dir,10))&&(range<800)) cannon (ang=dir,range);
   else ang+=60;
}

attack()
int sup;
{
  if (((scan(180,10)>0)+(scan(270,10)>0)+(scan(225,10)>0))>1) return (count=0);
  while (1)
{
  while (loc_y()>600) {drive (dir=270,100);fire1();}
  fermo();
  while (loc_x()>250) {drive (dir=180,100);fire();}
  fermo();
  while (loc_x()<750) {drive (dir=0,100);fire();}
  fermo();
}
}

/* Utilities per raccogliere il codice */

stop()                                /*  Fermati! */
{
	if ((++count >= maxcount) && (damage() < maxdamage))
		attack();
        fermo();
}

fermo()                                /*  Fermati! */
{
	drive(dir,0);
	while(speed() > 49) ;
	curx = loc_x();
	cury = loc_y();
}
