/*

Torneo di C Robots 2012
C Robots: ryanair.r
Categoria: Micro
VB: 447 (22%)

Autore: Pizzocaro Marco

Scheda tecnica:
Ryanair è l'ennesima iterazione di electron.r (del 2007).
La routine di fuoco è stata ridotta in codice e contiene strane 
temporizzazioni. All'inizio pensavo di sfruttare lo spazio recuperato
per inserire qualche strategia da 3vs3 ma non ho trovato niente che
funzionasse. Invece ho velocizzato il conteggio dei nemici.

*/


int range, dir, oang, ang;  	/*variabili per il cannone*/
int b, posy, posx;	 	/*variabili dell'attacco finale*/
int aq;			 	/*variabile dell'oscillazione*/
int t; 				/*timer*/
int sca, n;	 		/*angolo del conteggio degli avversari*/
int sc; 			/*angolo della scansione*/
int ver, hor; 			/*variabili dell'angolo*/
int m, limite;			/*regolazione dello sparo*/

main()
	{
	/*si muove verticalmente verso la parete più vicina e inizializza alcune variabili*/
	if(ver=(loc_y(hor=(loc_x(limite=835)>500))>500))  while(loc_y()<940)  fire(90);
	else while(loc_y()>60)  fire(270);
	
	
	/*controlla se e' un f2f*/
/*	look(dir=180*hor);*/
	dir=180*hor;
	
	sc=90*(ver*2+(ver!=hor))+5;
	
	while((++t)<160) {	/*oscilla nell'angolo durante il 4vs4*/
			
			if (hor){
				sx(925-(aq=range-800)*(aq>0));
				dx(925);
			}
			else {
				dx(75+(aq=range-800)*(aq>0));
				sx(75);
			}
			
			if((t%12)==1) look();
			
	}
	
	limite=2000;
	
	while(m=1) { 	/*attacco del f2f*/
		

		
		if (((posx=loc_x())%880)<120) dir=180*(posx>500);
		else if (((posy=loc_y())%880)<120) dir=90+180*(posy>500);
		else if (range>600) dir=ang+25;
		else if (range<150) dir=ang+195;
		else dir=ang+180*(b^=1);
		
		fire(dir);
		fire(dir); 
		fire(dir);
		
		
                       
	}
	


}/*end of main*/




/*routine di fuoco*/
fire(d)
{
	drive(d,100);
	if ((range=scan(oang=ang,10))&&(range<limite)) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4;}
		else if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4;}
		else ;
		return(cannon(ang+1*(ang-oang),2*scan(ang,10)-range));
	} 
	else if(scan(ang+=20,10));
	else if(scan(ang-=40,10));
	else if(scan(dir,10)) ang=dir;
	else ang+=80;
}

/*movimento verso destra e sinistra*/
dx(limt) {while(loc_x()<limt) fire(0); drive(0,0);}
sx(limt) {while(loc_x()>limt) fire(180);drive(180,0);}



look() {
	/*conteggio dei nemici*/
	sca=sc+100;
	n=2;
	drive(dir,0);
	while(sca>sc&&n) n-=(scan(sca-=20,10)>0);

	t+=(2012*n);
}

