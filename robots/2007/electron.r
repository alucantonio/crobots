/*


E L E C T R O N 



Torneo di C Robots 2007
C Robots: electron.r
Categoria: Micro
VB: 499 (24%)

Autore: Pizzocaro Marco

Scheda tecnica:
electron.r e' derivato da neutron.r, ma preso violentemente a martellate
per farlo rientrare nelle 500 istruzioni. 

Prima di tutto e' presente una sola routine di fuoco, sviluppata a
partire da quelle dei fratelli maggiori neutron.r e proton.r (a loro volta 
derivate da !alien.r), con alcuni parametri che cambiano se si
tratta di un f2f o di un 4vs4. 

Nel 4vs4 oscilla solo orizzontalmete. Il calcolo della lunghezza di oscillazione
e' notevolemente semplificato rispetto a neutron.r. Il tentativo e' sempre
quello di accanirsi esclusivamente cotro il nemico sulla stessa orizzontale.

Il controllo del numero di nemici avviene su 180 gradi (abbondanti)
anziche' solo sul quadrante opportuno, per risparmiare codice. La
conseguente perdita di tempo e' leggermente compensata dal fatto
che, ad inizio incontro, electron.r inizia a controllare i nemici 
non appena raggiunge la parete nord (o sud) dell'arena e non quando
raggiunge l'angolo.

Il f2f non è molto diverso da quello di neutron.r, a parte ulteriori riduzioni
di codice, con un movimento del tipo di boom.r.

*/


int range, dir, oang, ang;  	/*variabili per il cannone*/
int b, posy, posx;	 		/*variabili dell'attacco finale*/
int aq;			 	/*variabile dell'oscillazione*/
int t; 				/*timer*/
int sca, n;	 			/*angolo del conteggio degli avversari*/
int sc; 				/*angolo della scansione*/
int ver, hor; 			/*variabili dell'angolo*/
int m, limite;			/*regolazione dello sparo*/

main()
	{
	/*si muove verticalmente verso la parete più vicina e inizializza alcune variabili*/
	if((loc_y(hor=(loc_x(limite=835)>500))>500))  while(loc_y(sc=180)<940)  fire(90);
	else while(loc_y()>60)  fire(270);
	
	
	/*controlla se e' un f2f*/
	look(dir=180*hor);
	
	
	while((++t)<160) {	/*oscilla nell'angolo durante il 4vs4*/
			
			if (hor){
				sx(925-(aq=range-800)*(aq>0));
				dx(925);
			}
			else {
				dx(75+(aq=range-800)*(aq>0));
				sx(75);
			}
			
			if(range>899) look(); /*prende tempo per contare i nemici*/
			
	}
	
	limite=2000;
	
	while(m=1) { 	/*attacco del f2f*/
		
                if ((posx=loc_x())>880) dir=180;
                else if (posx<120 ) dir=0;
                else if ((posy=loc_y())>880) dir=270;
                else if (posy<120) dir=90;                      
		else if (range>600) dir=ang+25;
		else if (range<150) dir=ang+195;
		else dir=ang+180*(b^=1);
				
		fire(dir);
		fire(dir+0); /*una (in)utile temporizzazione*/
		fire(dir);
		
		
		/*drive(dir,60);*/
                       
	}
	


}/*end of main*/




/*routine di fuoco*/
fire(d)
{
	drive(d,100);
	if ((range=scan(oang=ang,10))&&(range<limite)) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))   { if (scan(ang-=2,2)) ; else ang+=4; return(cannon(ang+m*(ang-oang),2*scan(ang,10)-range)); }
	} 
	else if(scan(ang+=20,10));
	else if(scan(ang-=40,10));
	else if(scan(dir,10)) ang=dir;
	else ang+=80;
}

/*movimento verso destra e sinistra*/
dx(limt) {while(loc_x()<limt) fire(0); drive(0,0);}
sx(limt) {while(loc_x()>limt) fire(180);drive(180,0);}



/*scansiona circa 180 per controllare il numero di nemici*/
look() {
	drive(dir,n=2);	

	sca=sc+210;
	while(sca>sc&&n) n-=(scan(sca-=20,10)>0);

	t+=(2000*n);

}

