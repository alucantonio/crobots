/****************************************************************************\

	   STAR.r   V 1.0                        22/09/95



Creato da: MAIOLO FABIO  Aiuto programmazione: MAIOLO EMILIANO



Strategia: Il robot che ho creato, e di cui mi ha aiutato nella programmazione

	   mio fratello, segue una strategia piuttosto stupida, ma che ritengo

	   sufficiente a garantire un certo margine di vittoria.

	   Il mio robot segue in continuazione una traettoria a stella a 

	   quattro punte,dove le punte corrispondono agli angoli del campo

	   di battaglia, e nel frattempo, fa uno scan a 360 gradi per vedere 

	   se vi sono nemici nel raggio di 700 mt.

	   La routine di fuoco e' stata creata da mio fratello EMILIANO e me

	   assieme.

\****************************************************************************/



/* Variabili Globali */

int grado,counter;         /* Le variabili qui definite servono 

			      rispettivamente come contenitori per il grado 

			      di scansione, la distanza di un C-Robots 

			      intercettato dalla funzione di scan. */

int trovato;               /* variabile ausiliare   */



/* La seguente funzione serve per controllare se nel range di 700 mt dello

   angolo passato come parametro vi e' un C-Robots.

   Se cosi' fosse allora prende la distanza e spara 2 colpi al nemico.

*/

controlla(grado)

int grado;

{

		if (grado>360) grado=grado-360;

		trovato=0; /* azzero la var ausiliaria  */

		/* Se nel range dell'angolo vi e' un nemico...*/

		if((counter=scan(grado,700))>0) {

		/* e se non e' oltre i 700 mt. o piu' vicino di 50mt. ....*/

		 if((counter<700) && (counter>50)) {

		   /* spara 2 colpi .... */

		   cannon(grado,counter);

		   while((cannon(grado,counter))==0);

		   trovato=1;   /* e setta a 1 la var. aus. */

		 }

		}

	

}  /* fine funz. controlla */





main()

{

	/* Per prima cosa mi posiziono nell'angolo inferiore a destra

	   perche' voglio far partire da li' il mio robot per scaramanzia. */

	drive(270,100);  /* vado verso il basso */

	while(loc_y()>150) { controlla(grado); grado+=15; } /* mi avvicino

		al muro in basso */

	while(loc_y()>30) drive(270,20); /* cosi' poi rallento */

	drive(0,100);  /* poi parto in orizzontale verso destra. */

	while(loc_x()<850) { controlla(grado); grado+=15; } 

	while(speed()>30) drive(0,20);  /* quando sono vicino rallento */

	drive(0,0);  /* cosi' mi fermo. */

	grado=0; dan=0; counter=0; /* azzero le variabili. */

	/* ciclo sempre */

	while(1) {

		/* i seguenti movimenti servono a far muovere il mio robot

		   con una traettoria a stella a quattro punte.

		   I vertici delle punte corrispondono con gli angoli

		   del campo di battaglia.  

		   Ora si sposta verso il centro ...   */

		drive(165,80);

		while(loc_x()>530) {controllo(grado); grado+=15; }

		while(speed()>30) drive(165,20);

		while(speed()>0) drive(165,0);



		/* ..poi si sposta verso l'angolo in basso a sinistra.  */

		drive(195,80);

		while(loc_x()>150) {controllo(grado); grado+=15; }

		while(speed()>30) drive(195,20);

		while(speed()>0) drive(195,0);



		/* Ora si sposta di nuovo verso il centro */

		drive(75,90);

		while(loc_y()<470){ controlla(grado); grado+=15; }

		while(speed()>30) drive(75,20);

		while(speed()>0) drive(75,0);

		 

		/* Per poi dirigersi nuovamente in un angolo */

		drive(105,90);

		while(loc_y()<850){ controlla(grado); grado+=15; }

		while(speed()>30) drive(105,20);

		while(speed()>0) drive(105,0);



		/* Dall'angolo in alto a sinistra si sposta verso il

		   centro ...      */

		drive(345,80);

		while(loc_x()<470) {controllo(grado); grado+=15; }

		while(speed()>30) drive(345,20);

		while(speed()>0) drive(345,0);



		/* Per poi spostarsi verso l'angolo in alto a destra. */

		drive(15,80);

		while(loc_x()<850) {controllo(grado); grado+=15; }

		while(speed()>30) drive(15,20);

		while(speed()>0) drive(15,0);



		/* Di nuovo verso il centro ...  */

		drive(255,80);

		while(loc_y()>530) {controllo(grado); grado+=15; }

		while(speed()>30) drive(255,20);

		while(speed()>0) drive(255,0);



		/* per poi finire all'angolo di partenza. */

		drive(285,80);

		while(loc_y()>150) {controllo(grado); grado+=15; }

		while(speed()>30) drive(285,20);

		while(speed()>0) drive(285,0);

		

		/* ora dall'angolo di partenza ricomincia il giro ciclando

		   all'infinito.  */

	}

}   /* end del prog.*/

