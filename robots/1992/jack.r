/**********************************************************************
 * Nome Robot : Jack.r                                                *
 * Autore     : Sergio Chersovani                                     *
 * Strategia  : Corre sui lati modificando la strategia a seconda del *
 *              numero dei nemici e con una buona precisione di tiro  *
 **********************************************************************/


int	x, nem, giri;
int	dir, range, u, scala, pos_x, pos_y;
main()
{
	drive(0 + 180 * (loc_x() > 500), 100);
	drive(270, 100);
	dir = 270;
	nem = 0;
	scala = 100000;
	while (1) {
		if ((dir == 90 && loc_y() > 890) || (dir == 270 && loc_y() < 110)
		     || (dir == 0 && loc_x() > 890) || (dir == 180 && loc_x() < 110)) {
			drive(dir += 90, 0);
			while (speed() > 49)
				;
			drive(dir, 100);
			if (dir == 360) {
				dir = 0;
				if (giri = 2) {
					giri = 70;
					while (giri < 280) 
						nem += (scan(giri += 19, 10) != 0);
					if (nem < 2) 
						win(dir);
					giri = 0;
					nem = 0;
				} else 
					giri += 1;
			}
		}
		if (speed() < 50) 
			drive(dir, 100);
		if (range > 0 && range < 701) {
			x = calc(xy2dir(pos_x, pos_y) - 12);
			while ((range = scan((x = calc(x + 6)), 3)) == 0)
				;
			if ((calc(x - dir) * 10 / 18) > 85 || (calc(x - dir) * 10 / 18) < 3 ) 
				cannon(x, 7 * range / 8);
			else 
				cannon((x = calc(x + 2)), range);
			pos_x = loc_x() + cos(x) * range / scala;
			pos_y = loc_y() + sin(x) * range / scala;
			if ((calc(x - dir) * 10 / 18) > 85 || (calc(x - dir) * 10 / 18) < 3 ) 
				cannon(x, 7 * range / 8);
			else 
				cannon((x = calc(x + 3)), range);
		} else {
			if (!(range = scan(x = dir, 10)))  {
				if (!(range = scan(x = calc(dir + 180), 10)))  {
					range = scan(x = calc(rand(180) + dir), 10);
				}
			}
		}
	}
}


calc(z)
int	z;
{
	if (z < 0) 
		return(360 + z);
	if (z > 360) 
		return(z - 360);
	else 
		return(z);
}


win(dir)
int	dir, u, scala, pos_x, pos_y;
{
	scala = 100000;
	x = calc(dir - 10);
	while ((range = scan(x = calc(x + 21), 10)) == 0 )
		;
	pos_x = loc_x() + cos(x) * range / scala;
	pos_y = loc_y() + sin(x) * range / scala;
	while (1) {
		if ((dir == 90 && loc_y() > 890) || (dir == 270 && loc_y() < 110)
		     || (dir == 0 && loc_x() > 890) || (dir == 180 && loc_x() < 110)) {
			drive(dir += 90, 0);
			while (speed() > 49)
				;
			if (dir == 360) 
				dir = 0;
			drive(dir, 100);
		}
		drive(dir, 100);
		x = calc(xy2dir(pos_x, pos_y) - 12);
		while ((range = scan((x = calc(x + 6)), 3)) == 0)
			; 
		 {
			if ((dir == 90 && loc_y() > 890) || (dir == 270 && loc_y() < 110)
			     || (dir == 0 && loc_x() > 890) || (dir == 180 && loc_x() < 110)) {
				drive(dir += 90, 0);
				while (speed() > 49)
					;
				if (dir == 360) 
					dir = 0;
				drive(dir, 100);
			}
		}
		if ((calc(x - dir) * 10 / 18) > 85 || (calc(x - dir) * 10 / 18) < 3 ) 
			cannon(x, 7 * range / 8);
		else 
			cannon((x = calc(x + 3)), range);
		pos_x = loc_x() + cos(x) * range / scala;
		pos_y = loc_y() + sin(x) * range / scala;
	}
}


xy2dir(x, y)
int	x, y;
{
	int	d, locx, locy;

	locx = loc_x();
	locy = loc_y();

	if (locx == x) {
		if (y > locy)
			d = 90;
		else
			d = 270;
	} else
	 {
		if (y < locy) {
			if (x > locx)
				d = 360 + atan((100000 * (locy - y)) / (locx - x));
			else
				d = 180 + atan((100000 * (locy - y)) / (locx - x));
		} else if (x > locx)
			d = atan((100000 * (locy - y)) / (locx - x));
		else
			d = 180 + atan((100000 * (locy - y)) / (locx - x));
	};
	return(d);
}






