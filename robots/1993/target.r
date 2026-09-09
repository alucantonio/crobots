

/*
			===   TARGET serie I   ===
			=== robot sperimentale ===
			===    versione 1.1    ===
			===     31-07-1993     ===

Autore: Maurizio Camangi

*/

/*

   Robot statico sperimentale : si posiziona al centro del campo di
   battaglia (coordinate 500,500) e rimane immobile.
   Utilizza la funzione Fire() pe tenere sotto tiro il piu' possibile
   a lungo il robot avversario, modificando sia la gittata della Cannon()
   che l'angolo di scansione usato con Scan() in base allo spostamento
   "relativo" del robot nemico.

*/

int ang, range, orange, dir, scale;

main()               /* main() routine, versione del 31-07-93 */
int c,b;
{
	ang = 0;
	scale = 100000;
	dir = plot_course();
        c = sqrt((500 - loc_x())*(500 - loc_x()) + 
	         (500 - loc_y())*(500 - loc_y()));
	while (c > 55) {
		drive(dir,100);
		c = sqrt((500 - loc_x())*(500 - loc_x()) +
		         (500 - loc_y())*(500 - loc_y()));
		fire();
	}
        drive(dir,0);
	while(1) {
		fire();
		}
}

plot_course()  /* semplificazione della funzione omonima presente */
{              /* nel manuale di Crobots */
  int d, x, y;

  x = loc_x() - 500; y = loc_y() - 500;

  if (x == 0) {
    if (500 > loc_y()) d = 90;
    else d = 270;
  } else {
    if (500 < loc_y()) {
      if (500 > loc_x()) d = 360 + atan((scale * y) / x);
      else d = 180 + atan((scale * y) / x);
    } else {
      if (500 > loc_x())
        d = atan((scale * y) / x);
      else d = 180 + atan((scale * y) / x);
    }
  }
  return (d);
}

fire()          /* fire() routine, versione del 31-07-93 */
{
	if (range=scan(ang,8)) {
		if (range > orange)
			cannon(ang,8 * range / 7);
		else if (range < orange)
			cannon(ang,7 * range / 8);
		else cannon(ang,range);
		orange = range;
		ang-=(scan(ang - 16,8) != 0)*16;
	} else ang +=16;
}