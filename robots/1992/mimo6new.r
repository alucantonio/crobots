/*************************************************************************/
/**   NOME ROBOT: MIMO6NEW           ** MIMO6NEW si posiziona sul       **/
/**   DATA      : 01 - 09 - 1992     ** margine superiore del campo di  **/
/**   AUTORE    : Roberto Infante    ** battaglia, e si muove in senso  **/
/**                                  ** orizzontale. La funzione di     **/
/**               (studente)         ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/*************************************************************************/

int	Range, Old_Range, Ang, Dir, Agg_Ang;

main()
{
	drive(90, 100);   /* posizionamento iniziale */
	while (loc_y() < 975) 
		fuoco();

	Dir = -180;

	while (1) /* ciclo principale */ {
		Dir = (Dir + 180) % 360; /* cambia la direzione */

		drive(Dir, 0);
		while (speed() > 49) 
			fuoco();
		drive(Dir, 100);
		while (((loc_x() < 750 && Dir == 0) || 
		    (loc_x() > 250 && Dir == 180)) && speed())
			fuoco(); /* spara mentre si muove */
	}
}


fuoco()
{
	if (Range && Range < 701) {
		Ang += 5 - (scan(Ang - 5, 5) != 0) * 10; /* migliora la mira*/
		Ang += 3 - (scan(Ang - 3, 3) != 0) * 6;

		Old_Range = Range;

		if ((Range = scan(Ang, 10)) > 40)
			cannon(Ang, Range + (Range - Old_Range + 
			    cos(Ang - Dir) / 2000) * Range / 325); /* spara !! */
		else
			cannon(Ang, 55);
	} else
	 {
		Agg_Ang -= 23;
		if (!(Range = scan(Ang = Dir, 10)))  /* cerca nemici right...*/
			if (!(Range = scan(Ang = Dir + 180, 10))) /*... & left */
				while (!(Range = scan(Ang = 180 + Agg_Ang, 10))) {
					/* cerca nemici in mezzo */
					Agg_Ang += 20;
					if (Agg_Ang >= 180)
						Agg_Ang = 0;
				}

		if (Range < 60)
			Range = 60;

		cannon(Ang, 7 * Range / 8); /* spara immediatamente !! */
	}
}


