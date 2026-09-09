/* WarriorIII V 2.0 
   Programmato da Carmine Della Sala

 Il robot si muove in diagonale ed utilizza una routine di fuoco che varia
 il range basandosi sul movimento del bersaglio.
*/

int	d, pa, ang, newrange, oldrange;
main()
{
	drive(0, 100);
	while (loc_x() < 940) 
		spara();
	drive(270, 0);
	while (speed() > 49) 
		spara();

	drive(270, 100);
	while (loc_y() > 60) 
		spara();
	drive(135, 0);
	while (speed() > 49) 
		spara();

	ang = 0;
	while (1) {
		drive(135, 100);
		while (loc_y() < 940) 
			spara();
		drive(315, 0);
		while (speed() > 49) 
			spara();

		drive(315, 100);
		while (loc_y() > 60) 
			spara();
		drive(135, 0);
		while (speed() > 49) 
			spara();
	}


}


spara()
{

	if (newrange = scan(ang, 10)) {
		if (oldrange < newrange) {
			cannon(ang, 8 * newrange / 7);
			oldrange = newrange;
		} else
		 {
			cannon(ang, 7 * newrange / 8);
			oldrange = newrange;
		}
	} else   {
		ang -= 23;
		while (!(newrange = scan(ang, 10))) 
			ang += 20;
		if (newrange < 60) 
			newrange = 60;
		cannon (ang, 7 * newrange / 8);
	}
}














