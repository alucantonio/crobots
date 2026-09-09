/*
			\/\/\/\/\/\/\/\/\/\/\/\/\/

			  S  C  I  L  L  A  .  r

			/\/\/\/\/\/\/\/\/\/\/\/\/\

			    di Pizzocaro Marco


Torneo di C Robots 2003
C Robots: Scilla.r
Categoria: Micro
VB: 494 (24%)

Autore: Pizzocaro Marco

SCHEDA TECNICA

Tattica & Strategia
Ho sviluppato il robot attorno ad una precisa tattica: raggiunto l'angolo
pió vicino, Scilla inizia ad oscillare solo orizzontalmente, con un
movimento "ad underscore", seguendo questa idea:
se l'oscillazione avviene abbastanza appiccicata alla parete dell'arena,
in una sola direzione, probabilmente uno dei due robot vicini (a meno che
non sia particolarmente aggressivo o furbo) farÖ fatica a colpire. Cosç
Scilla tenta di far diventare quella che era una sfida contro i due bot
negli angoli adiacenti, un duello con quello che trova in orizzontale.
Ignorando completamente il bot sulla stessa verticale, Scilla si concentra,
con oscillazioni abbastanza lunghe, sul suo nemico prescelto (che si spera
venga messo alle strette avendo da combattere contro 2 nemici).
Praticamente si tratta di un estremizzazione del fatto che i crobot moderni
non perdono mai l'avversario puntato: Scilla oltre a questo aggiunge la
possibilitÖ di avere l'avversario per pió tempo possibile a portata di fuoco
(mentre con una oscillazione ad L, per esempio, siamo praticamente certi
che il nemico sarÖ fuori tiro quando il robot si muove sul lato opposto ad
esso).
Un oscillazione del genere non ä affatto difensiva, ma esiste il piccolo
vantaggio di prenderle (spero) solo da uno solo dei due bot vicini, che
magari ha deciso per fatti suoi di sparare ad un altro robot.
La scelta della lunghezza dell'oscillazione (che si basa sulla distanza del
nemico verso cui si oscilla) ä spudoratamente copiata da Rudolf_6,
a cui, diciamo, mi sono largamente "ispirato". Forse avrei dovuto
controllare tra i robot dell'anno scorso se esistevano robot pió moderni da
cui attingere, ma ispirarsi a Rudolf_6 ha il vantaggio che so giÖ come
funziona. Rispetto a Rudolf_6, Scilla ä pió aggressivo e si muove per
un tratto pió lungo di arena.
Pur non essendo un movimento nuovo, mi sembra che fino ad ora sia stato
poco sfruttato, cosç posso almeno dire di non aver proposto qualcosa di
banale.


Dunque Scilla inizia ogni incontro raggiungendo l'angolo pió vicino.
Poi inizia inizia a compiere un oscillazione orizzontale Rudolf_6-like,
sparando al nemico che si trova sulla stessa orizzontale,
secondo la distanza che li separa, come descritto sopra.
Dopo un tot di cicli, se non ha subito troppi danni allunga
leggermente l'oscillazione.
Quando il nemico prescelto muore o si allontana, l'oscillazione si allunga
a coprire tutto il lato dell'arena, nel tentativo di sfuggire il pió
possibile ai colpi degli avversari rimasti. ContinuerÖ cosç fino alla fine
del match sperando che gli avversari si distruggano reciprocamente.

Quindi non c'ä routine finale o da f2f.
Scilla occupa con il codice del movimento in orizzontale tutti i 500 VB
concessimi. Ciï non mi permette di aggiungere una routine finale. Invano
ho tentato di aggiungerne una semplicissima, basata magari solo sul numero
di cicli. Scilla continuerÖ finchä vince o muore la sua oscillazione da 4vs4.
Ciï ne costituisce il maggior difetto (pió o meno risolto nei miei altri
robot di quest'anno): Scilla ha un pessimo rendimento in f2f e ottiene un
numero spropositato di pareggi in 4vs4 (non ha modo di colpire gli
avversari sul lato opposto).



Routine di Fuoco
Scilla usa un'unica routine di fuoco, la fire(), che deriva da quella del
mio scarso robot dell'anno scorso (supernova.r) con qualche accorgimento
di cui mi sono dimenticato. A sua volta quella dell'anno prima mi sembra
derivare da arale.r. E' quasi temporizzata con il movimento (impiega circa
78 cicli virtuali), ricava al volo l'angolo e corregge leggermente il range.
Contiene un istruzione che gli fa cambiare puntamento se il nemico ä troppo
lontano (range<1050), ma dovrebbe funzionare solo con il bot sulla diagonale
(sempre troppo lontano per poterlo colpire). Inoltre ä pronto a tornare
al nemico originario sulla stessa orizzontale se per sbaglio stava mirando
da altre parti (tramite scan(dir,10)).

COMMENTO
Anche se puï ottenere qualche risultato in 4vs4, il suo rendimento in f2f
ä scandaloso.

*/

int ang, range, xora, dist, aq, oscar;
int t;
int a, dir;

main()
{
if(loc_y()>500)  up(940); else dn(60);
if(loc_x()>500)  {dx(920); ang=180;}else sx(80);


while(1)
{
	if (loc_x()>500){
	    while(speed()>49);
	    drive(dir=180,100);
	    /*if (oldr&&oldr<800) adef();*/
	    if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) a=dist=900;
	    if ((aq=dist-700+oscar)>0) xora=loc_x()-aq;
	    else xora=870;
	    sx(xora);
	    dx(925);
	     }
	     else {
	     while(speed()>49);
	     drive(dir=0,100);
	     /*if (oldr&&oldr<800) bdef();*/
	     if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) a=dist=900;
	     if	((aq=dist-700+oscar)>0) xora=aq+loc_x();
	     else xora=130;
	     dx(xora);
	     sx(75);
	     }

	if(++t>20||range>850)
	  {
	  oscar=40*((t>25));
	  if(a&&t>2) if (!scan(0,10)&&!scan(180,10)) {oscar=500; t+=2;}
	  if(damage()>80) oscar=0;
	  /*if(t>150) {up(500); dn(500);}*/
	  a=0;
	  }

}


}

fire()
{

if ((range=scan(ang,7))&&range<1050)
  {
   if (range<100) return cannon(ang,range);
   else
   cannon(ang+=4*(!(scan(ang+355,6)))+356*(!(scan(ang+5,6))), 3*scan(ang,10)-2*range);
  }
  else if (scan (ang-=16,10));
 /* else if (scan (ang+=32,10));*/
  else if (scan (dir,10)) ang=dir;
  else if(!scan (ang+=32,10)) ang+=30;
}



up(limt) {while(loc_y()<limt) {drive(90,100);fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(0,100);fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);fire();}drive(180,0);}



