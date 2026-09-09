/*                    T H E   I N V I S I B L E   M A N                     

        AUTORE
        Nome: Alessandro Carlin

SCHEDA TECNICA:
Inizialmente il crobot si porta vicino al fondo dello schermo, e da questa
posizione controlla l' angolo SUD-OVEST; nel caso in cui sia libero lo
raggiunge, altrimenti va ad occupare l' angolo SUD-EST. Raggiunta una di
queste posizioni inizia un movimento oscillatorio di circa 200 metri
che avviene in direzione verticale se non ci sono nemici negli angoli
adiacenti, e diventa orizzontale se e' presente un crobot nell' angolo
superiore. Durante questa fase (che dura almeno 8E+4 cicli virtuali di CPU)
The Invisible Man utilizza 2 diverse procedure di fuoco: kill() che consente
un puntamento molto preciso ma e' piuttosto lenta, e mortal() che e' di
esecuzione molto piu' rapida. Successivamente il crobot inizia ad effettuare
dei controlli (circa ogni 15 oscillazioni) sui robot rimasti: se ne individua
uno solo e i danni sono minori dell' 80% lo attacca con la procedura attack()
portandosi al centro del campo ed oscillando in direzione orizzontale.
La funzione di sparo e' diversa dalle due precedenti ed e' divisa in due parti
distinte: destroy() e shot().

PRECISAZIONI:
1) La routine di puntamento piu' precisa deriva dal crobot JEDI che ha
partecipato alla scorsa edizione del torneo.
2) La procedura di attacco e' molto simile a quella del crobot ARALE ma e'
stata migliorata apportando una semplice correzione sulla gittata ed un
puntamento piu' preciso nella sottoroutine di sparo rapido.
3) Il movimento oscillatorio o la vicinanza di due nemici fa si che talvolta
la funzione di controllo sul numero di nemici (radar()) sbagli; di conseguenza
The Invisible Man puo' attaccare anche se sono presenti 2 (molto raramente 3)
nemici. Non so se in effetti questo sia un inconveniente o no: infatti quando
The Invisible Man attacca e' nella zona centrale e puo' essere colpito da
chiunque, mentre lui attacca un nemico alla volta. Quindi la procedura
funziona al meglio contro un solo avversario; tuttavia si e' dimostrata cosi'
efficiente che spesso riesce a sconfiggere due nemici senza riportare troppi
danni.
4) Quest' anno ho spedito due crobot, ma questo e' quello che preferisco
veder combattere nel caso fosse necessario limitare la partecipazione ad un
solo concorrente.

COMMENTO:
L' uso di due procedure di fuoco mentre oscilla dipende dal fatto che
mortal(), pur essendo meno precisa, e' molto piu' veloce; questo permette al
crobot di avvicinarsi con piu' precisione ai muri senza spalmarsi; inoltre
negli scontri ravvicinati mortal() non e' molto inferiore a kill().
Il cambiamento di direzione nell' oscillazione e la scelta iniziale dell'
angolo sono ovviamente accorgimenti volti a mantenere The Invisible Man
fuori tiro per gli altri crobots.
Infine mi pare molto intelligente fare attaccare il crobot solo quando e'
rimasto un avversario solo nell' arena anziche' rischiare di fare i kamikaze
contro 3 avversari; soprattutto e' importante attaccare APPENA rimane solo un
nemico per evitare di attendere troppo e di essere attaccati. Mi sembra a
proposito giusto far notare che la funzione radar() (peraltro semplicissima)
era gia' stata usata da TEQUILA 3 anni fa.

NOTE:
Ho avuto non poche difficolta' ad ottimizzare il codice, e ho dovuto
rinunciare ad alcuni miglioramenti che volevo apportare (ad esempio la
possibilita' di svariare su 4 angoli) per l' ormai famigerata limitazione
sulla lunghezza del listato. Penso quindi che senza riprogrammare il
compilatore da zero basterebbe alzare questa soglia per aumentare notevolmente
la competitivita' dei robot e, di conseguenza, la longevita' del gioco (gia'
elevatissima).
                                                                            */
/*                     I 'M THE INVISIBLE MAN
              I 'M THE INVISIBLE INVISIBLE INVISIBLE MAN                    */

int pp,dz,dw,dx,su,via,ang,dir,cont,c;

/* I 'M THE INVISIBLE MAN
   I 'M THE INVISIBLE MAN
   INCREDIBLE HOW YOU CAN
   SEE RIGHT THROUGH ME
   I 'M THE INVISIBLE MAN
   I 'M THE INVISIBLE MAN
   IT 'S CRIMINAL HOW I CAN
   SEE RIGHT THROUGH YOU       */

