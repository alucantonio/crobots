/* genius_j.r */
/* Roberto Infante - Potenza */

int	angolo, direz;
int	range;

main()
{
	gira();
	attacca();
}


gira()
{
	int	ritorno;
	int	primo;

	direz = 0;
	angolo = 200;

	while (damage() < 70) {
		drive(direz, 100);

		if (direz == 0)
			while (loc_x() < 930) 
				fuoco();
		if (direz == 90)
			while (loc_y() < 930) 
				fuoco();
		if (direz == 180)
			while (loc_x() > 70) 
				fuoco();
		if (direz == 270)
			while (loc_y() > 70) 
				fuoco();

		if (!primo || range < 400 && !ritorno) {
			direz += 90;
			ritorno = 0;
		} else
		 {
			direz += 180;
			ritorno = 1;
		}

		angolo = direz + 200;

		if (direz  >= 360) 
			direz  -= 360;
		if (angolo >= 360) 
			angolo -= 360;

		drive(direz, 10);
		while (speed() > 49) 
			fuoco();
		primo = 1;
	}
}


fuoco()
{
	int	limite1;
	int	limite2;

	if (range = scan(angolo, 10)) 
		cannon(angolo, range);
	else
	 {
		angolo -= 20;

		limite1 = direz + 340;
		limite2 = direz + 200;
		if (limite1 >= 360) 
			limite1 -= 360;
		if (limite2 >= 360) 
			limite2 -= 360;

		if (direz == 0) {
			if (angolo <= 340 && angolo >= 200) 
				angolo = 200;
			if (angolo < 0) 
				angolo = 340;
		} else
		 {
			if (angolo <= limite1 && angolo >= limite2)
				angolo = limite2;
			if (angolo < 0) 
				angolo = 340;
		}
	}
}


attacca()
{
	int	angolo, range;
	int	iniz_scan, rota_scan;

	iniz_scan = 0;
	rota_scan = 10;

	while (1) {
		angolo = iniz_scan;
		while (!(range = scan(angolo, rota_scan)))
			angolo += (2 * rota_scan);

		if (range <= 600) {
			cannon(angolo, range);
			drive(angolo, 60);
		} else
			drive(angolo, range);

		rota_scan = 10;
		iniz_scan = angolo - 10;
	}
}


