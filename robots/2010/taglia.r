/*





Torneo di C Robots 2010
C Robots: taglia.r
Categoria: Micro


Autore: Pizzocaro Marco


Scheda tecnica:
Robot rompiscatole.
Si tratta della sola routine da f2f del vecchio proton.r, ridotto così a meno di 500 istruzioni.
Niente 4vs4 di sorta.


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
            
	


}/*end of main*/










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








