/* Realizzato da :   Brunetti Andrea*/

int	as;              /* dichiarazione della variabile 'as' usata nella */
/* procedura 'spara'                              */
main()
{
	loc_x();
	loc_y();
	while (loc_x() >= 205) /* coordinata per il movimento nello schermo      */ {
		spara();           /* richiamo della procedura di fuoco              */
		drive(180, 100);    /* movimento del robot con angolo di 180 a velo-  */
		/* cit… massima (100)                             */
	}
	while (loc_y() >= 150) {
		spara();
		drive(270, 100);
	}
	while ((loc_x() <= 825) && (loc_y() <= 835)) {
		spara();
		drive(45, 100);
	}
}


spara()                  /* inizio procedura di fuoco                  */
{
	int	result;             /* dichiarazione variabile interna 'result'   */
	if (result = scan(as, 10)) /* 'result' aquisisce il risultato del valore */ {/* della 'scan' formata da angolo & variazione*/

		cannon(as, result);     /* fuoco!                                     */
		as -= 35;                /* variazione angolo di fuoco di -35 gradi    */
	} else
		as += 20;                /* seconda variazione dell'angolo di fuoco di */
	/* +20 gradi                                  */
}


