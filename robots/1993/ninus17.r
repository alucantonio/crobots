/*************************************************************************/
/**   NOME ROBOT: NINUS17            ** NINUS17  si posiziona sul       **/
/**   DATA      : 01 - 09 - 1993     ** margine inferiore del campo di  **/
/**   AUTORE    : Ivan  Infante      ** battaglia, e si muove in senso  **/
/**                                  ** orizzontale. La funzione di     **/
/**               (studente)         ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/**                                  **                                 **/
/*************************************************************************/
int Range, Old_Range, Ang, Dir;

main()
{
	drive(270,100); /* posizionamento iniziale */
	while(loc_y() > 20) fuoco();

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
		while(loc_x() > 250 && speed()) fuoco();
	}
}

fuoco()
{
	if (Range = scan(Ang,3)) bang();   /* sparo */
	else
	{
		Ang -= 23;
		while (!(Range = scan(Ang, 10)))
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
	{
		cannon(Ang, 8*Range/7);
		Old_Range=Range;
	}
	else
	{
		cannon(Ang, 7*Range/8);
		Old_Range=Range;
	}
}

