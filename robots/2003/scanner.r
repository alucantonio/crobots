/* *************************************************************************** */
/*   							*/
/*  NOME CROBOT: Scanner.r				*/
/*							*/
/*  CATEGORIA: 1000 istruzioni				*/
/*							*/
/*  AUTORE: Michele (Miccar) Cardinale 			*/
/*							*/
/* *************************************************************************** */

/*		SCHEDA TECNICA			*/
/*
Introduzione:

Il mese scorso, quasi per caso (stavo cercando del materiale sul C),
mi sono ritrovato sul sito www.itportal.it alla pagina dedicata ai C-Robots.
L'argomento della pagina ha subito destato il mio interesse. 
Ho cosi' contattato uno degli indirizzi trovati sul sito per chiedere maggiori
informazioni sui C-Robot e sui programmatori di tali combattenti virtuali!
Simone (a cui avevo indirizzato la mail) mi ha risposto con incredibile 
celerità e gentilezza indirizzandomi verso la ML e incoraggiandomi
a sviluppare alcuni Robots per il torneo che si sarebbe svolto da li' ad un mese.
Da allora, nei momenti liberi (ma in verita' pensandoci spesso anche durante 
la notte :) ), ho scaricato il materiale trovato sul sito e ho tentato di creare 
anch'io un mio C-Robot. Inutile dirvi che non e' stato facile visti gli incredibili
risultati a cui siete giunti in questi anni! Inizialmente mi basavo molto sui 4 
robots di esempio inclusi nel file crobots.zip. Quando ho provato a testare il
risultato del mio lavoro con qualcuno dei partecipanti al torneo dell'anno scorso..
potete immaginare i risultati! Da allora quindi il mio punto di riferimento sono 
stati i vostri lavori dell'anno scorso. 

Note su alcune routine:

Fin dall'inizio ho tentato di realizzare qualcosa di assolutamente nuovo rispetto
a cio' che avevo visto in giro, ma non e' facile. Praticamente tutte le routine sono 
oramai pressoche' ottimizzate! Mi sono concentrato molto su quella di fuoco
poiche' avevo notato che quasi tutte quelle che avevo preso in considerazione
si basavano su una formula del genere: cannon(deg,rngN*2-rngV). Tale formula
tiene conto del movimento dell'avversario ma, se non sbaglio, non tiene conto del
tempo che il missile impiega ad arrivare dalla nostra posizione a quella del robot
nemico. Per questo motivo ho preferito utilizzare un funzione che, chiamato x1 il
risultato del primo scan e x2 il risultato del secondo, calcoli la posizione x3 come

x3=x1-(x1-x2)* (Num cicli per arrivare a x3)/(Num cicli fra i due scan).

dove (NUM CICLI PER ARRIVARE A x3)=x3/3.33 (cioe' posizione finale diviso spazio 
percorso dal missile in un ciclo)
e (NUM CICLI FRA DUE SCAN) sara' una costante che si deve calcolare in base al 
num di istruzioni presenti tra i rilevamenti di x1 e x2.
Alla fine, sviluppando algebricamente, si otteneva qualcosa del genere:

range=(x2*j)/(j+x1-x2) con j costante.

A questo andava poi aggiunto un aggiustamento ad x1 dovuto al moto del proprio robot che,
al momento del secondo scan, si e' sicuramente spostato dalla posizione che occupava
al tempo del rilevamento di x2. Dopo aver riempito un po' di fogli con disegnini e grafici vari
giungo alla conclusione di dover calcolare x1Nuova in funzione della velocita' del mio
robot e dell' angolo relativo che c'e' tra la direzione del nemico e la direzione del senso
di marcia del mio robot.

x1Nuovo=x1-speed()*cost*cos(deg-dir) 

dove la costante "cost" deve tenere conto della scala che hanno i risulati delle operazioni
trigonometriche!

Cio' che alla fine tale funzione calcola e' soltanto la gittata del missile.
Avrei dovuto adesso trovare una funzione che approssimasse al meglio anche l'angolo di
sparo.. ma non l'ho fatto perche', una volta giunto a questo punto, mi sono reso conto che
tutto il lavoro fatto era gia' stato svolto abbondantemente da molti altri tempo prima ed era 
adesso praticamente caduto in disuso!

Ho preferito allora dedicarmi ad altro. 
E' venuta fuori un'idea un po' bislacca e SPERO stavolta originale :).. Visti i comportamenti 
della maggior parte dei robot dell'ultimo torneo (recarsi inizialmente nell'angolo piu' vicini e 
iniziare ad oscillare avanti e indietro) ho provato a realizzare un robot che, una volta giunto
al suo angolo, cercasse di individuare con la maggiore precisione possibile la coordinata 
su cui si muove avanti e indietro il robot che ha di fronte.
Una volta individuata tale posizione, inizia anch'esso a oscillare in dir del nemico tentando 
di mantenersi, tramite un controllo sulla quantita' di danni subiti, appena al di fuori della gittata
dell'avversario e sparando quindi alla massima potenza(700) dritto davanti a se.
Una volta eliminato l'avversario preso di mira, il robot inizia ad oscillare vicino al bordo fra i
due angoli conquistati aspettando che gli altri due si danneggino tra loro!

Ovviamente questo comportamento ha grosse pecche e grossi limiti: 
prima di tutto non funziona con tutti i tipi di movimento degli avversari ma solo con movimenti
perpendicolari! Inoltre ho notato che la capacita' di uccidere gli avversari prima che anche i propri
danni siano troppo elevati e' molto influenzata dall'avversario che si trova di fronte! 
Ad esempio, povandolo sui primi dello scorso torneo, riesce ad uccidere drizzt e wulfgar con
ottimo margine e quindi ad istallarsi nella posizione di sicurezza in attesa che gli altri due si 
massacrino, ma viene distrutto da zorn (che praticamente rimane illeso) probabilmente a causa 
del suo moto rettangolare.

Ovviamente non nutro alcuna aspirazione di vittoria. Mi sarebbe piaciuto tuttavia realizzare
qualcosa di innovativo ma il tempo e' stato veramente poco e i vostri C-robot si sono dimostrati 
veramente imbattibili! Spero di poter realizzare qualcosa di piu' competitivo per l'anno prossimo!


STRATEGIA:
*) Si sposta nell'angolo piu' vicino.
*) Inizia uno scanning per individuare la posizione in cui l'avversario compie il suo moto verticale.
*) Torna all'angolo e inizia uno scanning lungo l'altro asse.
*) Sceglie tra i 2 scanning quello che ha dato il risultato migliore(maggior numero di avvistamenti nemici):
*) Una volta individuata la posizione si sposta lungo il bordo alla stessa coordinata e inizia un moto verticale
	tentando di restare appena fuori dalla portata avversaria e sparando alla massima
	potenza.
*) Dopo aver eliminato l'avversario che ha di fronte inizia un moto oscillatorio tra i due angoli liberi
	in attesa che gli altri due robot si indeboliscano tra loro.

Note: All'inizio effettua un controllo sul numero di avversari presenti.
         Nel caso di un solo avversario parte la routine del f2f.

QUESTO CROBOT E' ASSOLUTAMENTE INCAPACE DI AFFRONTARE AVVERSARI CHE UTILIZZANO
UN MOTO A RETTANGOLO O QUADRATO O, ANCOR PEGGIO, UN MOTO DIAGONALE! 
SPERO CHE QUEST'ANNO SE NE VEDANO POCHI IN GIRO..
MI RENDO CONTO CHE SI TRATTA TUTTAVIA DI UNA SPERANZA VANA :)		


*/

