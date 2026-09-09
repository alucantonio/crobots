/*
		=====   ========   =====         =====
		=====   ========   ======        =====
		 ===     ===        ===  ==       ===
		 ===     ===        ===   ==      ===
		 ===     ======     ===    ==     ===
		 ===     ===        ===     ==    ===
	     ==  ====   ========   ===========   =====
	     ========   ========   ===========   =====

        JEDI ver.2.03e del 23-nov-1999

        (C) Copyright 1999 Maurizio Camangi

Architettura:
	Jedi2 e` un'evoluzione di Jedi'97, anche se del "vecchio" robot non
	c'e` rimasto quasi nulla. Jedi2 e` un robot misto statico/dinamico
	che, a differenza del suo predecessore, spazia su tutti e quattro
	gli angoli del campo di battaglia. La procedura d'attacco finale
	basata sul codice di Leader, e` stata sostituita con una routine
	che sfrutta le diagonali del campo di battaglia.
	La funzione di fuoco e` la Tox-based, resa piu` complessa grazie
	ad innesti (con modifiche) di codice del robot Son-goku, ispirati
	dal robot Coppi:
	infatti al posto della sequenza classica di if(scan...) presenti
	nella Tox-based per cercare un bersaglio non ancora a tiro, e`
        utilizzata la fire2(). Tale funzione e` anche usata in
	luogo della fire() Tox-based quando Jedi2 e` vicino ai bordi, per
	stabilizzare con piu` precisione l'ampiezza di oscillazione. La
	funzione shot() unisce le due funz. di fuoco, utilizzando come
	discriminante la distanza dal punto di arrivo o la vicinanza del
	bersaglio (cfr. Hal9000'99).
	Nell'`else' che segue il primo if(...) della funzione shot() si
        utilizza la search() in cui ai classici if(range=scan...) sono
        fatte seguire delle cannon() senza correzione di angolo e gittata;
        per gli `else' che seguono gli if(range=scan(...)) della fire(),
        e` utilizzata la funzione fire2() che svolge il duplice
        compito di tracciare il bersaglio momentaneamente perduto, e
        sparare il colpo nel caso venga trovato, con una rapida ma
        efficace variazione dell'angolo e del range di gittata.
        Naturalmente, finche' il bersaglio e` sotto tiro, agisce la
        Tox-based doppia (sia per il robot da fermo che in movimento).
        Durante tutta la partita Jedi2 controlla periodicamente il numero di
        superstiti ed utilizza una routine di attacco finale, appena
	rimane un solo robot (danni < 80%): controlla l'angolo opposto e se
	libero si muove lungo la diagonale principale raggiungendolo; se
	occupato cerca di raggiungere un angolo adiacente, per poi riprendere
	daccapo.
        Nella variazione degli angoli di scansione/fuoco ogni decremento
        e` stato sostituito con un incremento equivalente (sommando 360
        gradi), per evitare la spiacevole (anche se rara) situazione di
        ottenere angoli negativi e conseguente scan() e cannon() errati.
        Jedi2 non tiene in nessun modo conto del famigerato bug
        dell'angolo 0 se si eccettua il fatto che preferisce attardarsi nelle
	oscillazioni (10 in piu`) a dx piu` che a sx ;-)

Strategia:
        Jedi2 raggiunge, nella primissima fase dell'incontro,
        l'angolo piu` vicino. Attende immobile (sparando) di essere
        colpito o che un robot avversario si avvicini (cfr.
	Hal9000'99, Goblin).
	Prima di cambiare angolo oscilla per un numero prefissato di volte
	o fino al momento in cui non subisce una prefissata quantita` di
	danni. L'oscillazione, a differenza del suo predecessore, e`
	effettuata solo su di un lato, quello percorso per ultimo o su
        quello perpendicolare nel caso in cui non sia riuscito a cambiare
        angolo.
	L'ampiezza di oscillazione e` imposta a circa 300 unita` per
        permettere a Jedi2 di raggiungere eventuali robot statici presenti
        nell'angolo opposto (1000 - 300 = 700 :-) ).
        Jedi2 sceglie in seguito un angolo libero adiacente, spostandosi
        lungo i bordi del campo di battaglia, preferibilmente in senso
        orario, oppure lungo la diagonale; se nessun angolo e` libero Jedi2
        non cambia posizione (e cambia lato di oscillazione).
        Periodicamente Jedi2 controlla il numero di superstiti: se ne rimane
	uno e se i danni sono inferiori all'80% innesca la routine di attacco
	finale, altrimenti prosegue utilizzando la medesima strategia iniziale.

Commenti:
        Jedi2 non riesce ad essere il migliore robot nel test Torneo98,
        ne' tantomeno nel Torneo91-98.
        I limiti maggiori risiedono in qualche "baco" (ovviamente a me non
        noto) del movimento, poiche', da quello che si riesce a
        vedere, la funzione di fuoco e` l'unica routine che funziona come
        si deve. Numerose modifiche sono state effettuate sulla strategia di
	movimento, senza riscontrare benefici.
	Il codice e` piu` ottimizzato rispetto alla versione Jedi'97 ed
	Hal9000'99 e quindi meno leggibile.

	Jedi2 sara` sviluppato in futuro, soprattutto dalle ceneri di
	Hal9000'99 :-}
	Il futuro e` nelle mani di robot dinamici (mi sbagliero`?)...

Credits:
        Un ringraziamento speciale a Simone Ascheri, inossidabile ed 
	instancabile aiuto senza il quale il Torneo Y2K non sarebbe mai
	venuto alla luce; un ringraziamento anche per il suo indecifrabile
	Son-goku, le cui routine base (molto base, poiche' le altre sono
	tuttora in fase di studio da parte di esperti di crittografia :-))
	sono state innestate in Jedi2.
        Un ringraziamento a tutti i fan di Crobots, Alessandro, Michelangelo,
	Daniele, Marco e tutti gli amici della maling list che hanno permesso
	lo svolgimento dell'importante evento di fine secolo.
	Un saluto agli miei colleghi OM del gruppo iRGP (Internet Radio
	Gateway Project) con i quali siamo riusciti a realizzare un importante
	progetto all'Universita` degli Studi di Ancona (fac. Ingegneria), che
	fornisce al Torneo Y2K un'adeguata potenza di calcolo.
        Un ringraziamento particolare a Fabio Farnesi per il supporto e la
        fiducia profusi.

                                                        'Joshua'

*/

