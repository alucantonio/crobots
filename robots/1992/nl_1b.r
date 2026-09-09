/* nome del Crobot:                  NL                      */
/* versione:                        1.00  B                  */
/* data finale di realizzazione:    4/9/92                   */
/* il numero dei prototipi approntati sono stati 18, e NL Š  */
/* stato selezionato tra i 2/3 Crobot che sono apparsi pi—   */
/* affidabili dalle prove sperimentali.                      */
/*                                                           */
/* dati dell'autore:                                         */
/*               Tognon Stefano                              */
/*                                                           */
/* strategia: il Crobot viene fatto girare per il campo di   */
/*            battaglia in modo da formare un quadrato.      */
/*            In questo modo il Crobot si trover… sempre     */
/*            vicino (a tiro) di quei Crobot che stazionano  */
/*            in un settore fisso del campo. Ci• dovrebbe    */
/*            evitare di avere partite patte.                */
/* modalità di tiro:                                         */
/*            la routine Spara si occupa di cercare i Crobot.*/
/*            Essa utilizza l'algoritmo di Jazz con la cura  */
/*            di non modificare il Range del tiro qualora    */
/*            la scansione avvenga con 10ø di risoluzione    */
/*            inquanto, essendo gi… bassa la precisione del  */
/*            tiro, non sempre conviene questa diminuzione.  */
/*            Sono state inoltre aggiunte delle ulteriori    */
/*            condizioni che dovrebbero migliorare la resa   */
/*            finale.                                        */
/*            Nota per Giuseppe Menozzi (autore di Jazz):    */
/*            Mi scuso per aver utilizzato la tua strategia  */
/*            di tiro, ma spero che nella guerra dei Crobots */
/*            sia permesso lo spionaggio, dato che questo    */
/*            giustificherebbe la mia azzardata azione.      */
/* punti deboli:                                             */
/*            Se NL dovesse scontrarsi con un altro Crobot   */
/*            rimarrebbe immobile inquanto non uscirebbe pi— */
/*            da uno dei WHILE del MAIN avendo i motori      */
/*            spenti. Succede anche che qualche volta NL vada*/
/*            a urtare un muro (dovrebbe verificarsi per via */
/*            del WHILE nella routine Spara) e rimanga fermo.*/
/*            Un ultimo punto debole: nei combattimenti a 4, */
/*            dato che NL percorre in tempi brevi il suo     */
/*            circuito, subisce abbastanza i colpi dei tre   */
/*            nemici. Sembra invece cavarsela abbastanga bene*/
/*            negli scontri diretti.                         */

int	Range, Dir;

main()
{
	/* il Crobot viene portato nel lato di partenza          */
	/* di coordinate (300,300) - (300,700)                   */
	/* se il Crobot fosse gi… nelle immediate vicinanze, vi  */
	/* viene lasciato                                        */
	if (loc_x() < 200) { 
		drive(0, 100);
		while (loc_x() < 250) 
			spara();
		drive(90, 0);
		while (speed() > 49) 
			spara();
	} else { 
		if (loc_x() > 400) { 
			drive(180, 100);
			while (loc_x() > 350) 
				spara();
			drive(90, 0);
			while (speed() > 49) 
				spara();
		}
	}
	if (loc_y() > 600) { 
		drive(270, 100);
		while (loc_y() > 500) 
			spara();
		drive (90, 0);
		while (speed() > 49) 
			spara();
	}
	/* nel ciclo principale il crobot percorrer… il quadrato    */
	/* di coordinate (300,300)-(300,700)-(700,700)-(700,300)    */
	/* ripetutamente. Ci• lo porta sempre vicino a quei Crobots */
	/* che rimangono sempre in un preciso settore del campo di  */
	/* battaglia                                                */
	while (1) {
		drive(90, 100);
		while (loc_y() < 660) 
			spara();
		drive(180, 0);
		while (speed() > 49) 
			spara();     /* Š stato raggiunto l'angolo */
		/* in alto a sinistra         */
		drive(0, 100);
		while (loc_x() < 660) 
			spara();
		drive(270, 0);
		while (speed() > 49) 
			spara();     /* Š stato raggiunto l'angolo */
		/* in alto a destra           */
		drive(270, 100);
		while (loc_y() > 340) 
			spara();
		drive(90, 0);
		while (speed() > 49) 
			spara();     /* Š stato raggiunto l'angolo */
		/* in basso a destra          */
		drive(180, 100);
		while (loc_x() > 340) 
			spara();
		drive(270, 0);
		while (speed() > 49) 
			spara();     /* Š stato raggiunto l'angolo */
		/* in basso a sinistra        */
	}
}


spara()
{
	if (Range = scan (Dir, 3))
		cannon (Dir, Range * 7 / 8);
	else
	 {
		Dir -= 23;
		while (!(Range = scan (Dir, 10)))
			Dir += 20;
		cannon (Dir, Range);
		/* ora cerco se il Crobot Š ancora a tiro dimezzando la scansione*/
		if (Range = scan (Dir, 4)) 
			cannon (Dir, Range * 7 / 8);
		else if (Range = scan (Dir + 5, 4)) 
			cannon (Dir + 5, Range * 7 / 8);
	};

}


