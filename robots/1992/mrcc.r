/*          C-Robot     MRCC	( Multi Role Combat Crobot )

        autore:                  Paolo Torda
        codice utente mclink:    MC6617
	Internet :		 MC6617@mclink.it

        strategia:
                        Il robot si  muove  lungo  il lato  destro del
                        campo di battaglia senza fermarsi mai sparando
                        a tutto cio' che vede.
                        La routine di sparo e' in grado di  accorciare
                        o allungare il tiro a  secondo se il nemico si
                        stia avvicinando o allontanando.
			se il robot capisce che il lato destro e' occupato
			da un altro nemico si sposta sull'altro lato.

*/


int	range, range1, mira, maxmira, minmira, warn, warn2, dam;
int	control, result;
main()
{
	minmira = 0;
	maxmira = 99999;

	drive(0, 100);
	while (loc_x() < 960) 
		spara();
	drive(90, 0);
	while (speed() > 49) 
		spara();

	maxmira = 270;
	minmira = 90;
	warn = 0;
	while (1) {
		drive(90, 100);                          /* vai su */

		while ((loc_y() < 900) && (speed()))
			spara();

		drive(270, 0);				/* rallenta */
		while (speed() > 49)
			spara();

		if (warn > 5)                             /* se ho nemici sullo stesso */
			inverti();			/* lato scappo */

		drive(270, 100);				/* vai giu' */
		while ((loc_y() > 100) && (speed()))
			spara();

		drive(90, 0);				/* rallenta */
		while (speed() > 49) 
			spara();

		if (warn > 5)				/* se ho nemici sullo stesso */
			inverti();			/* lato scappo */

		if (dam == damage())			/* se passa troppo tempo */
			++warn2;			/* senza che io sia colpito */
		else	/* vado in modo cruiser */		 {
			warn2 = 0;
			dam = damage();
		}

		if ((warn2 > 5) && (dam < 80))
			cruiser();
	}


}


spara()
{
	if (!range)  /* se e' la prima volta che inquadro il bersaglio */ {
		while (!(range1 = scan (mira, 10))) {
			mira += 20;
			if (mira > maxmira) {
				mira = minmira;
				return;
			}
		}

		if (range1 > 700) {	                       /* se fuori gittata lo ignoro */
			mira += 20;
			return;
		}

		cannon (mira, range1 - 30);             /* sparo corto */
		range = 1;                           /* range != 0 indica che ho gia'
		                                          inquadrato il bersaglio    */
		return;
	} 
	    else /* il bersaglio era stato gia' inquadrato in precedenza */  {

		if (range = scan(mira, 6))            /* guardo prima di fronte   */
			;
		else if (range = scan(mira + 12, 6))    /* guardo un poco piu' a sx */
			mira += 12;
		else if (range = scan(mira - 12, 6))    /* guardo un poco piu' a dx */
			mira -= 12;
		else if (range = scan(mira + 28, 10))   /* guardo ancora piu' a sx */
			mira += 28;
		else if (range = scan(mira - 28, 10))
			mira -= 28;                       /* guardo ancora piu' a dx */
		else
			return;                         /* se non lo trovo esco */

		if (range > 700) {
			range = 0;
			mira += 35;
			return;
		}

		if (range < 70)
			cannon (mira, 70);              /* per non colpirmi da solo */

		else if (range > (range1 + 20))         /* corezione di tiro */ {
			if (cannon (mira, 7 * range / 6))	/* solo se ha sparato */ {	/*controllo la presenza di nemici sullo stesso lato */
				if ( (scan(90, 10)) || (scan(270, 10)) )
					++warn;
				else
					warn = 0;
			}
		} else
		 {
			if (cannon (mira, 7 * range / 8))	/* solo se ha sparato */ {	/* controllo la presenza di nemici sullo stesso lato */
				if ( (scan(90, 10)) || (scan(270, 10)) )
					++warn;
				else
					warn = 0;
			}
		}
		range1 = range;                       /* range1 = vecchio range */
	}

}


/*
	inverti()
   questa funzione sposta il robot nell'altro lato dell'arena
   (da dx a sx o viceversa) viene chiamata se viene riscontrata
   la presenza di un nemico sullo stesso lato che si sta percorrendo
*/

inverti()
{

	if (maxmira == 270) {
		minmira = 0;
		maxmira = 99999;

		drive(180, 100);                    /* mi sposto dall'altro lato */
		while (loc_x() > 130) 
			spara();
		drive(180, 0);
		while (speed() > 49) 
			spara();

		maxmira = 450;
		minmira = 270;
	} 
	    else
	 {
		minmira = 0;
		maxmira = 99999;

		drive(0, 100);                        /* mi sposto dall'altro lato */
		while (loc_x() < 870) 
			spara();
		drive(0, 0);
		while (speed() > 49) 
			spara();

		maxmira = 270;
		minmira = 90;
	}

	warn = 0;                               /* azzero contatore di warning */
}


/*
	il robot cambia tattica, da un movimento verticale 
        costante passa ad uno diagonale. Irreversibile.
*/

cruiser()
{
	int	temp, ang;

	range = 0;
	temp = 5;
	mira = 90;
	maxmira = 99999;
	minmira = 0;

	ang = angolo (500, 500);		/* mi sposto un poco verso il centro */
	drive (ang, 100);
	while ( temp > 0) {
		spara();
		--temp;
	}

	while (speed() > 50)
		drive (ang, 30);

	ang = angolo (100, 900);

	/* mi sposto lungo la diagonale e sparo */


	while (1) {
		drive (ang, 100);
		while ( loc_x() > 150 && loc_y() < 850 && speed())
			spara();

		ang = 315;

		while (speed() > 50) {
			drive(ang, 49);
			spara();
		}

		drive (ang, 100);
		while ((loc_y() > 150) && (loc_x() < 850) && (speed()))
			spara();

		ang = 135;
		while (speed() > 50) {
			drive(ang, 49);
			spara();
		}
	}

}


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
