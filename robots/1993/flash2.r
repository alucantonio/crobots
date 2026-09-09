

/*
                        === Flash serie I ===
                        === versione  2.2 ===
                        ===   12-7-1993   ===

Autore:	MAURIZIO CAMANGI

*/

/*
 
   Robot perimetrale : percorre il perimetro di gioco in senso antiorario
   utilizzando la funzione Fire() per tenere sotto tiro il piu' possibile
   il robot nemico. Modifica sia la gittata della Cannon() che l'angolo
   di scansione in base allo spostamento "relativo" del robot nemico.

*/

int ang, range, oldrange;

main()                /*  main() routine, versione del 6:2:1993 */
{
	ang = 0;
	drive(180,100);
	while (loc_x() > 65) fire();
	drive(270,0);

	while (speed() > 49) fire();
	while (1)
	{
		drive(270,100);
		while (loc_y() > 65)  {
			fire();
			if (ang < 270 && ang > 90) ang = 270;
		}
		drive(0,0);
		while (speed() > 49) fire();
		drive(0,100);
		while (loc_x() < 935) {
			fire();
			if (ang > 180) ang = 0;
		}
		drive(90,0);
		while (speed() > 49) fire();
		drive(90,100);
		while (loc_y() < 935) {
			fire();
			if (ang < 90 || ang > 270) ang = 90;
		}
		drive(180,0);
		while(speed() > 49) fire();
		drive(180,100);
		while(loc_x() > 65)   {
			fire();
			if (ang < 180 || ang > 360) ang = 180;
		}
		drive(270,0);
		while(speed() > 49) fire();
	}
}

fire()         /*  fire() routine, versione del 29:6:1993 */
{
	if (range=scan(ang,8)) {
		if (range > oldrange)
			cannon(ang,8 * range / 7);
		else cannon(ang,7 * range / 8);
		oldrange=range;
		ang-=(scan(ang - 16,8) != 0)*16;
	} else ang+=16;
}
/* FLASH, omonima canzone dei Queen, in memoria di Freddie Mercury */