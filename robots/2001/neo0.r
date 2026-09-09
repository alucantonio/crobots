/*

NEO0 ver.1.0 (C) Lorenzo Ancarani 2001

Architettura: Microrobot
Strategia   : il suddetto esemplare raggiunge l'angolo piu' vicino e poi oscilla
              lungo la bisettrice del quadrante, correggendo l'angolazione ad
              ogni inversione di marcia.
	      Se rimane un solo avversario attacca portandosi al centro del
	      campo di battaglia, ed oscilla in direzione del nemico.

Nome        : il nome deriva dal Lucifer.r di Maurizio:
                Neo perche' e' nuovo;
*/

int odeg,d,deg,deg2,enemy,dx,dy,dir,rng,t,clock,orng;

main() {
   clock=t=1;
   degree(dx=15+970*(loc_x()>500),dy=15+970*(loc_y()>500));
   while(1) {
      if ((((d=dist(dx,dy)) > 10000 && clock) + (d < (30000-(damage()*150)) && !clock))) {
	 drive(dir,100);
         tox();
      }
       else {
         drive(dir,deg2=enemy=0);
         if (clock^=1) degree(dx,dy); else degree(1000-dx,1000-dy);
         if (--t);else {
	    while((deg2+=20)<729) enemy+=(scan(deg2,10)>0);
	    if (enemy<3) {
               clock=1;
               degree(dx=500,dy=500);
            } else t=50;
	 }
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

restrict() {

  if(scan(deg-8,4)) deg-=8;
  if(scan(deg+8,4)) deg+=8;
  if(scan(deg-4,2)) deg-=4;
  if(scan(deg+4,2)) deg+=4;
  if(scan(deg-1,1)) deg-=1;
  if(scan(deg+1,1)) deg+=1;  
	    
}

int tox()
{
 if ((d>28000)||(!clock))
 if (orng=scan(deg,10)) {
    restrict();
    if (orng=scan(odeg=deg,10)) {
     restrict();
     if (rng=scan(deg,10)) {
             cannon((odeg+(deg-odeg)*3-(sin(deg-dir)/19500)),(rng*165/(165+orng-rng-(cos(deg-dir)/4167))));
     }
  }
  return deg+=40*(orng>900);
 }
         if ((rng=scan(deg,10))&&(rng<850)) {
	    if (scan(deg+353,4)) deg+=350;
	    else if (scan(deg,4)) ;
	    else if (scan(deg+7,4)) deg+=10;
	    cannon(deg,3*scan(deg,10)-2*rng);
	 } else if(rng=scan(deg+=340,10)) cannon(deg,rng);
	 else if(rng=scan(deg+=40,10)) cannon(deg,rng);
	 else deg+=40;
}

