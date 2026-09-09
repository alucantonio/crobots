/* Crobot assassin,              */
/* Giulio Buccini                */

int	sc, range, endsc;

main() 
{
	sc = 360;
	while (1) {         /* inizia ciclo perpetuo ricerca-inseguimento */
		cerca();         /* ricerca primo bersaglio                    */
		insegui();       /* inseguimento                               */
	}
}


cerca() 
{
	while ( !(range = scan(sc, 5))) 
		sc += 5; /* ricerca in senso orario */
}


insegui() 
{
	cannon(sc, range);                                      /* fuoco su bersaglio appena avvistato.    */
	while (1) {                                            /* ciclo interrompibile sse il bersaglio Š perso */
		if (range > 40) 
			drive(sc, 35); 
		else 
			drive(sc, 1);        /* se lontano,avvicinati; else rallenta    */
		sc = sc - 15;
		endsc = sc + 15;
		range = 0;              /* cerca la sua posizione in un settore di */
		while ((!(range = scan(sc, 3))) && (sc <= endsc)) 
			sc += 3; /* 30 gradi dall'ultimo avvistamento;      */
		if (sc > endsc) 
			return;                              /* se non lo hai trovato, lo hai perso...  */
		cannon(sc, range);                                    /* altrimenti fuoco.                       */
	}
}


