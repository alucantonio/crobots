/*
		=====     =====        ===        =====
		=====     =====      =======      =====
		 ===       ===     ===     ===     ===
		 =============    ====     ====    ===
		 =============    =============    ===
		 ===       ===    ===       ===    ====
		=====     =====  =====     =====  ===========
		=====     =====  =====     =====  =============

	     ====           =====           =====           =====
	  =========       =========       =========       =========
	====     ====   ====     ====   ====     ====   ====     ====
	 ===     ====   ====     ====   ====     ====   ====     ====
	   =========    ====     ====   ====     ====   ====     ====
	      =====     ====     ====   ====     ====   ====     ====
	     ====         =========       =========       =========
	   ====             =====           =====           =====

        HAL9000 ver.6.07b del 21-nov-1999

	(C) Copyright 1999 Maurizio Camangi

Architettura:
	Hal9000'99 (v.6.07) e` un'evoluzione di Hal9000'97 (v.4). A
	differenza del suo predecessore, Hal9000'99 e` un robot
	fondamentalmente statico, basato sull'estrema precisione di
	fuoco. A parita` di funzione di fuoco, Hal9000'99 ottiene il 15%
	di efficienza in piu` in Torneo98, rispetto ad Hal9000'97. La
	procedura d'attacco finale basata sul codice di Leader, e` stata
	sostituita con una routine che sfrutta le diagonali del campo di
	battaglia. La funzione di fuoco e` la Tox-based, resa piu`
	complessa grazie ad innesti (con modifiche) di codice del robot
	Son-goku, ispirati dal robot Coppi: infatti al posto della
	sequenza di if(scan...) presenti nella Tox-fire classica
	per cercare un bersaglio non ancora a tiro, sono utilizzate la
	search() e la fire2().
	Nell'`else' che segue il primo if(...) della funzione fire() si
	utilizza la search() in cui ai classici if(range=scan...) sono
	fatte seguire delle cannon() senza correzione di angolo e gittata;
	per gli `else' che seguono gli if(range=scan(...)) piu` interni,
	e` utilizzata la funzione fire2() che svolge il duplice 
	compito di tracciare il bersaglio momentaneamente perduto, e
	sparare il colpo nel caso venga trovato, con una rapida ma
	efficace variazione dell'angolo e del range di gittata.
	Naturalmente, finche' il bersaglio e` sotto tiro, agisce la
	Tox-based doppia (sia per il robot da fermo che in movimento).
	Per bersagli piuttosto vicini (sotto le 200 unita`)
	l'utilizzo dell'algoritmo tox-like non risulta particolarmente
	efficace, per cui si usa la fire2() in luogo del codice standard.
	Un ulteriore controllo e` effettuato lungo la direzione di
	spostamento, con banale correzione di un fattore 9/10 sulla
	gittata, in caso di fuoco.
	Durante la fase finale di gioco, trascorsi circa 150/160mila
	cicli/CPU, Hal9000'99 utilizza una routine di attacco finale,
	indipendentemente dal fatto che i robot superstiti siano uno solo
	o di piu`. Hal9000'99 si muove lungo la diagonale principale
	partendo dall'angolo in cui si trova; raggiunge il centro del
	campo di battaglia e controlla se l'angolo d'arrivo e` libero; se
	e` libero lo raggiunge altrimenti rallenta e ne sceglie uno
	adiacente o, nel caso peggiore, torna indietro, per poi riprendere
	daccapo.
	Nella variazione degli angoli di scansione/fuoco ogni decremento
	e` stato sostituito con un incremento equivalente (sommando 360
	gradi), per evitare la spiacevole (anche se rara) situazione di
	ottenere angoli negativi e conseguente scan() e cannon() errati.
	Hal9000'99 non tiene in nessun modo conto del famigerato bug
	dell'angolo 0.

Strategia:
	Hal9000'99 raggiunge, nella primissima fase dell'incontro,
	l'angolo piu` vicino. Attende immobile (sparando) di essere
	colpito o che un robot avversario si avvicini (cfr. Goblin).
	Hal9000 sceglie in seguito un angolo libero adiacente, spostandosi
	lungo i bordi del campo di battaglia, preferibilmente in senso
	orario. Nella fase iniziale e di mediogioco non vengono piu`
	utilizzate le diagonali (come in Hal9000'97) ritenendo tale
	percorso troppo esposto. In piu` vengono sfruttati tutti e quattro
	gli angoli, contro i tre del lato sud-ovest in Hal9000'97.
	Dopo circa 150/160mila cicli/CPU Hal9000 controlla i danni: se
	inferiori all'80% innesca la routine di attacco finale, altrimenti
	rimane sullo stesso bordo, oscillando verticalmente, senza mai
	fermarsi.

Commenti:
	Hal9000'99 non riesce ad essere il migliore robot nel Torneo98,
	ne' tantomeno nel Torneo91-98.
	I limiti maggiori risiedono in qualche "baco" (parzialmente a me
	noto) del movimento, poiche', da quello che si riesce a
	vedere, la funzione di fuoco e` l'unica routine che funziona come
	si deve. Il controllo sul numero di robot supersiti ha portato ad
	un decremento dell'efficienza, segno che la procedura di attacco
	finale regge bene anche con piu` di un robot o segno che non c'ho 
	capito ancora una mazza :-] Numerose modifiche sono state
	effettuate sulla strategia di movimento, senza riscontrare
	benefici. Il codice non e` particolarmente ottimizzato, risulta anzi
        leggibile.

	Qualunque sia il risultato nel Torneo Y2K, questa e` l'ultima
	versione di Hal9000 rilasciata (era ora no? :-)).
	Credo che fra tutte sia, in ogni caso, la migliore.

Credits:
        Un ringraziamento speciale a Simone Ascheri, inossidabile ed
        instancabile aiuto senza il quale il Torneo Y2K non sarebbe mai
        venuto alla luce; un ringraziamento anche per il suo indecifrabile
        Son-goku, le cui routine base (molto base, poiche' le altre sono
        tuttora in fase di studio da parte di esperti di crittografia :-))
        sono state innestate in Hal9000'99.
        Un ringraziamento a tutti i fan di Crobots, Alessandro,
	Michelangelo, Daniele, Marco e tutti gli amici della maling list
	che hanno permesso lo svolgimento dell'importante evento di fine
	secolo.
        Un saluto ai miei colleghi OM del gruppo iRGP (Internet Radio
        Gateway Project) con i quali siamo riusciti a realizzare un
	importante progetto all'Universita` degli Studi di Ancona (fac.
	Ingegneria), che fornisce al Torneo Y2K un'adeguata potenza di
	calcolo.
        Un ringraziamento particolare a Fabio Farnesi per il supporto e la
        fiducia profusi.


							'Joshua'
*/

