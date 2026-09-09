/*

######      #####    ##########         ###     ###     #####     ##    ##
##    ##   ##   ##       ##             ####   ####    ##   ##    ###   ##
##   ##   ##     ##      ##             ## ## ## ##   ##     ##   ## ## ##
#######   #########      ##     #####   ##  ###  ##   #########   ##  ####
##    ##  ##     ##      ##             ##   #   ##   ##     ##   ##   ###
##    ##  ##     ##      ##             ##       ##   ##     ##   ##    ##
##    ##  ##     ##      ##             ##       ##   ##     ##   ##    ##

Crobots 	: Rat-Man
Type		: Micro
Version 	: 1.0
Author		: Maurizio Camangi
Begin		: 02-dic-2003
Revision	: 23-gen-2004

Scheda tecnica:

Rat-Man, come la stragrande maggioranza dei robot attuali, raggiunge l'angolo più vicino e inizia un movimento di
oscillazione a forma di "V" utilizzando, ad esempio, un'angolazione di 30 e 60 gradi rispetto al vertice dell'arena
in basso a sinistra.
L'estensione dell'oscillazione è di circa 300 unità, che si riducono a circa 280 qualora venisse colpito con un danno
superiore al 5% nel mentre del movimento di allontanamento dall'angolo.
Periodicamente conta gli avversari e nel caso in cui ci sia solo un robot, per effettuare lo scontro face2face, estende
l'estensione dell'oscillazione fino a circa 660 unità (ridotte se subisce danni).
Rat-Man fa uso delle funzioni di fuoco Tox-like derivate dalla famiglia dei robot di Simone Ascheri, grande appassionato
di Crobots, talentuoso programmatore e soprattutto amico. Un ringraziamento speciale va sicuramente a lui!

Intervista in esclusiva con Rat-Man:

MC :	Buon pomeriggio sig. Rat-Man, a nome di tutta la comunità crobotica le dò il benvenuto.
	E' un vero piacere averla fra noi per un'intervista in esclusiva, ed è un vero onore saperla
	iscritto a questa celeberrima manifestazione annuale.
	[voce leggermente tremolante, velata da una trabordante emozione]
	Ma lei, sig. Rat-Man, il paladino della legge, oltre a dare indubbiamente lustro alla competizione,
	per quale motivo è realmente sceso in campo ?
RM :	Buon pomeriggio a lei. Beh, a dire la verità (sebbene sia un'informazione riservata), posso dirle che
	sono trapelate delle notizie sulla regolarità della competizione, che si dice sia gravemente minacciata!
	[sguardo fiero, voce sicura e seria]
MC :	Questa cosa, se trapelasse, non potrebbe che gettare la comunità nel più completo panico! Di che cosa si
	tratta con precisione ?
RM :	Ciò che tutti i partecipanti devono sapere, riguarda un losco traffico di sorgenti di robot, un vero e
	proprio mercato nero del codice. Devo assolutamente smascherare i trafficanti e soprattutto la mente di
	questa organizzazione malavitosa, che da tempo spaccia sottobanco i sorgenti dei robot di Crobots...
	[il tono della voce diventa ancora più duro]
MC :	Scusi un attimo, sig. Rat-Man, non vorrei contraddirla senza motivo, ma mi risulta (anzi, glielo dico per certo)
	che fin dai primissimi anni '90, i sorgenti dei robot siano stati sempre liberamente disponibili.
	[delusione abilmente celata da un accennato sorriso di circostanza]
[pausa di silenzio...]
RM :	Lei ne è sicuro, eh ?
MC :	Sì, assolutamente.
[pausa di silenzio, RM lancia una rapida e nervosa occhiata all'orologio a muro]
MC :	Beh, continuando la nostra interessante conversazione, che cos altro ci può dire, sig. Rat-Man ?
RM :	Sono del tutto sicuro che vi sia comunque la presenza di un losco figuro, un abile e infingardo
	programmatore, che abbia tutto l'interesse a sabotare la manifestazione.
	[il tono della voce a fatica ritorna duro e carico di serietà]
MC :	E come potrebbe accadere una cosa del genere ? Sono anni che collaboro all'organizzazione del
	torneo e mai v'è stato un tentativo tale, e non vedo come sia tecnicamente possibile!?!
	[alla delusione si aggiunge via via una mal celata sfiducia]
RM :	Mi sono giunte sicure notizie riguardanti un programmatore che adora usare nomignoli legati al mondo
	dei fumetti giapponesi; questo personaggio sfrutta potenti metodi di crittografia e compressione del codice
	per confodere gli avversari (eludendone gli attacchi) mettendo in grave difficoltà il compilatore Crobots stesso!
	[gli occhi di RM scintillano di orgoglio e rabbia]
	Farò di tutto per catturarlo e renderlo innocuo, garantendo il corretto svolgimento del torneo!
	[sguardo pieno di fierezza]
MC :	Sono davvero spiacente di doverlo contraddire nuovamente, sig. Rat-Man...
	[nasce spontanea una risatina di scherno]
	ma tutti noi conosciamo il nome di questo personaggio: è famoso per la sua indiscussa genialità, grazie alla quale
	ha potuto raggiungere i gradini più alti del podio...
	Ammirato e stimato da tutta la comunità crobotica, è per di più fonte di ispirazione del suo robot, sig. Rat-Man...
[pausa di silenzio... RM è visibilmente in difficoltà]
RM :	Io non avrei mai immaginato che lei... lei...
MC :	Ma mi faccia il piacere! Io non l'ho mai visto neanche da lontano il podio, e sono fissato con Guerre Stellari!!!
	Proprio non ha capito di chi stiamo parlando ?
[pausa di silenzio... la maschera di RM trasuda goccioline impercettibili di sudore]
RM :	Bill Gates ?

                               ATTENZIONE


QUESTO C-ROBOT E' FATTO DI BIT AL 100%
NEL CASO IMPROBABILE CHE VENGA A CONTATTO CON ANTI-BIT DI QUALUNQUE TIPO
NE RISULTERA' UN'ESPLOSIONE.


                                AVVERTENZA


UN GIORNO, L'INTERO UNIVERSO (COMPRESO QUESTO C-ROBOT) POTREBBE COLLASSARE
IN UN PUNTO INFINITAMENTE PICCOLO. SE UN ALTRO UNIVERSO DOVESSE IN SEGUITO
EMERGERNE, L'ESISTENZA (ED IL FUNZIONAMENTO) DI QUESTO C-ROBOT IN
QUELL'UNIVERSO NON PUO' ESSERE GARANTITO.

*/

