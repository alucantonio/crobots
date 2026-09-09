

/*
   Le prime due righe sono utilizzabili per la versione Amiga di CROBOTS
*/

/*
                              === Flash.r ===

Autore  : MAURIZIO CAMANGI

*/

/*
        Testato con un Amiga 500 - 1 Mega - CPU 60000 7.15 Mhz
*/

int	ang, range, dir;

main()                /*  main() routine, versione del 13:7:1992 */
{
	drive(180, 100);
	while (loc_x() > 65) 
		fire();
	drive(270, 0);
	while (speed() > 49) 
		fire();
	while (1) {                                  /* Inizio Loop infinito */

		drive(270, 100);                   /*  Flash.r percorre    */
		while (loc_y() > 65) 
			fire();     /*  tutto il perimetro  */
		drive(0, 0);                     /*  di gioco correndo   */
		while (speed() > 49) 
			fire();   /*  lungo i bordi in    */
		/*  senso antiorario    */
		drive(0, 100);
		while (loc_x() < 935) 
			fire();    /*  La routine fire()   */
		drive(90, 0);                    /*  si preoccupa di     */
		while (speed() > 49) 
			fire();   /*  tenere sotto tiro   */
		/*  il robot avversario */
		drive(90, 100);                    /*  il piu' possibile   */
		while (loc_y() < 935) 
			fire();    /*  a lungo per poi     */
		drive(180, 0);                   /*  cannoneggiarlo !!   */
		while (speed() > 49) 
			fire();

		drive(180, 100);
		while (loc_x() > 65) 
			fire();
		drive(270, 0);
		while (speed() > 49) 
			fire();
	}
}


/* La routine fire() modifica costantemente l'angolo di scansione */
/* variandolo di piu' o meno 16 gradi, che nella maggior parte    */
/* dei casi e' una efficiente variazione                          */

fire()         /*  fire() routine, versione del 28:5:1992 */
{
	if (range = scan(ang, 8))
		cannon(ang, 7 * range / 8);     /* La range e' leggermente piu' corta */
	ang += 16 - (scan(ang - 16, 8) != 0) * 32;/* come in Jazz.r, l'algoritmo e'     */
}                                 /* infatti piu' efficiente            */


