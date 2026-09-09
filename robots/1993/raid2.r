/* R.A.I.D. II (1993) - basato su BRY_BRY.R
   Autore : Fabio Carucci
   Strategia : Il Robot RAID II si muove ai lati dell'arena calibrando
   il tiro contro i nemici.                                       
************************************************************************************/       
int	ang, fi, in, range;
main()
{
	in = 0;
	fi = 359;
        ang= 0;
	while (loc_y() < 900) { 
		drive(90, 100);
		uccidi(); 
	}
	drive(90, 0);
	while (speed() > 49) 
		uccidi();
	while (loc_x() > 50) { 
		drive(180, 40);
		uccidi(); 
	}
	drive(0, 0);
	while (speed() > 49) 
		uccidi();
	drive(270, 100);

	while (1) {
		while (loc_y() > 50) 
			uccidi();
		while (speed() > 50) 
			drive(360, 40);

		drive(360, 100);
		in = 0;
		fi = 180;
		while (loc_x() < 900) 
			uccidi();
		while (speed() > 50) 
			drive(90, 40);

		drive(90, 100);
		in = 90;
		fi = 270;
		while (loc_y() < 900) 
			uccidi();
		while (speed() > 50) 
			drive(180, 40);

		drive(180, 100);
		in = 180;
		fi = 360;
		while (loc_x() > 50) 
			uccidi();
		while (speed() > 50) 
			drive(270, 40);

		drive(270, 100);
	}
}


uccidi()
{
	int	raggio;
	if (raggio = scan(ang, 10)) {
		cannon(ang, raggio  * (8 / 7));
                cannon(ang, raggio);
	} else
	 {
		ang += 20;
		if (ang > 359 && fi != 359)
			ang = 0;
		else if (in < fi)
			if (ang > fi)
				ang = in;
			else if (ang > fi && ang < in)
				ang = in;
	}
}

