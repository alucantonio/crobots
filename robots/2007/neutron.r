/*


N E U T R O N


Torneo di C Robots 2007
C Robots: neutron.r
Categoria: Midi
VB: 982 (49%)

Autore: Pizzocaro Marco


Scheda tecnica:
neutron.r e' derivato dal mio cariddi.r. All'inizio della partita si reca 
nell'angolo piu' vicino (che strano!) e controlla il numero di avversari
per decidere cosa fare.

Nei f2f utilizza un molvimento di tipo boom (in particolare da confusion.r):
la novita' principale e' dovuta al movimento, che e' (in genere) radiale 
rispetto al nemico puntato, avanti o indetro rispetto alla direzione del 
nemico. La routine di fuoco usata è un innesto tra quella di cariddi e 
quella (non toxica) di !alien.r, con piccole modifiche.

Nei 4vs4 l'oscillazione e' solo orizzontale (come in cariddi.r). neutron.r si
accanisce soprattutto contro il robot presente sulla stessa orizzontale, la
cui distanza influenza la lunghezza dell'oscillazione. Complessivamente
l'oscillazione è abbastanza cauta e neutron.r non si allontana mai troppo 
dal suo angolo. 
La routine di sparo fire() deriva da quella del f2f, con alcuni accorgimenti,
e parzialmente da rudolf_9.r.

Il conteggio dei nemici non viene fatto ad ogni oscillazione, ma solo se il
nemico prescelto sulla stessa orizzontale e' abbastanza distante o non
presente.


Un ringraziamento a tutti gli autori dei numerosi crobot a cui, bene o male,
mi sono ispirato.
*/


int range, dir, oang, ang;  	/*variabili per il cannone*/
int b, posy, posx;	 		/*variabili dell'attacco finale*/
int xora, dist, aq, mod; 	/*variabili dell'oscillazione*/
int t; 				/*timer*/
int sca, nemici; 			/*variabili per il conteggio dei nemici*/
int sc; 				/*angolo della scansione*/
int ver, hor; 			/*variabili dell'angolo*/

main()
	{
	/*si muove nell'angolo più vicino*/
	if(ver=(loc_y()>500))  while(loc_y()<940)  fuoco(90); else while(loc_y()>60)  fuoco(270);
	if(hor=(loc_x()>500))  while(loc_x()<920)  fuoco(0); else while(loc_x()>80)  fuoco(dir=180);
	
	
	drive(dir,0);
	sc=90*(ver*2+(ver!=hor))-15;
	
	/*controlla il numero dei nemici ed eventualmente attacca*/
	look();
		
	while(1) {	/*ciclo principale del 4vs4*/
		
			if (loc_x(++t)>500){
				while(speed()>49);
				drive(dir=180,100);
				if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=loc_x()-aq;
				else xora=925;
				sx(xora);
				dx(925);
			}
			else {
				while(speed()>49);
				drive(dir=0,100);
				if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=aq+loc_x();
				else xora=75;
				dx(xora);
				sx(75);
			}
	
			if(dist>899) look(); /*prende tempo per contare i nemici*/
					
	}
	
	


}/*end of main*/






/*routine di fuoco del 4vs4*/
fire(d) {
	drive(d,100);
	if((range=scan(oang=ang,10))&&(range<835))
        {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=2,2)) ; else ang+=4; return(cannon(ang,3*scan(ang,10)-2*range)); } 
	}
	else if(range=scan(ang+=20,10)) veloce();
        else if(range=scan(ang-=40,10)) veloce();
	else if(scan(dir,10)) ang=dir;
	else return (ang+=80);
}


/*movimento*/

dx(limt) {while(loc_x()<limt) fire(0); drive(0,0);}
sx(limt) {while(loc_x()>limt) fire(180);drive(180,0);}



/*routine di fuoco del f2f*/
fuoco(d)
{
	drive(d,100);
	if ((range=scan(oang=ang,10))) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=3,3)) ; else ang+=6; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		
	} 
	else {
		if (range=scan(ang+=340,10)) return veloce();
		if (range=scan(ang+=40,10)) return veloce();
		if (range=scan(ang+=300,10)) return veloce();
		if (range=scan(ang+=80,10)) return veloce();
		if (range=scan(ang+=260,10)) return veloce();
		if (range=scan(ang+=120,10)) return veloce();
		ang+=80;
	}
}


veloce(){cannon(ang,2*scan(ang,10)-range);}


/*attacco da f2f*/
boom()
{

	int b=0;
		while(1) {
			
			if ((posx=loc_x())>880 ) dir=180;
			else if (posx<120 ) dir=0;
			else if ((posy=loc_y())>880 ) dir=270;
			else if (posy<120) dir=90;                        
			else if (range>600) dir=ang+25+(b^=1)*235;
			else if (range<150) dir=ang+170+(b^=1)*25;
			else dir=ang+180*(b^=1);
					
			
			fuoco(dir);
			fuoco(dir);
			fuoco(dir);
			
			drive(dir,60);
                       
                }
            
}





look() {
	/*conteggio dei nemici*/
	sca=sc+140;
	nemici=2;
	while(sca>sc&&nemici) nemici-=(scan(sca-=20,10)>0);


	if(nemici) boom();
	else if(t>260) { 
		if(damage()<70) boom();
		else t=mod=0;
		
        } else {
		++t;
		if(t>245) mod=80;
	}


}

