/* Robot CRAZY per CROBOTS */

/*       
          Autore: Ottavio Risolia
   Codice McLink: MC7163
*/


int	direzione;                                       /* direzione marcia */


/* main */
main()
{
	int	inrange;                                   /* e' nel campo di mira */
	int	dir;                                          /* direzione ricerca */
	int	danno;                                             /* totale danno */

	direzione = 0;
	danno = damage();                                     /* danno attuale */
	dir = 0;                                      /* direzione di partenza */

	centro();                              /* portarsi al centro del campo */
	while (danno < 100) {                              /* finche possibile */
		while (dir < 359) {                           /* ricerca a 360 gradi */
			inrange = scan(dir, 10);                          /* ricerca nemico */
			if (inrange <= 800 && inrange > 0) {
				while (inrange > 0) {                    /* finche' e' sottotiro */
					cannon(dir, inrange);                                 /* spara */
					inrange = scan(dir, 1);                      /* ricerca ancora */
					inrange = 0;                                 /* ferma attacco */
				}
			}
			dir += 20;                          /* incremento angolo scansione */
			danno = damage();                                  /* danni subiti */
			muovi();                                         /* muovi il robot */
		}
		if (dir >= 359) 
			dir = 0;             /* riparte la scansione da zero */
	}
}  /* fine main */



/* funzione movimento del robot */
muovi()
{
	if (loc_x() > 700)       /* muoversi costantemente e orizontalmente */
		direzione = 180;
	if (loc_x() < 200)
		direzione = 0;
	drive(direzione, 100);                          /* velocita' massima */
}  /* fine muovi */


/* funzione che porta il robot al centro del campo */
centro()
{
	if (loc_y() < 500) {
		drive(90, 70);               /* portarsi al centro.. */
		while (loc_y() - 500 < 20 && speed() > 0)
			;  /* .. e fermarsi vicino */
	} else {
		drive(270, 70);
		while (loc_y() - 500 > 20 && speed() > 0) 
			;
	}
	drive(0, 0);
}


