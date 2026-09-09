/*

Torneo di C Robots 2012
C Robots: easyjet.r
Categoria: Micro
VB: 498 (24%)

Autore: Pizzocaro Marco

Scheda tecnica:
Easyjet è l'ennesima iterazione di electron.r (del 2007).
La routine di fuoco è stata ridotta in codice e contiene strane 
temporizzazioni. Contiene un algoritmo che gli fa cambiare angolo:
aiuterà nel 3vs3 (che non ho mai testato)?

*/


int range, dir, vdir, oang, ang;  	/*variabili per il cannone*/
int b, posy, posx;	 	/*variabili dell'attacco finale*/
int aq, mod;			 	/*variabile dell'oscillazione*/
int t; 				/*timer*/
int sca, n;	 		/*angolo del conteggio degli avversari*/
int sc; 			/*angolo della scansione*/
int ver, hor; 			/*variabili dell'angolo*/
int m, limite;			/*regolazione dello sparo*/

main()
	{
	/*si muove verticalmente verso la parete più vicina e inizializza alcune variabili*/
	if((loc_y(hor=(loc_x(limite=835)>500))>500))  {up(940); sc=180;}
	else dn(60);
	
	
	
	dir=180*hor;
	
		
	while((++t)<160) {	/*oscilla nell'angolo durante il 4vs4*/
			mod = (aq=range-800)*(aq>0);
			if (hor){
				sx(925-mod);
				dx(925);
			}
			else {
				dx(75+mod);
				sx(75);
			}
			
			if((t%12)==1) {
			if(!look()) {
				if(!scan(sc+90,10)) {
				if(loc_y(t+=2)>500){dn(940);} else {up(60);}
				sc+=180;
				}
			};
			}
	}
	
	limite=2012;
	
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
/*		else  {  return(cannon(ang+m*(ang-oang),2*scan(ang,10)-range));}*/
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
up(limt) {while(loc_y()<limt) fire(90); drive(90,0);}
dn(limt) {while(loc_y()>limt) fire(270);drive(270,0);}



look() {
	/*conteggio dei nemici*/
	sca=sc+200;
	n=2;
	drive(dir,0);
	while(sca>sc&&n) n-=(scan(sca-=20,10)>0);

	return t+=(2012*n);
}

