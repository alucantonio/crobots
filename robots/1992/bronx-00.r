/*--------------------------------------------------------*
 * Nome robot:       bronx-00.r                           *
 *                                                        *
 * Autore:           Giovanni Riccardi                    *
 *                                                        *
 *--------------------------------------------------------*/

int	angolo,         /* Angolo di fuoco del cannone */
angin,          /* Angolo iniziale del range dove il cannone puo' sparare */
angfi;          /* Angolo finale del range dove il cannone puo' sparare */

main()
{
	int	posx,
	posy;

	/*----- Il robot raggiunge la posizione iniziale */
	/*----- angolo basso sinistro dello schermo */

	if (loc_x() > 70) {
		drive(180, 100);
		angin = 90;
		angfi = 270;
		while (loc_x() > 70) 
			spara();
		drive(180, 0);
	}

	while (speed() > 49) 
		spara();

	if (loc_y() > 70) {
		drive(270, 100);
		angin = 270;
		angfi = 90;
		while (loc_y() > 70) 
			spara();
		drive(270, 0);
	}
	while (speed() > 49) 
		spara();
	/*----- Il robot ha raggiunto la posizione iniziale */

	/*----- Ciclo di battaglia */
	/*----- il robot cicla sui lati del campo di battaglia */
	while (1) {
		posx = loc_x();
		posy = loc_y();

		/*----- Lato basso del campo di battaglia */
		if (posx < 500 && posy < 500) {
			angin = 0;
			angfi = 180;
			angolo = angin;
			drive(0, 100);
			while (loc_x() < 930) 
				spara();
			drive(0, 0);
			while (speed() > 49) 
				spara();
		}
		/*----- Lato destro del campo di battaglia */
		if (posx > 500 && posy < 500) {
			angin = 90;
			angfi = 270;
			angolo = angin;
			drive(90, 100);
			while (loc_y() < 930) 
				spara();
			drive(90, 0);
			while (speed() > 49) 
				spara();
		}
		/*----- Lato alto del campo di battaglia */
		if (posx > 500 && posy > 500) {
			angin = 180;
			angfi = 359;
			angolo = angin;
			drive(180, 100);
			while (loc_x() > 70) 
				spara();
			drive(180, 0);
			while (speed() > 49) 
				spara();
		}
		/*----- Lato sinistro del campo di battaglia */
		if (posx < 500 && posy > 500) {
			angin = 270;
			angfi = 90;
			angolo = angin;
			drive(270, 100);
			while (loc_y() > 70) 
				spara();
			drive(270, 0);
			while (speed() > 49) 
				spara();
		}
	}
}


/*----- fine main */

/*---------------------------------------------------*
 * Questa e' la funzione che permette al robot       *
 * di sparare al nemico.                             *
 * Una delle qualita' di questa funzione, e' che     *
 * spara colpi multipli, cio' permette di colpire    *
 * i nemici anche se questi si trovano in movimento  *
 *---------------------------------------------------*/
spara()
{
	int	raggio;
	if (raggio = scan(angolo, 10)) {
		/*----- Colpo multiplo per colpire nemici in movimento */
		cannon(angolo, raggio  * (8 / 7));
		cannon(angolo, raggio);
		cannon(angolo, (raggio * 7) / 8);
	} else
	 {
		angolo += 20;
		if (angolo > 359 && angfi != 359)
			angolo = 0;
		else if (angin < angfi)
			if (angolo > angfi)
				angolo = angin;
			else if (angolo > angfi && angolo < angin)
				angolo = angin;
	}
}


/*----- Fine bronx-00.r */
