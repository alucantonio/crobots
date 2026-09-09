/*---------------------------------------------------------------------*/
/*      File        : Nexus_2.r                                        */
/*      Serie       : NEXUS                                            */
/*      Livello     : 2                                                */
/*      Autore      : Vincenzo Benincasa                               */
/*---------------------------------------------------------------------*/

int	c, d, ang, oang, range, orange, dir;

main()
{

	drive(180, 100);                 /* Vai a sinistra */
	while (loc_x() > 170)
		;
	drive(0, 0);
	while (speed() > 49)
		;
	drive(dir = 90, 100);

	d = 100;
	while (d > damage()) {
		d = damage() + 6;             /* Valore soglia dei danni       */
		if (range = scan(ang, 8)) {    /* C'e' qualcosa in vista...     */
			oang = ang;        /* Sistema di puntamento         */
			orange = range;
			ang += 4 - (scan(ang - 4, 4) != 0) * 8;
			ang += 2 - (scan(ang - 2, 2) != 0) * 4;
			ang += 1 - (scan(ang - 1, 1) != 0) * 2;
			if (range = scan(ang, 10)) {
				if (range > 40)  /*         SPARA !!!             */
					cannon(ang + ang - oang, range + range - orange);
				else
					cannon(ang, 46);
			}
		} else 
			ang += 16;        /* Continua lo scan del campo di  */
		/* battaglia                      */

		/* Se sei vicino ai bordi inverti la marcia                 */
		if ((dir == 90 && loc_y() > 800) || (dir == 270 && loc_y() < 200)) {
			drive(dir += 180, 0);
			while (speed() > 49)
				;
			drive(dir %= 360, 100);
		}

	}

	/* Se troppo molestato cambia tattica e ATTACCA !!         */

	while (1) {
		while ((range = scan(ang += 19, 10)) == 0)
			;     /* Cerca il target */

		c = 0;
		while (c < 3) {
			while (range = scan(ang, 5)) {
				spara();
				c = 0;
			}
			++c;
			if (c == 1) 
				ang += 180;                  /* Guarda dietro  */
			if (c == 2) 
				ang += 170;                  /* Guarda a -10ø  */
		}
	}
}



spara()
{
	if (range > 40)
		cannon(ang, range);
	else
		cannon(ang, 50);

	drive(ang, 100);

}


