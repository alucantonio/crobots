/*-------------------------------------------------------------------------- 

   CROBOT:  LazyII.r 
   
   AUTORE:  LUIGI RAFAIANI (01.03.1962) 
	    MC-LINK  MC1503 

		    
			  SCHEDA TECNICA

 IL CROBOT TENDE A RIMANERE FERMO FINCHE' NON VIENE ATTACCATO O NON 
 HA PASSATO UN DETERMINATO PERIODO DI TEMPO FERMO NEL QUAL CASO 
 SI SPOSTA DESCRIVENDO UN QUADRATO A CIRCA 100 UNITA' DAL BORDO DEL CAMPO 
 DI GIOCO FERMANDOSI SIA AI QUATTRO VERTICI SIA A META' DEI LATI.
 
 LA FORZA DEL CROBOT DIPENDE QUINDI DALL'EFFICENZA DELLE ROUTINE DI TIRO 
 PIUTTOSTO CHE DA STRATEGIE DI MOVIMENTO.
 
 IL CROBOT ADOTTA DUE STRATEGIE DI TIRO: UNA PER QUANDO E' FERMO E L'ALTRA
 PER QUANDO E' IN MOVIMENTO.
 
 LE ROUTINE DI FUOCO ( FUOCO() E FUOCO2() ) COMPRENDONO UNA FUNZIONE DI 
 PUNTAMENTO ( FIND() ) E DUE ROUTINE DI TIRO VERO E PROPRIO ( SPARA() E 
 SPARA2() ). 
 
 IL CROBOT UNA VOLTA PERSO IL BERSAGLIO LO CERCA A DESTRA E A SINISTRA E
 SE NON LO TROVA VA IN CERCA DI UN ALTRO BERSAGLIO.

 LA ROUTINE DI PUNTAMENTO TENDE AD INDIVIDUARE PER APPROSSIMAZIONI SUCCESSIVE
 L'ESATTO ANGOLO DELLA POSIZIONE DELL'AVVERSARIO. (SI E' CERCATO DI RENDERE
 IL PIU' POSSIBILE COSTANTE IL TEMPO DI ESECUZIONE DELLA ROUTINE AL VARIARE
 DELL'ANGOLO).
 
 LA ROUTINE DI TIRO DA FERMO ( SPARA() ) SEGUE IL BERSAGLIO ( ATTRAVERSO UNA 
 CASCATA DI TRE FIND() ) DOPO DI CHE' CALCOLA L'ANGOLO DI TIRO IN BASE ALLO
 SPOSTAMENTO DEL BERSAGLIO ( CALCOLATO "A LUNGO TERMINE" ) E CALCOLA IN RANGE
 IN BASE ALLA SEGUENTE FORMULA:
				    VELOCITA' PROIETTILE
 RANGE = RANGE ATTUALE * ------------------------------------------
			 VELOCITA' PROIETTILE + VELOCITA' BERSAGLIO
 
 DOVE LA VELOCITA' PROIETTILE E' UNA COSTANTE E LA VELOCITA' DEL BERSAGLIO
 E' PROPORZIONALE ALLO SPOSTAMENTO DEL BERSAGLIO ( CALCOLATO "A BREVE 
 TERMINE" ).

 PER LA ROUTINE DI TIRO IN MOVIMENTO SI SONO AGGIUNTI DUE FATTORI CORRETTIVI:
 UNO SULL'ANGOLO PROPORZIONALE AL SENO DELL'ANGOLO TRA DIREZIONE DI MARCIA
 E POSIZIONE DEL BERSAGLIO ( ANGOLO ALFA ) E UNO SUL RANGE PROPORZIONALE AL
 COSENO DI TALE ANGOLO.

 SI E' CERCATO DI MANTENERE IL TEMPO DI ESECUZIONE DELLA ROUTINE DI FUOCO
 AL DI SOPRA DEL TEMPO DI RICARICA DELLA FUNZIONE CANNON().

 --------------------------------------------------------------------------*/

/***---                   LazyII.r                      ---***/

int   ang,    /* angolo di scansione                         */
      dir,    /* angolo ddella direzione di movimento        */
      dam,    /* variabile del danno attuale                 */
      sdam,   /* tolleranza sul danno attuale                */
      ldam,   /* limite del danno per cercare la patta       */
      t,      /* contatore per riprendere il movimento       */
      limt;   /* limite del contatore t                      */


/***---                     main()                      ---***/

