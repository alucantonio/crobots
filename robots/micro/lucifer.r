/*

LUCIFER ver.1.0 (C) Maurizio Camangi 1999-2000

Architettura: Microrobot
Strategia   : Lucifer raggiunge l'angolo piu' vicino e poi oscilla lungo la
              stessa direzione usata per raggiungerlo, avanti ed indietro.
	      (Per questo motivo raramente Lucifer si spiaccica simpaticamente
	      contro il muro vicino)
	      Se rimane un solo avversario attacca portandosi al centro del
	      campo di battaglia, ed oscilla in direzione del nemico.

*/

int d,deg,deg2,enemy,dx,dy,dir,rng,t,clock;

main() {
   clock=t=1;
   degree(dx=15+970*(loc_x()>500),dy=15+970*(loc_y()>500));
   while(1) {
      if ((((d=dist(dx,dy)) > 7500 && clock) + (d < 20000 && !clock))) {
	 drive(dir,100);
	 if (rng=scan(deg,10)) {
	    if (scan(deg+353,4)) deg+=350;
	    else if (scan(deg,4)) ;
	    else if (scan(deg+7,4)) deg+=10;
	    cannon(deg,3*scan(deg,10)-2*rng);
	    if (rng>770) deg+=40;
	 } else if(rng=scan(deg+=340,10)) cannon(deg,rng);
	 else if(rng=scan(deg+=40,10)) cannon(deg,rng);
	 else deg+=40;
      } else {
	 drive(dir+=180,deg2=enemy=0); clock^=1;
	 if (!--t) {
	    while((deg2+=20)<729) enemy+=(scan(deg2,10)>0);
	    if (enemy<3) {
	       clock=1;
	       degree(dx=dy=500,dy);
	    } else t=50;
	 } /*else while (speed() > 49) ;*/
      }
   }
}

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

dist(x,y) /* Distanza al quadrato (evita una sqrt())   */
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}
