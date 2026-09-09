/**********************************************************************
 *                                                                    *
 *  SASSY  (dedicato alla mitica Sarah)                     15/9/92   *
 *                                                                    *
 *              by Giuseppe Menozzi Genova, 2:332/218.2@fidonet       *
 *                                                                    *
 *         CRobot derivato da Jazz, che descrive sul bordo sinistro   *
 *         dello schermo una "W". Su alcuni tratti sfrutta lo stesso  *
 *         algoritmo di fuoco di Jazz (Spara78()), su altri spara     *
 *         senza variazioni del Range. Esprime la massima efficienza  *
 *         nei tornei con match a 4 robot.                            *
 *                                                                    *
 **********************************************************************/

int	Dir, Range;

Spara()
{
	if (Range = scan (Dir, 3))
		cannon (Dir, Range);
	else
	 {
		Dir -= 43;
		while (!(Range = scan (Dir, 10))) 
			Dir += 20;
		if (Range < 60) 
			Range = 60;
		cannon (Dir, Range);
	}
}


Spara78()
{
	if (Range = scan (Dir, 3))
		cannon (Dir, 7 * Range / 8);
	else
	 {
		Dir -= 43;
		while (!(Range = scan (Dir, 10))) 
			Dir += 20;
		if (Range < 60) 
			Range = 60;
		cannon (Dir, 7 * Range / 8);
	}
}


main()
{
	drive (270, 100);
	while (loc_y() > 80)
		Spara78();
	drive (180, 0);
	while (speed() > 50)
		Spara78();

	drive (180, 100);
	while (loc_x() > 80)
		Spara78();
	drive (90, 0);
	while (speed() > 50)
		Spara78();

	drive (90, 100);
	while (loc_y() < 250)
		Spara78();
	drive (90, 0);
	while (speed() > 50)
		Spara78();

	while (1) {
		drive (45, 100); 
		Spara(); 
		while (speed() && loc_x() < 245) 
			Spara(); 
		drive (135, 0); 
		while (speed() > 50) 
			drive(135, 0);
		drive (135, 100); 
		Spara78(); 
		while (speed() && loc_x() > 60) 
			Spara78(); 
		drive (45, 0); 
		while (speed() > 50) 
			drive(45, 0);
		drive (45, 100); 
		Spara78(); 
		while (speed() && loc_y() < 940) 
			Spara78(); 
		drive (225, 0); 
		while (speed() > 50) 
			drive(225, 0);
		drive (225, 100); 
		Spara78(); 
		while (speed() && loc_x() > 60) 
			Spara78(); 
		drive (315, 0); 
		while (speed() > 50) 
			drive (315, 0);
		drive (315, 100); 
		Spara(); 
		while (speed() && loc_x() < 245) 
			Spara(); 
		drive (225, 0); 
		while (speed() > 50) 
			drive (225, 0);
		drive (225, 100); 
		Spara78(); 
		while (speed() && loc_x() > 60) 
			Spara78(); 
		drive (315, 0); 
		while (speed() > 50) 
			drive (315, 0);
		drive (315, 100); 
		Spara78(); 
		while (speed() && loc_y() > 60) 
			Spara78(); 
		drive (135, 0); 
		while (speed() > 50) 
			drive (135, 0);
		drive (135, 100); 
		Spara78(); 
		while (speed() && loc_x() > 60) 
			Spara78(); 
		drive (45, 0); 
		while (speed() > 50) 
			drive (45, 0);
	}
}