int CAang,CAtemp; /* Variabili della funzione CA */

int a,b; /* Variabili della funzione CL */

int lx,ly,b1x,b2x,b1y,b2y,b3x,b3y,ax,ay,oscill; /* Variabili per il movimento */

int x1,x2,ang,dir,j,odeg; /* Variabili della funzione spara */

int dam;

int pos,deg,deg2,ll,lim;  /*Funzione CONTRO */

int ll2,lim2; /* Funzione inizializza */


/* ********* Variabili per la scansione ********************************************************************* */
int scansioni; /* Numero di posizioni da scansire per ogni lato*/
int stempo; /* Tempo da impiegare per scansire una singola locazione */
int visto; /* Quante volte e' stato avvistato un avversario da una certa posizione */
int max; /* Numero massimo di avvistamenti */
int POSY,POSX; /* Posizione del massimo degli avvistamenti */
int mov; /* Tempo da impiegare per raggiungere a velocita' 10 la nuova posizione da scansire */
int lato;
/* ************************************************************************************************************* */


main(){

lx=(-1+2*(loc_x()>499));
ly=(-1+2*(loc_y()>499));
b1x=CL(lx,420);
b1y=CL(ly,420);

b2x=CL(lx,495);
b2y=CL(ly,495);

b3x=CL(lx,475);
b3y=CL(ly,475);

vaiangolo();

scansioni=mov=5;
stempo=30;


if(CA()<2) quadrato(0);							/*CONTROLLA SE SI TRATTA DI UN MATCH A 2 */

while(1){
	scanner(ay,ax,1);
	vaiangolo();
	scanner(ax,ay,0);
	vaiangolo();
	contro(lato);
	}

} /*Chiusa MAIN */

