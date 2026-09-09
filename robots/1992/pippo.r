/*       Nome del robot ..........." PIPPO "                        */
/*       Autori :                                                   */
/*           Andrea Ferullo                                         */
/*           David Coen                                             */
/*       Data di realizzazione ... 28 settembre 1992                */

int	angolo;
main()
{

	int	x, y;

	/* Pippo si porta sul bordo destro del campo di gioco */

	x = loc_x();
	y = loc_y();
	while (loc_x() < 980) {
		distruggi();
		drive(0, 75);
	}

	/* Pippo si muove su e giu lungo il bordo destro sparando ai nemici */

	while (1) {
		while (loc_y() < 940) {
			distruggi();
			drive (90, 60);
		}
		while (loc_y() > 40) {
			distruggi();
			drive (270, 60);
		}
	}
}


/* Quella che segue Š la procedura di sparo */

distruggi ()
{
	if (risultato = scan(angolo, 10)) {
		cannon (angolo, (7 * risultato) / 8);
		cannon (angolo, risultato);
		angolo -= 15;
		if (angolo < 75) 
			angolo = 270;
	} else
		angolo += 15;
	if (angolo > 285) 
		angolo = 90;
}


