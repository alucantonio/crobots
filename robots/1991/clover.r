/*

             >>> clover <<<

          crobot a quadrifoglio

    by Enrico Colombini, Novembre 1991

*/



/* variabili: */

int	dir;											/*direzione corrente*/
int	at, bt;											/*angoli bersagli*/
int	dt;												/*distanza bersaglio*/
int	deltas;											/*delta in scansione lato*/
int	atmax;											/*angolo massimo per Lato*/
int	ngiri, n, d;



/* --- sezione strategica ------------------------------------------------ */


main()
{
	if ((n = rand(4)) == 0) {                       /*estrae lato iniziale*/
		Nord(940);									/*si posiziona*/
		if (loc_x() > 600) { 
			Ovest(400); 
		}
	} else if (n == 1) {
		Ovest(60);
		if (loc_y() > 600) { 
			Sud(400); 
		}
		LatoOvest();
		LatoSud();
		LatoEst();
	} else if (n == 2) {
		Sud(60);
		if (loc_x() < 400) { 
			Est(600); 
		}
		LatoSud();
		LatoEst();
	} else {
		Est(940);
		if (loc_y() < 600) { 
			Nord(600); 
		}
		LatoEst();
	}

	while (1) {                                    	/*ciclo principale*/
		LatoNord();
		LatoOvest();
		LatoSud();
		LatoEst();
	}
}


/* LatoNord: fa il lato nord per n volte, salvo danni, poi passa ad ovest */

LatoNord()
{
	n = 3; 
	d = damage();
	Est(800);
	while (damage() - d < 16 && --n) { 
		Ovest(200); 
		Est(800); 
	}
	Vai(225);
	while (loc_x() > 50 && speed()) { 
		Diag(); 
	}
}


/* LatoOvest: fa il lato ovest per n volte, salvo danni, poi passa a sud */

LatoOvest()
{
	n = 3; 
	d = damage();
	Nord(800);
	while (damage() - d < 16 && --n) { 
		Sud(200); 
		Nord(800); 
	}
	Vai(315);
	while (loc_y() > 50 && speed()) { 
		Diag(); 
	}
}


/* LatoSud: fa il lato sud per n volte, salvo danni, poi passa ad est */

LatoSud()
{
	n = 3; 
	d = damage();
	Ovest(200);
	while (damage() - d < 16 && --n) { 
		Est(800); 
		Ovest(200); 
	}
	Vai(45);
	while (loc_x() < 950 && speed()) { 
		Diag(); 
	}
}


/* LatoEst: fa il lato est per n volte, salvo danni, poi passa a nord */

LatoEst()
{
	n = 3; 
	d = damage();
	Sud(200);
	while (damage() - d < 16 && --n) { 
		Nord(800); 
		Sud(200); 
	}
	Vai(135);
	while (loc_y() < 950 && speed()) { 
		Diag(); 
	}
}



/* --- sezione tattica --------------------------------------------------- */


/* Vai: si gira nella direzione indicata */

Vai(d)
{
	drive(d, 0);										/*spegne il motore*/
	while (speed() > 50) {
	}							/*aspetta di poter girare*/
	drive(d, 100);									/*riparte a tutta birra*/
	at = bt = d + 360;								/*prepara scansione*/
	atmax = at + 10;
}


/* Nord: va a nord fino alla y data */

Nord(y)
int	y;
{
	Vai(90);
	if (scan(90, 10) || scan(270, 10)) {				/*sceglie routine*/
		while (loc_y() < y && speed()) { 
			Lato(); 
		}
	} else {
		while (loc_y() < y && speed()) {
			if (dt = scan(at, 8)) {      			/*scan verso destra*/
				cannon(at, dt);
			} else {                                /*non trovato, avanza*/
				at -= 14;
			}
			if (dt = scan(bt, 8)) {                  /*scan verso sinistra*/
				cannon(bt, dt);
			} else {                                /*non trovato, avanza*/
				bt += 14;
			}
		}
	}
}


/* Sud: va a sud fino alla y data */

Sud(y)
int	y;
{
	Vai(270);
	if (scan(270, 10) || scan(90, 10)) {
		while (loc_y() > y && speed()) { 
			Lato(); 
		}
	} else {
		while (loc_y() > y && speed()) {
			if (dt = scan(at, 8)) {
				cannon(at, dt);
			} else {
				at -= 14;
			}
			if (dt = scan(bt, 8)) {
				cannon(bt, dt);
			} else {
				bt += 14;
			}
		}
	}
}


/* Est: va ad est fino alla x data */

Est(x)
int	x;
{
	Vai(0);
	if (scan(0, 10) || scan(180, 10)) {
		while (loc_x() < x && speed()) { 
			Lato(); 
		}
	} else {
		while (loc_x() < x && speed()) {
			if (dt = scan(at, 8)) {
				cannon(at, dt);
			} else {
				at -= 14;
			}
			if (dt = scan(bt, 8)) {
				cannon(bt, dt);
			} else {
				bt += 14;
			}
		}
	}
}


/* Ovest: va ad ovest fino alla x data */

Ovest(x)
int	x;
{
	Vai(180);
	if (scan(180, 10) || scan(0, 10)) {
		while (loc_x() > x && speed()) { 
			Lato(); 
		}
	} else {
		while (loc_x() > x && speed()) {
			if (dt = scan(at, 8)) {
				cannon(at, dt);
			} else {
				at -= 14;
			}
			if (dt = scan(bt, 8)) {
				cannon(bt, dt);
			} else {
				bt += 14;
			}
		}
	}
}


/* Diag: movimento diagonale o generico, cerca bersaglio sui due lati */

Diag()
{
	dt = scan(at, 8);
	if (dt && dt < 500) {      						/*scan verso destra*/
		cannon(at, dt);
	} else {                                   		/*non trovato, avanza*/
		at -= 14;
	}
	dt = scan(bt, 8);
	if (dt && dt < 500) {                         	/*scan verso sinistra*/
		cannon(bt, dt);
	} else {                                       	/*non trovato, avanza*/
		bt += 14;
	}
}


/* Lato: spara con mira accurata ai robot che si muovono sullo stesso lato */

Lato()
{
	dt = scan(at, 3);
	if (dt) {										/*se vede qualcuno davanti*/
		deltas = scan(at, 10) - dt;                 	/*valuta movimento*/
		cannon(at, (500 * dt) / (440 - deltas * 14));    	/*spara dove lo prevede*/
	} else {
		dt = scan((bt = at + 180), 3);	           		/*idem all'indietro*/
		if (dt) {
			deltas = scan(bt, 10) - dt;
			cannon(bt, (500 * dt) / (560 - deltas * 14));
		} else {									/*bersaglio non trovato*/
			if ((at += 5) > atmax) { 
				at -= 25; 
			}  	/*prepara nuova scansione*/
		}
	}
}


/* Note:
	14 = fattore di velocita' bersaglio (per v = 100, deltas = 7)
    deltas*14 = velocita' assoluta bersaglio
    500 = velocita' assoluta proiettile
    500-(deltas*14) = velocita' proiettile relativa al bersaglio
    440,460: compensazioni empiriche per tempo trascorso e varie
*/
