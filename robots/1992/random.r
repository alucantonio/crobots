/*

   ROBOT         :Random.R
   
   PROGRAMMATORE :Mattia Rossi 
*/




/* Il robot ha un comportamento casuale al massimo: si muove a caso per tutto
   il campo di battaglia cercando bersagli da colpire.
   La routine di fuoco e' minimizzata al massimo per permettere un alto 
   volume di fuoco                                                           */


int	dir, direz  ;


main()
{
	dir = 0;

	while ( 1 ) {


		direz = plot_course ( rand(1000) , rand(1000) ); /* sceglie una direzione
				                                                    a caso               */

		drive ( direz , 100 );                            /* vi si dirige alla 
				                                                    massima velocita'    */


		while (loc_x() > 150 && loc_y() > 150 && loc_y() < 850 && loc_x() < 850 ) {


			drive (direz, 100);
			cerca()          ;                       /* Routine di ricerca e 
						                                            di fuoco            */

		}

		drive(direz, 50);                                 /* Quando e' vicino al 
								    margine riduce la sua
								    velocita' per poter
										    girare              */

	}

}






/* La routine di ricerca e' un semplice scan circolare del campo di battaglia
   Viene eseguita un numero finito di volte e poi sospesa per poter controlla_
   re la posizione del robot ed evitare che vada a sbattere                  */




cerca()
{
	int	range , cycle , cycle1;

	cycle = 0;


	while (cycle < 2 ) {


		cycle1 = 0;


		/* Cerca un Robor, Angolo di 10 gradi */


		if (range = scan(dir, 10)) {


			cannon(dir + 3 , 7 * range / 8 ); /* spara! ( Jazz insegna )*/

			dir  -= 3 ;


			/* Esegue uno scan pi— preciso */


			while (cycle1 < 10 ) {


				range = scan(dir , 3);   /* cerca in una direzione, angolo di 10 gradi */

				if (range > 70 )         /* piu' vicino mi faccio male anch'io         */ {


					cannon(dir , 7 * range / 8 ); /* spara! */

					dir  -= 8 ;


				}

				dir += 5 ;
				cycle1 +=  1  ;

			}

		}
		dir += 10;
		cycle += 1 ;
	}


}


/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;  /* scale for trig functions */
	curx = loc_x();  /* get current location */
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	/* atan only returns -90 to +90, so figure out how to use */
	/* the atan() value */

	if (x == 0) {      /* x is zero, we either move due north or south */
		if (yy > cury)
			d = 90;        /* north */
		else
			d = 270;       /* south */
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
			else
				d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);        /* north-east, quadrant 1 */
			else
				d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
		}
	}
	return (d);
}


