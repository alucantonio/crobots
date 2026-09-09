/***************************************************************/
/*                                                             */
/*                 >>>>> B A C H O P I N <<<<<                 */
/*                                                             */
/*    Autore: Andrea Moschetto                                 */
/*                                                             */
/*    Strategia:                                               */
/*      - Movimento: Sul lato est dell'arena.                  */
/*                   Si muove a velocità 60 nel mezzo del lato */
/*                   est per aumentare la precisione di tiro.  */
/*      - Attacco:   C'è una correzione sia sull'angolo che    */
/*                   sulla distanza di sparo                   */
/*                                                             */
/***************************************************************/


int     oldrange, newrange, newang, oldang;
main()
{
	newang = 90;

	drive(0, 100);
	while ((loc_x() < 950) && speed())
		spara();
	drive(0, 100);                         /* ripetuto due volte per essere */
	while ((loc_x() < 950) && speed())     /* sicuro che entri in regime    */
		spara();

	drive(90, 0);
	while (speed() > 49) 
		spara();

	while (1)                              /* Regime                        */
	{
		drive(90, 100);
		while ((loc_y() < 280) )
			spara();

		drive(90, 60);
		while ((loc_y() < 720) )
			spara();

		drive(90, 100);
		while ((loc_y() < 900) )
			spara();
		drive(270, 0);
		while (speed() > 49)
			spara();


		drive( 270, 100);
		while ((loc_y() > 720) )
			spara();
		drive( 270, 60);
		while ((loc_y() > 280) )
			spara();
		drive( 270, 100);
		while ((loc_y() > 100) )
			spara();

		drive(90, 0);
		while (speed() > 49)
			spara();

	}          
}

spara()
{
	if( oldrange = scan( newang, 10))
	{
		if ((newrange = scan(newang + 8, 2)) > 20 )
			collima( 8 );
		else if ((newrange = scan(newang + 4, 2)) > 20 )
			collima( 4 );
		else if ((newrange = scan(newang , 2)) > 20 )
			collima( 0 );
		else if ((newrange = scan(newang - 4, 2)) > 20 )
			collima( -4 );
		else if ((newrange = scan(newang - 8, 2)) > 20 )
			collima( -8 );
	     	if( newrange >= 699)
			newang +=30;
		else
			newang -= 20;
	}
	else if (newang > 270)
		newang = 90;
	     else
		newang += 20;
}

collima( incr )
int     incr;
{
	newang += incr;
	if ( oldrange < newrange )
	{
		if( newang < 115)
			cannon(newang, 9 * newrange / 8);
		else if( newang > 255)
			cannon(newang, 9 * newrange / 8);
		else if( newang  < oldang )
		{
			cannon(newang - 10, 9 * newrange / 8);
			oldang = newang;
		}
		else if(newang > oldang)
		{
			cannon(newang + 10, 9 * newrange / 8);
			oldang = newang;
		}
		else
			cannon(newang , 9 * newrange / 8);
	}
	else
	{
		if( newang < 115)
			cannon(newang, 8 * newrange / 9);
		else if( newang > 255)
			cannon(newang, 8 * newrange / 9);
		else if( newang < oldang )
		{
			cannon(newang - 10, 8 * newrange / 9);
			oldang = newang;
		}
		else if (newang > oldang)
		{
			cannon(newang + 10, 8 * newrange / 9);
			oldang = newang;
		}
		else
			cannon(newang, 8 * newrange / 9);
	}
}