int ang,        /* Angolo di scanning                           	*/
    oang,	/* Angolo di scanning precedente			*/
    range,	/* Gittata corrente					*/
    orange,	/* Gittata precedente					*/
    spd,	/* 1 se in movimento, 0 altrimenti			*/
    dam,	/* Variabile temporanea salva danni subiti		*/
    dir,
    deg,        /* Direzione del cammino                        	*/
    pos1,
    pos2,
    pos,  	/* Variabili temporanee ad uno e due bit		*/
    curx,
    cury,
    dx,
    dy,
    wall,
    deg1,
    lim1,
    deg2,
    flag,
    lim2,	/* Variabili temporanee per il movimento		*/
    enemy,
    maxwave,	/* Numero massimo di oscillazioni nell'angolo		*/
    maxcount;	/* Massimo numero di cicli virtuali in difesa		*/


main()
{
	ang=spd=flag=1;
	maxcount=200;
	xy2deg(dx=25+(950*(loc_x()>500)),dy=25+(950*(loc_y()>500)));
	go(dir+=360);
	dir=180*!pos1;
	while (1) /* Ciclo principale */
	{
	        if (flag) { /* Se l'angolo e` cambiato flag=1 */
		   dam=damage(spd=0);
		   wall=100000;
		   while (check(450,4)) shot(); /* Immobile come Hal9000'99*/
		}
		dam=damage(spd=1,curx=dx,cury=dy,dir%=360);
		maxwave=10+10*pos1; /* Jedi2 preferisce la destra :-) */
		while(check(350,10) && --maxwave) { /* Oscilla		*/
			if (!(dir % 180))
				dx=350+300*pos1;
			else
				dy=350+300*pos2;
			go(dir+=180);
		        if (scan(dir,10)) ang=dir;
		        else if (scan(dir+180,10)) ang=dir+180;
			dx=curx; dy=cury;
			go(dir-=180);
		}
		if (maxcount <= 0) { /* Controlla i cicli		*/
		 deg=9; enemy=0; /* Conta i nemici superstiti */
		 while ((deg+=20)<379) enemy+=(scan(deg,10)>0);
		   if (enemy<2) {
			if (damage() < 80) {
				wall=100000;
				while(1) { /* Funz. attacco finale	*/
				        if (radar(dir=((xy2deg(1000-loc_x(),1000-loc_y())/90)*90+45))) ;
					else if (radar(dir+=45)) ;
					else if (radar(dir+=270)) ;
					else dir+=45;
					change();
				}
			} else maxcount=999; /* altrimenti sempre uguale*/
		   } else maxcount+=100;
		} else { 
		/* Si muove in senso orario, se possibile		*/
		dir=((deg=xy2deg(1000-dx,1000-dy))/90)*90+90; 
		if (radar(dir)) change();
		else if(radar(dir+=270)) change();
	        else if (radar(deg)) {
		   change(dir=deg);
		   dir=180*!pos1;
		} else {
		   dir+=180; flag=0;
		}
	    }
	}
}

