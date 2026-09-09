/*
			###      Flash       ###
			###   versione 4.1   ###
			###  08 - 08 - 1995  ###

Autore: Lorenzo Ancarani

	Flash4 si sposta percorrendo in senso antiorario il perimetro
	del campo di battaglia.
	L'algoritmo di fuoco e' stato completamente mutuato da LazyII
	per cui la documentazione relativa e' reperibile nella scheda
	tecnica di tale crobot.
*/

int ang, dir;

main()
{
	ang=11;
	drive(dir=180,100);
	while (loc_x() > 100) fuoco();
	drive(dir=270,0);
	while (speed() > 49) fuoco();
	while (1)
	{
		drive(dir,100);
		while (loc_y() > 100)  {
			fuoco();
		}
		drive(dir=0,0);
		while (speed() > 49) fuoco();
		drive(dir,100);
		while (loc_x() < 900) {
			fuoco();
		}
		drive(dir=90,0);
		while (speed() > 49) fuoco();
		drive(dir,100);
		while (loc_y() < 900) {
			fuoco();
		}
		drive(dir=180,0);
		while(speed() > 49) fuoco();
		drive(dir,100);
		while(loc_x() > 100)   {
			fuoco();
		}
		drive(dir=270,0);
		while(speed() > 49) fuoco();
	}
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

fuoco() /* fuoco() - routine di gestione del tiro in moto */        
{
	if ( find() )
	{
		spara();
	} else {
		ang-=11;
		if ( find() ) {
			spara();
		} else {
			ang+=22;
			if ( find() ) {
				spara();
			} else 
				while ( ! scan ( (ang += 19), 10 ) ) ;
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

spara() /* spara() - routine di tiro in movimento */
{
	oang=ang;
	if ( find() ) {
		orange=xrange;
		alfa = (dir-ang) - ((dir-ang)/360)*360;
		anco = sin(alfa);
		corr = cos(alfa);
		dang = ang + (ang-oang)*11/4 + anco/41500 ;
		if (range=scan(ang,10)) xrange=range;
		while ( ! cannon ( dang,xrange*183/(183+orange-xrange-corr/2700) ) );
		if (xrange > 700)
			ang+=30;
	}
}
