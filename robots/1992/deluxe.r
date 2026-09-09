/************************************************************************/
/*                                                                      */
/*                          DELUXE.R                                    */
/*                                                                      */
/*      Autore:             Perugini Gianni                             */
/*                                                                      */
/************************************************************************/

int	ang;                            /*  Variabile globale utilizzata    */
/*  per memorizzare l'angolo di     */
/*  scansione.                      */

main()                              /*  Inizio Main                     */

{
	int	x, y;                        /*  Variabili locali utilizzate     */
	/*  per memorizzare la posizione    */
	/*  del robot.                      */

	x = loc_x();                      /*  Memorizza la posizione.         */
	y = loc_y();                      /*                                  */

	if (x > 500)   {                   /*  Va nella posizione (500,y)      */
		drive(180, 100);             /*  sparando.                       */
		while (loc_x() > 550)          /*                                  */
			spara();                /*                                  */

	}                               /*                                  */ else {                       /*                                  */

		drive(0, 100);               /*                                  */
		while (loc_x() < 450)          /*                                  */
			spara();                /*                                  */

	}                               /*                                  */

	drive(90, 100);                  /*  Va nella posizione (500,920)    */
	while (loc_y() < 920)  {           /*  sparando e controllando che la  */
		if (speed() < 60)              /*  velocit… non scenda al di sotto */

			drive(90, 100);          /*  di 60.                          */
		spara();                    /*                                  */

	}                               /*                                  */


	while (1)    {                   /*  Inizio ciclo infinito           */

		drive(225, 100);             /*  Vai nella posizione (80,500)    */
		while (loc_x() > 80)  {        /*  sparando e controllando che la  */
			if (speed() < 60)          /*  velocit… non scenda al di sotto */
				drive(225, 100);     /*  di 60.                          */
			spara();                /*                                  */
		}                           /*                                  */

		drive(315, 100);             /*  Vai nella posizione (500,80)    */
		while (loc_y() > 80)   {       /*  sparando e controllando che la  */
			if (speed() < 60)          /*  velocit… non scenda al di sotto */
				drive(315, 100);     /*  di 60.                          */
			spara();                /*                                  */
		}                           /*                                  */

		drive(45, 100);              /*  Vai nella posizione (920,500)   */
		while (loc_x() < 920)   {      /*  sparando e controllando che la  */
			if (speed() < 60)          /*  velocit… non scenda al di sotto */
				drive(45, 100);      /*  di 60.                          */
			spara();                /*                                  */
		}                           /*                                  */

		drive(135, 100);             /*  Vai nella posizione (500,920)   */
		while (loc_y() < 920)  {       /*  sparando e controllando che la  */
			if (speed() < 60)          /*  velocit… non scenda al di sotto */
				drive(135, 100);     /*  di 60.                          */
			spara();                /*                                  */
		}                           /*                                  */

	}                               /*  Ripeti                          */

}                                   /*  Fine Main                       */


spara()                             /*  Inizio function Spara           */


{
	int	range;                      /*  Variabile locale utilizzata per */
	/*  memorizzare il risultato di     */
	/*  scan.                           */

	if (!(range = scan(ang, 3)))        /*  Se il nemico non Š nella        */ {/*  posizione ang ...               */

		ang -= 13;                    /*  ... decrementa ang e ...        */
		while (!(range = scan(ang, 10)))/*  ... cerca il nemico nella nuova */ {                           /*  posizione. Se non lo trova ...  */
			ang += 20;                /*  ... incrementa ang.             */
		}                           /*  Ripete fino a che non ha        */
		/*  trovato il nemico.              */
	}
	cannon(ang, 7 * range / 8);          /*  Spara.                          */

}                                   /*  Fine function spara.            */


