/*BAEOS DI ALBERTO MORRI */

int	ang;
main()
{
	drive(0, 100);        /*muove verso est*/
	while (loc_x() < 960) 
		cannon(180, 300);
	drive(90, 0);
	while (speed() > 45) 
		cannon(180, 300);
	while (1) {
		drive(90, 100);  /*muove verso nord*/
		ang = 270;
		while (loc_y() < 940) {
			if (dist = scan(ang, 8)) /*cerca nemico*/ {
				cannon(ang, 7 * dist / 8);
				ang += 10;
			} else
			 {
				ang -= 10;
				if (ang <= 80) 
					ang = 280;
			}
		}
		drive(180, 0);
		while (speed() > 49) 
			cannon(225, 300);

		drive(180, 100);       /*muove verso ovest*/
		ang = 360;
		while (loc_x() > 60) {
			if (dist = scan(ang, 8)) /*cerca nemico*/ {
				cannon(ang, 7 * dist / 8);
				ang += 10;
			} else
			 {
				ang -= 10;
				if (ang <= 170) 
					ang = 370;
			}
		}
		drive(270, 0);
		while (speed() > 49) 
			cannon(315, 300);

		drive(270, 100);       /*muove verso sud*/
		ang = 450;
		while (loc_y() > 60) {
			if (dist = scan(ang, 8)) /*cerca nemico*/ {
				cannon(ang, 7 * dist / 8);
				ang += 10;
			} else
			 {
				ang -= 10;
				if (ang <= 280) 
					ang = 460;
			}
		}
		drive(90, 0);
		while (speed() > 49) 
			cannon(45, 300);

		drive(0, 100);   /*muove verso est*/
		ang = 180;
		while (loc_x() < 940) {
			if (dist = scan(ang, 8))   /*cerca nemico*/ {
				cannon(ang, 7 * dist / 8);
				ang += 10;
			} else
			 {
				ang -= 10;
				if (ang <= 0) 
					ang = 190;
			}
		}
		drive(90, 0);
		while (speed() > 49) 
			cannon(135, 300);
	}
}


