/*************************************************************************/
/**   NOME ROBOT: NINUS6             ** NINUS6   si posiziona sul       **/
/**   DATA      : 01 - 09 - 1992     ** margine inferiore del campo di  **/
/**   AUTORE    : Ivan  Infante      ** battaglia, e si muove in senso  **/
/**                                  ** orizzontale. La funzione di     **/
/**               (studente)         ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/*************************************************************************/

int	Range, Old_Range, Ang, Dir;

main()
{
	drive(270, 100); /* posizionamento iniziale */
	while (loc_y() > 40) 
		fuoco();

	Dir = -180;

	while (1) /* ciclo principale */ {
		Dir = (Dir + 180) % 360; /* cambia direzione */

		drive(Dir, 0);
		while (speed() > 49) 
			fuoco();
		drive(Dir, 100);
		while (((loc_x() < 750 && Dir == 0) || 
		    (loc_x() > 250 && Dir == 180)) && speed())
			fuoco(); /* spara mentre si muove (orizzontalmente)*/
	}
}


fuoco()
{
	if (Range && Range < 701) {
		Ang += 5 - (scan(Ang - 5, 5) != 0) * 10; /* migliora la mira */
		Ang += 3 - (scan(Ang - 3, 3) != 0) * 6;

		Old_Range = Range;

		if ((Range = scan(Ang, 10)) > 40)
			cannon(Ang, Range + (Range - Old_Range + 
			    cos(Ang - Dir) / 2000) * Range / 325); /* spara !! */
		else
			cannon(Ang, 50);
	} else
	 {
		Ang -= 23;
		if (!(Range = scan(Ang = Dir - 10, 10))) /* cerca nemici right...*/
			if (!(Range = scan(Ang = Dir + 190, 10))) /* ... & left */
				while (!(Range = scan(Ang, 10))) {
					/* cerca nemici in mezzo */
					Ang += 20;
					if (Ang >= 200)
						Ang = 0;
				}

		if (Range < 60)
			Range = 60;

		cannon(Ang, 7 * Range / 8); /* spara immediatamente !! */
	}
}


