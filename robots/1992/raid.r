/* R.A.I.D.
   Autore : Fabio Carucci
   Basato su SPOT.R di John Smolin
   Strategia : Il Robot RAID cerca di seguire il nemico sparandogli continuamente e  
               muovendosi rapidamente da un lato all'altro dell'avversario.
************************************************************************************/

main()
{
	int	r, x;                              /* dichiara variabili */
	x = 359;                                /* pone x (direzione) a 359ø */
	while (1)                              /* ciclo infinito */ {
		while (!(r = scan(x -= 20, 10)))
			;           /* ciclo che controlla lo scan */
		x += 1;                       /* incrementa la direzione di tiro di 1 */
		if (r < 60) 
			r = 60;              /* controlla che il range sia a 60ø */
		cannon(x, r);                /* spara */
		if (speed() < 60 || r > 200) {  /* controlla che il nemico sia vicino */
			cannon(x, r);             /* spara */
			drive(x, 100);            /* si muove verso il nemico */
			x += 359;                  /* incrementa direzione di 359 unita' */
		}
	} 
}


