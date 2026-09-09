/* Nome del Robot : " Casimiro "  (versione 37-6820) */
/* Autore         : Luca Masi ( Mc4970 alias "LuM" ) */
/* Realizzazione  : 16 & 17 giugno 1991 a Roma       */
/* Test & Debug   : 18 giugno - 30 novembre 1991     */
/* Ringraziamenti : Andrea Masi, i386/25 e Mc-Link   */

int	angolo;                            /* Numero dell' angolo attuale */
int	a1x, a1y, a2x, a2y, a3x, a3y, a4x, a4y;   /* Coordinate dei 4 angoli     */
int	grado, g1;                          /* Grado attuale per lo scan   */
int	range;                             /* Lontananza dell' avversario */
int	danno;                             /* Danni subiti fino ad ora    */
int	posx, posy;                         /* Posizione iniziale Casimiro */
int	conta;

main()
{
	a1x = 0;       
	a1y = 0;              /*         Inizializza         */
	a2x = 0;       
	a2y = 999;            /*        le coordinate        */
	a4x = 999;     
	a4y = 999;            /*         dei 4 angoli        */
	a3x = 999;     
	a3y = 0;              /*          principali         */

	dove();
	if (angolo == 0) 
		arriva (a1x, a1y, inclina(a1x, a1y, posx, posy));
	else
	 {
		if (angolo == 1) 
			arriva (a2x, a2y, inclina(a2x, a2y, posx, posy));
		else
		 {
			if (angolo == 2) 
				arriva (a3x, a3y, inclina(a3x, a3y, posx, posy));
			else 
				arriva (a4x, a4y, inclina(a4x, a4y, posx, posy));
		}
	}

	conta = 0;
	danno = damage();

	while (conta < 266) {
		if (angolo > 1) 
			grado = angolo * 90 - 1;
		else 
			grado = angolo * 270 + 89;
		g1 = grado;
		while (danno == damage() && conta < 266) {
			range = scan(g1, 4);
			while (range > 40 && range < 850 && danno == damage()) {
				cannon(g1, range);
				range = scan(g1, 4);
			}
			g1 -= 8;
			if (grado - g1 > 88) {
				g1 = grado;
				conta += 1;
			}
		}
		cambia_angolo();
		danno = damage();
	}

	grado = g1;
	g1 = 0;
	while (1) {
		while ((range = scan(grado, 4)) > 0) {
			drive(grado, 0);
			if (range > 730) 
				drive(grado, 100);
			else if (range > 40) 
				cannon(grado, range);
			grado -= 12;
			check();
		}
		grado += 8;
	}
}


check()                                /* Gestione movimenti II robot */
{
	int	somma, verso;
	if (danno != damage()) {
		danno = damage();
		conta = 0;
		if (g1 == 0) {
			g1 = 1;
			posy = loc_y();
			if (posy > 512) {
				somma = -100;
				verso = 270;
			} else
			 {
				somma = 100;
				verso = 90;
			}
			drive(verso, 100);
			while (posy + somma < loc_y() && conta++ < 100)
				;
			drive(verso, 0);
		} else
		 {
			g1 = 0;
			posx = loc_x();
			if (posx > 512) {
				somma = -100;
				verso = 180;
			} else
			 {
				somma = 100;
				verso = 0;
			}
			drive(verso, 100);
			while (posx + somma < loc_x() && conta++ < 100)
				;
			drive(verso, 0);
		}
	}
}


distanza(x1, y1, x2, y2)                  /* La distanza tra due punti   */
int	x1, y1, x2, y2;
{
	int	x, y;
	x = x1 - x2;
	y = y1 - y2;
	return(sqrt((x * x) + (y * y)));
}


arriva(x, y, dir)                        /* Si sposta ad una locazione  */
int	x, y, dir;
{
	drive(dir, 100);
	while (distanza(loc_x(), loc_y(), x, y) > 100 && speed() > 0)
		;
	drive(dir, 20);
	while (distanza(loc_x(), loc_y(), x, y) > 10 && speed() > 0)
		;
	drive(dir, 0);
}


inclina(a, b, c, d)                       /* Angolo per lo spostamento   */
int	a, b, c, d;
{
	int	calcola, x, y;
	x = c - a;
	y = d - b;
	if (x == 0) {
		if (b > posy) 
			calcola = 90;
		else 
			calcola = 270;
	} else
	 {
		if (b < posy) {
			if (a > posx) 
				calcola = 360 + atan((100000 * y) / x);
			else 
				calcola = 180 + atan((100000 * y) / x);
		} else
		 {
			if (a > posx) 
				calcola = atan((100000 * y ) / x);
			else 
				calcola = 180 + atan((100000 * y) / x);
		}
	}
	return(calcola);
}


dove()                                 /* In quale angol si trova ?!? */
{
	posx = loc_x(); 
	posy = loc_y();
	if (posx > 500) 
		angolo = 2;
	else 
		angolo = 0;
	if (posy > 500) 
		angolo += 1;
}


cambia_angolo()                        /* Arriva ad un nuovo angolo   */
{
	if (angolo == 0) {
		if (scan(90, 3) == 0) 
			arriva(a2x, a2y, inclina(a2x, a2y, loc_x(), loc_y()));
		else
		 {
			if (scan(0, 3) == 0) 
				arriva(a3x, a3y, inclina(a3x, a3y, loc_x(), loc_y()));
			else 
				arriva(a4x, a4y, inclina(a4x, a4y, loc_x(), loc_y()));
		}
	} else
	 {
		if (angolo == 1) {
			if (scan(0, 3) == 0) 
				arriva(a4x, a4y, inclina(a4x, a4y, loc_x(), loc_y()));
			else
			 {
				if (scan(270, 3) == 0) 
					arriva(a1x, a1y, inclina(a1x, a1y, loc_x(), loc_y()));
				else 
					arriva(a3x, a3y, inclina(a3x, a3y, loc_x(), loc_y()));
			}
		} else
		 {
			if (angolo == 3) {
				if (scan(270, 3) == 0) 
					arriva(a3x, a3y, inclina(a3x, a3y, loc_x(), loc_y()));
				else
				 {
					if (scan(180, 3) == 0) 
						arriva(a2x, a2y, inclina(a2x, a2y, loc_x(), loc_y()));
					else 
						arriva(a1x, a1y, inclina(a1x, a1y, loc_x(), loc_y()));
				}
			} else
			 {
				if (scan(180, 3) == 0) 
					arriva(a1x, a1y, inclina(a1x, a1y, loc_x(), loc_y()));
				else
				 {
					if (scan(90, 3) == 0) 
						arriva(a4x, a4y, inclina(a4x, a4y, loc_x(), loc_y()));
					else 
						arriva(a2x, a2y, inclina(a2x, a2y, loc_x(), loc_y()));
				}
			}
		}
	}
	dove();
}


