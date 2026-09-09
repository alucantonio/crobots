/*		D A N C E R		*/
/*	   di Gaetano Trovatello	*/


int	direz, raggio, usc1, var1;
int	drmov, usc, dmg, var, stm;

/* <<< SEZIONE DI RICERCA >>> */

main ()
{
	while (1) {
		drmov = rand(359);
		if ((raggio = scan(drmov, 5)) > 0)
			cannon(drmov, raggio);
		drive(drmov, 100);
		usc = 1;
		var1 = 0;
		while (usc) {
			if (var1 > 17)
				var1 = 0;
			direz = var1 * 20;
			var1 = var1 + 1;
			if ((raggio = scan(direz, 5)) > 0 && raggio < 700)
				attacco();
			guarda();
			drive(drmov, 100);
		}
	}
}


/* <<< SEZIONE D'ATTACCO (la metalloficina) >>> */

attacco()
{
	cannon(direz, raggio);
	usc1 = 1;
	dmg = damage();
	dmg = dmg + 10;
	var = 14;
	stm = 14;
	while (usc1) {
		drive(direz, 70);
		if (dmg < damage()) {
			usc1 = 0;
			usc = 0;
		}
		if ((raggio = scan(direz, 7)) > 0) {
			cannon(direz, raggio);
		} else {
			direz = direz + var;
			var = var + stm;
			stm = stm - (stm * 2);
			var = var - (var * 2);
		}
	}
}


/* <<< SEZIONE PER IL CONTROLLO DELLA POSIZIONE >>> */
/* onde evitare che vada a sbattere il cranio contro le pareti */

guarda()
{
	if (loc_x() > 900 && (drmov < 135 || drmov > 225)) {
		drmov = rand(90);
		drmov = drmov + 135;
		drive(drmov, 100);
	}

	if (loc_x() < 100 && (drmov > 45 && drmov < 315)) {
		drmov = rand(90);
		if (drmov > 45) {
			drmov = drmov - 45;
		} else {
			drmov = drmov + 315;
		}
		drive(drmov, 100);
	}

	if (loc_y() > 900 && (drmov < 225 || drmov > 135)) {
		drmov = rand(90);
		drmov = drmov + 225;
		drive(drmov, 100);
	}

	if (loc_y() < 100 && (drmov > 135 || drmov < 45)) {
		drmov = rand(90);
		drmov = drmov + 45;
		drive(drmov, 100);
	}
}


/* E QUESTA E' LA FINE DEL PROGRAMMA */
