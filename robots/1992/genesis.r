/* 
   GENESIS.R
   ---------
   Claudio DAFFRA
*/

int	dir, range;

main()
{
	dir = 270;
	drive(270, 100);
	while (loc_y() > 50)
		if (range = scan(dir, 3))
			cannon ( dir, 7 * range / 8 );
		else
		 {
			dir -= 23;
			range = 800;
			while ( range > 750 && loc_y() > 50 )
				while (!(range = scan(dir, 10)) && loc_y() > 50 )
					dir += 20;
			if (range < 60) 
				range = 60;
			cannon (dir, 7 * range / 8);
		};
	drive(0, 50);
	while (speed() > 49)
		if (range = scan(dir, 10)) 
			cannon(dir, 7 * range / 8);
	while (1) {
		drive(0, 100);
		while (loc_x() < 920) {
			if (range = scan(dir, 3))
				cannon ( dir, 7 * range / 8 );
			else
			 {
				dir -= 23;
				range = 800;
				while ( range > 750 && loc_x() < 920 ) {
					while (!(range = scan(dir, 10)) && loc_x() < 920 ) {
						dir += 20;
						if (dir > 180) 
							dir = 0;
					}
				}
				if (range < 60) 
					range = 60;
				cannon (dir, 7 * range / 8);
			};
		}
		drive(180, 50);
		while (speed() > 49)
			if (range = scan(dir, 10)) 
				cannon(dir, 7 * range / 8);

		drive(180, 100);
		while (loc_x() > 80) {
			if (range = scan(dir, 3))
				cannon ( dir, 7 * range / 8 );
			else
			 {
				dir -= 23;
				range = 800;
				while ( range > 750 && loc_x() > 80 ) {
					while (!(range = scan(dir, 10)) && loc_x() > 80 ) {
						dir += 20;
						if (dir > 180) 
							dir = 0;
					}
				}
				if (range < 60) 
					range = 60;
				cannon (dir, 7 * range / 8);
			};
		}
		drive(0, 50);
		while (speed() > 49)
			if (range = scan(dir, 10)) 
				cannon(dir, 7 * range / 8);
	}
}


