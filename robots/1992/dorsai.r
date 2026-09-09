/*************************************************************************

  DORSAI.R by 
    Biraghi Sandro                              "Nei Secoli Fedele"

    fidonet  2:332/504 

  Dorsai (mai letto nulla di Gordon Dickson ?)  e' un CRobot che si 
  mantiene sul lato sud finche' non rimane un solo CRobot nemico.
  A questo punto si porta nell'angolo sud-est ,si ferma, e spara usando
  un'estrapolazione che ho leggermente modificato da Killer.r (John Smolin).
  Essendo la mia seconda scelta nel caso il superstite avversario sia
  Jager si suicida favorendo cosi' il caposquadra.

 *************************************************************************/
int	range, orange, dir, odir, D, switch, n, m, a, b, k1, k2, count, rimani;

main()
{  
	int	d, m, r1;

	k1 = 25;
	k2 = 17;
	orange = 2000;
	drive (D = plot(500, 500), 100);        /* si porta nel centro... */
	d = 20000;
	while ((d > 10000) && speed()) {
		Spezza();                          /* combattendo ! */
		a = loc_x() - 500;
		a = a * a;
		b = loc_y() - 500;
		b = b * b;
		d = (a + b);
	}
	drive (270, 0);
	while (speed() > 49)
		;
	drive (270, 100);                     /* rotta verso sud */
	while (loc_y() > 200 && speed())
		Spezza();
	while (loc_y() > 50 && speed()) 
		drive(270, 100);
	drive(270, 0);
	while (speed() > 49)
		;

	rimani = 2;

	while (rimani) {                /* ciclo principale */

		drive(180, 100);
		k1 = 25;
		k2 = 17;
		while (loc_x() > 120 && speed()) {        /*   <--   */
			Spezza();
			if (range > 550) {               /* cerca un avversario piu' vicino */
				d = 180 - switch * 85;
				switch = (switch + 1) 
					 % 2;
				m = 6;
				while (--m && loc_x() > 120) {
					r1 = scan(d -= 17, 10);
					if (r1 < range && r1) {
						range = r1;
						dir = d;
					}
				}
			} else {                    /* corregge il futuro fuoco nel caso un */
				if (dir > 160 && dir < 200) 
					orange -= 54; /* avversario stia scappando */
			}
		}
		drive (180, 0);                         /* frena e riparte */
		while (speed() > 49)
			;

		drive (0, 100);                         /*   -->   */
		k1 = -25;
		k2 = -17;
		while (loc_x() < 880 && speed()) {
			Spezza();
			if (range > 550) {              /* cerca un avversario piu' vicino */
				d = 10 + switch * 85;
				switch = (switch + 1) 
					 % 2;
				m = 6;
				while (--m && loc_x() < 880) {
					r1 = scan(d += 17, 10);
					if (r1 < range && r1) {
						range = r1;
						dir = d;
					}
				}
			} else {                      /* corregge il futuro fuoco nel caso un */
				if (dir < 20) 
					orange -= 54;   /* un avversario stia scappando */

			}
		}
		drive (0, 0);                          /* frena e riparte */
		while (speed() > 49)
			;

		drive(180, 100);
		/* conta gli avversari */
		count = 0;
		d = 70;
		while (d < 200) 
			count += (scan(d += 20, 10) != 0);
		if (count == 1) 
			--rimani;

	}

	drive(0, 100);
	while (speed() > 49)
		;       /* uscito dal ciclo vai all'angolo */
	drive(0, 100);
	dir = 70;
	while (loc_x() < 950 && speed())
		;
	drive(0, 0);

	while (1) {                            /* ciclo finale */
		if (range = scan(dir, 8)) 
			dir = finisci(dir);
		dir += 15;
		if (count > 5) {   /* probabilmente (si spera...) si e' rimasti solo Dorsai */
			cannon(0, 0);    /* e il capo (Jager) quindi ci si piega alla disciplina */
			count = 0;        /* di squadra */
		}
		if (dir > 210) 
			dir = 70;
	}
}



Spezza() /* classica routine di fuoco con qualche aggiustamento euristico */
{

	if ((range = scan(dir, 3))) 
		cannon(dir, (35 + (orange < range) * 13) * range / 40);
	else {
		dir += k1;
		while (!(range = scan(dir, 10))) 
			dir -= k2;
		cannon(dir += 5 - (scan(dir - 5, 5) != 0) * 10, (35 + (orange < range) * 13) * range / 40);
		dir -= 360;
		if (dir < 0) 
			dir += 360;
	}
	orange = range;
}


finisci(dir)   /* a me questa routine e' piaciuta subito...*/
int	dir;       /* l'estrapolazione e'funzionata dopo parecchi tentativi */

{
	while (range && range < 800) {
		odir = dir;
		orange = range;
		dir += 4 - (scan(dir - 4, 4) != 0) * 8;
		dir += 2 - (scan(dir - 2, 2) != 0) * 4;
		range = scan(dir, 10);
		if (range > 150) {
			dir += 1 - (scan(dir - 1, 1) != 0) * 2;
			cannon(dir + (dir - odir) * range / 275, range + (range - orange) * range / 275);
		} else if (range > 47) 
			cannon(dir, (4 + (orange < range) * 2) * range / 5);
	}
	if (dir > 80 && dir < 100) 
		++count; /* la distanza e' maggiore di 700 in */
	else 
		count = 0;                 /* direzione nord ? C'e' in giro il capo...*/

	return dir;
}


plot (x, y)      /* data una coordinata cartesiana ritorna la direzione per */
int	x, y;           /* raggingerla dalla posizione attuale */
{
	int	d, locx, locy;

	locx = loc_x();
	locy = loc_y();

	if (locx == x) {
		if (y > locy)
			d = 90;
		else
			d = 270;
	} else
	 {
		if (y < locy) {
			if (x > locx)
				d = 360 + atan ((100000 * (locy - y)) / (locx - x) );
			else
				d = 180 + atan ((100000 * (locy - y)) / (locx - x) );
		} else if (x > locx)
			d = atan ((100000 * (locy - y)) / (locx - x) );
		else
			d = 180 + atan ((100000 * (locy - y)) / (locx - x) );
	};
	return (d);
}


