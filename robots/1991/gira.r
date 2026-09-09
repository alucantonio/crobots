/* Programma per Crobot */
/* By Gabriele Morra */

int	ang, mem, range;
main()
{
	drive(90, 100);
	ang = 90;

	while (1) {
		while (loc_y() < 950) 
			Spara();
		Guida(180);
		while (loc_x() > 50) 
			Spara();
		Guida(270);
		while (loc_y() > 50) 
			Spara();
		Guida(0);
		while (loc_x() < 950) 
			Spara();
		Guida(90);
	}
}


Guida(ang2)
int	ang2;
{
	int	l;
	drive(ang2 + 90, 0);
	l = 1;
	while ((l += 1) < 7) 
		drive(ang2 + 90, 0);
	drive(ang2, 100);
	mem = ang2;
}


Spara()
{
	if (range = scan(ang, 10)) {
		if (range < 750) 
			cannon(ang, range);
	} else if (ang > mem + 5) 
		ang += 170;
	else 
		ang += 18;
}


