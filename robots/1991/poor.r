main() 
{
	int	i; 
	int	r; 
	int	a; 
	int	b; 
	int	c; 
	int	l; 
	int	k; 
	int	m;
	k = 90;
	while (loc_x() > 50) {
		drive(180, 100);
	}
	while (1) {
		while (scan(i, 10) < 50) {
			i += 20; 
			drive(k, 100);
			if (i > 360) {
				i = 20;
			}
			if ((i > 90) && (i < 270)) {
				i += 160;
			}
			if (loc_y() > 875) {
				k = 270;
			}
			if (loc_y() < 125) {
				k = 90;
			}
		}
		if (loc_y() > 875) {
			k = 270;
		}
		if (loc_y() < 125) {
			k = 90;
		}
		drive(k, 100);
		r = scan(i + 8, 2); 
		b = scan(i - 9, 2);
		a = scan(i + 3, 2); 
		c = scan(i - 3, 2);
		i += ((k - 180) / 45);
		if (r > 50) {
			cannon(i + 9 + (r / 90), r + 30);
		}
		if (b > 50) {
			cannon(i - 9 + (b / 90), b + 30);
		}
		if (a > 50) {
			cannon(i + 4 + (a / 90), a + 10);
		}
		if (c > 50) {
			cannon(i - 4 + (c / 90), c + 10);
		}
	}
}