main()
{

/* costanti */

sdam=1;
ldam=88;
limt=50;

/* inizializzazione variabili */

ang = 3602;
t   = 0;
dam = sdam;

/* pre-ciclo */

while ( (damage() < dam) && (t < limt) )
      { ++t; fuoco(); }

/* ciclo principale */

while (1)
	
	{
	

	dir = 36090;
	while (loc_y() < 820) 
	      { drive (dir,100); fuoco2(); }
	
	stop();

	dir = 36000;
	while (loc_x() < 420) 
	      { drive (dir,100); fuoco2(); }
	
	stop();
	
	dir = 36000;
	while (loc_x() < 820) 
	      { drive (dir,100); fuoco2(); }
	
	stop();
	
	dir = 36270;
	while (loc_y() > 580) 
	      { drive (dir,100); fuoco2(); }
	
	stop();
	
	dir = 36270;
	while (loc_y() > 180) 
	      { drive (dir,100); fuoco2(); }
	
	stop();
	
	dir = 36180;
	while (loc_x() > 580) 
	      { drive (dir,100); fuoco2(); }

	stop();

	dir = 36180;
	while (loc_x() > 180) 
	      { drive (dir,100); fuoco2(); }
	 
	stop();
	
	dir = 36090;
	while (loc_y() < 420) 
	      { drive (dir,100); fuoco2(); }
	
	stop();        
	
	}

}

/***---               routines                          ---***/

/***--- stop() - routine di gestione del crobot fermo   ---***/

stop()        
	{
	
	drive (dir,0);
	t=0;
	dam = damage()+sdam;
	if (dam>ldam) limt=2000; 
	
	while ( (damage() < dam) && (t < limt) )
	  { ++t; fuoco(); }

	}



int   oang,  /* angolo precedente del bersaglio              */
      dang,  /* angolo corretto per il tiro                  */
      alfa,  /* angolo tra ang e dir                         */
      corr,  /* cos(alfa)                                    */
      anco,  /* sin(alfa)                                    */
      nrg,   /* variabile di range                           */
      rng2,  /* posizione precedente del bersaglio           */
      rg;    /* posizione attuale del bersaglio              */


/***--- fuoco() - routine di gestione del tiro da fermo ---***/

fuoco()         
{
/* se individui un bersaglio spara                           */
if ( find() )
   {
   spara();
   }
else    
   {
   /* altrimenti cercalo a destra                            */
   ang-=11;
   if ( find() ) 
      {
      spara();
      }
   else 
      {
      /* altrimenti cercalo a sinistra                       */
      ang+=22;
      if ( find() )
	 {
	 spara();
	 }
      else 
	 /* altrimenti vai in cerca di un altro bersaglio    */
	 while ( ! scan ( (ang += 19), 10 ) ) {}
      }
   }
}

/***--- fuoco2() - routine di gestione del tiro in moto ---***/

fuoco2()         
{
/* se idividui un bersaglio spara                            */
if ( find() )
   {
   spara2();
   }
else    
   {
   /* altrimenti cercalo a destra                            */
   ang-=11;
   if ( find() ) 
      {
      spara2();
      }
   else 
      {
      /* altrimenti cercalo a sinistra                       */
      ang+=22;
      if ( find() )
	 {
	 spara2();
	 }
      else 
	 /* altrimenti cerca un altro bersaglio              */ 
	 while ( ! scan ( (ang += 19), 10 ) ) {}
      }
   }
}

/***--- find() - routine di ricerca del bersaglio       ---***/

/* se un bersaglio Š nel arco di 10ø gradi intorno ad ang si */
/* determina l'esatto angolo della posizione e si rimanda al */
/* programma chiamante l'OK.                                 */

find()

{
if ( nrg = scan(ang,5) )  
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

/***--- spara() - routine di tiro da fermo              ---***/

spara()
{
/* si fissa l'angolo della posizione attuale del bersaglio   */
oang=ang;
/* si segue il bersaglio con tre find() in cascata           */
if ( find() )
   {
   if ( find() )
      {
      if ( find() )
	 {
	 /* si fissa il range attuale del bersaglio          */
	 rng2=nrg;
	 /* si fissa l'angolo di tiro in base ad ang e oang  */
	 dang = ang + (ang-oang)*(900+nrg)/1000;
	 /* si spara calcolando il range in base al range    */
	 /* attuale e al precedente, utilizzando la formula  */
	 /* indicata nella scheda tecnica                    */
	 cannon ( dang, (rg=scan(ang,10))*183/(183+rng2-rg) );
	 }
      /* se il bersaglio Š fuori range se ne cerca un altro  */
      if (nrg > 700) 
	 ang+=30;
      }
   }
}

/***--- spara2() - routine di tiro in movimento         ---***/

spara2()
{
/* si fissa l'angolo della posizione attuale del bersaglio   */
oang=ang;
/* si segue il bersaglio con una find()                      */
if ( find() )
   {
   /* si fissa il range precedente del bersaglio             */
   rng2=nrg;
   /* si calcola alfa e il sen(alfa) ed il cos(alfa)         */  
   alfa = (dir-ang) - ((dir-ang)/360)*360;                   
   anco = sin(alfa);
   corr = cos(alfa);
   /* si calcola l'angolo di tiro con correzione             */
   dang = ang + (ang-oang)*11/4 + anco/41500 ;
   /* si calcola il range attuale del bersaglio              */
   if (rg=scan(ang,10)) nrg=rg;
   /* si spara correggendo il range                          */
   while ( ! cannon ( dang,nrg*183/(183+rng2-nrg-corr/2700) ) );
   /* se il bersaglio Š fuori range se ne cerca un altro     */
   if (nrg > 700) 
      ang+=30;
   }
}

/***---                 fine LazyII.r                   ---***/
