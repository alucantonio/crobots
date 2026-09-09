/*

			==   HAL 9000 clone  ==
			==    version 2.01   ==
			==     11-08-1995    ==

Autore: Maurizio Camangi

N.B.: E' IL ROBOT SPECULARE DI HAL9000 CHE COMBATTE SUL LATO OPPOSTO DEL
      CAMPO DI BATTAGLIA.

Strategia:
	Abbastanza complessa, il crobot rimane fermo finche' non viene
	colpito da una bomba che gli procura un danno maggiore o uguale
	al 5%. Si sposta poi nell'angolo a sud-est del campo di
	battaglia. Da qui in poi il percorso che puo' compiere e' di
	forma triangolare (i cateti sono ad est e a sud) e rimane
	fermo su ogni vertice finche' non viene colpito da una bomba
	vicina (5% o piu' di danni). Memorizza poi i danni durante ogni 
	spostamento e sceglie il lato successivo dove ha subito meno danni.
	La funzione di fuoco e' piuttosto complessa e si basa sulla
	correzione dell'angolo e della gittata in base allo spostamento
	proprio e dell'avversario (vedere commento su LazyII).
Commento:
	E' un Crobot ibrido, un po' tra Mister2 (che e' 
	di mio cugino!) e LazyII, l'ultimo vincitore dal quale ho
	prelevato l'incasinato ma efficientissimo algoritmo di attacco.
	Come HAL 9000 di "2001 Odissea nello spazio" ha i sui punti deboli;
	come sconfiggerlo :
	costringerlo a stare fermo il meno possibile nei vertici
	colpendolo con molta precisione!.

*/

int ang,     /* Angolo di scanning                           */
    d,       /* Danni attuali                                */
    dmax,    /* Danni massimi subiti su ogni lato            */
    loc_dam, /* Danni locali relativi ad ogni ciclo di fuoco */
    dir;     /* Direzione del cammino                        */

main()
{
	ang=11;
	loc_dam=0;
	dmax=9;
	while(loc_dam < 5) {
		fuoco();
	}
	drive(dir=270,100);
	while (loc_y() > 105) fuoco2();
	despeed(0);
	drive(dir,100);
	while(loc_x() < 895) {
		fuoco2();
	}
	l1up();
}

l1up()                                  /* Lato Est, direzione Nord */
{
	despeed(90);
	while(loc_dam < 5) {            /* Per adesso fermo */
		fuoco();
	}
	gospeed();                      /* Ok, direzione Nord */
	while (loc_y() < 895) {
		fuoco2();
	}
	if (flag()) {                   /* Ho subito piu' danni */
		dmax=damage() - d;
		dig1();                 /* Cambia direzione */
	} else l1down();                /* Altrimenti rimani su questo lato */
}

l1down()                                /* Lato Ovest, direzione Sud */
{
	despeed(270);
	while(loc_dam < 5) {            /* Come prima! */
		fuoco();
	}
	gospeed();
	while (loc_y() > 105) {
		fuoco2();
	}
	if (flag()) {
		dmax=damage() - d;
		l2left();
	} else l1up();
}

l2right()                               /* Lato Sud, direzione Est */
{
	despeed(0);
	while(loc_dam < 5) {
		fuoco();
	}
	gospeed();
	while (loc_x() < 895) {
		fuoco2();
	}
	if (flag()) {
		dmax=damage() - d;
		dig2();
	} else l2left();
}

l2left()                                /* Lato Sud, direzione Ovest */
{
	despeed(180);
	while(loc_dam < 5) {
		fuoco();
	}
	gospeed();
	while (loc_x() > 105) {
		fuoco2();
		if (ang > 190) ang=0;
	}
	if (flag()) {
		dmax=damage() - d;
		l1up();
	} else l2right();
}

dig1()                                  /* Diagonale, direzione Sud-Ovest */
{
	despeed(225);
	while(loc_dam < 5) {
		fuoco();
	}
	gospeed();
	while ((loc_x() > 105) && (loc_y() > 105)) fuoco2();
	if (flag()) {
		dmax=damage() - d;
		l2right();
	} else dig2();
}

dig2()                                  /* Diagonale, direzione Nord-Est */
{
	despeed(45);
	while(loc_dam < 5) {
		fuoco();
	}
	gospeed();
	while ((loc_x() < 895) && (loc_y() < 895)) fuoco2();
	if (flag()) {
		dmax=damage() - d;
		l1down();
	} else dig1();
}

/* Utility per raccoglire il codice, indispensabili!!      */
/* Eliminandole il codice supererebbe le 1000 istruzioni!! */

