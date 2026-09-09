
/*                      Robot cube.r per CRobots

                              Tattica di gioco

   La tattica di questo robot non e' molto elaborata, esso punta tutto sulla
   precisione del tiro.  Il robot si muove avanti e indietro sulle diagonali
   "piccole" dello schermo: comincia su quella in alto a destra, poi, quando
   i danni raggiungono rispettivamente il 25%, 50% e 75% si sposta sulle
   altre tre diagonali.  In questo modo e' probabile che il robot resti piu'
   a lungo sulle diagonali in cui subisce meno danni.  Inoltre se il robot
   subisce consistenti danni consecutivi (piu' del 9%) cambia subito rotta
   in modo da disorientare i robot che inseguono o evitare scontri
   particolarmente nocivi.  In questo modo cube puo' andare su diagonali
   diverse da quelle previste.
   Per quanto riguarda il tiro tutto e' affidato ad un sottoprogramma
   invocato iterativamente.  Questo cerca i robot avversari e, una volta
   trovati, effettua correzioni al tiro secondo i loro spostamenti.
   Le correzioni riguardano sia l' angolo che la gittata, e dalla loro messa
   a punto dipende in modo critico l' efficienza del robot.

   Scritto da:
   Mario Gregori                                                   */


/* variabili globali */

int	sc_dir;       /* direzione dello scanner */
int	sfas;         /* sfasamento dell' angolo di fuoco */
int	oldd;         /* distanza a cui si trovava l' avversario */
int	dist;         /* distanza a cui si trova l' avversario */
int	scd2;         /* direzione di un secondo scanner */
/* (cerca avversari piu' vicini)   */
int	danni;        /* totale danni subiti */

main()
{
	sc_dir = 0;
	scd2 = 0;
	sfas = 0;
	oldd = 500;

	/* Si posiziona */
	while (loc_y() < 910) {
		drive (90, 80);
		look();
	}
	drive (90, 0);
	look();
	if (loc_x() > 550)
		while (loc_x() > 550) {
			drive (180, 80);
			look();
		}
	else
		while (loc_x() < 450) {
			drive (0, 80);
			look();
		}
	drive (0, 0);
	look();

	/* movimento alternato sulla prima diagonale */
	while (damage() < 25) {
		drive (45, 80);
		danni = damage();
		while (loc_y() < 870 && ((damage() - danni) < 9))
			look();
		drive (45, 0);
		look();

		drive (225, 80);
		danni = damage();
		while (loc_x() > 130 && ((damage() - danni) < 9))
			look();
		drive (225, 0);
		look();
	}

	/* movimento alternato sulla seconda diagonale */
	while (damage() < 50) {
		drive (135, 80);
		danni = damage();
		while ((loc_x() > 130) && (loc_y() < 870) && ((damage() - danni) < 9))
			look();
		drive (135, 0);
		look();

		drive (315, 80);
		danni = damage();
		while ((loc_y() > 130) && (loc_x() < 870) && ((damage() - danni) < 9))
			look();
		drive (315, 0);
		look();
	}

	/* movimento alternato sulla terza diagonale */
	while (damage() < 75) {
		drive (225, 80);
		danni = damage();
		while ((loc_y() > 130) && (loc_x() > 130) && ((damage() - danni) < 9))
			look();
		drive (225, 0);
		look();

		drive (45, 80);
		danni = damage();
		while ((loc_x() < 870) && (loc_y() < 870) && ((damage() - danni) < 9))
			look();
		drive (45, 0);
		look();
	}

	/* ultima diagonale... */
	while (1) {
		drive (135, 80);
		danni = damage();
		while ((loc_y() < 870) && (loc_x() > 130) && ((damage() - danni) < 9))
			look();
		drive (135, 0);
		look();

		drive (315, 80);
		danni = damage();
		while ((loc_x() < 870) && (loc_y() > 130) && ((damage() - danni) < 9))
			look();
		drive (315, 0);
		look();
	}
}


/* Si guarda intorno e spara */

look ()
{
	int	i, dist2;

	if (!(dist = scan (sc_dir, 5))) {
		if (dist = scan(sc_dir -= 10, 5))
			sfas = -6;
		else if (dist = scan(sc_dir -= 15, 10))
			sfas = -10;
		else if (dist = scan(sc_dir += 35, 5))
			sfas = 6;
		else if (dist = scan(sc_dir += 15, 10))
			sfas = 10;
		else {
			i = 10;
			while (!(dist = scan(sc_dir += 20, 10)) && (--i))
				;
			sfas = 0;
			oldd = dist;
			return;
		}
	}
	if ((dist - oldd) > 0)
		cannon(sc_dir + sfas, (dist * 15) / 13);
	else
		cannon(sc_dir + sfas, (dist * 15) / 17);
	dist2 = scan (scd2 -= 20, 10);
	if ((dist2 > 0) && (dist2 < (dist - 50))) {
		sc_dir = scd2;
		oldd = dist2;
	} else 
		oldd = dist;
}


