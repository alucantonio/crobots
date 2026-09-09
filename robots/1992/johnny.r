

/*
  Le prime due righe sono utilizzabili per la versione Amiga di CROBOTS
*/

/*

                           === JOHNNY.R ===

Autore  : MAURIZIO CAMANGI
*/

/*
       Johnny.r tiene attivi due angoli di scansione, uno a nord
       uno a sud, in modo da poter sparare quasi contemporaneamente
       a due o piu' robot avversari, tenendoli sotto tiro il piu' possibile
*/

/*
       Testato con un Amiga 500 - 1 Mega - 68000 7.15 Mhz
*/

int	ang, ang2, range, dir;

main()                /* main() routine versione del 30:5:1992 */
{
	if (loc_y() > 520) {                                         /* si dirige in mezzo al campo */
		drive(270, 100);                          /* di battaglia                */
		while (speed() < 50) 
			;                   /* per poi oscillare in senso  */
		while (loc_y() >= 520) 
			spezza_ossa();    /* orizzontale                 */
	} else if (loc_y() < 480) {
		drive(90, 100);
		while (speed() < 50) 
			;
		while (loc_y() <= 480) 
			spezza_ossa();
	}
	dir = 0;
	drive(dir, 0);
	while (speed() > 49) 
		spezza_ossa();
	while (1)                            /* Esegue per sempre . . . .         */ {                                   /* o almeno finche' non e' distrutto */
		drive(dir, 100);                    /* dondolandosi in mezzo al campo    */
		while (loc_x() <= 910) 
			spezza_ossa();
		dir = 180;
		drive(dir, 0);
		while (speed() > 49) 
			spezza_ossa();
		drive(dir, 100);
		while (loc_x() >= 90) 
			spezza_ossa();
		dir = 0;
		drive(dir, 0);
		while (speed() > 50) 
			spezza_ossa();
	}
}


spezza_ossa()        /* spezza_ossa() routine versione del 30:5:1992 */
{
	if (range = scan(ang, 8))                     /* Scan nel primo angolo      */
		cannon(ang, 7 * range / 8);                  /* compreso tra 180 e 360     */

	ang += 16 - (scan(ang - 16, 8) != 0) * 32;
	if (ang <= 180) 
		ang += 180;

	if (range = scan(ang2, 8))                    /* Secondo angolo ....         */
		cannon(ang2, 7 * range / 8);                 /* compreso tra 0 e 180        */

	ang2 += 16 - (scan(ang2 - 16, 8) != 0) * 32;
	if (ang2 >= 180) 
		ang2 += 180;

}


