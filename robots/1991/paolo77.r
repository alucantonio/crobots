/*	crobot della serie	   paolo7			*/
/*	Robot Stellare				 		*/
/*	versione :	7					*/
/*	nome paolo77.r						*/
/*								*/
/*      autore : 	Paolo Torda  	( MC6617 )		*/


main()
{
	while (1) {
		go(200, 150);
		go(500, 850);
		go(800, 150);
		go(180, 450);
		go(820, 550);
	}
}


/*
   GO(ax,ay)
   Sposta il robot alle coordinate (ax,ay) 
*/


go(ax, ay)
int	ax, ay;
{
	int	result;
	int	an;

	an = angolo_rotazione(ax, ay);

	while (distanza(ax, ay) > 3500) {
		drive(an, 100);

		if (result = scan(0, 10))
			cannon(0, result);


		if (result = scan(110, 10))
			cannon(110, result);


		if (result = scan(225, 10))
			cannon(225, result);


		if (result = scan(335, 10))
			cannon(335, result);


		if (result = scan(90, 10))
			cannon(90, result);


		if (result = scan(200, 10))
			cannon(200, result);


		if (result = scan(315, 10))
			cannon(315, result);


		if (result = scan(65, 10))
			cannon(65, result);


		if (result = scan(180, 10))
			cannon(180, result);


		if (result = scan(290, 10))
			cannon(290, result);


		if (result = scan(45, 10))
			cannon(45, result);


		if (result = scan(155, 10))
			cannon(155, result);


		if (result = scan(270, 10))
			cannon(270, result);


		if (result = scan(20, 10))
			cannon(20, result);


		if (result = scan(135, 10))
			cannon(135, result);


		if (result = scan(245, 10))
			cannon(245, result);

	}
	drive(an, 40);
}


/* Calcola l'angolo di rotazione */
angolo_rotazione(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	curx;

	curx = loc_x();
	x = curx - xx;
	y = (loc_y() - yy) * 100000;

	if (xx > curx)
		d = 360 + atan(y / x);
	else
		d = 180 + atan(y / x);

	return (d);
}


distanza(x1, y1)
int	x1;
int	y1;
{
	int	x, y, d;


	x = x1 - loc_x();
	y = y1 - loc_y();
	d = (x * x) + (y * y);

	return(d);
}


