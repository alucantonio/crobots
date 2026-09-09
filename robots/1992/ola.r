/*   Nome Robot : OLA.R             Data ultima revisione   29/9/92          */
/*                                                                           */
/*   Autore: Francesco Maggio                                                */
/*           Codice MC7977                                                   */
/*                                                                           */
/*  Strategia del movimeto:                                                  */
/*  OLA.R si muove circa sul perimetro del campo di gioco in senso           */
/*  antiorario. La velocita' del movimeto e' la massima possibile.           */
/*  Per eseguire i cambi di marcia esegue un solo comando drive(..50) che    */
/*  risulta essere sufficente.                                               */
/*                                                                           */
/*  Strategia di attacco:                                                    */
/*  Esegue ciclicamete degli scan sul terreno di gioco usando 5 angolazioni  */
/*  base rispetto all'angolazione di movimento, incrementa la variabile tolp */
/*  che varia l'angolazione di scan ad ogni chiamata della funzione att().   */
/*  Una scansione eseguita con successo oltre eseguire una funzione cannon   */
/*  influenza l' incremento della variabile tolp, in modo abbastanza casuale */
/*  dovuto a tuning successivi e mirati a specifici Robot.                   */
/*  In questo modo OLA.R spera di contrastare sia i robot che eseguono       */
/*  movimeti al centro del campo, sia, in modo meno efficace, quelli che     */
/*  si muovono sul perimetro. Lo scan con angle180 risulta ad esempio        */
/*  efficace sui robot inseguitori.                                          */
/*                                                                           */

/* distaza rilevata dalla scan del robot avversario                          */
int	range;

/* angolazione della traettoria del robot                                    */
int	angle;

/* angolazioni basi per la ricerca dell'avversario e del fuoco               */
int	angle45, angle90, angle135, angle180;

/* variabile che memorizza l'incremento delle scansioni di ricerca           */
/* e' comune a tulle le angolazioni di scansione                             */
int	tolp;

main()

{
	/*  impostazioni di base permettono al robot di guadagnare la sponda        */
	tolp = 0;
	angle = 0;
	angle45 = 45;
	angle90 = 90;
	angle135 = 135;
	angle180 = 180;
	while (1) {
		/* fase movimento inizio */
		/* FASE 1 */
		while (loc_x() < 920)  {
			/* massima velocita' e attacco */
			drive(angle, 100);
			att();
		}
		/* rallenta per girare e imposta i dati base della nuova angolazione */
		drive(angle, 50);
		tolp = 0;
		angle = 90;
		angle45 = 135;
		angle90 = 180;
		angle135 = 225;
		angle180 = 270;
		/* FASE 2 */
		while (loc_y() < 920)  {
			/* massima velocita' e attacco */
			drive(angle, 100);
			att();
		}
		/* rallenta per girare e imposta i dati base della nuova angolazione */
		drive(angle, 50);
		tolp = 0;
		angle = 180;
		angle45 = 225;
		angle90 = 270;
		angle135 = 315;
		angle180 =   0;
		/* FASE 3 */
		while (loc_x() >  80)  {
			/* massima velocita' e attacco */
			drive(angle, 100);
			att();
		}
		/* rallenta per girare e imposta i dati base della nuova angolazione */
		drive(angle, 50);
		tolp = 0;
		angle = 270;
		angle45 = 315;
		angle90 = 0;
		angle135 = 45;
		angle180 = 90;
		/* FASE 4 */
		while (loc_y() >  80)  {
			/* massima velocita' e attacco */
			drive(angle, 100);
			att();
		}
		/* rallenta per girare e imposta i dati base della nuova angolazione */
		drive(angle, 50);
		tolp = 0;
		angle = 0;
		angle45 = 45;
		angle90 = 90;
		angle135 = 135;
		angle180 = 180;
	}
}



att()
{
	/* incremeta la varibile per eseguire le scansioni rispetto agli angoli base*/
	tolp = tolp + 3;
	if (range = scan(angle180 - tolp, 10)) {
		tolp += 6;
		cannon(angle180 - tolp, range - 30);
	} else {
		if (range = scan(angle45 + tolp, 10)) {
			cannon(angle45 + tolp, range);
			tolp -= 6;
		} else {
			if (range = scan(angle90 + tolp, 10)) {
				cannon(angle90 + tolp, range);
				tolp -= 5;
			} else {
				if (range = scan(angle135 + tolp, 10)) {
					cannon(angle135 + tolp, range);
					tolp -= 9;
				} else {
					if (range = scan(angle + tolp, 10)) {
						cannon(angle + tolp, range);
						tolp -= 7;
					}
				}
			}
		}
	}
}


