/* Nome del Robot : " Geltrude "  ( versione E-6820 ) */
/* Autore         : Luca Masi ( Mc4970 alias "LuM" )  */
/* Realizzazione  : 16 & 17 giugno 1991 a Roma        */
/* Test & Debug   : 18 giugno - 30 novembre 1991      */
/* Ringraziamenti : Andrea Masi, i386/25 e Mc-Link    */

int	angolo;                            /* Numero dell' angolo attuale */
int	a1x, a1y, a2x, a2y, a3x, a3y, a4x, a4y;   /* Coordinate dei 4 angoli     */
int	sc1, sc2, sc3, sc4;                   /* Angolo per iniziare lo scan */
int	grado, g1;                          /* Grado attuale per lo scan   */
int	range;                             /* Lontananza dell' avversario */
int	danno;                             /* Danni subiti fino ad ora    */
int	posx, posy;                         /* Posizione iniziale Casimiro */

main()
{
	a1x = 0;   
	a1y = 0;   
	sc1 =  89;     /*         Inizializza         */
	a2x = 0;   
	a2y = 999; 
	sc2 = 359;     /*        le coordinate        */
	a3x = 999; 
	a3y = 999; 
	sc3 = 269;     /*         degli angoli        */
	a4x = 999; 
	a4y = 0;   
	sc4 = 179;     /*            e la             */
	posx = loc_x();  
	posy = loc_y();     /*          posizione          */

	if (posx < 500 && posy < 500) {
		angolo = 0;
		arriva (a1x, a1y, inclina(a1x, a1y, posx, posy));
	} else
	 {
		if (posx < 500 && posy >= 500) {
			angolo = 1;
			arriva (a2x, a2y, inclina(a2x, a2y, posx, posy));
		} else
		 {
			if (posx >= 500 && posy >= 500) {
				angolo = 2;
				arriva (a3x, a3y, inclina(a3x, a3y, posx, posy));
			} else
			 {
				angolo = 3;
				arriva (a4x, a4y, inclina(a4x, a4y, posx, posy));
			}
		}
	}

	while (1) {
		danno = damage();
		if (angolo == 0 ) 
			grado = sc1;
		else
		 {
			if (angolo == 1 ) 
				grado = sc2;
			else
			 {
				if (angolo == 2 ) 
					grado = sc3;
				else 
					grado = sc4;
			}
		}
		g1 = grado;
		while (danno == damage()) {
			range = scan(g1, 4);
			while (range > 40 && danno == damage()) {
				cannon(g1, range);
				range = scan(g1, 4);
			}
			g1 = g1 - 8;
			if (grado - g1 > 88) 
				g1 = grado;
		}
		cambia_angolo();
	}
}


distanza(x1, y1, x2, y2)                  /* La distanza tra due punti   */
int	x1, y1, x2, y2;
{
	int	x, y, conta;

	x = x1 - x2;
	y = y1 - y2;
	conta = sqrt((x * x) + (y * y));
	return(conta);
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


cambia_angolo()                        /* Arriva ad un nuovo angolo   */
{
	int	xx, yy;
	xx = loc_x(); 
	yy = loc_y();

	if (angolo == 0) {
		if (scan(90, 3) == 0) 
			arriva(a2x, a2y, inclina(a2x, a2y, xx, yy));
		else
		 {
			if (scan(0, 3) == 0) 
				arriva(a4x, a4y, inclina(a4x, a4y, xx, yy));
			else 
				arriva(a3x, a3y, inclina(a3x, a3y, xx, yy));
		}
	} else
	 {
		if (angolo == 1) {
			if (scan(0, 3) == 0) 
				arriva(a3x, a3y, inclina(a3x, a3y, xx, yy));
			else
			 {
				if (scan(270, 3) == 0) 
					arriva(a1x, a1y, inclina(a1x, a1y, xx, yy));
				else 
					arriva(a4x, a4y, inclina(a4x, a4y, xx, yy));
			}
		} else
		 {
			if (angolo == 2) {
				if (scan(270, 3) == 0) 
					arriva(a4x, a4y, inclina(a4x, a4y, xx, yy));
				else
				 {
					if (scan(180, 3) == 0) 
						arriva(a2x, a2y, inclina(a2x, a2y, xx, yy));
					else 
						arriva(a1x, a1y, inclina(a1x, a1y, xx, yy));
				}
			} else
			 {
				if (scan(180, 3) == 0) 
					arriva(a1x, a1y, inclina(a1x, a1y, xx, yy));
				else
				 {
					if (scan(90, 3) == 0) 
						arriva(a3x, a3y, inclina(a3x, a3y, xx, yy));
					else 
						arriva(a2x, a2y, inclina(a2x, a2y, xx, yy));
				}
			}
		}
	}
	xx = loc_x(); 
	yy = loc_y();
	if (xx < 500 && yy < 500 ) 
		angolo = 0;
	else
	 {
		if (xx > 500 && yy > 500) 
			angolo = 2;
		else
		 {
			if (xx > 500 && yy < 500 ) 
				angolo = 3;
			else 
				angolo = 1;
		}
	}
}


