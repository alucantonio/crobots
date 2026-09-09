/* Filippo Quondam */

int	range, ang;
main()
{ 
	while (loc_x() < 800) 
		drive(0, 100);
	while (speed() > 49) 
		drive(0, 0);
	while (loc_y() < 800) 
		drive(90, 100);
	while (speed() > 49) 
		drive(90, 0);
	while (1) {

		while (loc_x() < 800) {
			drive(45, 100);
			while (scan(ang, 10) < 41) 
				ang += 20;

			if ((range = scan(ang + 5, 5)) > 10) {
				ang += 7;
				cannon(ang + 6, range);
			} else if ((range = scan(ang - 5, 5)) > 10) {
				ang -= 7;
				cannon(ang - 6, range);
			}

		}

		while (loc_x() > 200) {
			drive(225, 100);
			while (scan(ang, 10) < 41) 
				ang += 20;
			if ((range = scan(ang + 5, 5)) > 10) {
				ang += 7;
				cannon(ang + 6, range);
			} else if ((range = scan(ang - 5, 5)) > 10) {
				ang -= 7;
				cannon(ang - 6, range);
			}
		}
	}          
}


