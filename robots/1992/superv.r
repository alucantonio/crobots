/**********************************************************************
 * DATI AUTORE di SuperV :                                            *
 *                                                                    *
 * Cognome   :  Vidali    Nome :  Matteo                              *
 **********************************************************************/



/**********************************************************************
 * Il main usa la variabile globale ang per sparare.                  *
 * Vi sono due funzioni: muovi() per il movimento romboidale e fire() *
 * per sparare.                                                       *
 **********************************************************************/

int	ang;

main()
{
	int	direz;
	direz = muovi(500, 100);  /*va al punto di partenza x=500 y=100*/
	while (1)  {
		drive(direz, 100);
		while (loc_y() > 90)  
			fire();
		direz = muovi(900, 500); /*calcola nuova traiettoria
							x=900 y=500*/
		while (speed() > 50)   
			drive(direz, 50); /*diminuisce velocit…
									per poter voltare*/
		drive(direz, 100);
		while (loc_x() < 900)  
			fire();
		direz = muovi(500, 900);  /*calcola nuova traiettoria
							 x=500 y=900*/

		while (speed() > 50)  
			drive(direz, 50);

		drive(direz, 100);
		while (loc_y() < 900)  
			fire();
		direz = muovi(100, 500);  /*calcola nuova traiettoria
							 x=100 y=500*/
		while (speed() > 50)   
			drive(direz, 50);

		drive(direz, 100);
		while (loc_x() > 90)  
			fire();
		direz = muovi(500, 100); /*torna punto di partenza*/
		while (speed() > 50)  
			drive(direz, 50);

	}

}


/**********************************************************************
 * Funzione : muovi()                                                 *
 * Questa funzione  permette il  movimento romboidale :  calcola la   * 
 * traiettoria  (gradi+ atan(coefficiente angolare))  . 100000 Š il   *
 * fattore scala.                                                     *
 **********************************************************************/

muovi(x, y)
int	x, y;
{
	int	gradi, pos_x, pos_y;

	pos_x = loc_x();   /*posizioni x y correnti*/
	pos_y = loc_y();

	if (pos_x == x)  {
		if (y < pos_y)
			gradi = 270;
		else 
			gradi = 90;
	}  else {
		if (y > pos_y)  {
			if (x > pos_x)
				gradi = atan((100000 * (pos_y - y)) / (pos_x - x));
			else
				gradi = 180 + atan((100000 * (pos_y - y)) / (pos_x - x));
		}  else if (x > pos_x)
			gradi = 360 + atan((100000 * (pos_y - y)) / (pos_x - x));
		else
			gradi = 180 + atan((100000 * (pos_y - y)) / (pos_x - x));
	}
	return(gradi);    /*ritorna gradi inclinazione*/
}


/**********************************************************************
 * Funzione : fire()                                                  *
 * Questa funzione calcola il range e spara solo se minore o uguale a *
 * 700 e se positivo.Il range Š ridotto per colpire i nemici insegui- *
 * tori e la precisione nel tiro Š aggiustata dal movimento nemico.   *
 **********************************************************************/

fire()
{
	int	range;
	range = scan(ang, 10);
	if (range <= 700  && range > 0)
		cannon(ang, 7 * range / 8);
	else 
		ang += 20; /*la scan() spazia*/
}




