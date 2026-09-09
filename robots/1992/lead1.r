/*

  LEAD1.R  Realizzato da Mauro Mezzini  (MC9713 - Roma)


*/

int	bersaglio;
int	angolo;
int	cdir;
int	dirscan;
int	danno;

main()
{
	angolo = 0;
	dirscan = 20;
	cdir = init_robot();         /* Inizializza la posizione */

	/* Movimento semplice a forma di quadrato con vertici 
      i punti medi dei lati del campo di battaglia      */

	while (1)                    /* Loop principale */ {
		danno = damage();
		if (cdir == 45) {
			drive (cdir, 100);
			while (loc_x() < 930)
				ricerca();
			drive (cdir, 0);
			while (speed() > 50)
				ricerca();
			cdir = 135;
		}

		if (cdir == 135) {
			drive (cdir, 100);
			while (loc_y() < 930)
				ricerca();
			drive (cdir, 0);
			while (speed() > 50)
				ricerca();
			cdir = 225;
		}
		if (danno + 15 < damage())  /* Controlla i danni subiti    */
			svicola();               /* E' sotto torchio : svicola  */
		danno = damage();

		if (cdir == 225) {
			drive (cdir, 100);
			while (loc_x() > 80)
				ricerca();
			drive (cdir, 0);
			while (speed() > 50)
				ricerca();
			cdir = 315;
		}

		if (cdir == 315) {
			drive (cdir, 100);
			while (loc_y() > 80)
				ricerca();
			drive (cdir, 0);
			while (speed() > 50)
				ricerca();
			cdir = 45;
		}
		if (danno + 15 < damage())  /* Controlla i danni subiti */
			svicola();
	}
}


ricerca ()
{
	int	new_bers;


	if (new_bers = scan (angolo, 10))      /* scan per un bersaglio */ {
		/*fai lo scan 20 gradi a sinistra*/
		if (bersaglio = scan (angolo + 20, 10)) {/* Se trovato bersaglio anticipalo di 15 gradi */

			if (bersaglio < new_bers )    /* Il bersaglio si avvicina? */ {                             /* Si: accorcia la gittata   */
				if (!cannon (angolo + 15, 27 * bersaglio / 31))
					cannon (angolo + 15, 27 * bersaglio / 31);
			} else {                      /* No: allunga la gittata    */
				if (!cannon (angolo + 15, 31 * bersaglio / 27))
					cannon (angolo + 15, 31 * bersaglio / 27);
			}
			dirscan = 20;          /* Prosegui lo scan in quella direzione */

			return;

		} else {
			/* fai lo scan 20 gradi a destra*/
			if (bersaglio = scan (angolo - 20, 10)) {/* Se trovato bersaglio anticipalo di 15 gradi */

				if (bersaglio < new_bers )   /* Il bersaglio si avvicina?*/ {
					if (!cannon (angolo - 15, 27 * bersaglio / 31))
						cannon (angolo - 15, 27 * bersaglio / 31);
				} else {                     /* Allunga la gittata */
					if (!cannon (angolo - 15, 31 * bersaglio / 27))
						cannon (angolo - 15, 31 * bersaglio / 27);
				}
				dirscan = -20;       /* Prosegui lo scan in quella direzione */

				return;
			}
		}
		/* Il bersaglio e' piu' o meno centrale .
         Lascia la direzione di scan invariata  */
		/* Vedi se riesce a individuare con maggior precisione il bersaglio */
		if (bersaglio = scan(angolo, 5)) {
			if (bersaglio > new_bers)  /* Il bersaglio si allontana ?*/ {
				if (!cannon (angolo, 31 *  bersaglio / 27))
					cannon (angolo, 31 *  bersaglio / 27);
			} else {                   /* Accorcia la gittata */
				if (!cannon (angolo, 27 *  bersaglio / 31))
					cannon (angolo, 27 *  bersaglio / 31);
			}
			return;
		} else {
			if (!cannon (angolo ,  new_bers  ))
				cannon (angolo ,  new_bers );
		}
		return;

	} else
		angolo += dirscan;
}


svicola()
/*  Secondo l'angolo in cui si trova torna */
/*  all' angolo precedente                 */
{

	if (cdir == 45) {
		vai_al_punto(100, 500);
		cdir = 315;
	} else {
		vai_al_punto(900, 500);
		cdir =  135;
	}
}


init_robot()
/* Inizializza la posizione del robot. Viene
   eseguita solo all'inizio della battaglia */
{
	int	x, y;     /*  Posizione attuale  */
	int	xx, yy;   /*  Vertice iniziale   del percorso */
	int	d, d1;    /*  Distanze dalla posizione attuale al punto d'inizio */
	int	initdir; /*  Direzione iniziale sul percorso */

	x = loc_x();
	y = loc_y();
	xx = 500;
	yy = 50;
	initdir = 45;
	d  = distanza(x, y, xx, yy);
	d1 = distanza (x, y, 500, 950);

	if ( d  > d1 ) /* L'altro angolo e' piu' vicino? */ {

		xx = 500;   /* Si : allora sara' quello il punto d'inizio */
		yy = 950;
		initdir = 225;
		d = d1;
	}
	d1 = distanza (x, y, 950, 500);
	if (d > d1)   /* L'altro angolo e' piu' vicino? */ {

		xx = 950;  /* Si : allora sara' quello il punto d'inizio */
		yy = 500;
		initdir = 135;
		d = d1;
	}
	d1 = distanza (x, y, 50, 500);
	if (d > d1)   /* L'altro angolo e' piu' vicino? */ {

		xx = 50;   /* Si : allora sara' quello il punto d'inizio */
		yy = 500;
		initdir = 315;
	}
	vai_al_punto(xx, yy);   /* Vai al punto d'inizio */
	return (initdir);      /* Direzione iniziale da prendere */
}


vai_al_punto(xx, yy)
int	xx;
int	yy;
{
	int	d;
	ricerca();
	d = plot_course (xx, yy);

	drive (d, 100);
	while ( distanza (xx, yy, loc_x(), loc_y() ) > 50)
		ricerca();

	drive (d, 0);
	while (speed () > 50)
		ricerca();
}


/* la stessa del manuale  */

plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;
	curx = loc_x();
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	if (x == 0) {
		if (yy > cury)
			d = 90;
		else
			d = 270;
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);
			else
				d = 180 + atan((scale * y) / x);
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);
			else
				d = 180 + atan((scale * y) / x);
		}
	}
	return (d);
}


distanza (x0, y0, x1, y1)
int	x0;
int	y0;
int	x1;
int	y1;
{
	int	dx, dy;
	dx = x1 - x0;
	dy = y1 - y0;
	return (sqrt (dx * dx + dy * dy) );
}