int ang,        /* Angolo di scanning                                   */
    oang,       /* Angolo di scanning precedente                        */
    range,      /* Gittata corrente                                     */
    orange,     /* Gittata precedente                                   */
    dam,        /* Variabile temporanea salva danni subiti              */
    dir,        /* Direzione del cammino                                */
    posx,
    posy,
    x,y,       /* Variabili temporanee ad un bit salva posizione       */
    dif,
    dist,
    limit,
    flag;

_scan_()  
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}

int run_(safe)
int safe;
{
 drive(dir,100);
 if (safe);
 else if (scan(ang,10))
    {
      if ((orange=_scan_())<limit)
        {
          if (range=_scan_())               
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*220/(220+orange-range-(cos(ang-dir)/4167))));
        }
    }     
  if ((range=scan(ang,10))&&(range<limit));
  else
    if((range=scan(ang+=339,10)));
    else
      if((range=scan(ang+=42,10)));
      else
        if((range=scan(dir,10))) ang=dir;
        else
          return (ang+=40);
  cannon (ang,2*scan(ang,10)-range);
}

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

dista(dx,dy) /* Distanza al quadrato (evita una sqrt())   */
int dx,dy;
{
        return (((dx-=loc_x())*dx+(dy-=loc_y())*dy));
}

corner() {
	degree(x=20+960*posx,y=20+960*posy);
	while((dist=dista(x,y)) > 8100) run_(dist<25600);
	drive(dir,0);
}

main() /* Inizializza alcune variabili ed innesca la routine principale */
{
int dist3,timer,deg,l,dif,d;

 corner(posy=loc_y(posx=loc_x(limit=850)>500)>500,dist3=94900,dif=(60*(posx^posy))-30);

 while (1)
 {
        while (--timer>-1) {
        	dir=flag*(540*posx - dif) + (!flag)*(90 + 180*posy + dif);
		while(dista(x,y) < (dist3-16200*(damage()>d))) run_(0); drive(dir,0);
		d=damage(corner(flag^=1))+5;
        }
        l=(deg=(90*((posy<<1)+(posx^posy))+320))+131;
        while((deg < l) && (timer<1)) { timer+=(scan(deg+=20,10)>0); }
        if (timer<1) {
	   limit=timer=dist3=438700;
        }
 }
}

/* Fletto i muscoli e sono nel vuoto! */
