/*
   Runner: Corre sui bordi dello schermo alla massima velocità
   in modo da non farsi colpire e spara a tutto spiano...
*/

int	ang, ang1, ang2, range;
main()
{
	ang = ang1 = 0; 
	ang2 = 360;
	while (loc_y() > 60) {
		spara();
		if ( !speed()) 
			drive (270, 100);
		spara();
	}

	while (1) {
		drive (270, 49);
		while (speed() > 49) 
			spara();
		drive(0, 100);
		ang = ang1 = 0; 
		ang2 = 180;
		while (loc_x() < 940) {
			spara();
			if ( !speed()) 
				drive (0, 100);
			spara();
		}

		drive (0, 49);
		while (speed() > 49) 
			spara();
		drive(90, 100);
		ang = ang1 = 90; 
		ang2 = 270;
		while (loc_y() < 940) {
			spara();
			if ( !speed()) 
				drive (90, 100);
			spara();
		}

		drive (90, 49);
		while (speed() > 49) 
			spara();
		drive(180, 100);
		ang = ang1 = 180; 
		ang2 = 360;
		while (loc_x() > 60) {
			spara();
			if ( !speed()) 
				drive (180, 100);
			spara();
		}

		drive (180, 49);
		while (speed() > 49) 
			spara();
		drive(270, 100);
		ang = ang1 = 270; 
		ang2 = 450;
		while (loc_y() > 60) {
			spara();
			if ( !speed()) 
				drive (270, 100);
			spara();
		}

	}
}


spara()
{
	if (range = scan(ang, 10))
		cannon(ang, range);
	else
	 {
		if (ang >= ang2) 
			ang = ang1;
		ang += 20;
	}
}


