/**
 * aswhup.r
 *
 * Author: Tim Hentenaar
 */
int heading, range, d, d2, x, y;

/**
 * Scan around for other robots, and fire at any we see.
 */
search()
{
	x = 0;
	while (x < 90) {
		if ((range = scan(heading -= x, 10)))
			return cannon(heading, range);
		if ((range = scan(heading -= (x >> 1), 10)))
			return cannon(heading, range);
		x += 15;
	}
}

/**
 * Get a rough idea of where we are in relation
 * to the center of the arena, and begin moving
 * towards it while searching for opponents.
 *
 * If we're too close to the target, move
 * slightly oblique.
 */
adjust_heading()
{
	d2 = d; d = damage();
	if (d != d2) heading += d * 180;
	if ((y = loc_y(x = loc_x()>500)>500)) {
		if (x) heading = 200;
		else heading = 300;
	} else {
		if (x) heading = 125;
		else heading = 395;
	}

	drive(heading += 35 * (range < 60), 100);
}

main()
{
	heading = rand(180);
	while(1)
		adjust_heading(search());
}
