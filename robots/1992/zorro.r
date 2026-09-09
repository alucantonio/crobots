/*  ZORRO         */
/*                */
/*  Vincenzi Massimo - MC7729 */
/*                */
/*                */
int	range;             /* range per cannon() */
int	angle;             /* angolo di scansione */
int	count;             /* contatore per attack() */
int	resolution;        /* angolo di risoluzione standard */
int	var;               /* angolo di risoluzione variabile */
int	incremento;        /* gap di gradi "saltati" dallo scan */

main()
{
	int	border;          /* distanza dal bordo prima di fermarsi */
	incremento = 5;
	angle = 0;
	resolution = 10;
	var = resolution;
	border = 80;

	/* Il robot cerca di portarsi nell'angolo in alto a sinistra */

	/* Si muove alla massima velocita' verso sinistra */
	drive (180, 100);
	while (loc_x() > border && speed() > 0 ) 
		attack(0);
	drive (180, 0);
	while (speed() > 49) 
		attack(0);

	/* Si porta verso l'alto */
	drive (90, 100);
	while (loc_y() < 1000 - border && speed() > 0 ) 
		attack(0);
	drive (90, 0);
	while (speed() > 49) 
		attack(0);



	/* Ora comincia a muoversi secondo la Z ... di Zorro !!! */
	while (1) {

		drive (0, 100);
		while (loc_x() < 1000 - border && speed() > 0 ) 
			attack(45);
		drive (0, 0);
		while (speed() > 49) 
			attack(45);

		drive (225, 100);
		while (loc_x() > border && loc_y() > border && speed() > 0 ) 
			attack(0);
		drive (225, 0);
		while (speed() > 49) 
			attack(0);

		drive (0, 100);
		while (loc_x() < 1000 - border && speed() > 0 ) 
			attack(45);
		drive (0, 0);
		while (speed() > 49) 
			attack(45);

		drive (180, 100);
		while (loc_x() > border && speed() > 0 ) 
			attack(225);
		drive (180, 0);
		while (speed() > 49) 
			attack(225);

		drive (45, 100);
		while (loc_x() < 1000 - border && loc_y() < 1000 - border && speed() > 0 ) 
			attack(0);
		drive (45, 0);
		while (speed() > 49) 
			attack(0);

		drive (180, 100);
		while (loc_x() > border && speed() > 0 ) 
			attack(225);
		drive (180, 0);
		while (speed() > 49) 
			attack(225);
	};
}


attack(limit)
int	limit;    /* angolo di partenza in cui non effettuare lo scan */
{
	int	cannon_yet;
	angle += 2 * var + incremento;   /* calcola l'angolo di scansione */
	cannon_yet = 0;
	/* controlla che l'angolo sia corretto */
	if (limit != 0 && angle % 360 > limit && angle % 360 < limit + 900) 
		angle += 90;
	/* esegue lo scan */
	while (!cannon_yet && (range = scan(angle, var )) > 0 ) {
		/* spara solo se non troppo lontano ne' troppo vicino */
		if (range < 500 && range > 20) {
			cannon_yet = cannon(angle, range);
		} else 
			cannon_yet = 1; 
	}
	/* se c'e' un robot nell'angolo di scansione diminuisce la risoluzione
         e riprova */
	if (cannon_yet)  {
		if (var == 10)
			incremento = 0;
		if (var > 1) {
			var >>= 1;
			angle -= 4 * var;
			count = 0;          
		} else {
			angle -= 2 * var;
			count = 3;    
		}
	} else {
		if ((++count) == 5) { 
			var = resolution;
			incremento = 5;
		}
	}

}


