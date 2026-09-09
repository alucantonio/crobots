/****************************************************************************

                      ####  ####  #   #  ###  ###   ####
                      #  #  #  #  #   #   #   #  #  #  #
                      ####  ####   # #    #   #  #  #  #
                      #     #  #    #    ###  ###   ####

                                      di

                                 Paolo  Sacco

                                     ***

                          Paolo Sacco


****************************************************************************/

main()
{
	while (loc_y() > 50)             /* raggiunge il bordo inferiore  */ {
		drive(270, 100);
		fire();
	}
	drive(0, 0);

	while (1) {
		while (loc_x() < 920)     /* arriva fino all'angolo destro */ {
			drive(0, 100);
			fire();
		}
		while (speed() > 50)      /* rallenta                      */
			drive(0, 0);

		while (loc_x() > 80)      /* arriva fino all'angolo sinis. */ {
			drive(180, 100);
			fire();
		}
		while (speed() > 50)     /* rallenta                       */
			drive(0, 0);
	}
}


/**************************************************************************/
/*    Scandisce il campo su sette angolazioni comprese tra  0ø e  180ø    */
/*    utilizzando una scarsa precisione di tiro che avvantaggia contro    */
/*    i bersagli in movimento.                                            */
/**************************************************************************/
fire()
{
	if (range = scan(90, 10)) {
		cannon(90, range * 8 / 7);
		cannon(90, range * 7 / 8);
	}
	if (range = scan(180, 10)) {
		cannon(180, range * 8 / 7);
		cannon(180, range * 7 / 8);
	}
	if (range = scan(0, 10)) {
		cannon(0, range * 8 / 7);
		cannon(0, range * 7 / 8);
	}
	if (range = scan(45, 10)) {
		cannon(45, range * 8 / 7);
		cannon(45, range * 7 / 8);
	}
	if (range = scan(135, 10)) {
		cannon(135, range * 8 / 7);
		cannon(135, range * 7 / 8);
	}
	if (range = scan(180, 10)) {
		cannon(180, range * 8 / 7);
		cannon(180, range * 7 / 8);
	}
	if (range = scan(0, 10)) {
		cannon(0, range * 8 / 7);
		cannon(0, range * 7 / 8);
	}
}