gospeed()                               /* Vai! */
{
	drive(dir,100);
	d=damage();                     /* Salva i danni attuali */
}

despeed(x)                               /* Fermati! */
int x;
{
	drive(dir=x,0);
	loc_dam=0;
	while(speed() > 49) fuoco2();
}

flag()                                  /* Controllo danni subiti */
{
	return((damage() - d) > dmax);
}

/* Le routines d'attacco, le piu' importanti */

int   oang,   /* Angolo precedente del bersaglio              */
      dang,   /* Angolo corretto per il tiro                  */
      alfa,   /* Angolo tra ang e dir                         */
      corr,   /* Cos(alfa)                                    */
      anco,   /* Sin(alfa)                                    */
      xrange, /* Variabile di range                           */
      orange, /* Posizione precedente del bersaglio           */
      range;  /* Posizione attuale del bersaglio              */

fuoco()    /* fuoco() - routine di gestione del tiro da fermo */        
{
	loc_dam=damage();
	if ( find() ) {    /* se individui un bersaglio spara */
		spara();
	} else {
		ang-=11;       /* altrimenti cercalo a destra */
		if ( find() ) {
			spara();
		} else {
			ang+=22;     /* altrimenti cercalo a sinistra */
			if ( find() ) {
				spara();
			} else
				while ( ! scan ( (ang += 19), 10 ) ) ;
				/* altrimenti vai in cerca di un altro bersaglio */
		}
	}
	loc_dam=damage() - loc_dam;

}

fuoco2() /* fuoco2() - routine di gestione del tiro in moto */        
{
	if ( find() )     /* se idividui un bersaglio spara */
	{
		spara2();
	} else {
		ang-=11;     /* altrimenti cercalo a destra */
		if ( find() ) {
			spara2();
		} else {
			ang+=22; /* altrimenti cercalo a sinistra */
			if ( find() ) {
				spara2();
			} else 
				while ( ! scan ( (ang += 19), 10 ) ) ;
				/* altrimenti cerca un altro bersaglio */
	}
	}
}

find() /* find() - routine di ricerca del bersaglio */
{
if ( xrange = scan(ang,5) )  
   {
   if ( scan(ang+3,2) )
      if ( scan(ang+4,1) ) 
	 { 
	 if ( scan(ang+3,0) ) 
	    ang+=3; 
	 else   
	    ang+=4;
	 }
      else
	 if ( scan(ang+2,0) )
	    ang+=2; 
	 else
	    ang+=1; 
   else
      if ( scan(ang-4,2) )
	 if ( scan(ang-2,1) ) 
	    ang-=2;
	 else
	    ang-=3;        
      else
	 if ( scan(ang-1,0) )
	    ang-=1;
	 else
	    ang-=0;        
   return 1;
   }
else 
   return 0;
}

spara() /* spara() - routine di tiro da fermo */
{
oang=ang;     /* si fissa l'angolo della posizione attuale del bersaglio   */
if ( find() ) /* si segue il bersaglio con tre find() in cascata           */
   {
   if ( find() )
      {
      if ( find() )
	 {
	 orange=xrange; /* si fissa il range attuale del bersaglio         */
	 dang = ang + (ang-oang)*(900+xrange)/1000; /* si fissa l'angolo di tiro in base ad ang e oang  */
	 cannon ( dang, (range=scan(ang,10))*183/(183+orange-range) );
	 /* si spara calcolando il range in base al range    */
	 /* attuale e al precedente, utilizzando la formula  */
	 /* indicata nella scheda tecnica                    */
	 }
      if (xrange > 700) /* se il bersaglio Š fuori range se ne cerca un altro  */
	 ang+=30;
      }
   }
}

spara2() /* spara2() - routine di tiro in movimento */
{
	oang=ang; /* si fissa l'angolo della posizione attuale del bersaglio */
	if ( find() ) { /* si segue il bersaglio con una find() */
		orange=xrange; /* si fissa il range precedente del bersaglio */
		alfa = (dir-ang) - ((dir-ang)/360)*360; /* si calcola alfa e il sen(alfa) ed il cos(alfa) */
		anco = sin(alfa);
		corr = cos(alfa);
		dang = ang + (ang-oang)*11/4 + anco/41500 ; /* si calcola l'angolo di tiro con correzione */
		if (range=scan(ang,10)) xrange=range;       /* si calcola il range attuale del bersaglio  */
		while ( ! cannon ( dang,xrange*183/(183+orange-xrange-corr/2700) ) ); /* si spara correggendo il range */
		if (xrange > 700) /* se il bersaglio Š fuori range se ne cerca un altro */
			ang+=30;
	}
}

