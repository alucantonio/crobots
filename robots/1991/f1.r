int	r, range, ang;
main()
{
	while (loc_y() < 935) 
		drive(90, 100);
	while (1) {
		attendi(180);
		while (loc_x() > 60)
			if ((range = scan(180, 10)) > 10) {
				r = scan(180, 10);
				if (r < range) {
					while ((loc_x() > 80) && ((range = scan(180, 10)) > 10)) 
						spvicina(180);
					if (loc_x() > 800)
						while (loc_x() > 80) 
							spdav(0);
					else
						while (loc_x() > 80) 
							spdietro(0);
				} else
				 {
					if (r < 580)
						while ((loc_x() > 80) && ((range = scan(180, 10)) > 10)) 
							cannon(180, 62 * range / 50);
					else
						while ((loc_x() > 80) && ((range = scan(180, 10)) > 10)) 
							spvicina(180);
					while (loc_x() > 80) 
						spdav(0);
				}
			}
			else
			 {  
				while ((scan(ang + 180, 10) < 11) && (loc_x() > 80)) {
					ang += 20;
					ang %= 180;
				}
				ang += 180;
				spara();
			}

		attendi(270);
		while (loc_y() > 60)
			if ((range = scan(270, 10)) > 10) {
				r = scan(270, 10);
				if (r < range) {
					while ((loc_y() > 80) && ((range = scan(270, 10)) > 10)) 
						spvicina(270);
					if (loc_y() < 800)
						while (loc_y() > 80) 
							spdav(90);
					else
						while (loc_y() > 80) 
							spdietro(90);
				} else
				 {
					if (r < 580)
						while ((loc_y() > 80) && ((range = scan(270, 10)) > 10)) 
							cannon(270, 62 * range / 50);
					else
						while ((loc_y() > 80) && ((range = scan(270, 10)) > 10)) 
							spvicina(270);
					while (loc_y() > 80) 
						spdav(90);
				}
			}
			else
			 { 
				while ((scan(ang + 270, 10) < 11) && (loc_y() > 80)) {
					ang += 20;
					ang %= 180;
				}
				ang += 270;
				spara();
			}


		attendi(0);
		while (loc_x() < 940)
			if ((range = scan(0, 10)) > 10) {
				r = scan(0, 10);
				if (r < range) {
					while ((loc_x() < 920) && ((range = scan(0, 10)) > 10)) 
						spvicina(0);
					if (loc_x() > 200)
						while (loc_x() < 920) 
							spdav(180);
					else
						while (loc_x() < 920) 
							spdietro(180);
				} else
				 {
					if (r < 580)
						while ((loc_x() < 920) && ((range = scan(0, 10)) > 10)) 
							cannon(0, 62 * range / 50);
					else
						while ((loc_x() < 920) && ((range = scan(0, 10)) > 10)) 
							spvicina(0);
					while (loc_x() < 920) 
						spdav(180);
				}
			}
			else {
				while ((scan(ang, 10) < 41) && (loc_x() < 910)) {
					ang += 20;
					ang %= 180;
				}
				spara();
			}


		attendi(90);
		while (loc_y() < 935)
			if ((range = scan(90, 10)) > 10) {
				r = scan(90, 10);
				if (r < range) {
					while ((loc_y() < 920) && ((range = scan(90, 10)) > 10)) 
						spvicina(90);
					if (loc_y() > 200)
						while (loc_y() < 920) 
							spdav(270);
					else
						while (loc_y() < 920) 
							spdietro(270);
				} else
				 {
					if (r < 580)
						while ((loc_y() < 920) && ((range = scan(90, 10)) > 10)) 
							cannon(90, 62 * range / 50);
					else
						while ((loc_y() < 920) && ((range = scan(90, 10)) > 10)) 
							spvicina(90);
					while (loc_y() < 920) 
						spdav(270);
				}
			}
			else
			 {
				while ((scan(ang + 90, 10) < 41) && (loc_y() < 920)) {
					ang += 20;
					ang %= 180;
				}
				ang += 90;
				spara();
			}

	} 
}


spara()
{
	if ((range = scan(ang + 5, 5)) > 10) {
		ang += 5;
		cannon(ang + range / 100, range);
	} else if ((range = scan(ang - 5, 5)) > 10) {
		ang -= 5;
		cannon(ang - range / 100, range);
	}
}


spdav(q)
int	q;
{ 
	if ((range = scan(q, 10)) > 10) 
		cannon(q, range + range / 5);
}


spdietro(q)
int	q;
{
	if ((range = scan(q, 10)) > 10) 
		cannon(q, range - range / 6);
}


spvicina(q)
int	q;
{
	cannon(q, range - range / 8);
}


attendi(q)
int	q;
{ 
	drive(q, 0);
	while (speed() > 40) 
		spara();
	drive(q, 100);
}


