
/*
			\/\/\/\/\/\/\/\/\/\/\/\/\/

			      K  N  T  .  r

			/\/\/\/\/\/\/\/\/\/\/\/\/\

			    di Pizzocaro Marco

Torneo di C Robots 2003
C Robots: Knt.r
Categoria: Macro
VB: 1214 (60%)

Autore: Pizzocaro Marco


SCHEDA TECNICA
Si tratta semplicemente di Cariddi.r, con alcune piccole modifiche:
-l'oscillazione orizzontale Š pi— corta
-accanto ad essa affianca un oscillazione in diagonale difensiva
 sempre della stessa lunghezza.
Ci• a comportato il passaggio alla categoria dei Macro.
Per la descrizione di tutte le altre caratteristiche si rimanda alla
scheda tecnica di Cariddi.r

COMMENTO
L'anno scorso avevo partecipatoi solo con un microbo. Quest'anno volevo
partecipare invece con tutti e 4 i robot. Ma ho sprecato molto tempo
nell'evoluzione di Cariddi, e volendo far fede al mio proposito, ho
assemblato in fretta e furia questo macro, che Š perfino peggiore di
Cariddi stesso.



oscillazione orizzontale rudolf_6-like
meltdown variabile
fuoco modificato
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

if(nn()) meltdown();


while(damage()<30) Cariddi(++t);
while(damage()<70&&!a) Scilla(++t);
while(!nn()&&t<165) Cariddi(++t);

if(damage()<80) meltdown();
while(1) Cariddi();


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
    if ((aq=dist-750+oscar)>0) xora=loc_x()-aq;
    else xora=870;
    sx(xora);
    dx(925);
    }
    else {
    while(speed()>49);
    drive(dir=0,100);
    /*if (oldr&&oldr<800) bdef();*/
    if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) a=dist=1400;
    if	((aq=dist-750+oscar)>0) xora=aq+loc_x();
    else xora=130;
    dx(xora);
    sx(75);
    }
if((damage()-dam)>3) oscar=-50;
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
sx(80);
while(1) Cariddi();
}

nn() {
int sca, nemici;
sca=sc;
nemici=2;
while(sca<=(sc+90)&&nemici) nemici-=(scan(sca+=20,10)>0);
if(nemici>0) return 1;
return 0;
}


ne(limt) {while(loc_x()<limt&&loc_y()<limt) {drive(45,100);fire();}drive(45,0);}
no(limt) {while(loc_x()>limt&&loc_y()<(1000-limt)) {drive(135,100);fire();}drive(135,0);}
se(limt) {while(loc_x()<limt&&loc_y()>(1000-limt)) {drive(315,100);fire();}drive(315,0);}
so(limt) {while(loc_x()>limt&&loc_y()>limt) {drive(225,100);fire();}drive(225,0);}


Cariddi()
{
dam=damage();
if(b==0) {
    while(speed()>49);
    drive(45,100);
    ne(115);
    so(70);
    }
else if(b==1)
    {
    while(speed()>49);
    drive(135,100);
    no(885);
    se(930);
    }
else if(b==2)
    {
    while(speed()>49);
    drive(225,100);
    so(885);
    ne(930);
    }
else
    {
    while(speed()>49);
    drive(315,100);
    se(115);
    no(70);
    }

if((damage()-dam)>5) oscar=-100;
else oscar=0;
}
