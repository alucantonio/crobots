/****************************************************************************\

	   ELS.r   V 4.1                        Galliate, 22/09/95



programmato da: MAIOLO EMILIANO


strategia: Il mio C-Robot (cr) e' stato programmato in modo che si metta

	   in attesa nell'angolo inferiore a destra. Se dopo qualche tempo

	   non viene colpito o non colpisce, alterna la sua posizione tra

	   l'angolo inferiore e quello superiore a destra.

	   Se invece viene colpito, si sposta, alternando sempre i due

	   angoli esposti sopra, non in linea retta verticale, ma 

	   spostandosi in linea orizzontale per qualche metro e poi 

	   tagliando il campo di battaglia.

	   Per quel che riguarda l'attacco, il mio (cr) fa uno scan con

	   una scansione di 15 gradi e quando inquadra un nemico continua

	   a sparargli fino a quando e' nel mirino.



	   Essendo solo due settimane che mi sono dedicato ai C-Robots, 

	   penso che questa strategia sia piena di ingenuita' dettate

	   dall'inesperienza, pero' credo che sia sufficiente per evitare

	   di essere colpito a ripetizione e di sbaragliare piu' avversari

	   possibile prima di essere distrutto.

	   







\****************************************************************************/





/*   Variabili Globali */

int dan,pos,grado,counter; /* Le variabili qui definite servono 

			      rispettivamente come contenitori per i danni,

			      la posizione(0 se e' nell'angolo in basso o

			      1 se in quello in alto), il grado di scansione,

			      la distanza di un C-Robots intercettato dalla   

			      funzione di scan. */

int trovato,cont;          /* trovato e' una variabile ausiliaria per

			      indicare se il mio (cr) ha intercettato un

			      altro; cont serve come contatore per quantificare

			      (a spanne) per quqnato tempo il mio (cr) deve

			      rimanere negli angoli.  */



/* La seguente funzione serve per controllare se nel range di 700 mt dello

   angolo passato come parametro vi e' un C-Robots.

   Se cosi' fosse allora prende la distanza e spara 2 colpi al nemico.

*/

controlla(grado)

int grado;

{

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

	/* Le prossime sette istruzioni servono a posizionare il

	   mio (cr) nell'angolo inferiore a destra.               */

	drive(270,100);  /* mi sposto verso il basso alla massima velocita'*/

	while(loc_y()>150) { controlla(grado); grado+=15; } /* fino a quando

		 non mi trovo troppo vicino al muro (150 mt.); nel

		 frattempo continua a scannare a 360 gradi per vedere ( e 

		 colpire ) se riesce a trovare nemici durante lo spostamento.

		 Questa tattica e' utilizzata in tutti gli spostamenti che

		 seguono. */

	while(loc_y()>30) drive(270,20); /* rallento .... */

	drive(0,100);  /* ... e giro. */

	while(loc_x()<850) { controlla(grado); grado+=15; } /* come sopra..*/

	while(speed()>30) drive(0,20);  /* ...rallento... */

	drive(0,0);  /* ...e mi fermo. */

	grado=2; pos=0; dan=0;  /* inizializzo le var. aus. */

	counter=0;              /* azzero counter */



	/* ciclo fino alla morte !!! */

	while(1) {

		cont=0;          /* azzero la variabile che mi indica

				    quanto tempo stare in un angolo    */

		dan=damage();    /* memorizzo quanti danni ho subito   */

		/* fino a quando non vengo colpito, o fino a quando il

		   contatore non e' arrivaro a 100, faccio uno scan a 360 gr. 

		   e colpisco se e' necessario  */

		while((dan==damage())&&(cont<100)) {

			controlla(grado);

			/* il seguente if serve a farmi incrementare 

			   l'indicatore di gradi di 15 solo se guardando

			   al valore precedente il (cr) non ha trovato niente.

			*/

			if (trovato==0) grado+=15;

			if (grado>360) grado=2;  /* se supero i 360 gradi 

						    re-inizializzo la var. */

			cont++;   

		}

		/* se il contatore e'minore di 100 significa che il prog.

		   e' uscito dal while perche' il mio (cr) e' stato colpito.

		   quindi devo prima spostarmi un po' verso il centro....*/

		if(cont<100) { 

			/* si sposta con lo stesso concetto di sopra.*/

			drive(180,100);

			while(loc_x()>600) { controlla(grado); grado+=15; }

			while(speed()>30) drive(180,20);

			while(speed()>0) drive(180,0);

		}

		/* Che sia stato colpito o no, lo spostamento verticale lo

		   deve comunque fare. 

		   Il seguente if fa spostare il mio (cr) in su o in giu'

		   in base alla posizione in cui si trova.               */

		if(pos==0) {

			/* si sposta con lo stesso concetto di sopra.*/

			drive(90,90);

			while(loc_y()<850) { controlla(grado); grado+=15; }

			while(speed()>30) drive(90,20);

			while(speed()>0) drive(90,0);

			pos=1; 

		} else {

			/* si sposta con lo stesso concetto di sopra.*/

			drive(270,90);

			while(loc_y()>150){ controlla(grado); grado+=15; }

			while(speed()>30) drive(270,20);

			while(speed()>0) drive(270,0);

			pos=0; 

		}

		/* poi bisogna riavvicinarci all'angolo spostandosi verso

		   destra. */

		if(cont<100) {

			/* si sposta con lo stesso concetto di sopra.*/

			drive(0,100);

			while(loc_x()<850) { controlla(grado); grado+=15; }

			while(speed()>30) drive(0,20);

			while(speed()>0) drive(0,0);

		}

	}

}   /* end del prog.*/

