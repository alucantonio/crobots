/* Warrior V2.0 (c) 1991 Carmine Della Sala                       */
/* Robot per il torneo di MCmicrocomputer                         */
int	angle;
main()
{
	angle = 100;
	drive (180, 100);
	while (loc_x() > 50) 
		fireone();
	drive (270, 0);
	rallenta();
	drive (270, 100);
	while (loc_y() > 80) 
		fireone();
	drive (90, 0);
	rallenta();
	while (1) {
		angle = 100;
		drive (90, 100);
		while (loc_y() < 940) 
			fireone();
		drive (0, 0);
		rallenta();
		angle = 350;
		drive (0, 100);
		while (loc_x() < 940) 
			firetwo();
		drive (270, 0);
		rallenta();
		angle = 80;
		drive (270, 100);
		while (loc_y() > 80) 
			firethree();
		drive (180, 0);
		rallenta();
		angle = 190;
		drive (180, 100);
		while (loc_x() > 80) 
			firefour();
		drive (90, 0);
		rallenta ();
	}
}


fireone()
{
	int	range;
	if (range = scan(angle, 10))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle == 0) 
			angle = 340;
		if (angle == 260) 
			angle = 100;
	}
}


firetwo()
{
	int	range;
	if (range = scan(angle, 10))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle == 170) 
			angle = 350;
	}
}


firethree()
{
	int	range;
	if (range = scan(angle, 10))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle == 260) 
			angle = 80;
	}
}


firefour()
{
	int	range;
	if (range = scan(angle, 10))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle == -10) 
			angle = 190;
	}
}


rallenta()
{
	while (speed() > 49) 
		fireone();
}


