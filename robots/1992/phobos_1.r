/* -------------------------------------------------------------- */
/*  ROBOT:          Phobos                                        */
/*  GENERAZIONE:    1                                             */
/*  CATEGORIA:      TD-3                                          */
/*  NOME UFFICIALE: PHOBOS_1                                      */
/*                                                                */
/*  CREATO nel Settembre 1992 DA:                                 */
/*                                                                */
/*                      Davide Tretene                            */
/* -------------------------------------------------------------- */


int	Deg, Range, ORange;

main()
{
	Deg = 90; 
	ORange = 100;

	drive (270, 100);                 /*  Direzione SUD a tutta velocita' */
	while (loc_y() > 60) 
		shoot();
	drive (0, 0);
	while (speed() > 49)  
		shoot();

	while (1) {
		if (!speed() && loc_x() < 500) 
			drive (0, 0);

		drive (0, 100);                         /* Direzione EST */
		while (loc_x() < 920) 
			shoot();         /* Cerca e spara */
		drive (180, 0);
		while (speed() > 49)  
			shoot();

		if (!speed() && loc_x() >= 500) 
			drive (180, 0);

		drive (180, 100);                       /* Direzione OVEST */
		while (loc_x() > 80)  
			shoot();         /* Cerca e spara   */
		drive (0, 0);
		while (speed() > 49)  
			shoot();
	}
}


shoot ()
{
	if (Range = scan (Deg, 6)) {
		if (Range < 70) 
			Range = 70;
		if (Range > ORange) 
			cannon ( Deg, Range + 4 * (Range - ORange) / 5 );
		else 
			cannon ( Deg, 8 * Range / 9 );

		ORange = Range;
	} else {
		Deg -= 36;
		while (!(Range = scan (Deg += 16, 8)))
			;
		if (Range < 70) 
			Range = 70;
		if (Range > ORange) 
			cannon ( Deg, Range + 4 * (Range - ORange) / 5 );
		else 
			cannon ( Deg, 8 * Range / 9 );

		ORange = Range;
	}
}