scanner(deg,deg2,lat){
int deg,deg2,lat; /* lat=1 se scanna la Y -- 0 se scanna la X */

if(scan(deg+170,10)||scan(deg+190,10)){ 			/*SE C'E' UN AVVERSARIO NELL'ANGOLO OPPOSTO RISPETTO ALL'ASSE CONSIDERATO*/
	while(--scansioni){ 					/*EFFETTUA scansioni SCANSIONI*/
		while(--stempo){ 				/*PER stempo CICLI CONTROLLA SE C'E' L'AVVERSARIO*/
			if(scan(deg+180,0)) ++visto;		/*SE C'E' INCREMENTA IL CONTATORE*/
			spara();		 		/*INTANTO SPARA.. NON SI SA MAI :)*/
			}
		if (visto>max) {				/*SE L'AVVERSARIO E' STATO AVVISTATO + VOLTE RISPETTO ALLE SCANSIONI...*/
			max=visto;lato=lat;			/*...PRECEDENTI SEGNA LA LOCAZIONE SULL'ASSE SU CUI TI TROVI*/
			if(lat) POSX=loc_x();else POSY=loc_y();	
			} 
		while(--mov) spara(drive(dir=(deg2+180),10));			/*SPOSTATI LUNGO L'ASSE X PER UNA NUOVA SCANSIONE*/
		spara(drive(333,0));						/*FERMATI*/
		stempo=30;mov=5;visto=0;				 	/*REINIZIALIZZA LE VARIABILI*/
		}
	scansioni=5;	
	}
}

contro(lat){
int lat;
inizializza(lat);
while(((SL(lat)-pos)>7)||((SL(lat)-pos)<(-7))) drive(deg+180,10);			/*RAGGIUNGI LA POSIZIONE DI MASSIMO AVVISTAMENTO*/
while(speed()>0) spara(drive(dir=deg,0));					/*FERMATI*/
while((scan(deg2+170,10))||(scan(deg2+190,10))){				/*FINCHE' NON LO FAI FUORI...*/
	if (damage()-dam)  {if(oscill>30) oscill-=30; else oscill=0;} else {if (oscill<200) oscill+=1;}
	dam=damage();
	if((SL(!lat)*ll)>lim) drive(deg2+180,50);					/*MUOVITI AVANTI E INDIETRO VEDENDO DI RESTARE FUORI DAL SUO TIRO*/
	cannon(deg2+180,700);						/*SPARA*/
	if((SL(!lat)*ll)<lim-oscill) drive(deg2,50);
	}
quadrato(lat);								/*OSCILLA NELLA POSIZIONE DI SICUREZZA*/
}

vaiangolo(){
while(loc_y()*ly<b1y) spara(drive(dir=ay=(90*ly),100));
while(loc_x()*lx<b1x) spara(drive(dir=ax=(270+90*lx),100));
while(loc_y()*ly<b2y) spara(drive(dir=ay=(90*ly),20));
while(loc_x()*lx<b2x) spara(drive(dir=ax=(270+90*lx),20));
while(speed()>0) spara(drive(0,0));
}

CA(){ /* Ritorna il numero di avversari presenti nel terreno di gioco */
CAtemp=CAang=0;
while(CAang<360) if (scan(CAang+=20,10)) ++CAtemp;
return CAtemp;
}

spara() /* Grazie ad Alessandro Carlin.. la routine di fuoco e' sua.. */
{
    if (x1=scan(odeg=ang,10)) {
           if (scan(ang-=7,4));
           else if (scan(ang+=14,4));
           else if (scan(ang-=7,4));
    if (!(scan(ang+=2,2))) ang-=4; return(cannon(ang+(ang-odeg),2*scan(ang,10)-x1));
    }
    else {
        if (x1=scan(ang+=340,10)) return cannon(ang,x1);
        if (x1=scan(ang+=40,10)) return cannon(ang,x1);
        if (x1=scan(ang+=300,10)) return cannon(ang,x1);
        if (x1=scan(ang+=80,10)) return cannon(ang,x1);
        if (x1=scan(ang+=260,10)) return cannon(ang,x1);
        if (x1=scan(ang+=120,10)) return cannon(ang,x1);
        ang+=80;
    }
}


quadrato(lat){
inizializza(lat);
while(1){
	while(SL(!lat)*ll<lim-500) spara(drive(dir=deg2,100));
	while(SL(lat)*ll2>lim2-100) spara(drive(dir=deg+180,100));
	while(SL(!lat)*ll>lim-500) spara(drive(dir=deg2+180,100));
	while(SL(lat)*ll2<lim2-100) spara(drive(dir=deg,100));
	}
}

CL(a,b){
return a*(500+b*a);
}

SL(lat){
int lat;
if (lat) return loc_x();
return loc_y();
}

inizializza(lat){
int lat;
if (lat){ll=ly;deg=ax;deg2=ay;pos=POSX; lim=b3y;ll2=lx;lim2=b3x;}
else {ll=lx;deg=ay;deg2=ax;pos=POSY; lim=b3x;ll2=ly;lim2=b3y;}
}

