/*  robot UANINO  */
/*  Ideatore : ROSSI CORRADO */

int	appo;
main()
{
	if (loc_x() < 950)  /* SPOSTAMENTO PARTE DESTRA DELLO SCHERMO */ {
		drive(0, 65);
	} else {
		drive(0, 0);  /* CONTROLLO E STOP ROBOT PRIMA DELL'URTO CONTRO MURO */
		angolo();    /* CHIAMATA FUNZIONE CHE SPOSTA ROBOT ALL'ANGOLO */
	}
}        /* FINE MAIN */


fuoco()  /* FUOCO CON SCAN */
{
	int	esiste; /* VARIABILE D'APPOGGIO CHE DA' RISULTATO DELLO SCAN */
	drive(0, 0);
	if (esiste = scan(appo, 10)) {
		cannon (appo, (7 * esiste) / 8); /* CALCOLO DEL FATTORE DI SPOSTAMENTO*/
		appo -= 35;
	} else
		appo += 22;
}


angolo()           /* MOVIMENTO DEL ROBOT VERSO UNO DEI DUE ANGOLO DX */
{
	while (loc_y() < 500) {
		drive(270, 50);
		if (loc_y() < 70) {
			drive(270, 0);
			fuoco();
		}
	}
	while (loc_y() > 500) {
		drive(90, 50);
		if (loc_y() > 930) {
			drive(90, 0);
			fuoco();
		}
	}
}


/* FINE CODICE LINUS */

