/*




Torneo di C Robots 2010
C Robots: copia.r
Categoria: Micro


Autore: Pizzocaro Marco

Scheda tecnica:
Praticamente identico ad electron.r.
Durante il 4vs4 oscilla nell'angolo lungo la verticale anzichè in orizzontale.
Il cambiamento ha necessitato qualche riduzione di codice per rimanere nelle 500 istruzioni.

Ovviamente nelle mie prove (meglio: nella mia prova) perde efficienza rispetto ad electron.r,
ma pazienza.

*/


int range, dir, oang, ang;  	/*variabili per il cannone*/
int b, posy, posx;	 		/*variabili dell'attacco finale*/
int aq;			 	/*variabile dell'oscillazione*/
int t; 				/*timer*/
int sca, n;	 			/*angolo del conteggio degli avversari*/
int sc; 				/*angolo della scansione*/
int m, limite;			/*regolazione dello sparo*/
int ver;

main()
	{
	/*si muove verticalmente verso la parete più vicina e inizializza alcune variabili*/
	if((loc_x(ver=(loc_y(limite=850)>500))>500))  while(loc_x(sc=90)<940)  fire(0);
	else while(loc_x(sc=270)>60)  fire(180);
	
	
	/*controlla se e' un f2f*/
	look(dir=90+180*ver);
	
	
	while((++t)<160) {	/*oscilla nell'angolo durante il 4vs4*/
			
			if (ver){
				dn(925-(aq=range-800)*(aq>0));
				up(925);
			}
			else {
				up(75+(aq=range-800)*(aq>0));
				dn(75);
			}
			
			if(range>899) look(); /*prende tempo per contare i nemici*/
			
	}
	
	/*limite=2000;*/
	
	while(m=1) { 	/*attacco del f2f*/
		
                if ((posx=loc_x())>880) dir=180;
                else if (posx<120 ) dir=0;
                else if ((posy=loc_y())>880) dir=270;
                else if (posy<120) dir=90;                      
		else if (range>600) dir=ang+25;
		else if (range<150) dir=ang+195;
		else dir=ang+180*(b^=1);
				
		fire(dir);
		fire(dir);
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
up(limt) {while(loc_y()<limt) fire(90); drive(90,0);}
dn(limt) {while(loc_y()>limt) fire(270);drive(270,0);}



/*scansiona circa 180 per controllare il numero di nemici*/
look() {
	drive(dir,n=2);	

	sca=sc+210;
	while(sca>sc&&n) n-=(scan(sca-=20,10)>0);

	t+=(2000*n);

}

