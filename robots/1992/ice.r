/*       Nome       :   Ice                       */
/*       Autore     :   Sbrilli Daniele           */

int	range, as;
main()
{
	loc_x();
	loc_y();
	while (loc_x() <= 900)                      /*  Mi muovo verso destra */ {
		spara();
		drive(0, 100);
		spara();
	}
	while (loc_y() >= 150)                      /*  Mi muovo verso il basso */ {
		spara();
		drive(270, 100);
		spara();
	}
	while ((loc_x() >= 220) && (loc_y() <= 900))  /*  Mi muovo in diagonale */ {
		spara();
		drive(135, 100);
		spara();
	}
}


spara()
{
	int	result;
	if (result = scan(as, 10)) {
		cannon(as, (7 * result) / 8);
		as -= 35;
	} else
		as += 20;
}


