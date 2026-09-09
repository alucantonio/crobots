/*
     TRIANGOL.R Realizzato da Mauro Mezzini 
*/

int	bersaglio;
int	angolo;
int	dirscan;
main()
{
	angolo = 0;
	dirscan = 10;
	vai_al_punto (900, 100);

	while (1)                    /* Loop principale */ {
		drive(90, 100);
		while (loc_y() < 900)
			ricerca();
		drive (90, 0);
		while (speed() > 49)
			ricerca();
		drive (180, 100);
		while (loc_x() > 100)
			ricerca();
		drive (180, 0);
		while (speed() > 49)
			ricerca();
		drive (315, 100);
		while (loc_x() < 900)
			ricerca();
		drive (315, 0);
		while (speed() > 49)
			ricerca();

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
	while (speed () > 49)
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


