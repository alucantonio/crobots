/*                      C-Robot     Paolo.r

        autore:                  Paolo Torda
        codice utente mclink:    MC6617

        strategia:
                        Il robot si  muove lungo  una diagonale senza
                        fermarsi mai  sparando a tutto cio' che vede.
                        La routine di sparo e' in grado di accorciare
                        o allungare il tiro a secondo se il nemico si
                        stia avvicinando o allontanando.

*/



int	mira, range, range1, ang;

main()
{
	int	temp;

	/* INIZIO PROGRAMMA */
	/* - - - - - - - - - - - - - - - - - - - - - */
	/* fase iniziale mi sposto un poco verso il centro */
	range = 0;
	temp = 5;
	mira = 90;
	ang = angolo (500, 500);
	drive (ang, 100);
	while ( temp > 0) {
		spara();
		--temp;
	}

	while (speed() > 50)
		drive (ang, 30);

	ang = angolo (100, 900);
	/* fine fase iniziale */
	/* - - - - - - - - - - - - - - - - - - - - - */



	/* 2 fase */
	/* - - - - - - - - - - - - - - - - - - - - - */
	/* mi sposto lungo la diagonale e sparo */


	while (1) {
		drive (ang, 100);
		while ( loc_x() > 110 && loc_y() < 890 && speed())
			spara();

		ang = 315;

		while (speed() > 50) {
			drive(ang, 49);
			spara();
		}

		drive (ang, 100);
		while ((loc_y() > 110) && (loc_x() < 890) && (speed()))
			spara();

		ang = 135;
		while (speed() > 50) {
			drive(ang, 49);
			spara();
		}
	}

}


/* fine 2 fase */
/* - - - - - - - - - - - - - - - - - - - - - */


/* questa funzione calcola l'angolo che c'e' 
   tra la posizione attuale del robot e il punto xx yy */

angolo(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	curx;

	curx = loc_x();
	x = curx - xx;
	y = (loc_y() - yy) * 100000;

	if (xx > curx)
		d = 360 + atan(y / x);
	else
		d = 180 + atan(y / x);

	return (d);
}


/* - - - - - - - - - - - - - - - - - - - - - */

/* subroutine di sparo */
spara()
{
	if (!range)  /* se e' la prima volta che inquadro il bersaglio range = 0 */ {
		while (!(range1 = scan (mira, 10)))
			mira += 20;                      /* cerca fino a che non lo inquadra */

		if (range1 > 700)                      /* se fuori gittata lo ignoro */
			return;

		cannon (mira, range1 - 30);             /* sparo corto */
		range = 1;                           /* range != 0 indica che ho gia'
		                                          inquadrato il bersaglio    */
		return;
	} 
	    else /* il bersaglio era stato gia' inquadrato in precedenza */  {

		if (range = scan(mira, 6))            /* guardo prima di fronte   */
			;
		else if (range = scan(mira + 12, 6))    /* guardo un poco piu' a sx */
			mira += 14;
		else if (range = scan(mira - 12, 6))    /* guardo un poco piu' a dx */
			mira -= 14;
		else if (range = scan(mira + 28, 10))   /* guardo ancora piu' a sx */
			mira += 30;
		else if (range = scan(mira - 28, 10))
			mira -= 30;                       /* guardo ancora piu' a dx */
		else
		 {
			mira += 35;
			return;                         /* se non lo trovo esco */
		}

		if (range < 70)
			cannon (mira, 70);              /* per non colpirmi da solo */

		else if (range > (range1 + 20))         /* corezione di tiro */
			cannon (mira, 7 * range / 6);

		else
			cannon (mira, 7 * range / 8);

		range1 = range;                       /* range1 = vecchio range */
	}

}