int ang,        /* Angolo di scanning                           	*/
    oang,	/* Angolo di scanning precedente			*/
    range,	/* Gittata corrente					*/
    orange,	/* Gittata precedente					*/
    spd,	/* 1 se in movimento, 0 altrimenti			*/
    flag,	/* Attendi negli angoli se uguale a 1			*/
    dam,	/* Variabile temporanea salva danni subiti		*/
    dir,        /* Direzione del cammino                        	*/
    pos,  	/* Variabile temporanea a due bit salva posizione	*/
    maxcount;	/* Massimo numero di cicli virtuali			*/

main() /* Inizializza alcune variabili ed innesca la routine principale	*/
{
	ang=spd=1;
	flag=0;
	maxcount=650;
	defence();
}

up() /* Direzione nord (90 gradi) */
{
	drive(dir=90,100);
	while(loc_y() < 850) fire();
        drive(dir,50); /* Si avvicina il piu` possibile ai bordi */
        while(loc_y() < 925) fire();
	stop();

}

down() /* Direzione sud (270 gradi) */
{
	drive(dir=270,100);
	while(loc_y() > 150) fire();
        drive(dir,50);
	while(loc_y() > 75) fire();
        stop();
}

left() /* Direzione ovest (180 gradi) */
{
	drive(dir=180,100);
	while(loc_x() > 150) fire();
        drive(dir,50);
        while(loc_x() > 75) fire();
        stop();
}

right() /* Direzione est (0 gradi, si usa 360 per evitare casini)	*/
{
	drive(dir=360,100);
	while(loc_x() < 850) fire();
        drive(dir,50);
        while(loc_x() < 925) fire();
	stop();
}

