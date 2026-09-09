/*
    ***********************  ClockWise . Robot   *********************

    Scritto da Persiani Giuseppe

    Attenzione: solamente la prima parte del programma viene ben commentata 
    in quanto esso consiste di quattro sezioni identiche, una per ogni lato
    dell'arena nella quale esso si muove in senso orario ( Clock-Wise) ed 
	utilizza per la scansione dell'area una serie di if...then...else
	in cascata.
*/

main()
{
	int	trovato, sc1; /* Nella variabile TROVATO viene memorizzata
			    la distanza che ci restituisce la funzione  
				    SCAN se viene trovato un avversario */

	/* Nella variabile SC1 viene memorizzato l'angolo 
			   di scansione che servir… solamente nella fase
			   iniziale quando il robot si porta nel lato in
			   basso */
	sc1 = 0;
	drive(270, 100);				/* Il robot si porta alla */
	while (loc_y() > 60) {			/* massima velocit… verso */
		if ((trovato = scan(sc1, 10)) != 0) /* il lato in basso utilizzando */
			cannon(sc1, trovato);	/* nel frattempo una semplice */
		else 
			sc1 += 20;			/* scansione per colpire gli */
	}					/* avversari */
	drive(270, 0);
	while (1) {
		while (speed() > 40)
			;
		while (loc_x() > 84) {  /* Una volta arrivato nel lato in basso */
			drive(180, 100);  /* CW.R si muove alla massima velocit…
								    in senso orario */

			while (((trovato = scan(180, 9)) >= 50) && (trovato < 700))
				cannon(180, 8 * trovato / 9);
			/* Se viene trovato un avversario nella direzione in cui
		   CW.R si muove, esso spara con lo stesso angolo accorciando
		   il tiro */

			/* Adesso CW.R inizia a scandire l'area sopra di lui 
		   utilizzando un angolo di scansione assoluto e sparando
		   nella medesima direzione senza modificare la distanza */
			if (((trovato = scan(160, 9)) >= 50) && (trovato < 700))
				cannon(160, trovato);
			/* Altrimenti si controlla nella direzione immediatamente
		   minore ma sempre con lo stesso metodo visto sopra, da notare 
		   che se viene trovato un avversario in una data posizione
		   gli altri IF non vengono eseguiti ma il ciclo di ricerca 
		   ricomincia dal WHILE iniziale */
else if (((trovato = scan(140, 9)
) 
 >= 50) 
 && (trovato < 700)
)
cannon(140, trovato);
else if (((trovato = scan(120, 9)
) 
 >= 50) 
 && (trovato < 700)
)
cannon(120, trovato);
else if (((trovato = scan(100, 9)
) 
 >= 50) 
 && (trovato < 700)
)
cannon(100, trovato);
else if (((trovato = scan(80, 9)
) 
 >= 50) 
 && (trovato < 700)
)
cannon(80, trovato);
/* Se arriva a scandire le posizioni pi— arretrate rispetto alla 
		   sua direzione di spostamento, CW.R quando trova un avversario 
		   spara anche se ‚ pi— lontano della gittata massima (700) */
else if ((trovato = scan(60, 9)
) 
 >= 50)
cannon(60, trovato);
else if ((trovato = scan(40, 9)
) 
 >= 50)
cannon(40, trovato);
else if ((trovato = scan(20, 9)
) 
 >= 50)
cannon(20, trovato);
else if ((trovato = scan(0, 9)
) 
 >= 50)
cannon(0, trovato);
		}
		/* 	Quando il robot arriva nella prossimit… della parete sinistra
	 	si ferma, diminuisce le sua direzion di 90 gradi e riparte 
		costeggiandola. */

		drive(0, 0);
		while (speed() > 40)
			;
		while (loc_y() < 916) {
			drive(90, 100);

			/*	Ricomincia l'operazione di scansione identica a quella sopra ma 
		con gli angoli di ricerca ovviamente diversi in quanto sono assoluti */

			while (((trovato = scan(90, 9)) >= 50) && (trovato < 700))
				cannon(90, 8 * trovato / 9);
			if (((trovato = scan(70, 9)) >= 50)  && (trovato < 700))
				cannon(70, trovato);
			else if (((trovato = scan(50, 9)) >= 50) && (trovato < 700))
				cannon(50, trovato);
			else if (((trovato = scan(30, 9)) >= 50) && (trovato < 700))
				cannon(30, trovato);
			else if (((trovato = scan(10, 9)) >= 50) && (trovato < 700))
				cannon(10, trovato);
			else if (((trovato = scan(350, 9)) >= 50) && (trovato < 700))
				cannon(350, trovato);
			else if ((trovato = scan(330, 9)) >= 50)
				cannon(330, trovato);
			else if ((trovato = scan(310, 9)) >= 50)
				cannon(310, trovato);
			else if ((trovato = scan(290, 9)) >= 50)
				cannon(290, trovato);
			else if ((trovato = scan(270, 9)) >= 50)
				cannon(270, trovato);
		}
		drive(90, 0);
		/* Parete alta, si gira e si riparte */

		while (speed() > 40)
			;
		while (loc_x() < 916) {
			drive(0, 100);
			while (((trovato = scan(0, 9)) >= 50) && (trovato < 700))
				cannon(0, 8 * trovato / 9);
			if (((trovato = scan(340, 9)) >= 50) && (trovato < 700))
				cannon(340, trovato);
			else if (((trovato = scan(320, 9)) >= 50) && (trovato < 700))
				cannon(320, trovato);
			else if (((trovato = scan(300, 9)) >= 50) && (trovato < 700))
				cannon(300, trovato);
			else if (((trovato = scan(280, 9)) >= 50) && (trovato < 700))
				cannon(280, trovato);
			else if (((trovato = scan(260, 9)) >= 50) && (trovato < 700))
				cannon(260, trovato);
			else if ((trovato = scan(240, 9)) >= 50)
				cannon(240, trovato);
			else if ((trovato = scan(220, 9)) >= 50)
				cannon(220, trovato);
			else if ((trovato = scan(200, 9)) >= 50)
				cannon(200, trovato);
			else if ((trovato = scan(180, 9)) >= 50)
				cannon(180, trovato);
		}
		drive(180, 0);
		/* Parete destra, si gira e si riparte */

		while (speed() > 40)
			;
		while (loc_y() > 84) {
			drive(270, 100);
			while (((trovato = scan(270, 5)) >= 50) && (trovato < 700))
				cannon(270, 8 * trovato / 9);
			if (((trovato = scan(250, 9)) >= 50) && (trovato < 700))
				cannon(250, trovato);
			else if (((trovato = scan(230, 9)) >= 50) && (trovato < 700))
				cannon(230, trovato);
			else if (((trovato = scan(210, 9)) >= 50) && (trovato < 700))
				cannon(210, trovato);
			else if (((trovato = scan(190, 9)) >= 50) && (trovato < 700))
				cannon(190, trovato);
			else if (((trovato = scan(170, 9)) >= 50) && (trovato < 700))
				cannon(170, trovato);
			else if ((trovato = scan(150, 9)) >= 50)
				cannon(150, trovato);
			else if ((trovato = scan(130, 9)) >= 50)
				cannon(130, trovato);
			else if ((trovato = scan(110, 9)) >= 50)
				cannon(110, trovato);
			else if ((trovato = scan(90, 9)) >= 50)
				cannon(90, trovato);
		}
		drive(270, 0);

		/*  Il robot ‚ ritornato alla parete in basso, ricominciando il ciclo 
		principale dovr… girare di 90 gradi a destra e ripartir… per un nuovo
		giro sfidando il tempo e sopratutto gli avversari */
	}
}


