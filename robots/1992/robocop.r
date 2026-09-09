/* ROBOCOP.R   di Gianni LIVOLSI   MC6087  */


int	ang;
main()
{
	ang = 90;

	drive(0, 100);                    /* si sposta sul lato destro     */
	while (loc_x() < 960) 
		spara();      /* sparando se trova un bersaglio*/
	drive(90, 0);
	while (speed() > 49) 
		spara();

	while (1) {                                               /* continua a muoversi   */
		drive(90, 100);                             /* lungo il lato  destro */
		while (loc_y() < 920 && speed() > 0) 
			spara();   /* sparando ad eventuali */
		drive(270, 0);                              /* bersagli              */

		while (speed() > 49) 
			spara();

		drive(270, 100);
		while (loc_y() > 80 && speed() > 0) 
			spara();
		drive(90, 0);

		while (speed() > 49) 
			spara();
	}

}


/* esegue scansione del campo alla massima  */
spara()
{                       /* risoluzione se trova un bersaglio chiama */
	int	re;                        /* la funzione gun per ottimizzare il tiro  */
	re = scan(ang, 10);               /* altrimenti incrementa l'angolo           */
	if (re > 0 && re < 700)             /* viene eseguita la ricerca dei bersagli   */
		gun(ang);                    /* solo nei 180 gradi da 90 a 270 visto che */
	else /* muovendosi lungo il lato destro ha le    */   {                           /* spalle coperte dal bordo del campo       */
		ang += 20;
		if (ang == 290) 
			ang = 90;
	}
}




gun(an)                        /* con un algoritmo simile ad una ricerca  */
int	an;                        /* dicotomica viene aggiustato l'angolo di */
{                              /* mira                                    */
	int	r;

	an -= 5;                         /* torna indietro di 5 gradi            */
	r = scan(an, 5);                  /* riduce la risoluzione dello scanner  */
	if (!r) 
		an += 10;                 /* se non trova il bersaglio ovviamente */
	/* e' nell'altra meta della risoluzione */
	an -= 3;                         /* dello scanner .... e cosi via fino a */
	r = scan(an, 3);                  /* sparare con lo scarto di +- un grado */
	if (!r) 
		an += 6;                  /* una maggiore precisione influiva in  */
	/* modo negativo in quanto occorre      */
	an -= 2;                         /* tener in considerazione il tempo che */
	r = scan(an, 2);                  /* intercorre tra lo sparo e il suo     */
	if (!r) 
		an += 4;                  /* arrivo sul bersaglio                 */

	an -= 1;
	r = scan(an, 1);
	if (!r) {
		an += 2;
		r = scan(an, 1);
		if (r > 10) 
			cannon(an, r);         /* evita di spararsi sulle scarpe  */
	} else if (r > 10) 
		cannon(an, r);         /* evita di spararsi sulle scarpe  */

}


