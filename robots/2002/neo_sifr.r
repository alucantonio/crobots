/*


Neo_Sifr ver. 1.5 (C) Lorenzo Ancarani 2002


Architettura: Microrobot


Strategia   : il suddetto esemplare raggiunge l'angolo piu' vicino e poi oscilla
              in direzione dell'angolo opposto, calcolando la correzione sull'angolo di rientro ad 
              ogni oscillazione.
              Ogni certo numero di cicli calcola il numero di avversari, e se ne trova uno sol
              lo attacca, con la solita routine.
              Neo_Sifr non usa le toxiche, e per questo rende abbastanza in t2k1, anche se non
              fa sfracelli.
              In micro2001 rende meno di StaticXP!


*/


int odeg,d,deg,deg2,enemy,dx,dy,dir,rng,t,clock,orng;
int uno,due;


main() {
   dx=15+970*(uno=(loc_x(dy=15+970*(due=(loc_y(t=1)>500)))>500));
   while(degree(dx,dy)) {


      while ((dist(dx,dy)) > 10000)
      {  
         spara(drive(dir,100));
      }
      dir=(due)*180+(uno!=due)*90+45;


      spara(drive(dir,deg2=enemy=0));


         if (--t);
         else {
            while((deg2+=20)<380) enemy+=(scan(deg2,10)>0);
            if (enemy<2) {
                dx=dy=500;
            } else t=10;
         }


      while (dist(dx,dy) < (25000-(enemy<2)*14000)) 
      {  
         spara(drive(dir,100));
      }


      spara(drive(dir,0));
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



int spara()
{
         if ((rng=scan(deg,10))&&(rng<850)) {
            if (scan(deg+353,4)) deg+=350;
            else if (scan(deg,4)) ;
            else if (scan(deg+7,4)) deg+=10;
            cannon(deg,2*scan(deg,10)-rng);
         } else if(rng=scan(deg+=340,10)) cannon(deg,rng);
         else if(rng=scan(deg+=40,10)) cannon(deg,rng);
         else deg+=40;
}
