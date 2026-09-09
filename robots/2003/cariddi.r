
/*
			\/\/\/\/\/\/\/\/\/\/\/\/\/

			 C  A  R  I  D  D  I  .  r

			/\/\/\/\/\/\/\/\/\/\/\/\/\

			    di Pizzocaro Marco

Torneo di C Robots 2003
C Robots: Cariddi.r
Categoria: Classic
VB: 904 (42%)

Autore: Pizzocaro Marco


SCHEDA TECNICA
Cariddi condivide i motivi tattici di Scilla.r e ne costituisce il
miglioramento e il superamento sfruttando il maggior spazio a disposizione.

Cariddi inizia l'incontro muovendosi verso l'angolo pió vicino dell'arena.
Conta i nemici presenti con un unica chiamata della funzione nn() (pur non
avendo osservato un numero molto grande di incontri penso non sbagli mai)
ed eventualmente parte con la routine finale meltdown();

Scontro 4vs4: nello scontro 4vs4 inizia ad oscillare orizzontalmente
chiamando la funzione Scilla() e usando la routine di fuoco fire();
L'oscillazione ä simile a quella di scilla.r. La parte centrale del match
ä gestita da 2 while. Il primo continua finchä il nemico sulla stessa
orizzontale ä presente (ovvero finchä la variabile 'a' ä zero; questo
consente di risparmiare tempo non richiamando la funzione nn() che impiega
un certo tempo a contare i nemici, in quanto finchä il nemico puntato ä
nell'angolo ä inutile partire con l'attacco finale). Quando non trova pió
il nemico nell'angolo sulla stessa orizzontale (nella situazione ideale
perchä morto; potrebbe anche accadere che il nemico faccia un oscillazione
troppo lunga ed esca dal "campo di vista" scansionato nel controllo: poco
male, il resto dell'incontro ä comunque regolato dal secondo while) inizia
il secondo while che invece controlla il numero di nemici scansionando
l'arena (nel modo pió veloce possibile, non controllando inutilemnte
verso le pareti dell'arena 'alle sue spalle' e interrompendosi non appena
conta 2 nemici) e con una variabile che conta il numero di cicli.
L'oscillazione ä per il resto identica. Se trova
un solo nemico o se stanno per scadere i 200000 cicli virtuali del match
parte con la routine finale meltdown() (se non ha troppi danni).

Attacco finale meltdown(): nella fase finale del 4vs4 o nel f2f usa invece
la routine fuoco(). Cariddi si sposta al centro dell'arena e descrive un
rettangolo, i cui lati vengono allungati se l'avversario ä troppo vicino.
L'incremento non ä lo stesso tra i due lati del rettangolo.


Routine di fuoco
la fire() ä la stessa di Scilla.r, che deriva da quella del
mio scarso robot dell'anno scorso (supernova.r) con qualche accorgimento
di cui mi sono dimenticato. A sua volta quella dell'anno prima mi sembra
derivare da arale.r. E' quasi temporizzata con il movimento (impiega circa
78 cicli virtuali), ricava al volo l'angolo e corregge leggermente il range.
Contiene un istruzione che gli fa cambiare puntamento se il nemico ä troppo
lontano (range<1050), ma dovrebbe funzionare solo con il bot sulla diagonale
(sempre troppo lontano per poterlo colpire). Inoltre ä pronto a tornare
al nemico originario sulla stessa orizzontale se per sbaglio stava mirando
da altre parti (tramite scan(dir,10)). Viene usata nel 4vs4;

la fuoco() deriva da Rudolf_6.r e da Drizzt.r, con qualche modifica
irrilevante. Corregge angolo e range e viene usata nell'attacco finale.

COMMENTO
Non ho altro da dire se non che questo ä il robot che ho testato pió a
lungo, con notevole spreco di tempo e conseguente poco lavoro sugli
altri robot presentati.


*/

int oang, ang, range, xora, dist, aq;
int b;
int a;
int sc, dir;
int t, oscar, dam;

main()
{
if(loc_y()>500)  up(940); else dn(60);
if(loc_x()>500)  dx(920); else sx(80);
b=(loc_y()>500)*2+(loc_x()>500);
b=b+(b==2)-(b==3);
sc=90*b-15;


if(nn()) meltdown();

Scilla();
ang=dir;

while(!a) Scilla(++t);
while(!nn()&&t<140) Scilla(++t);
if (damage()<80) meltdown();

while(1) Scilla();


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





fuoco()
{
    if (range=scan(oang=ang,10)) {
      /*	if (!scan(ang+=355,5)) ang+=10;
	if (!scan(ang+=357,3)) ang+=6;*/
	if (scan(ang+350,10)) ang+=355; else ang+=5;
	if (scan(ang+350,9)) ang+=357; else ang+=3;

	cannon(ang+(ang-oang),2*scan(ang,10)-range);
    } 
    else {
	if (range=scan(ang+=340,10)) return cannon(ang,range);
	if (range=scan(ang+=40,10)) return cannon(ang,range);
	if (range=scan(ang+=300,10)) return cannon(ang,range);
	if (range=scan(ang+=80,10)) return cannon(ang,range);
	if (range=scan(ang+=260,10)) return cannon(ang,range);
	if (range=scan(ang+=120,10)) return cannon(ang,range);
	ang+=80;
    }
}





up(limt) {while(loc_y()<limt) {drive(90,100);fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(0,100);fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);fire();}drive(180,0);}


Scilla()
{
dam=damage(a=0);
if (loc_x()>500){
    while(speed()>49);
    drive(dir=180,100);
    /*if (oldr&&oldr<800) adef();*/
    if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) a=dist=1400;
    if ((aq=dist-700+oscar)>0) xora=loc_x()-aq;
    else xora=870;
    sx(xora);
    dx(925);
    }
    else {
    while(speed()>49);
    drive(dir=0,100);
    /*if (oldr&&oldr<800) bdef();*/
    if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) a=dist=1400;
    if	((aq=dist-700+oscar)>0) xora=aq+loc_x();
    else xora=130;
    dx(xora);
    sx(75);
    }
if((damage()-dam)>5) oscar=-100;
else oscar=0;
}

meltdown()
{
dam=damage();
while((damage()-dam)<9) {
	
	while(loc_y()<520+60*(range<300)) fuoco(drive(90,100));
	while(loc_x()>460-20*(range<300)) fuoco(drive(180,100));
	while(loc_y()>480-60*(range<300)) fuoco(drive(270,100));
	while(loc_x()<540+20*(range<300)) fuoco(drive(0,100));
	dam=damage();
}
dn(80);
while(1) Scilla();
}

nn() {
int sca, nemici;
sca=sc;
nemici=2;
while(sca<=(sc+90)&&nemici) nemici-=(scan(sca+=20,10)>0);
if(nemici>0) return 1;
return 0;
}


