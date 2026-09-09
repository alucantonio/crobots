/*

STATIC ver. 1.0 (C) Maurizio Camangi 1999-2000

Architettura: MicroRobot
Strategia   : Static non si chiama in questo modo perche' rimane immobile,
              pero' il codice non mi e' bastato per fargli cambiare angolo o
	      per farlo attaccare nel f2f. Static raggiunge l'angolo piu'
	      vicino e poi oscilla possibilmente in direzione di un nemico
	      nell'angolo opposto.

*/


int dx,dy,dir,p1,p2,deg,orng,rng,ext;

main() {
   degree(dx=20+960*(p1=(loc_x()>500)),dy=20+960*(p2=(loc_y()>500)));
   while (1) {
      while (shot(drive(dir,100))>9000) ;
      while (shot(drive(dir,50))>1500) ;
      if (ext=scan(dir=180*p1,10)) deg=dir;
      else {
	 dir=90+180*p2; ext=15000;
      }
      while(shot(drive(dir,100))<(15000+ext)) ;
      drive(dir+=180,0);
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

shot() {
   if (orng=scan(deg,10)) {

      if (!scan(deg+=5,5)) deg-=10;
      if (!scan(deg+=3,3)) deg-=6;
      if (!scan(deg+=2,1)) deg-=4;

      if (rng=scan(deg,10)) { cannon(deg,2*rng-orng); }
      if (orng>700) deg+=40;
   } else if (orng=scan(deg+=340,10)) cannon(deg,orng);
   else if (orng=scan(deg+=40,10)) cannon(deg,orng);
   else deg+=40;
   return(dist(dx,dy));
}
