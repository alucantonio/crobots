/* Programma di prova per Crobot */
/* By Gabriele Morra */

int	angd, angs, range;
main()
{
	drive(90, 100);
	angd = 90;
	angs = 90;
	while (loc_y() < 920) 
		Spara();
	Guida(0);
	while (loc_x() < 920) 
		Spara();

	while (1) {
		Guida(225);
		while ((loc_y() > 60) && (loc_x() > 60)) 
			Spara();
		Guida(45);
		while ((loc_y() < 940) && (loc_x() < 940)) 
			Spara();
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
}


Spara()
{
	if (range = scan(angd, 10)) {
		if (range < 730) 
			cannon(angd, range);
		angs = angd - 15;
	} else {
		if (range = scan(angs, 10)) {
			if (range < 730) 
				cannon(angs, range);
			angd = angs;
			angs -= 15;
		} else {
			angd += 15;
			angs -= 15;
		}
	}
}


