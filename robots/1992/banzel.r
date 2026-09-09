/*************************************************************************/
/**   NOME ROBOT: BANZEL             ** BANZEL si posiziona sul margine **/
/**   DATA      : 01 - 09 - 1992     ** sinistro del campo di battaglia **/
/**   AUTORE    : Roberto Infante    ** e comincia a roteare attorno ad **/
/**                                  ** esso. La funzione di sparo,     **/
/**                                  ** fuoco(), fa in modo che nel caso**/
/**                                  ** in cui venga individuato un     **/
/**                                  ** nemico, la mira venga progressi-**/
/**                                  ** vamente migliorata.             **/
/**                                  **                                 **/
/*************************************************************************/

int	Ang, Agg_Ang, Dir;
int	Range, Old_Range;

main()
{
	Dir = 180;

	while (1) /* ciclo principale */ {

		drive(Dir, 100);

		if (speed() < 50)          /* se si ferma si riavvia */
			drive(Dir, 100);

		while ((Dir == 90 && loc_y() < 875) || (Dir == 270 && loc_y() > 135)
		     || (Dir == 0 && loc_x() < 920)
		     || (Dir == 180 && loc_x() > 80) )
			fuoco(); /* spara mentre si muove */

		Dir = (Dir + 90) % 360; /* cambia la direzione */
		drive(Dir, 0);
		while (speed() > 49)
			fuoco();
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
			    cos(Ang - Dir) / 2000) * Range / 325); /* spara!! */
		else
			cannon(Ang, 50);
	} else
	 {
		Agg_Ang += 20;
		if (!(Range = scan(Ang = Dir + 10, 10))) /* cerca nemici ai lati */
			if (!(Range = scan(Ang = Dir + 170, 10)))
				Range = scan(Ang = ((Dir + Agg_Ang) % 360), 10);
		/* cerca nemici nel centro */
		if (Agg_Ang >= 170)
			Agg_Ang = 0;
	}
}


