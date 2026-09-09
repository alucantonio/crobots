/* C-CYBER */
/* robot design by Victor Cerullo */
/* based on an original programming strategy by Tom Poindexter */
/* Activation Date: September, 7, 1991. */


register int	d;
int	last_dir;

main()
{
	int	angle, memory, range, microscan, mirange;
	long	i;
	last_dir = 0;
	d = 0;
	angle = 30;
	while (1) {
		while ((range = scan(angle, 7)) > 0) {
			if (range > 700) {
				drive(angle, 100);
				i = 1;
				while ((i++ < 10) && (d == damage()))
					;
				drive (angle, 0);
				if (d != damage()) {
					d = damage();
					run();
				}
			} else {
				memory = angle;
				angle -= 6;
				microscan = 0;
				while ((d == damage()) && (microscan++ <= 5) && (scan(memory, 7) > 0)) {
					if ((mirange = scan(angle, 1)) <= 700 && mirange > 0) {
						cannon(angle, mirange);
						microscan--;
					} else 
						angle += 3;
				}
				angle = memory;
				if (d != damage()) {
					d = damage();
					run();
				}
			}
		}
		if (d != damage()) {
			d = damage();
			run();
		}
		angle = (angle + 14) % 360;
	}
}


run()
{
	int	j, x, y;
	x = loc_x();
	y = loc_y();
	j = 0;
	if (last_dir == 0) {
		last_dir = 1;
		if (y > 512) {
			drive(270, 100);
			while ((y - 200 < loc_y()) && (d == damage()))
				;
			drive(270, 0);
		} else {
			drive(90, 100);
			while ((y + 200 > loc_y()) && (d == damage()))
				;
			drive(90, 0);
		}
	} else {
		last_dir = 0;
		if (x > 512) {
			drive(180, 100);
			while ((x - 200 < loc_x()) && (d == damage()))
				;
			drive(180, 0);
		} else {
			drive(0, 100);
			while ((x + 200 > loc_x()) && (d == damage()))
				;
			drive(0, 0);
		}
	}
}


