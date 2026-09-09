/* d47.r, c-crobots da combattimento
   Autore: Filippo Quondam
   e' il mio c-robot da RISERVA */
int	range, r, s, ang, q, p, k, c;

main()
{       
ang:
	 = 0;
	c = 10;
	k = 5;
	q = 3;
	while (loc_y() > 150) 
		drive(270, 100);
	drive(270, 0);
	while (speed() > 49) {
	};                   /* si dirige al lato sud */
	while (loc_y() > 50) {
		drive(270, 10);
	}
	drive(270, 0);
	while (1) {




		while (loc_x() > 300) {


			drive(180, 100);                          /*va verso ovest*/

			while (((s = scan(ang + 355, 8)) < 40)) {
				ang += 15;
				ang %= 190;
			}                        /*scanna*/
			if (s < 730)
				if ((r = scan(ang, 10)) > 40) 
					cannon(ang + 7, 2 * r - s);            /*spara*/
				else if ((r = scan(ang + 340, 10)) > 40) 
					cannon(ang + 333, 2 * r - s);
		}


		drive(180, 0);
		while (speed() > 50) {
		}


		while (loc_x() < 700)                       /*va verso est*/ {
			drive(0, 100);
			while (((s = scan(ang + 355, 8)) < 40)) {
				ang += 15;
				ang %= 190;
			}
			if (s < 730)
				if ((r = scan(ang + 10, 10)) > 40) 
					cannon(ang + 17, 2 * r - s);
				else if ((r = scan(ang + 350, 10)) > 40) 
					cannon(ang + 343, 2 * r - s);
		}


		drive(0, 0);
		while (speed() > 50) {
		}


	}
}


