
/*                     Robot spider.r per CRobots

                              Tattica di gioco

   Questo  robot si  posiziona negli  angoli  e li' vi  resta fino a che non
   subisce  danni  superiori  al  6%,  dopo  di  che cambia  angolo  secondo
   uno schema fisso che gli permette di girare tutto lo schermo.
   E' una tattica difensiva, in quanto il robot cerca di fuggire dalle zone
   calde dello schermo, piuttosto che cercare gli avversari.
   Inoltre se durante i trasferimenti viene colpito  inverte momentaneamente
   la rotta, per poi tornare alla rotta originaria.
   L' algoritmo di mira e' lo stesso del robot cube.r:  tutto e' affidato ad
   un   sottoprogramma   invocato  iterativamente.   Questo  cerca  i  robot
   avversari  e,  una  volta  trovati, effettua correzioni al tiro secondo i
   loro spostamenti.
   Le correzioni riguardano sia l' angolo che la gittata, e dalla loro messa
   a punto dipende in modo critico l' efficienza del robot.

   Scritto da:
   Mario Gregori                                                    */


/* variabili globali */

int	sc_dir;       /* direzione dello scanner */
int	sfas;         /* sfasamento dell' angolo di fuoco */
int	oldd;         /* distanza a cui si trovava l' avversario */
int	dist;         /* distanza a cui si trova l' avversario */
int	scd2;         /* direzione di un secondo scanner */
/* (cerca avversari piu' vicini)   */
int	danni;        /* totale danni subiti */

main()
{
	sc_dir = 0;
	scd2 = 0;
	sfas = 0;
	danni = 0;
	oldd = 500;

	/* Si posiziona nell' angolo in basso a destra */
	while (loc_y() > 80) {
		drive (270, 80);
		look();
		if ((damage() - danni) > 6) 
			dietrofront(270);
	}
	drive (0, 0);
	look();
	while (loc_x() < 920) {
		drive (0, 80);
		look();
		if ((damage() - danni) > 6) 
			dietrofront(0);
	}
	drive (0, 0);

	while (1) {
		/* resta nell' angolo finche' non viene colpito */
		stay();

		/* si trasferisce nell' angolo in alto a destra */
		while (loc_y() < 470) {
			drive (112, 80);
			look();
			if ((damage() - danni) > 6) 
				dietrofront(112);
		}
		drive (112, 50);
		look();
		while (loc_y() < 920 && loc_x() < 920) {
			drive (68, 80);
			look();
			if ((damage() - danni) > 6) 
				dietrofront(68);
		}
		drive (68, 0);
		/* ci resta per un po'... */
		stay();

		/* si trasferisce nell' angolo in alto a sinistra */
		while (loc_x() > 530) {
			drive (202, 80);
			if ((damage() - danni) > 6) 
				dietrofront(202);
			look();
		}
		drive (202, 50);
		look();
		while (loc_y() < 920 && loc_x() > 80) {
			drive (158, 80);
			if ((damage() - danni) > 6) 
				dietrofront(158);
			look();
		}
		drive (68, 0);
		stay();

		/* si trasferisce nell' angolo in basso a sinistra */
		while (loc_y() > 530) {
			drive (292, 80);
			if ((damage() - danni) > 6) 
				dietrofront(292);
			look();
		}
		drive (292, 50);
		look();
		while (loc_y() > 80 && loc_x() > 80) {
			drive (248, 80);
			if ((damage() - danni) > 6) 
				dietrofront(248);
			look();
		}
		drive (248, 0);
		stay();

		/* torna nell' angolo in basso a destra */
		while (loc_x() < 470) {
			drive (22, 80);
			if ((damage() - danni) > 6) 
				dietrofront(22);
			look();
		}
		drive (22, 50);
		look();
		while (loc_y() > 80 && loc_x() < 920) {
			drive (338, 80);
			if ((damage() - danni) > 6) 
				dietrofront(338);
			look();
		}
		drive (338, 0);
	}
}


/* Si guarda intorno e spara */

look ()
{
	int	i, dist2;

	if (!(dist = scan (sc_dir, 5))) {
		if (dist = scan(sc_dir -= 10, 5))
			sfas = -6;
		else if (dist = scan(sc_dir -= 15, 10))
			sfas = -10;
		else if (dist = scan(sc_dir += 35, 5))
			sfas = 6;
		else if (dist = scan(sc_dir += 15, 10))
			sfas = 10;
		else {
			i = 10;
			while (!(dist = scan(sc_dir += 20, 10)) && (--i))
				;
			sfas = 0;
			oldd = dist;
			return;
		}
	}
	if ((dist - oldd) > 0)
		if (cannon(sc_dir + sfas, (dist * 15) / 13)) 
			sfas = 0;
		else if (cannon(sc_dir + sfas, (dist * 15) / 17)) 
			sfas = 0;
	dist2 = scan (scd2 -= 20, 10);
	if ((dist2 > 0) && (dist2 < (dist - 50)) ) {
		sc_dir = scd2;
		oldd = dist2;
	} else 
		oldd = dist;
}


/* resta fermo finche' non subisce danni per piu' del 6% */

stay()
{
	danni = damage();
	while ((damage() - danni) <= 6)
		look();
	danni = damage();
}


/* inverte momentaneamente la rotta */

dietrofront (dir)
int	dir;       /* attuale direzione di marcia */
int	dir2;      /* direzione opposta */
int	i;
{
	drive (dir, 0);
	look();
	dir2 = dir + 180;
	i = 5;
	while (--i) {
		drive (dir2, 80);
		look();
	}
	drive (dir2, 0);
	danni = damage();
}


