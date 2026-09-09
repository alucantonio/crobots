/*


P R O T O N


Torneo di C Robots 2007
C Robots: proton.r
Categoria: Macro
VB:  1292 (64%)

Autore: Pizzocaro Marco


Scheda tecnica:
Si tratta praticamente di neutron.r, ma senza tutti quei trucchi per
ridurre lo spazio occupato dal codice. L'idea originaria era 
quella di introdurre istruzioni per il cambio dell'angolo, ma l'implementazione
e i risultati lasciavano a desiderare. Ho introdotto un oscillazione
corta nel caso venga danneggiato, ma la cosa non è fondamentale.
Quindi come macro è abbastanza scadente e piccolo (circa 1300
VB) ma ho assemblato tutti 4 i robot in meno di due settimane,
e ormai tempo e idee scarseggiano.

Nei f2f utilizza un molvimento di tipo boom (in particolare da confusion.r):
la novita' principale e' dovuta al movimento, che e' (in genere) radiale
rispetto al nemico puntato, avanti o indetro rispetto alla direzione del 
nemico. La routine di fuoco usata è un innesto tra quella di cariddi e 
quella (non toxica) di !alien.r, con piccole modifiche.

Nei 4vs4 l'oscillazione e' solo orizzontale (come in cariddi.r). proton.r si
accanisce soprattutto contro il robot presente sulla stessa orizzontale, la
cui distanza influenza la lunghezza dell'oscillazione. Complessivamente
l'oscillazione è abbastanza cauta e proton.r non si allontana mai troppo dal
suo angolo.
La routine di sparo fire() deriva da quella del f2f, con alcuni accorgimenti,
e parzialmente da rudolf_9.r.

Il conteggio dei nemici non viene fatto ad ogni oscillazione, ma solo se il
nemico prescelto sulla stessa orizzontale e' abbastanza distante o non
presente.


Un ringraziamento a tutti gli autori dei numerosi crobot a cui, bene o male,
mi sono ispirato.

*/


int range, dir, oang, ang;
int t;
int xora, dist, aq, mod;
int dam;
int sc;
int sca, nemici;
int i;
int b, ver, hor;
int posy, posx;

main()
	{
	/*si muove nell'angolo più vicino*/
	if(hor=(loc_x()>500))  {ang=dir=180; dx2(920);} else {ang=0; sx2(80);}
	if(ver=(loc_y()>500))  {up(940);} else {dn(60);}
	
	
	b=ver*2+(ver!=hor);
	sc=90*b-15;
	
	/*controlla se è un f2f*/	
	look();	
		
	while(dam=damage()+6) {		/*ciclo del 4vs4*/
		while(damage()<dam){
			if (loc_x(++t)>500){
				while(speed()>49);
				drive(dir=180,100);
				
				if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=loc_x()-aq;
				else xora=925-mod;
				sx(xora);
				dx(925);
			}
			else {
				while(speed()>49);
				drive(dir=0,100);
				
				if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=aq+loc_x();
				else xora=75+mod;
				dx(xora);
				sx(75);
			}
			
			
			
			if(dist>899) look();
		}
		
		/*oscillazione corta*/	
		if(loc_x(++t)>500) {
			i=3; while(--i) {sx(925-mod);dx(925);}
		} else {
			i=3; while(--i) {dx(75+mod);sx(75);}
		}
		if(range>899) look();

	}
	
	


}/*end of main*/







/*routine di fuoco del 4vs4*/
fire() {
 if((range=scan(oang=ang,10))&&(range<835))
        {
       	if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
	if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
        if (scan(ang,10))     { if (scan(ang-=2,2)) ; else ang+=4; return(cannon(ang,3*scan(ang,10)-2*range)); } 
	}
	else if(range=scan(ang+=20,10)) cannon(ang,2*scan(ang,10)-range);
        else if(range=scan(ang-=40,10)) cannon(ang,2*scan(ang,10)-range);
	else if(scan(dir,10)) ang=dir;
	else return (ang+=80);
}




/*routine di fuoco del f2f*/
fuoco()
{
	
	if ((range=scan(oang=ang,10))) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=3,2)) ; else ang+=6; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
	} 
	else {
		if (range=scan(ang+=340,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=40,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=300,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=80,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=260,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=120,10)) return cannon(ang,3*scan(ang,10)-2*range);
		ang+=80;
	}
}





/*movimento*/

up(limt) {while(loc_y()<limt) {drive(90,100);fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(0,100);fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);fire();}drive(180,0);}


up2(limt) {while(loc_y()<limt) {fuoco(drive(90,100));}drive(90,0);}
dn2(limt) {while(loc_y()>limt) {fuoco(drive(270,100));}drive(270,0);}
dx2(limt) {while(loc_x()<limt) {fuoco(drive(0,100));}drive(0,0);}
sx2(limt) {while(loc_x()>limt) {fuoco(drive(180,100));}drive(180,0);}




boom()	/*attacco del f2f*/
{

	int b=0;
		while(1) {
			
                        if ((posx=loc_x(posy=loc_y()))>880 ) dir=160+40*(posy>500);
                        else if (posx<120 ) dir=340+40*(posy<500);
                        else if ((posy)>880 ) dir=250+40*(posx<500);
                        else if (posy<120) dir=70+40*(posx>500);                        
			else if (range>600) dir=ang+25+(b^=1)*235;
			else if (range<150) dir=ang+170+(b^=1)*25;
			else dir=ang+180*(b^=1);
					
			
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			
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



