/**************************************************************************/
/* Robot Name     : ET_5                                                  */
/* Author Name    : Luigi Morelli                                         */
/*                                                                        */
/* TATTICA :                                                              */
/* Il robot percorre un circuito triangolare, evitando gli angoli ed      */
/* il centro dell'arena. Va il piu' velocemente possibile senza           */
/* urtare le pareti. La routine di sparo cerca di centrare il bersaglio   */
/* presupponendo che questo si trovi entro 80 gradi dall'ultima           */
/* posizione. In ciascun vertice del triangolo, qualora il bersaglio      */
/* sia perso, viene controllato il centro del campo cercando di           */
/* massimizzare la ricerca nel minor tempo possibile.                     */
/**************************************************************************/

int	dir, ang, dist;

main()

{
	if ((loc_x() < 600) && (loc_y() < 400)) {
		dir = plot_course (200, 50);
		ang = dir;
		while ((loc_x() > 300) && (loc_y() > 140)) /* vai a casa... */
			shoot (100);                         /*...sparando */
		drive (dir, 40);                            /* Rallenta */
		while (speed > 40)                         /* continuando a sparare
			*/
			shoot (40);
	}

	while (1) {


		/* Primo lato del triangolo */

		dir = plot_course (650, 50);  /* prossima destinazione */
		if (dist == 0)               /* Nessuno in vista? */
			ang = dir;             /* Avanti! */
		while (loc_x() < 580)        /* Controlla l'arrivo */
			shoot (100);           /* sparando al massimo */
		drive (dir, 40);              /* Sei vicino, rallenta! */
		if (dist == 0)               /* Se non ci sono nemici in vista */
			ang = dir;             /* Aggiusta la direzione */
		while (speed > 40)
			shoot (40);            /* Controlla mentre rallenta */


		/* Secondo lato del triangolo */


		dir = plot_course (950, 650); /* prossima destinazione */
		if (dist == 0)               /* Nessuno in vista? */
			ang = dir;             /* Avanti! */
		while (loc_y() < 590)        /* Controlla l'arrivo */
			shoot (100);           /* sparando al massimo */
		drive (dir, 40);              /* Sei vicino, rallenta! */
		if (dist == 0)               /* Se non ci sono nemici in vista */
			ang = dir;             /* Aggiusta la direzione */
		while (speed > 40)
			shoot (40);            /* Controlla mentre rallenta */


		/* Terzo lato del triangolo */


		dir = plot_course (50, 950);  /* prossima destinazione */
		if (dist == 0)               /* Nessuno in vista? */
			ang = dir;             /* Avanti! */
		while (loc_x() > 120)        /* Controlla l'arrivo */
			shoot (100);           /* sparando al massimo */
		drive (dir, 40);              /* Sei vicino, rallenta! */
		if (dist == 0)               /* Se non ci sono nemici in vista */
			ang = dir;             /* Aggiusta la direzione */
		while (speed > 40)
			shoot (40);            /* Controlla mentre rallenta */
	}
}



/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */

plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;  /* scale for trig functions */
	curx = loc_x();  /* get current location */
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	/* atan only returns -90 to +90, so figure out how to use */
	/* the atan() value */

	if (x == 0) {      /* x is zero, we either move due north or south */
		if (yy > cury)
			d = 90;        /* north */
		else
			d = 270;       /* south */
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
			else
				d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);        /* north-east, quadrant 1 */
			else
				d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
		}
	}
	return (d);
}


/* Funzione che spazza un'area di ricerca ampia 120 gradi; se nulla */
/* e' a tiro continua la scansione, altrimenti spara 2 volte */

shoot (spd)
int	spd;
{
	drive (dir, spd);
	dist = scan (ang, 10);
	if (dist > 39) {
		cannon (ang + 2, dist);
		cannon (ang - 2, dist);
	} else
	 {
		ang += 20;
		if (scan (ang, 10) == 0) {
			ang -= 40;
			if (scan (ang, 10) == 0) {
				ang += 60;
				if (scan (ang, 10) == 0)
					while (scan (ang, 10) = 0)
						ang -= 20;
			}
		}
		dist = scan (ang, 10);
		if (dist > 39) {
			cannon (ang - 2, dist);
			cannon (ang + 2, dist);
		}
	}
}


