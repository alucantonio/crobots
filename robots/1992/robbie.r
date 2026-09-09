
/**********************************************************************
 *   ROBBIE     CRobot di Mario Mene' 20/09/1992                      *
 *                                                                    *
 * Robbie corre su un percorso triangolare sparando velocemente con   *
 * poca precisione ed un range ridotto. Di derivazione Jazzistica     *
 * non puo' essere considerato intelligente ma sicuramente si e'      *
 * dimostrato efficiente nelle prove con i vecchi robots              *          *
 *                                                                    *
 **********************************************************************/


int	Dir, Range, DirR;

main()
{
	DirR = angolo (900, 100);       /* direzione iniziale */


	/* ciclo infinito*/
	while (1) {
		drive (DirR, 100);
		while (loc_y() > 90 && speed()) {
			/* se ho inquadrato qualcuno sparo */
			if (Range = scan (Dir, 3))
				cannon (Dir, 7 * Range / 8);
			else
			 {
				/* altrimenti cerco un obiettivo */
				Dir -= 23;
				while (!(Range = scan (Dir, 10)))
					Dir += 20;
				/* e poi sparo */
				if (Range < 60)
					Range = 60;
				cannon (Dir, 8 * Range / 9);
			};
		};
		DirR = angolo (666, 900);       /* seconda direzione */
		while (speed() > 50)
			drive (DirR, 50);

		drive (DirR, 100);
		while (loc_y() < 910 && speed()) {
			if (Range = scan (Dir, 3))
				cannon (Dir, 8 * Range / 9);
			else
			 {
				Dir -= 23;
				while (!(Range = scan (Dir, 10)))
					Dir += 20;
				if (Range < 60)
					Range = 60;
				cannon (Dir, 7 * Range / 8);
			};
		};
		DirR = angolo (100, 333);       /* terza direzione */
		while (speed() > 50)
			drive (DirR, 50);

		drive (DirR, 100);
		while (loc_x() > 90 && speed()) {
			if (Range = scan (Dir, 3))
				cannon (Dir, 7 * Range / 8);
			else
			 {
				Dir -= 23;
				while (!(Range = scan (Dir, 10)))
					Dir += 20;
				if (Range < 60)
					Range = 60;
				cannon (Dir, 8 * Range / 9);
			};
		};
		DirR = angolo (900, 100);
		while (speed() > 50)
			drive (DirR, 50);
	};
}


angolo (x, y)
int	x, y;
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