defence() /* Routine base di difesa, attiva per circa 150mila cicli/CPU	*/
{
	if (loc_x() > 500) right();
	else left();
	flag=1;
	if (loc_y() > 500) up();
	else down();
	while (1)
	{
		if (pos == 0) /* (0,0) */
		{
			if (radar(90)) {
				up();
                        } else {
				right();
			}
		} else if (pos == 1) /* (1000,0) */
		{
			if (radar(180)) {
				left();
			} else {
				up();		
			}
		} else if (pos == 2) /* (0,1000) */
		{
			if (radar(1)) {
				right();
			} else {
				down();
			}
		}  else /* if (pos == 3)  (1000,1000) */
                {
                        if (radar(270)) {
                                down();
                        } else {
                                left();
                        }
		}
	}
}

/* Funzione finale, movimento oscillatorio				*/

wave() {

	if (loc_y() < 500) { up(); }
	while(1)
	{
		down();
		up();
	}
}

/* Funzione finale d'attacco aggressiva				*/

attack()
{
	while(1) {
		if (pos < 2) {
			drive(dir=45+(90*pos),100);
			while (loc_y() < 400) fire();
		} else {
			drive(dir=495-(90*pos),100);
			while (loc_y() > 600) fire();
		}
		if (radar(dir)) ; /* controlla avanti		*/
		else if (radar(dir+=90)) stop(); /* a sinistra	*/
		else if (radar(dir+=180)) stop(); /* a destra	*/
		else { dir-=90; stop(); } /* torna indietro	*/
		drive(dir,100);
		while (((loc_x() % 850) > 150) && ((loc_y() % 850) > 150))
			fire();
		stop();
	}
}

scan_()	/* Versione presente in Coppi	*/
{
        if(scan(ang+354,1)) ang+=354;
        if(scan(ang+6,  1)) ang+=6;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+358,1)) ang+=358;
        if(scan(ang+2,  1)) ang+=2;
}

search() /* Una delle funz. di fuoco di Son-goku, modificata		*/
{
    if(orange=scan(ang+339,10))
      cannon(ang+=339,orange);
    else
      if(orange=scan(ang+21,10))
        cannon(ang+=21,orange);
      else
        if(orange=scan(ang+318,10))
          cannon(ang+=318,orange);
        else
          if(orange=scan(ang+42,10))
            cannon(ang+=42,orange);
          else
            ang+=105;
} /* In luogo delle sottrazioni sono usati incrementi equivalenti in	*/
/*	modulo 360 gradi						*/

fire2()	/* Una delle funzioni di fuoco di Son-goku, modificata		*/
{
   if (range=scan(ang+353,4)) cannon(ang+=350,3*range-2*orange);
   else if (range=scan(ang,4)) cannon(ang,3*range-2*orange);
   else if (range=scan(ang+7,4)) cannon(ang+=10,3*range-2*orange);
   else search();
}

fire()	/* Tox-based con innesti e modifiche				*/
{
	if (range=scan(dir,10)) { /* Controlla la dir. del cammino	*/
		if (range < 770)
			cannon(ang=dir, 9*range/10);
	}
        if(orange=scan(ang,10))
	{
		if (orange < 200) { /* se troppo vicino ...		*/
			fire2(); /* ... non usare la Tox ma la fire2()	*/
			return;
		}
		scan_();
		if (orange=scan(oang=ang,5))
		{
			scan_();
			if (range=scan(ang,10))
			{
				cannon(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14)*spd,range*200/(200+orange-range-(cos(ang-dir)>>12)*spd));
			} /* else fire2(); (diminuisce l'efficienza) */
		} else fire2();
	} else search();
}

radar(x) /* Restituisce 1 se la direzione x e` libera da nemici		*/
{
	return( !(scan(x+351,10) || scan(x+9,10)));
}

stop()		/*  Fermati!						*/
{
	drive(dir,0);
        while (speed() > 49) fire();
        pos = (loc_x() > 500) + 2*(loc_y() > 500) ;
	if (flag) { /* Se 1 rimane immobile				*/
		dam=damage();
		spd=0;
		while ((!orange || orange>450) && (damage()<dam+4) &&
		--maxcount)
			fire();
		spd=1;
		if (!maxcount) { /* Controllo cicli/CPU trascorsi	*/
			flag=0;
			if (damage() > 80)
	       		        wave(); 
			else attack();
		}
	} 
}
