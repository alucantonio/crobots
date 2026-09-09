/*  Bry_Bry C-Robot   Roma 03/07/92  */

/*  Scorre l' arena secondo traiettorie
    orizzontali e verticali.
    Spara, secondo 3 procedure di fuoco,
    a 7/8, 8/7 o 8/9 dell' effettivo range.
    (Per maggiori dettagli vedere la scheda nel
     file Scheda.Doc)     

    Cristiano De Mei
*/

int	a1, a2, ang;
main()
{
	a1 = 0;
	a2 = 359;
	ang = 0;
	while (loc_y() < 950) { 
		drive(90, 100);
		fuoco1(); 
	}
	drive(90, 0);
	while (speed() > 49) 
		fuoco1();
	while (loc_x() > 50) { 
		drive(180, 100);
		fuoco2(); 
	}
	drive(0, 0);
	while (speed() > 49) 
		fuoco2();
	drive(270, 100);

	while (1) {
		while (loc_y() > 50) 
			fuoco3();
		while (speed() > 50) 
			drive(360, 50);

		drive(360, 100);
		a1 = 0;
		a2 = 180;
		while (loc_x() < 950) 
			fuoco2();
		while (speed() > 50) 
			drive(90, 50);

		drive(90, 100);
		a1 = 90;
		a2 = 270;
		while (loc_y() < 950) 
			fuoco1();
		while (speed() > 50) 
			drive(180, 50);

		drive(180, 100);
		a1 = 180;
		a2 = 360;
		while (loc_x() > 50) 
			fuoco2();
		while (speed() > 50) 
			drive(270, 50);

		drive(270, 100);
	}
}


fuoco1()
{
	int	range;

	if (range = scan(ang, 8)) {
		cannon(ang, 7 * range / 8);
		if (range > 530)
			ang += 18;
	} else
	 {
		ang += 18;
		if (ang > a2) 
			ang = a1;
	}
}


fuoco2()
{
	int	range;

	if (range = scan(ang, 8)) {
		cannon(ang, 8 * range / 7);
		if (range > 570)
			ang += 18;
	} else
	 {
		ang += 18;
		if (ang > a2) 
			ang = a1;
	}
}


fuoco3()
{
	int	range;

	if (range = scan(ang, 8)) {
		cannon(ang, 8 * range / 9);
		if (range > 520)
			ang += 18;
	} else
	 {
		ang += 18;
		if (ang == 108) 
			ang = 270;
		if (ang > 359) 
			ang = 0;
	}
}


