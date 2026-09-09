/*************************************************************************/
/**   NOME ROBOT: NINUS99            ** NINUS99  si posiziona sul       **/
/**   DATA      : 01 - 09 - 1995     ** margine inferiore del campo di  **/
/**   AUTORE    : Ivan & Roberto     ** battaglia, e si muove in senso  **/
/**                  Infante         ** orizzontale. La funzione di     **/
/**                                  ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/**                                  ** La funzione fuoco2() Š utilizza-**/
/**                                  ** ta quando NINUS99 va a sinistra **/
/*************************************************************************/

int Range, Old_Range, Ang, Dir;

main()
{
	drive(270,100); /* posizionamento iniziale */
	while(loc_y() > 0) fuoco();

	while(1) /* ciclo principale */
	{
		Dir = 0;
		drive(Dir, 50);
		while(speed() > 49);
		drive(Dir, 100);
		while(loc_x() < 750 && speed()) fuoco();
		
		Dir = 180;
		drive(Dir, 50);
		while(speed() > 49);
		drive(Dir, 100);
		while(loc_x() > 250 && speed()) fuoco2();
	}
}

fuoco()
{
	if (Range && Range < 699)
	{
		Ang += 5 - (scan(Ang-5, 5) != 0)*10; /* migliora la mira */
		Ang += 3 - (scan(Ang-3, 3) != 0)*6;  /* progressivamente */

		Old_Range = Range;

		if ((Range = scan(Ang,11)) > 42)
			cannon(Ang, Range + (Range - Old_Range + 
			   cos(Ang - Dir)/2000) * Range/325); /* spara !! */
		else
			cannon(Ang, 50);
	}
	else
	{
		if(!(Range=scan(Ang = Dir - 10,11))) /* cerca nemici destra..*/
			if(!(Range=scan(Ang = Dir + 190,11))) /* ... & sin. */
				while(!(Range = scan(Ang,11)))
				{
					/* cerca nemici in mezzo */
					Ang -= 20;
					if (Ang <= -10)
						Ang = 200;
				}

		if (Range < 60)
			Range = 60;

		cannon(Ang, 7*Range/8); /* spara immediatamente !! */
	}
}

fuoco2()
{
	if (Range = scan(Ang,3)) bang();   /* sparo */
	else
	{
		Ang -= 23;
		while (!(Range = scan(Ang, 11)))
		{   
			Ang += 20;
			if (Ang >= 200) Ang = 0;
		}
		if (Range < 60) Range = 60;
		
		bang();
	}
}

bang()
{
	if (Old_Range < Range)   /* miglioramento mira */
		cannon(Ang, 8*Range/7);
	else
		cannon(Ang, 7*Range/8);
	Old_Range=Range;
}

