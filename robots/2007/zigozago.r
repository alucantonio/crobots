/*

Z I G O _ Z A G O

Torneo di C Robots 2007
C Robots: zigozago.r
Categoria: Micro
VB:  500 (25%) 

Autore: Pizzocaro Marco


zigozago.r nasce dall'idea di usare un moviento a zig-zag nel f2f. Per 
risparmiare spazio usa lo stesso movimento anche nel 4vs4.

Dunque, nei f2f si muove a zig zag verso destra e sinistra al centro del 
campo (movimento del tutto simile a rudolf_9.r).
Nei 4vs4 si muove a zig zag solo nel suo angolino. Questo movimento
in presenza di tre nemici non e' molto furbo (e nonostante compia
oscillazioni molto corte, le prende anche dalle toxiche!) ma non c'è spazio
(tempo e idee) per altro. Conta i nemici ad ogni oscillazione.
L'unica routine di fuoco deriva da quelle dei fratelli maggiori neutron.r e 
proton.r (a loro volta derivate da una routine di !alien.r).

zigozago.r e' stato preso a martellate per farlo rientrare nelle 500 
istruzioni (la routine di fuoco è abbastanza ingombrante),
quindi il listato è particolarmente inconprensibile. Per esempio la variabile 
"m" nella routine di fuoco (che controlla di quanto varia l'angolo) deve
essere 1 nei f2f e 0 nei 4vs4. Mentre la variabile "m" del conteggio
dei nemici (originariamente chiamata in un altro modo) e' 1 quando trova
un solo avversario, zero altrimenti. Quindi il comportamento delle
due variabili e' identico e questa fortunata coincidenza mi permette 
di risparmiare una variabile e qualche controllo. Infine il ciclo
dell'attacco finale contiene comunque "m=1" in modo che il tutto funzioni
anche quando la routine da f2f viene chiamata allo scadere del tempo,
e non perche' e' rimasto un solo nemico. (Tutto questa fatica solo per avere
m=1 mentre il robot si sposta al centro dell'arena!)




*/


int oang, ang, range, dir;	/*variabili del cannone*/
int t; 				/*timer*/
int sc, sca, m;			/*variabili per il controllo dei nemici*/
int ver, hor;			/*variabili dell'angolo*/
int limite;				/*limite massimo dello scan nella fire()*/
int h;					/*altezza (centro) dello zig zag*/



main(){
	/*si muove nell'angolo e qua e là calcola alcuni parametri*/
	if(ver=(loc_y(limite=835)>500)) up(h=900);
	else dn(h=100);
	if(hor=(loc_x()>500)) while(loc_x()<900) fire(0);
	else while(loc_x()>100) fire(180);
	
	
	/*controlla se è un f2f*/
	/*b=ver*2+(ver!=hor);*//*grazie a puma.r per questa*/
	look(sc=90*(ver*2+(ver!=hor))); 	/*originariamente qui c'era un "-15". Non serve perchè*/
							/*esegue comuque lo stesso numero di cicli (spero)*/
							
	
	while((++t)<50) {/*ciclo del 4vs4*/
		if(hor) {
		zag(900);
		zig(920);
		}
		else {
		zig(100);
		zag(80);
		}
		look();
	}
	
	/*si sposta al centro dell'arena*/
	limite=2000;	
	dn(h=500);
	up(500);

	
	while(m=1) { /*attacco finale*/
		zig(900);
		zag(100);
	}
	
	
	
}




/*zig zag verso destra*/
zig(max) {
	while(loc_x(dir=0)<max) {
		while(loc_y()>h) fire(280);
		while(loc_y()<h) fire(80);
        }
}

/*zig zag verso sinistra*/
zag(min) {
	while(loc_x(dir=180)>min) {
		while(loc_y()>h) fire(260);
		while(loc_y()<h) fire(100);
	}
}

/*routine di fuoco*/
fire(d)
{
	drive(d,100);
	if ((range=scan(oang=ang,10))&&(range<limite)) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=2,2)) ; else ang+=4; return(cannon(ang+m*(ang-oang),2*scan(ang,10)-range)); }
	} 
	else if(range=scan(ang+=20,10)) cannon(ang,range);
	else if(range=scan(ang-=40,10)) cannon(ang,range);
	else if(scan(dir,10)) ang=dir;
	else ang+=80;
}


/*controlla i nemici*/
look() {
	drive(dir,m=2);	/*rallenta, altrimenti si schianta sui bordi dell'arena*/

	sca=sc+125;
	while(sca>sc&&m) m-=(scan(sca-=20,10)>0);

	t+=(2000*m);
}

/*movimento su-giu*/
up(limt) {while(loc_y()<limt) fire(90);}
dn(limt) {while(loc_y()>limt) fire(270);}