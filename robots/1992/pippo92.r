/****************************************************************************
 * // Pippo //                                                              *
 * // Creola Andrea //                                                      *
 *                                                                          *
 * Pippo è un robot molto semplice , ma che segue tre tattiche differenti , *
 * che sono sopratutto difensive . La prima lo porta sui bordi del campo di *
 * battaglia dove combatta finche la variabile DAMAGE() non arriva a essere *
 * superiore di dieci alla variabile D che è il valore del damage di quando *
 * arriva sul bordo , dopo di che passa alla seconda tattica , che consiste *
 * nel girare attorno al campo di battaglia finche la variabile DAMAGE()    *
 * non arriva a 80 , in quel momento il robot si ferma . Questo lo può      *
 * avataggiare contro robot che come Jazz hanno usano un range più corto di *
 * quello fornito dallo scan .                                              *
 ****************************************************************************/

int	range, ang, min, max;
/****************************************************************************
 *                               MAIN                                       *
 ****************************************************************************/
main()
{
	int	d;
	ang = 0;
	speed(100);
	inizio();
	d = damage();
	while (1) {
		if (damage() < d + 11) 
			spara(min, max);
		if (damage() > d + 10) 
			parte2();
	}
	return;
}


/****************************************************************************
 *                               PARTE2                                     *
 ****************************************************************************/
parte2()
{
	while (1) {
		ang = 90;
		while (speed() > 50) 
			drive(ang, 50);
		drive (90, 100); /* su */
		while (loc_y() < 950) {
			if (damage() > 80) 
				drive(0, 0);
			if (range = scan (ang, 10)) 
				cannon (ang, range);
			else 
				ang += 10;
			if (ang >= 270) 
				ang = 90;
		}

		ang = 180;
		while (speed() > 50) 
			drive(ang, 50);
		drive (180, 100); /* sinistra */
		while (loc_x() > 50) {
			if (damage() > 80) 
				drive(0, 0);
			if (range = scan (ang, 10)) 
				cannon (ang, range);
			else 
				ang += 10;
			if (ang >= 360) 
				ang = 180;
		}

		ang = 270;
		while (speed() > 50) 
			drive(ang, 50);
		drive (270, 100); /* gi— */
		while (loc_y() > 50) {
			if (damage() > 80) 
				drive(0, 0);
			;
			if (range = scan (ang, 10)) 
				cannon (ang, range);
			else 
				ang += 10;
			if (ang > 360) 
				ang = 0;
			if ((ang >= 90) & (ang <= 110)) 
				ang = 270;
		}
		ang = 0;
		while (speed() > 50) 
			drive(ang, 50);
		drive (000, 100); /* Destra */
		while (loc_x() < 950) {
			if (damage() > 80) 
				drive(0, 0);
			if (range = scan (ang, 10)) 
				cannon (ang, range);
			else 
				ang += 10;
			if (ang >= 180) 
				ang = 0;
		}
	}
	return;
}


/****************************************************************************
 *                               INIZIO                                     *
 ****************************************************************************/
inizio()
int	angolo, dir, distanza;
{
	angolo = rand(4);
	if (angolo == 0) {
		dir = direzione(50, 950);
		drive (dir, 100);
		while (dist(50, 950) > 20) 
			spara(0, 360);
		drive (dir, 0);
		min = 270;
		max = 360;
	}
	if (angolo == 1) {
		dir = direzione(950, 950);
		drive (dir, 100);
		while (dist(950, 950) > 20) 
			spara(0, 360);
		drive (dir, 0);
		min = 180;
		max = 270;
	}
	if (angolo == 2) {
		dir = direzione(950, 50);
		drive (dir, 100);
		while (dist(950, 50) > 20) 
			spara(0, 360);
		drive (dir, 0);
		min = 90;
		max = 180;
	}
	if (angolo == 3) {
		dir = direzione(50, 50);
		drive (dir, 100);
		while (dist(50, 50) > 20) 
			spara(0, 360);
		drive (dir, 0);
		min = 0;
		max = 90;
	}
	return;
}


/****************************************************************************
 *                               DIREZIONE                                  *
 ****************************************************************************/
direzione (dest_x, dest_y)
int	dest_x, dest_y;
{
	int	dir, locx, locy;
	locx = loc_x();
	locy = loc_y();
	if (locx == dest_x ) {
		if (dest_y > locy)
			dir = 90;
		else
			dir = 270;
	} else
	 {
		if (dest_y < locy) {
			if (dest_x > locx)
				dir = 360 + atan ((100000 * (locy - dest_y)) / (locx - dest_x) );
			else
				dir = 180 + atan ((100000 * (locy - dest_y)) / (locx - dest_x) );
		} else if (dest_x > locx)
			dir = atan (100000 * (locy - dest_y) / (locx - dest_x));
		else
			dir = 180 + atan(100000 * (locy - dest_y) / (locx - dest_x));
	};
	return (dir);
}


/****************************************************************************
 *                               SPARA                                      *
 ****************************************************************************/
spara(min, max)
int	min, max;
{
	if (ang < min) 
		ang = min;
	if (ang > max) 
		ang = min;
	if (ang > 360) 
		ang = min;
	if (range = scan(ang, 10)) 
		cannon (ang, range);
	else 
		ang += 10;
	return;
}


/****************************************************************************
 *                               DISTANZA                                   *
 ****************************************************************************/
dist (x, y)
int	x, y;
{
	int	x1, y1, dis;
	x1 = loc_x() - x;
	y1 = loc_y() - y;
	dis = sqrt ((x1 * x1) + (y1 * y1));
	return (dis);
}


