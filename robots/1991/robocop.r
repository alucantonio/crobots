/* ROBOCOP V3.0 (c) 1991 Carmine Della Sala */
/* Robot per il torneo di MCmicrocomputer   */

int	angle;
main()
{
	angle = 350;
	drive (0, 100);
	while (loc_x() < 960) 
		fire();
	drive (270, 0);
	rallenta();
	angle = 270;
	drive (270, 100);
	while (loc_y() > 80) 
		fireone();
	drive (90, 0);
	rallenta();
	while (1) {
		drive (90, 100);
		while (loc_y() < 920) 
			fireone();
		drive (270, 0);
		rallenta();
		drive (270, 100);
		while (loc_y() > 80) 
			fireone();
		drive (90, 0);
		rallenta();
	}

}


fireone()
{
	int	range;

	range = scan(angle, 10);
	if ((range != 0) && (range < 850))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle <= 70)
			angle = 270;
	}
}


fire()
{
	int	range;
	if (range = scan(angle, 10))
		cannon(angle, range);
	else
	 {
		angle -= 20;
		if (angle == -10) 
			angle = 350;
	}
}


rallenta()
{
	while (speed() > 49) 
		fireone();
}


