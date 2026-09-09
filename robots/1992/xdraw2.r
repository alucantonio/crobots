/*          Xdraw.r                  */
/*                                  */
/*   di Andrea De Baggis            */
/*          mc5912                  */
/*                                  */
int	angle, a, ang, angvec, d, f, l, ymax, xmin;
main()
{
	ang = 0;
	angle = 45;
	Frena();                   /* si sposta verso un angolo */
	drive(angle, 0);
	while (1) {
		angvec = angle;                   /* si sposta lungo la diagonale*/
		if (loc_y() >= ymax)
			angle = 220;

		if (loc_x() <= xmin)
			angle = 45;

		if (angvec |= angle) {
			drive(angvec, 0);
			while (speed() > 49) 
				fire();
			drive(angle, 100);
		}
		fire();
	}
}


fire()
{
	int	range;
	d = damage();
	if (range = scan(f, 5))          /* cerca il robot avversario      */
		cannon(f, range + 5);    /* prima sui lati */
	if (range = scan(l, 5))
		cannon(l, range + 5);
	if (range = scan(f + ang, 5))      /* poi in tutto il campo         */
		cannon(f + ang, range + 5);
	else 
		ang += 10;
	if (ang > 110) 
		ang = 0;
	if (damage() > 75) 
		fuga();        /* e fugge se i danni superano 75% */

}


Frena()
{
	if (loc_x() < 500) {

		if (loc_y() <= 850) {
			drive(90, 49);
			while (loc_y() <= 800) 
				fire();
		}

		if (loc_x() >= 50)                      /* si avvia verso l' angolo */ {                                   /* in alto a sinistra */
			drive(180, 49);
			while (loc_x() >= 50) 
				fire();
		}
		f = 250;
		ymax = 940;
		xmin = 60;
		a = 1;
		l = 15;
	} else
	 {
		if (loc_y() > 50) {                            /* o verso quello a destra */
			drive(270, 49);                /* in basso */
			while (loc_y() > 100) 
				fire();
		}

		if (loc_x() < 850) {
			drive(0, 49);
			while (loc_x() < 800) 
				fire();
		}

		f = 80;
		ymax = 90;
		xmin = 850;
		a = 2;
		l = 190;
	}
}


fuga()
{   
	int	range;
	ang = 0;
	if (a == 1) {
		if (loc_x() >= 30) {
			drive(180, 49);                   /* se Š stato troppo     */
			while (loc_x() >= 30) 
				fire();     /* danneggiato si        */
		}                                      /* nell' angolo e non    */
		if (loc_y() <= 990)                        /* si muove continuando  */ {
			/* a sparare             */
			drive(90, 49);
			while (loc_y() <= 990) 
				fire();
		}
		drive (0, 0);
	}
	if (a == 2) {
		if (loc_y() >= 30) {
			drive(270, 49);                   /* se Š stato troppo     */
			while (loc_y() >= 30) 
				fire();     /* danneggiato si        */
		}                                      /* nell' angolo e non    */
		if (loc_x() <= 990)                        /* si muove continuando  */ {
			/* a sparare             */
			drive(0, 49);
			while (loc_x() <= 990) 
				fire();
		}
		drive (0, 0);
	}

	while (1) {
		if (range = scan(f + ang, 7))
			cannon(f + ang, range);
		else 
			ang += 10;
		if (ang > 110) 
			ang = 0;
	}
}


