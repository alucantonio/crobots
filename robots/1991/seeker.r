/*
   Indivisua un obiettivo, lo segue sparando nella sua direzione
*/

int	counter, ang, ang1, range;

main()
{
	counter = 20;
	ang1 = ang = 0;
	mira();
	while (1) {
		if (range < 150) {
			drive (ang, 49);
			while (speed() > 49) 
				mira();
			drive (ang + 180, 100);
			counter = 10;
		}
		mira();
		if (counter > 20 && ang != ang1) {
			ang1 = ang;
			drive(ang, 49);
			while (speed() > 49) 
				mira();
			drive(ang, 100);
			counter = 10;
		}
		counter++;
	}
}


cerca()
{
	ang = 0;
	while (!(range = scan(ang, 10))) 
		ang += 20;
}


mira()
{
	if (!speed()) {
		if (loc_x() > 950)
			drive(180, 100);
		else 
			drive(0, 100);
		counter = 5;
	}
	if (!(range = scan(ang - 5, 5)))
		if (!(range = scan(ang + 5, 5)))
			if (!(range = scan(ang - 20, 10)))
				if (!(range = scan(ang + 20, 10)))
					cerca();
				else 
					ang += 20;
			else 
				ang -= 20;
		else 
			ang += 5;
	else 
		ang -= 5;
	cannon(ang, range + speed() / 2);
}


