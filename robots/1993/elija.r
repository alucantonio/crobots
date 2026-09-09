/*************************************************************************/
/**   NOME ROBOT: ELIJA Baley        ** ELIJA    si posiziona sul       **/
/**   DATA      : 01 - 09 - 1993     ** margine destro    del campo di  **/
/**   AUTORE    : Roberto Infante    ** battaglia, e si muove in senso  **/
/**                                  ** verticale  . La funzione di     **/
/**               (studente)         ** sparo, fuoco(), fa in modo che  **/
/**                                  ** nel caso in cui venga individua-**/
/**                                  ** to un nemico la mira viene      **/
/**                                  ** progressivamente migliorata.    **/
/**                                  **                                 **/
/*************************************************************************/

int Range, Old_Range, Ang, Dir;

main()
{
	drive(0,100);   /* posizionamento iniziale */
	while(loc_x() < 980) fuoco();

	while(1) /* ciclo principale */
	{
		Dir = 90;
		drive(Dir, 50);
		while(speed() > 49); 
		drive(Dir, 100);
		while(loc_y() < 600 && speed()) fuoco();

		Dir = 270;
		drive(Dir, 50);
		while(speed() > 49); 
		drive(Dir, 100);
		while(loc_y() > 300 && speed()) fuoco();
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
			if (Ang >= 280) Ang = 80;
		}
		if (Range < 60) Range = 60;
		bang();        
	}
}

bang()
{
	if (Old_Range < Range)   /* milgioramento mira */
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


