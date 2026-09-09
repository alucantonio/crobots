/* Robocop III V 1.0
   Programmato da Carmine Della Sala

 Il robot si muove lungo il lato destro dell' area di combattimento ed 
 utilizza una routine di fuoco che varia il range in base al movimento
 del bersaglio.Cerca di individuare gli avversari in un raggio di 750 
 metri.
*/
int     ang, newrange, oldrange;
main()
{
	drive(0, 100);
	while (loc_x() < 960) 
		spara();
	drive(90, 0);
	while (speed() > 49) 
		spara();

	ang = 270;
	while (1) {
		drive(90, 100);
		while (loc_y() < 920) 
			spara();
		drive(270, 0);

		while (speed() > 49) 
			spara();

		drive(270, 100);
		while (loc_y() > 80) 
			spara();
		drive(90, 0);

		while (speed() > 49) 
			spara();
	}


}
spara()
{

	if ((newrange = scan(ang, 10))&&(newrange<750)) {
		if (oldrange < newrange) {
			cannon(ang, 8 * newrange / 7);
			oldrange = newrange;
		} else
		 {
			cannon(ang, 7 * newrange / 8);
			oldrange = newrange;
		}
	} else   {
		ang -= 20;
		if (ang <= 70) 
			ang = 270;
	}
}


