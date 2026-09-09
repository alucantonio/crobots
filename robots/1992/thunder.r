/*  THUNDER.R programma che si muove velocemente nell'arena disegnando 
	un ROMBO. Scritto da Persiani Giuseppe nel mese di Agosto 1992.
	Persiani Giuseppe */

int	trovato; /* Variabile nella quale viene posto il risultato della scansione
				dell'arena */

int	direz;	 /* Variabile che contiene il valore attuale della direzione di
				movimento del robot */

int	x, y, locx, locy, d; /* Variabili che serviranno nella funzione per il calcolo 
						della nuova posizione */
main()
{
	int	sc1;	/* Questa variabile viene utilizzata per la direzione della 
					   scansione dell'arena */

	sc1 = 0;
	x = 500;     /* THUNDER.R, per spostarsi utilizza la funzione NEW_DIR() */
	y = 0;	   /* che tramite il valore delle variabili X ed Y che contengono*/
	new_dir(); /* le coordinate dell'arena dove spostarsi ritorna la direzione */
	drive(d, 100); /* relativa nella variabile D */
	while ( loc_y() > 100) {
		if ((trovato = scan(sc1, 10)) != 0) /* All'inizio THUNDER.R si porta */
			cannon(sc1, trovato);        /* a meta' del lato inferiore (500,0) */
		else 
			sc1 += 20;			/* cercando gli avversari con questo semplice */
	}							/* ciclo e sparando se li trova */
	drive(d, 0);		/* Raggiunta la destinazione il robot rallenta */
	direz = 45;	/* Dato che il robot si muove in senso antiorario dirigendosi */
	while (1) {   /* sempre verso la meta' del lato successivo, la direzione iniziale */
		drive(d, 100); /* sara' di 45 gradi */
		while ((loc_x() >= 60) && (loc_x() <= 940) && (loc_y() >= 60) && (loc_y() <= 940)) {
			if ((trovato = scan(sc1, 10)) >= 50)  /* Questo e` il semplice ciclo di */
				cannon(sc1, 16 * trovato / 17);	/* ricerca degli avversari che prosegue */
			else 
				sc1 += 20;   /* fino a che THUNDER.R non e` vicino ad uno dei */
			/* lati, la precisione dello SCANNING e` molto bassa */
		}					/* ed la distanza a cui sparare memorizzata in TROVATO */
		drive(d, 0);			/* viene accorciata di poco (16*trovato/17) */
		direz += 90;			/* La variabile DIREZ contiene la direzione verso */
		if (direz == 135) {   /* la quale THUNDER.R si sta spostando e serve */
			x = 500;			/* per aggiornare i valori di X ed Y che serviranno */
			y = 1000;			/* alla funzione NEW_DIR() */
			new_dir();
			drive(d, 100);
		} else if (direz == 225) {  /* Questi IF in cascata aggiornano i valori */
			x = 0;						/* delle variabili X ed Y da passare a NEW_DIR()*/

			y = 500;				/* a seconda del valore della direzione attuale del */
			new_dir();			/* robot */
			drive(d, 100);
		} else if (direz == 315) {
			x = 500;
			y = 0;
			new_dir();
			drive(d, 100);
		} else if (direz == 405) {
			direz = 45;
			x = 1000;
			y = 500;
			new_dir();
			drive(d, 100);
		}
		while ((loc_x() <= 61) || (loc_x() >= 941) || (loc_y() <= 61) || (loc_y() >= 941))
			drive(d, 100); /* Questo ciclo serve a far allontanare THUNDER.R dai bordi */
	}						/* dell'arena se vi si ‚ avvicinato troppo */
}


new_dir()
{

	locx = loc_x();  /* Questa funzione ‚ identica a quella del fornita nel */
	locy = loc_y();	/* compilatore di robot CROBOTS in uno degli esempi */

	if (locx == x) {   /* ed a seconda della sua posizione attuale ed al valore */
		if (y > locy)	/* delle variabili X ed Y ritorna nella variabile D la */
			d = 90;		/* direzione voluta per raggiungere la posizione (X,Y) */
		else /* dell'arena */
			d = 270;
	} else
	 {
		if (y < locy) {
			if (x > locx)
				d = 360 + atan((100000 * (locy - y)) / (locx - x));
			else
				d = 180 + atan((100000 * (locy - y)) / (locx - x));
		} else if (x > locx)
			d = atan((100000 * (locy - y)) / (locx - x));
		else
			d = 180 + atan((100000 * (locy - y)) / (locx - x));

	}
}


