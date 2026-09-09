/*           CROBOT              */

/*            666.r              */

/*      di Antonio Montese       */
/*           13/09/92            */


int	corner, d, ssc, esc, dir1, dir2;

main()

{
	int	range, s, i;
	while (1) {
		i = 3;
		newcorner();                      /* Cambia angolo nel campo di battaglia */
		d = damage();
		s = ssc;
		while (!(d - damage()) && i)                         /* Ripete per 3 volte  */ {                                                 /* lo scan dei 90 gradi*/
			range = scan(s, 3);                                 /* a meno che          */
			while (!(d - damage()) && range && range <= 700)     /* non viene colpito.  */ {
				cannon(s, range);                               /* Se trova un nemico  */
				if (range = scan(dir1 + 3, 3)) 
					s = dir1 = dir1 + 8;       /* gli spara seguendo  */
					/* i suoi movimenti.   */
				else if (range = scan(dir2 + 357, 3)) 
					s = dir2 = dir2 + 352;
			}
			s += 6;                                            /* Step dello SCAN     */
			if (s > esc) {
				s = ssc; 
				i -= 1;
			}
		}
	}
}


newcorner()
{
	int	xp, yp;
	int	rotazione, range;
	int	OK, oldcorner, vers, dirs, offs;
	OK = 0;
	oldcorner = corner;
	vers = 60;
	offs = 6;
	while (!OK) {
		corner = (corner + 3) % 4;        /* Sceglie l'angolo successivo          */
		/* L'angolo scelto sara' accettato solo */
		/* se nella posizione di destinazione   */
		/* non ci sono nemici gia' appostati.   */
		/* Cio' viene indicato dal flag OK      */
		if ( corner == 0 ) {
			yp = 12;                                /* Coordinate dell'angolo        */
			xp = 12;
			rotazione = angolo_rotazione(xp, yp);
			ssc = 350;                             /* Angolo iniziale SCAN          */
			esc = 460;                             /* Angolo finale SCAN            */
			if (!(scan(rotazione, 6))) { 
				OK = 1;                               /* viene settato il flag OK      */
				if ((oldcorner == 3) || (oldcorner == 2)) {
					vers = 300;                      /* A seconda dell'angolo di          */
					offs = 354;                      /* provrnienza, vengono aggiornati   */
				}                               /* i parametri da usare nello SCAN   */
				if (oldcorner == 2) {                               /* e la posizione di destinazione    */
					rotazione -= 7;                  /* nel caso di spostamento diagonale.*/
					yp += 200;                       /* Cio' assicura maggiore precisione */
					ssc = 260;                       /* e potenza di fuoco                */
				}
			}
		}


		if ( corner == 1 ) {
			yp = 988;
			xp = 12;
			rotazione = angolo_rotazione(xp, yp);
			ssc = 260;
			esc = 370;
			if (!(scan(rotazione, 6))) {
				OK = 1;
				if ((oldcorner == 0) || (oldcorner == 3)) {
					vers = 300;
					offs = 354;
				}
				if (oldcorner == 3) {
					rotazione -= 7;
					xp += 200;
					ssc = 175;
				}
			}
		}


		if ( corner == 2 ) {
			yp = 988;
			xp = 988;
			rotazione = angolo_rotazione(xp, yp);
			ssc = 170;
			esc = 280;
			if (!(scan(rotazione, 6))) {
				OK = 1;
				if ((oldcorner == 1) || (oldcorner == 0)) {
					vers = 300;
					offs = 354;
				}
				if (oldcorner == 0) {
					rotazione -= 7;
					yp -= 200;
					ssc = 80;
				}
			}
		}


		if ( corner == 3 ) {
			yp = 12;
			xp = 988;
			rotazione = angolo_rotazione(xp, yp);
			ssc = 80;
			esc = 190;
			if (!(scan(rotazione + 358, 6))) {
				OK = 1;
				if ((oldcorner == 2) || (oldcorner == 1)) {
					vers = 300;
					offs = 354;
				}
				if (oldcorner == 1) {
					rotazione -= 7;
					xp -= 200;
					ssc = 0;
				}
			}
		}
	}

	dirs = rotazione + vers;                /* Direzione dello SCAN.                */
	drive(rotazione, 100);               /* Si muove alla massima velocita       */
	dir1 = dir2 = dirs;                     /* verso l'angolo prescelto.            */

	while (distanza(loc_x(), loc_y(), xp, yp) > 100 && speed()) {                                                    /* Durante lo         */
		range = scan(dirs, 2);                                 /* spostamento        */
		if (range && range <= 700) 
			cannon(dirs + 359, range);  /* intercetta i nemici*/
		if (range = scan(dir1 + offs, 3)) 
			dirs = dir1 = dir1 + offs;   /* e li segue sparando*/
		if (range = scan(dir2, 4)) 
			dirs = dir2;
	}

	drive(rotazione, 10);                                      /* Vicino al     */
	while (distanza(loc_x(), loc_y(), xp, yp) > 13 && speed())
		;  /* bordo rallenta*/
	drive(rotazione, 0);                                       /* e poi si ferma*/
}


/* formula di pitagora */
distanza(x1, y1, x2, y2)
int	x1;
int	y1;
int	x2;
int	y2;
{
	int	x, y;

	x = x1 - x2;
	y = y1 - y2;
	d = sqrt((x * x) + (y * y));
	return(d);
}


/* Calcola l'angolo di rotazione */

angolo_rotazione(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;                      /* Scala per funzioni trigonometriche */
	curx = loc_x();                      /* Restituisce la posizione corrente  */
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	if (x == 0) {                          /* x = 0, allora va a Nord o a Sud  */
		if (yy > cury)
			d = 90;                            /* Nord                             */

		else
			d = 270;                           /* Sud                              */
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);      /* Sud-Est, quadrante 4        */
			else
				d = 180 + atan((scale * y) / x);      /* Sud-Ovest, quadrante 3      */
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);            /* Nord-Est, quadrante 1       */
			else
				d = 180 + atan((scale * y) / x);      /* Nord-Ovest, quadrante 2     */
		}
	}
	return (d);
}