main()
{
        c=14;
        ang=0;
        cont=0;
	drive(dir=270,100);
        while (loc_y() > 160) kill();
	stop();
        if ((!scan(180,10))&&(!scan(162,10))) {
        drive(dir=180,100);
        dz=0;
        dw=180;
        dx=0;
        while(loc_x() > 140) {
                kill();
	}
        stop(); }
        else {
        drive(dir=0,100);
        dz=180;
        dw=0;
        dx=1;
        while(loc_x() < 840) {
                kill();
	}
        stop(); }
	while(1)
	{
        su=scan(90,10);
        via=scan(dz,10);
        if (su<=via){
                drive(dir=90,100);
                while (loc_y() < 285)         
		{
                kill();
		}
                stop();
                drive(dir=270,100);
                kill();
                kill();
                while (loc_y() > 90)
		{
                mortal();
		}
                stop();  }
                else {
                drive(dir=dz,100);
                if (dx==0) while(loc_x() <= 285)       
                {
                kill();
                }
                else while(loc_x() >715)                
                {
                kill();
                }
                stop();
                drive(dir=dw,100);
                kill();
                kill();
                if (dx==0) while(loc_x() > 95)
                {
                mortal();
                }
                else while(loc_x() < 910)
                {
                mortal();
                }
                stop();  }
	}
}

int   d,oang,range,orange,aa,rr,diff;

/* WHEN YOU HEAR A SOUND
   THAT YOU JUST CAN'T PLACE
   WHEN SOMETHING MOVE
   THAT YOU JUST CAN'T TRACE
   WHEN SOMETHING SITS
   IN THE END OF YOUR BED
   DON'T TURN AROUND
   WHEN YOU HEAR MY TREAD
   I 'M THE INVISIBLE MAN... */

search()
{
	if(scan(ang-5,1)) ang-=5;
	if(scan(ang+5,1)) ang+=5;
	if(scan(ang-3,1)) ang-=3;
	if(scan(ang+3,1)) ang+=3;
	if(scan(ang-1,1)) ang-=1;
	if(scan(ang+1,1)) ang+=1;
}

/* ...AND I 'M IN YOUR ROOM
   AND I 'M IN YOUR BED
   AND I 'M IN YOUR LIFE
   AND I 'M IN YOUR HEAD
   LIKE THE C.I.A.
   OR THE F.B.I.
   YOU 'LL NEVER GET CLOSE
   NEVER TAKE ME ALIVE
   I 'M THE INVISIBLE MAN... */

kill()
{
        if(range=scan(ang,5))
	{
                cannon(ang,range);
                search();
		if (range=scan(ang,5))
		{
			orange=range;
			oang=ang;
                        search();
			if (range=scan(ang,10))
			{
				aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14));
				rr=(range*160/(160+orange-range-(cos(ang-dir)>>12)));
				while(!cannon(aa,rr));
				if (range>700) ang+=30;
			}
			else if(scan(ang-=10,10));
			else if(scan(ang+=20,10));
			else ang+=40;
		}
		else if(scan(ang-=10,10));
		else if(scan(ang+=20,10));
		else ang+=40;
	}
	else if(scan(ang-=10,10));
	else if(scan(ang+=20,10));
	else ang+=40;
}

/* AH,AH,AH HELLO
   AH,AH,AH OK
   AH,AH,AH HELLO
   HELLO, HELLO, HELLO... */

attack()
{
while(loc_y()<450) {drive(90,100);destroy();}
drive(90,0);
while(speed()>49) destroy();
 while(1)
  {
   drive(0,100);  while (loc_x() < 900) destroy();
   drive(0,0);     shot();      
   drive(180,100); while (loc_x() > 100) destroy();
   drive(180,0);   shot();
  }
}

/* NEVER HAD A REAL GOOD FRIEND
   NOT A BOY OR A GIRL... */

destroy(){
    if (pp=scan(ang,10))
      cannon(ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))),2*scan(ang,10)-pp);
                                         else ang+=21;
   }

/* ...SO I MAKE MY MARK
   FROM THE EDGE OF THE WORLD... */

stop()  {
	drive(dir,0);
        if ((++cont >= 86) && (damage() < 80)) {++c;     
        if (c%15==0) {if(radar()<2)
                attack();} }
        while(speed() > 49) mortal();

}

/* ...FROM THE EDGE OF THE WORLD
   FROM THE EDGE OF THE WORLD... */

mortal()
{  
 if ( (d=scan(ang,10)) && (d<750) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<710)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<710)) ang+=42;
        else ang+=63;
  }  
}                         

/* ...AND I 'M IN YOUR ROOM
   AND I 'M IN YOUR BED
   AND I 'M IN YOUR LIFE
   AND I 'M IN YOUR HEAD... */

radar()       
{
    int num,da;     
    num=0; da=1;
    while (da!=361) 
    { 
        if (scan(da,10)) ++num;  
        da+=18;
    }
    return num;
}

/* ...LIKE THE C.I.A.
   OR THE F.B.I.
   YOU 'LL NEVER GET CLOSE
   NEVER TAKE ME ALIVE
   I 'M THE INVISIBLE MAN... */

shot()
{     
 while (speed() > 49) if ((d=scan(ang,10))) {
                      if (!scan(ang+=5,5)) ang-=10;
                      cannon(ang,d);
                      }
                      else ang+=20;
}

/*         I 'M THE INVISIBLE INVISIBLE INVISIBLE INVISIBLE MAN...          */