/* Utilities per raccogliere il codice */

change() {
        if (sin(dir+=360)) dy=1000-dy;
	if (cos(dir)) dx=1000-dx;
	go(flag=1);
}

shot() /* Funz. di fuoco principale			*/
{
        if ((orange=scan(ang,10)) && (orange<800) && orange)
		if ((orange > 300) && (wall > 30000)) fire();
		else fire2();
	else search();
}

scan_() /* Versione di Coppi				*/
{
        if(scan(ang+354,1)) ang+=354;
        if(scan(ang+6,  1)) ang+=6;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+358,1)) ang+=358;
        if(scan(ang+2,  1)) ang+=2;
}

fire()	/* Tox-based con innesti			*/
{
	scan_();
	if (orange=scan(oang=ang,5))
	{
		scan_();
		if (range=scan(ang,10))
		{
			cannon(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14)*spd,range*200/(200+orange-range-(cos(ang-dir)>>12)*spd));
		} else fire2();
	} else fire2();
}

search() /* Una delle funz. di fuoco di Son-goku, modificata	*/
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
}

fire2() /* Una delle funz. di fuoco di Son-goku, modificata    */
{
   if (range=scan(ang+353,4)) cannon(ang+=350,3*range-2*orange);
   else if (range=scan(ang,4)) cannon(ang,3*range-2*orange);
   else if (range=scan(ang+7,4)) cannon(ang+=10,3*range-2*orange);
   else search();
}

radar(x) /* 1 se la direz. x e` libera da robot avversari	*/
{
	return( !(scan(x+351,10) || scan(x+9,10)));
}

check(r,d) /* Controlla la vicinanza dei nemici, i cicli e i danni	*/
{
	return((!orange || orange>r) && (damage()<dam+d) &&
                (--maxcount>0));
}

go() /* Muoviti finche' la distanza non e` inferiore a sqrt(8000) unita`*/
{
	drive(dir,100);
	while (((wall=dist(dx,dy)) > 8000) && speed()) {
		shot();
	}
	stop();
}

xy2deg(x,y) /* Funz. rapida ma bacata che fornisce la dir. per (x,y)*/
int x,y;
{
	return (dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

dist(x,y) /* Distanza al quadrato (evita una sqrt())			*/
int x,y;
{
	return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()		/*  Fermati!						*/
{
        while (speed(drive(dir,0)) > 49) ;
        pos = (pos1=(loc_x() > 500)) + 2*(pos2=(loc_y() > 500)) ;
}

/* ``May the Force be with you'' */
