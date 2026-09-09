/*

Neo_Sel ver. 0.9 (C) Lorenzo Ancarani 2003

Architettura: ClassicBot
Nascita     : Il cuginastro quest'anno è stato più benevolo. Mi ha ricordato del torneo ben 2 mesi prima.
              Nonostante ciò, questo e' tutto quello che sono riuscito a fare.
Strategia   : il suddetto esemplare raggiunge l'angolo piu' vicino e poi oscilla
              in direzione dell'angolo opposto, calcolando la correzione sull'angolo di rientro ad 
              ogni oscillazione.
              Ogni certo numero di cicli calcola il numero di avversari, e se ne trova uno sol
              lo attacca con un movimento finale che ho gia' visto da qualche parte, anche se non ricordo dove.
              Neo_Sifr non usa le toxiche, e per questo rende abbastanza in t2k2.

*/

int odeg,d,deg,deg2,enemy,dx,dy,dir,rng,t,clock,orng;
int uno,due,att;
main() {
   dx=15+970*(uno=(loc_x(dy=15+970*(due=(loc_y(t=1)>500)))>500));
   att=850;
   while(degree(dx,dy)) {

      while ((dist(dx,dy)) > 7000)
      {  
         NoTox(drive(dir,100));
      }
      dir=(due)*180+(uno!=due)*90+45;

      NoTox(drive(dir,deg2=enemy=0));
      while(speed()>0);

         if (--t);
         else {
	    while((deg2+=20)<380) enemy+=(scan(deg2,10)>0);
	    while (enemy<2) {att=12000;
	      while (loc_x() > 490)NoTox(drive(180,100));
	      while (loc_y() > 490)NoTox(drive(270,100));
	      while (loc_x() < 510)NoTox(drive(0,100));
	      while (loc_y() < 510)NoTox(drive(90,100));
	      while (loc_x() > 490)NoTox(drive(225,100));
	      while (loc_y() < 510)NoTox(drive(90,100));
	      while (loc_x() < 510)NoTox(drive(315,100));
	      while (loc_y() > 490)NoTox(drive(270,100));
            }
	    t=4;
	 }

      while (dist(dx,dy) <25000) 
      {  
         NoTox(drive(dir,100));
      }

      NoTox(drive(dir+=180,0));
      }
}

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/(x+(x==loc_x())))));
}

dist(x,y) /* Distanza al quadrato (evita una sqrt())   */
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}


int NoTox()
{
         if ((rng=scan(deg,10))&&(rng<att)) {
	    if (scan(deg+353,4)) deg+=350;
	    else if (scan(deg,4)) ;
	    else if (scan(deg+7,4)) deg+=10;
	    cannon(deg,2*scan(deg,10)-rng);
	 } else if(rng=scan(deg+=340,10)) cannon(deg,rng);
	 else if(rng=scan(deg+=40,10)) cannon(deg,rng);
	 else if(rng=scan(deg-=60,10)) cannon(deg,rng);
	 else if(rng=scan(deg+=80,10)) cannon(deg,rng);
	 else deg+=40;
}

