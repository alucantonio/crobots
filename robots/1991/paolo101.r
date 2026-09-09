/*	crobot della serie	   paolo10			*/
/*	versione :	1					*/
/*	nome paolo100.r						*/
/*								*/
/*      autore : 	Paolo Torda  	( MC6617 )		*/


int	angolo;	/* variabile usata per lo scan dell'area di battaglia */

main()
{

	/* mi sposto ad un alto */

	drive(0, 100);
	while (loc_x() < 960) 
		bomb1();
	drive(0, 0);
	while (speed() > 49) 
		bomb2();

	angolo = 270;

	/*  inizia ora il loop principale con movimenti verticali */
	while (1) {
		drive(90, 100);		/* spostamento in alto */
		while (loc_y() < 920) 
			bomb2();

		drive(90, 40);		/* attesa che la velocita' scenda */
		while (speed() > 49) 
			bomb3();

		drive(270, 100);		/* spostamento in basso */
		while (loc_y() > 80) 
			bomb2();

		drive(270, 40);		/* attesa che la velocita' scenda */
		while (speed() > 49) 
			bomb4();
	}
	/* fine loop principale */

}


/* 
	funzione di sparo Nr. 1 : 
	spara a 360 gradi utilizzata mentre ci si sposta al lato 
*/
bomb1()
{
	int	distanza;

	if ((distanza = scan(angolo, 10)) && (distanza < 700)) {
		cannon(angolo, distanza);
		angolo -= 20;
	} else
	 {
		angolo += 20;
	}
}


/* 
	funzione di sparo Nr. 2 :
	spara da 90 a 270 gradi quando il robot si trova al lato.  
*/
bomb2()
{
	int	distanza;

	if ((distanza = scan(angolo, 10)) && (distanza < 700) ) {
		cannon(angolo, distanza);
		angolo += 20;
	} else
	 {
		angolo -= 20;
		if (angolo <= 70) 
			angolo = 270;
	}
}


/* 
	funzione di sparo Nr. 3 :
	spara da  180 a 270 gradi utilizzata quando il robot si trova
	nell'angolo superiore destro.
*/
bomb3()
{
	int	distanza;

	if ((distanza = scan(angolo, 10)) && (distanza < 700)) {
		cannon(angolo, distanza);
		angolo += 20;
	} else
	 {
		angolo -= 20;
		if (angolo <= 160) 
			angolo = 270;
	}
}


/* 
	funzione di sparo Nr. 1 : 
	spara da  180 a 90 gradi utilizzata quando il robot si trova
	nell'angolo inferiore destro.
*/
bomb4()
{
	int	distanza;

	if ((distanza = scan(angolo, 10)) && (distanza < 700)) {
		cannon(angolo, distanza);
		angolo += 20;
	} else
	 {
		angolo -= 20;
		if (angolo <= 70) 
			angolo = 180;
	}
}


