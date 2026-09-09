/*




Torneo di C Robots 2010
C Robots: incolla.r
Categoria: Macro


Autore: Pizzocaro Marco


Scheda tecnica:
Praticamente si tratta del vecchio proton.r,
però oscilla nell'angolo in verticale anzichè in orizzontale.
Il 4vs4 è un poco semplificato (assomiglia di più a neutron.r).


Ovviamente nelle mie prove (meglio: nella mia prova) perde efficienza, ma pazienza.

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
	if(hor=(loc_x()>500))  dx2(920); else sx2(80);
	if(ver=(loc_y()>500))  {ang=dir=270; up(940);} else {ang=dir=90; dn(60);}
	
	
	b=ver*2+(ver!=hor);
	sc=90*b-15;
	
	/*controlla se è un f2f*/	
	look();	
		
	while(1) {		/*ciclo del 4vs4*/
		
			if (loc_y(++t)>500){
				while(speed()>49);
				drive(dir=270,100);
				
				if (!(dist=scan(260,10))) if (!(dist=scan(280,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=loc_y()-aq;
				else xora=925-mod;
				dn(xora);
				up(925);
			}
			else {
				while(speed()>49);
				drive(dir=90,100);
				
				if (!(dist=scan(80,10))) if (!(dist=scan(100,10))) dist=900+mod;
				if ((aq=dist-800+mod)>0) xora=aq+loc_y();
				else xora=75+mod;
				up(xora);
				dn(75);
			}
			
			
			
			if(dist>899) look();
		

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



