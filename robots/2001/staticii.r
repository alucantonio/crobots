/*

STATICII ver. 1.01 (C) Lorenzo Ancarani 2001

Architettura: Microrobot (o forse no)
Nascita     : Qualche mese fa me ne stavo in tutt'altre faccende affaccendato
              quando mi arriva la chiamata del mio cugino preferito: me lo
              scrivi un crobot per il torneo di 2k1?
              E adesso che cavolo ci infilo li' dentro?
              L - quanto tempo ho?
              M - tutto quello che vuoi, le iscrizioni scadono la settimana
              prossima.
              Cosi' ho preso in mano la situazione:
              rispolverato Neo0.r (scritto per il IIø torneo microrobotico,
              mai giocato), Mflash2.r e' diventato il mio secondo microbo,
              mentre StaticII.r, altro microbo, Š stato promosso a Big,
              per la competizione principale.
              Di pi— non sono riuscito a fare.
Strategia   : il suddetto esemplare raggiunge l'angolo piu' vicino e poi oscilla
              in una delle due direzioni, preferibilmente in quella con il nemico
              assente, o piu' vicino.
              Non attacca mai.

Nome        : il nome deriva dallo Static.r di Maurizio.

*/


int clock,d,dx,dy,dir,p1,p2,deg,odeg,orng,rng,ext,str;

main() {
   degree(dx=20+960*(p1=(loc_x()>500)),dy=20+960*(p2=(loc_y()>500)));
   while (1) {                        
      clock=0;
      while (dist(dx,dy)>5000) shot();
      drive (dir+=180,0);
      if (scan(180*p1,10)<scan(dir=90+180*p2,10)) dir=180*p1;
      clock=1;
      ext=60000-(damage()*400);
      while(dist(dx,dy)<ext) shot();
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
        return (d=((x-=loc_x())*x+(y-=loc_y())*y));
}

restrict() {

  if(scan(deg-8,4)) deg-=8;
  if(scan(deg+8,4)) deg+=8;
  if(scan(deg-4,2)) deg-=4;
  if(scan(deg+4,2)) deg+=4;
  if(scan(deg-1,1)) deg-=1;
  if(scan(deg+1,1)) deg+=1;  
	    
}

int shot()
{
 drive(dir,100);
 if ((d>28000)||(clock))
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
