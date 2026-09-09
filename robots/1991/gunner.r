/*    GUNNER  -  (C) 1991 Ettore De Simone       */

int	place, dir, tgt, axis;
int	c1x, c1y;
int	c2x, c2y;
int	c3x, c3y;

main()
{
	c1x = 50;
	c1y = 500;
	c2x = 50;
	c2y = 950;
	c3x = 500;
	c3y = 950;

	place = 1;
	dir = 1;
	tgt = 0;

	first_place();
	while (1)
		new_place();
}



new_place()
{
	int	x, y, angle, new, dist;

	new = place + dir;
	if (new == 2 || new == 0)
		dir = -dir;
	place = new;
	if (place == 0) {
		x = c1x;
		y = c1y;
		axis = 0;
	}
	if (place == 1) {
		x = c2x;
		y = c2y;
	}
	if (place == 2) {
		x = c3x;
		y = c3y;
		axis = 1;
	}
	angle = plot_course(x, y);
	drive(angle, 100);
	while (dist_axis(x, y) > 1000 && speed() > 0) {
		if ((dist = scan(tgt, 5)) > 0)
			cannon(tgt, dist);
		else
			tgt += 10;
	}
	drive(angle, 0);
}


first_place()
{
	int	angle, dist;

	angle = plot_course(c2x, c2y);
	drive(angle, 100);
	while (distance(c2x, c2y) > 1000 && speed() > 0) {
		if ((dist = scan(tgt, 5)) > 0)
			cannon(tgt, dist);
		else
			tgt += 10;
	}
	drive(angle, 0);
}


distance(x1, y1)
int	x1;
int	y1;
{
	int	x, y;

	x = loc_x() - x1;
	y = loc_y() - y1;
	return ((x * x) + (y * y));
}


dist_axis(x1, y1)
int	x1;
int	y1;
{
	int	d;

	if (axis == 1)
		d = loc_x() - x1;
	else
		d = loc_y() - y1;
	return (d * d);
}


/************************************************************/

plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;
	curx = loc_x();
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	if (x == 0) {
		if (yy > cury)
			d = 90;
		else
			d = 270;
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);
			else
				d = 180 + atan((scale * y) / x);
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);
			else
				d = 180 + atan((scale * y) / x);
		}
	}
	return (d);
}


