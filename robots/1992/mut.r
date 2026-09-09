/* Crobot mut,                   */
/* Giulio Buccini,               */

int	heading, range;
main () 
{
	go_east_wall();         /* Avvicinamento veloce al lato est */
	while (1) {              /* inizio ciclo perpetuo            */
		drive(heading, 80);    /* percorre il lato indicato da heading */
		startscan = heading - 60; /* controlla un settore di 65 gradi */
		endscan = heading + 5;    /* partendo alla destra del robot e */
		scandir = startscan;    /* terminando 5 grd. alla sua sinistra */
		while ( (heading == 270 && loc_y() > 100) ||  /* controlla l'avvicinamento al      */
		(heading == 180 && loc_x() > 100) ||  /* muro perpendicolare per prevenire */
		(heading == 90 && loc_y() < 900) ||  /* l'urto                            */
		(heading == 360 && loc_x() < 900) ) {
			if (range = scan(scandir, 5)) 
				cannon(scandir, range); /* se rileva qualcosa, spara           */

			if (scandir == endscan) 
				scandir = startscan;        /* se ha finito un settore, ricomincia */
			else 
				scandir += 5;                                  /* incrementa dir.ne di scanning       */
		}
		drive(heading, 20);                        /* muro vinino: rallenta e */
		while ( (heading == 270 && loc_y() >  40) || /* finche' ci si trova ad  */
		(heading == 180 && loc_x() >  40) || /* una distanza magg.re di */
		(heading == 90 && loc_y() < 960) || /* 40...                   */
		(heading == 360 && loc_x() < 960) ) {
			if (range = scan(scandir, 5)) 
				cannon(scandir, range);  /* spara a qualsiasi oggetto */

			if (scandir == endscan) 
				scandir = startscan;           /* vicino all'angolo.        */
			else 
				scandir += 5;
		}
		turn(); /* a distanza min.re di 40 gira senza fermarti */
	}
}


/* questa routine esamina la direzione attuale e      */
/* calcola la prossima da seguire in modo da scorrere */
/* in senso orario sui muri                           */
turn() 
{
	if (heading == 270) 
		heading = 180;
	else if (heading == 180) 
		heading = 90;
	else if (heading == 90) 
		heading = 360;
	else if (heading == 360) 
		heading = 270;
}


/* quest'altra routine provvede affinche' il robot si */
/* porti il pi— velocemente possibile in prossimit…   */
/* del muro est a meno che  non si trovi gi… in tale  */
/* posizione.                                         */

go_east_wall() 
{
	if (loc_x() < 900 ) {
		drive(360, 100);
		while (loc_x() < 960)
			;
		drive(360, 0);
		while (speed())
			;
	}
	if (loc_y() < 20) 
		heading = 180;
	else 
		heading = 270;
}


