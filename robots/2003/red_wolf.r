/*
			\/\/\/\/\/\/\/\/\/\/\/\/\/\/

			R  E  D  _  W  O  L  F  .  r

			/\/\/\/\/\/\/\/\/\/\/\/\/\/\

			    di Pizzocaro Marco


Torneo di C Robots 2003
C Robots: Red_Wolf.r
Categoria: Micro
VB: 500 (50%)

Autore: Pizzocaro Marco

SCHEDA TECNICA
Red_Wolf.r tenta come Cariddi.r di superare i difetti di Scilla.r
(si rimanda alla scheda tecnica di questo crobots), ma
rimanendo al di sotto dei 500 VB. Per far ci• fonde in una unica routine
di fuoco lo sparo del 4vs4 e del f2f (in una funzione vergognosamente
brutta, che alterna i due metodi di sparo secondo la variabile m). Inoltre
vede le istruzioni dell'oscillazione notevolmente semplificata, a spese
di un peggior rendimento in 4vs4. Ma ci• mi permettere di inserire
una routine finale che descrive un rettangolo al centro dell'arena e
il conteggio del numero di nemici.

COMMENTI
Probabilemnte non potevo fare robot pi— brutto: nel tentativo di migliorare
Scilla.r ho menomato le sue caratteristiche e Red_Wolf.r in alcuni tornei
ha un rendimento peggiore dell'altro microbo. Purtroppo infatti non ho avuto
abbastanza tempo per migliorarlo e testarlo.


*/

int ang, range, dist, aq, oang;
int b, sc, m;
int dir;

main()
{
if(loc_y()>500)  {up(940); b=2;} else dn(60);
if(loc_x()>500)  {dx(920); b+=1;}else sx(80);
/*b=(loc_y()>500)*2+(loc_x()>500);*/
b=b+(b==2)-(b==3);
sc=90*b-15;


while(!nn())
{
	if (loc_x()>500){
	    if (!(dist=scan(dir=180,10))) dist=900;
	    if ((aq=dist-750)>0) sx(loc_x()-aq);
	    else sx(870);
	    dx(925);
	     }
	     else {
	     if (!(dist=scan(dir=0,10))) dist=900;
	     if	((aq=dist-750)>0) dx(aq+loc_x());
	     else dx(130);
	     sx(75);
	     }


}
m=1;
while(1)
	{
	while(loc_y()<520) fire(90);
	while(loc_x()>460) fire(180);
	while(loc_y()>480) fire(270);
	while(loc_x()<540) fire(0);
	}

}



up(limt) {while(loc_y()<limt) fire(90);}
dn(limt) {while(loc_y()>limt) fire(270);}
dx(limt) {while(loc_x()<limt) fire(0); drive(0,0);}
sx(limt) {while(loc_x()>limt) fire(180); drive(180,0);}



fire(dir)
{
drive(dir,100);
    if (range=scan(oang=ang,10)) {

	if(m)
	{
	if (scan(ang+350,10)) ang+=355; else ang+=5;
	if (scan(ang+350,9)) ang+=357; else ang+=3;
	}
	else
	{
	if (!scan(ang+=355,5)) ang+=10;
	if (!scan(ang+=357,3)) ang+=6;
	}
	cannon(ang+(ang-oang)*m,2*scan(ang,10)-range);
    }
    else if (range=scan(ang+=340,10)) cannon(ang,range);
	else if (scan(dir,10)) ang=dir;
	else if (range=scan(ang+=40,10));
	/*else if (scan(ang+=300,10));*/
	/*else if (scan(ang+=80,10));*/
	else ang+=300;

}

nn() {
int sca, nemici;
sca=sc;
nemici=2;
while(sca<=(sc+90)&&nemici) nemici-=(scan(sca+=20,10)>0);
return nemici;
}
