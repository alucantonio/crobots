/*       Nome del robot:............DAITAN3				*/
/* 	 Autori:							*/
/*        Deias Andrea							*/
/*                            						*/
/*        Filoni Gianluca						*/
/*       								*/
/*        DATA DI REALIZZAZIONE   29/9/92				*/





int	as;

main()

{

	while (loc_y() < 930) {
		spara();
		drive(90, 80);
	}
	spara();
	drive(90, 0);
	while (loc_x() > 70) {
		spara();
		drive(180, 80);
	}
	spara();
	drive(180, 0);
	while (1) {
		while (loc_x() < 930) {
			spara();
			drive(0, 95);
		}
		spara();
		drive(0, 0);
		while (loc_y() > 70) {
			spara();
			drive(270, 85);
		}
		spara();
		drive(270, 0);
		while ((loc_x() > 70) && (loc_y() < 930)) {
			spara();
			drive(90, 80);
		}
		spara();
		drive(90, 0);
		while (loc_x() > 70) {
			spara();
			drive(180, 80);
		}
		spara();
		drive(180, 0);
		while (loc_x() < 930) {
			spara();
			drive(0, 95);
		}
		drive(0, 0);
	}
}


spara()
{
	int	range;
	if (range = scan(as, 10)) {
		cannon(as, (7 * range) / 8);
		as -= 35;
	} else
		as += 20;
}


