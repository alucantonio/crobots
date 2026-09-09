/*
Nome del robot  : Gengis khan
Nome del file   : gengis.r
Autore          : Gianni Ino

Il robot all'inizio del match si reca nell'angolo piu' vicino, e controlla che
non sia uno scontro a singolar tenzone: se e' cosi' attacca con Satana.r.
Altrimenti oscilla alternativamente lungo la x e la y per un'escursione massima
di 250 metri.
Ogni 30 oscillazioni controlla i sopravvissuti, e se ne trova solo uno parte
all' attaco con Satana.r
Non si muove mai dal suo angolo, anche perche' l'efficienza altrmenti peggiora.
*/

int ang,        /* Angolo di scanning                           */
    dir,        /* Direzione del cammino                        */
    att,        /* Sto attaccando?                              */
    count,      /* Contatore                                    */
    curx,cury,  /* Variabili temporanee salvaposizione          */
    maxcount,   /* Massimo numero di oscillazioni               */
    maxdamage;  /* Massimo danni consetiti per attaccare        */
int dir,deg,normal;
int odeg,rng,orng;

main()
{
	ang=0;
	count=0;
        maxcount=30;
	maxdamage=90;

        while ((loc_y()%800) > 200){drive(dir=90+(loc_y()<500)*180,100);
		fire();
	}
        while ((loc_y()%910) > 90){drive(dir=90+(loc_y()<500)*180,100);
		fire1();
	}
	stop();

        while ((loc_x()%800) > 200){drive(dir=(loc_x()<500)*180,100);
		fire();
	}
        while ((loc_x()%910) > 90){drive(dir=(loc_x()<500)*180,100);
		fire1();
	}
	stop();
        attack();
	while(1)
	{
                while ((loc_y()%750) < 250)
		{
                        drive(dir=90+(loc_y()>500)*180,100);
                        fire();
		}
                stop();
                while ((loc_y()%850) > 150)
		{
                        drive(dir=90+(loc_y()<500)*180,100);
                        fire();
		}
                while ((loc_y()%910) > 90)
		{
                        drive(dir=90+(loc_y()<500)*180,100);
                        fire1();
		}
                stop();
                while ((loc_x()%750) < 250)
		{
                        drive(dir=(loc_x()>500)*180,100);
                        fire();
		}
                stop();
                while ((loc_x()%850) > 150)
		{
                        drive(dir=(loc_x()<500)*180,100);
                        fire();
		}
                while ((loc_x()%910) > 90)
		{
                        drive(dir=(loc_x()<500)*180,100);
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
                if ((range>700)&&(!att)) return fire1();
                if (range<150) return cannon (ang,range);
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
   if ((range=scan(ang,10))&&((range<800)))
     cannon (ang+=(scan(ang+5,5)>0)*5-(scan(ang-5,5)>0)*5,2*scan(ang,10)-range);
   else if ((range=scan(ang+20,10))&&(range<800)) cannon (ang+=20,range);
   else if ((range=scan(ang+40,10))&&(range<800)) cannon (ang+=40,range);
   else if ((range=scan(dir,10))&&(range<800)) cannon (ang=dir,range);
   else ang+=80;
}

attack()
int sup,u;
{
  fermo();
  while (sup<380) u+=(scan(sup+=20,10)>0);
  if (u>1) return (count=0);
  main2();
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

main2() {
  int clock;

/* vai in verticale verso il muro piu` lontano */
  if (loc_y()>500) {deg=450; dir=270;}
  else             {deg=630; dir=90; }

  while(normal=3) {
/* vai nella direzione dir fino ad una distanza di 175 dal muro
o finche` angolo e/o distanza del nemico divengono pressoche` costanti */
    if (dir==270)     while(focus(loc_y()<275));
    else if (dir==90) while(focus(loc_y()>725));
    else if (dir)     while(focus(loc_x()<275));
    else              while(focus(loc_x()>725));

/* se incontri il muro rimbalza altrimenti devia di 135 o 225 gradi
rispetto al nemico */
    if (normal) drive((dir+180)%=360,50);
    else        drive(dir=(( ((deg+180)/90) + (clock^=1) )*90)%360,50);

/* spara velocemente */
    while (speed()>50)
      if (orng=scan(deg,10)) {
        odeg=deg;
        if (scan(deg+=5,5)); else deg-=10;
        if (scan(deg+=3,3)); else deg-=6;
  
        if (rng=scan(deg,10))
          cannon(deg+(deg-odeg),rng+(rng-orng)*2);
      }
      else if (scan(deg+=21,10));
      else if (scan(deg-=42,10));
      else deg+=84;

/* accelera nella nuova direzione */
    drive(dir,100);
  }
}

focus(exit) {
  if (exit) return 0;
  else {
    drive(dir,100);

/* cerca il nemico in un range angolare di 63 gradi */
    if (scan(deg,10));
    else if (scan(deg+=21,10));
    else if (scan(deg-=42,10));
    else {deg+=84; return --normal;}

/* famosissima toxica */
    if (scan(deg-=5,5)); else deg+=10;
    if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
    if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
    if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;
    if (orng=scan(odeg=deg,5)) {
/* peccato che questi parametri soffrono del bug ma in 1&1 sono magnifici
dato che non sono cosi` fesso da cascarci proprio mentre attacco */
      if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
      if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
      if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

      if (rng=scan(deg,10))
        cannon(deg+ (deg-odeg)*((1200+rng)>>9)- (sin(deg-dir)>>14),
               rng*192/(192+ orng-rng- (cos(deg-dir)>>12)));

/* se l`angolo diventa costante preparati per cambiare direzione */
      if (deg==odeg) return normal>>=1;
    }
/* ricordati che il tempo passa */
    return --normal;
  }
}


