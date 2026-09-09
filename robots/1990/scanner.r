/* scanner.r - robot sperimentale ad angolo di scansione variabile */
/* Corrado Giustozzi, marzo 1991 */


int		danni, scandir, oldpos;


main()

{

	int		distanza;


	danni = damage();		/* danni attuali */
	scandir = 0;			/* direzione di scansione */
	oldpos = 5;				/* attuale posizione */

	while ( 1 ) {

		distanza = scan( scandir, 10 );

		if ( ( distanza > 0 ) && ( distanza <= 800 ) ) {
			colpisci( scandir );
			scandir -= 10;
		} else
			scandir += 20;

		if ( colpito() || ( rand( 80 ) == 0 ) )
			muoviti();

		scandir %= 360;

	}

}


colpisci( dir )

int		dir;

{

	int		dist, step, end;


	end = dir + 10;
	dir -= 10;

	while ( dir <= end ) {

		if ( ( dist = scan( dir, 2 ) ) > 800 )		/* Troppo lontano?		*/
			return;

		if ( dist )								/* Se il nemico e' a tiro...*/
			step = -4;							/* ...prox. scans. indietro	*/
		else									/* Altrimenti in avanti		*/
			step = 4;

		while ( dist > 0 && dist <= 800 ) {		/* Nemico a tiro!			*/
			cannon( dir, dist );				/* Spara...					*/
			if ( colpito() ) {					/* ...controlla danni...	*/
				muoviti();						/* ...ed event. scappa!		*/
				return;
			}
			dist = scan( dir, 2 );				/* Controlla stessa direz.	*/
		}

		dir += step;							/* Perso: prox. scansione	*/

	}

}


colpito()

{

	int		d;

	if ( ( d = damage() ) > danni ) {
		danni = d;
		return( 1 );
	} else
		return( 0 );

}


muoviti()

{

	int		newpos, newx, newy, direz, velocita;


	while( ( newpos = rand( 3 ) ) == oldpos )
		;

	if ( newpos == 0 ) {
		newx = 200;
		newy = 200;
	}
	if ( newpos == 1 ) {
		newx = 800;
		newy = 200;
	}
	if ( newpos == 2 ) {
		newx = 800;
		newy = 800;
	}
	if ( newpos == 3 ) {
		newx = 200;
		newy = 800;
	}

	oldpos = newpos;
	direz = angolo( newx, newy );

	drive( direz, 100 );
	while( ( sqdist( loc_x(), loc_y(), newx, newy ) > 100 ) && ( speed() > 0 ) )
		;
	drive( direz, 0 );
	danni = damage();
	scandir = direz;
	return;

}


angolo( xx, yy )

int		xx, yy;

{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */
  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {      /* x is zero, we either move due north or south */
    if (yy > cury)
      d = 90;        /* north */
    else
      d = 270;       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
        d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */ 
    } else {
      if (xx > curx)
        d = atan((scale * y) / x);        /* north-east, quadrant 1 */
      else
        d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (d);
}


sqdist( x1, y1, x2, y2 )

int		x1, y1, x2, y2;

{

	int		x, y;

	x = x1 - x2;
	y = y1 - y2;
	return( (x*x) + (y*y) );

}
