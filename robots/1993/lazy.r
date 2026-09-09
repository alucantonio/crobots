/* 

   Lazy Ver. 1.0
   Luigi Rafaiani (01.03.1962) 

   MC1503 (Mc-link)

		    SCHEDA TECNICA

   Il robot si posiziona al centro del campo di gioco dove resta fermo per
 tutta la durata della battagia. 
   Da qui spara contro gli avversari utilizzando un range calcolato in base 
 agli ultimi due scan() ed al cambiamento dell'angolo di scansione ed 
 impiegando un angolo calcolato in base al senso di scansione ed al range.
   Una volta perso di mira l'avversario lo cerca a destra e a sinistra e
 se non lo trova va in cerca di un altro bersaglio.

*/

int   ang,  /* angolo di scansione attuale */
      oang, /* parametro di correzione per l'angolo di tiro:
	       -1 se l'angolo di scansione precedente era minore
		0 se era lo stesso
		1 se era maggiore */
      nrg, /* range attuale della scansione */
      org, /* parametro di correzione per il range di tiro:
	      range della precedente scansione */
      dff; /* parametro di correzione per il range di tiro:
	      10 se l'angolo di scansione Š cambiato
	       0 se rimane lo stesso */

main()
	{

	/*  setta l'angolo di scansione */

	ang = 3602;

	/* cerca un avversario */

	while (! scan(ang -= 20,10)) {}
	
	/* Si posizione al centro dell'asse delle x e comincia a sparare */
	
	if (loc_x() > 510) while (loc_x() > 510 ) { drive (180,100);
						    fire(); }
	else while (loc_x() <= 490) { drive (0,100);
				      fire(); }
	
	/* Si posiziona al centro dell'asse delle y e continua a sparare */

	if (loc_y() > 510) while (loc_y() > 510 ) { drive (270,100);
						    fire(); }
	else while (loc_y() <= 490) { drive (90,100);
				      fire(); }

	/* Si ferma */
	
	drive (0,0);

	/* Spara senza richiamare una routine ma utilizzando direttamente
	   il codice in linea */
	
	while (1)
	 
	 {

	 /* Se Š stato individuato un bersaglio */

	 if ( ( nrg = scan(ang, 2) ) > 50 )  
	    {

	    /* Spara calcolando l'angolo e il range in base ai vari 
	       parametri utilizzati */

	    cannon ( ang + nrg*oang/48, nrg + dff + nrg*(nrg-org)/250 );
	    
	    /* aggiorna alcuni parametri */
	    
	    org=nrg;
	    dff=0;
	    oang=0;
	    
	    }

	 /* Altrimenti se l'avversario non Š pi— nella stessa posizione */

	 else    
	    {

	    /* se si Š spostato a destra aggiorna angolo di scansione e
	       relativo parametro per il tiro */

	    if ( scan ( (ang -= 5), 2 ) ) oang = -1;
	    
	    else 
	       {

	       /* se si Š spostato a sinistra idem */

	       if ( scan ( (ang += 10), 2 ) ) oang = 1;

	       /* altrimenti cerca velocemente finch‚ non si trova
		  un avversario */

	       else while ( ! scan ( (ang -= 20), 10 ) ) {}
	       
	       }

	    /* aggiorna parametro per il tiro */

	    dff=10;
	    
	    }
	 }

	}


/* Routine di fuoco provvisoria utilizzata durante lo spostamento
   iniziale ed utile soprattutto per settare tutti i parametri */

fire()

	{
	if ( (nrg = scan(ang, 5)) > 50 )  
	   {
	   cannon (ang+ nrg*oang/100, nrg + dff + nrg*(nrg-org)/250 );
	   org=nrg;
	   dff=0;
	   oang=0;
	   }
	else    
	   {
	   if ( scan ( (ang -= 10), 5 ) ) oang = -1;
	   else 
	      {
	      ang += 20;
	      oang = 1;
	      }
	   dff=10;
	   }
	}

