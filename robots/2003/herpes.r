/* *****************  HERPES ******************** 

Luca Stringher

Più o meno tutti i miei virus di quest'anno (2003) sono frutto più di un lavoro di psicologia che di tecnica, quindi non mi aspetto molto! Spero almeno che siano utili esperimenti per i futuri programmatori.
Herpes è il più piccolo dei miei virus, appena 444 istruzioni (neanche farlo apposta!).
Herpes va come tutti sull'angolo e gli si avvicina il più possibile.
Una volta stabilitosi incomincia ad andare molto veloce da destra a sinistra dell'arena restando molto vicino alla parete. Utilizza una routine di sparo derivante da quella di Arale (perchè non ho avuto tempo!!) che viene usata sempre!
credo che il robottino si a buono ma possa essere migliorato.
per ulteriori info guardate le note di lebbra suo fratello.
*/

int x,y,xi,yi,xf,yf,ang,ang1,i,d,dir,r,amax,amin;

main ()
{
settore();
trip(xi,yi);
while(1) {lila();}
}

settore()
{
if(loc_x()>500){xi=999;xf=870;}else{xi=0;xf=120;}
if(loc_y()>500){yi=999;yf=870;}else{yi=0;yf=120;}
}

angolo()
{
if(xi==999 && yi==999) amax=270;
if(xi==999 && yi==0) amax=180;
if(xi==0 && yi==999) amax=0;
if(xi==0 && yi==0) amax=90;
}

trip(x,y)
{
while(sqrt((loc_x()-x)*(loc_x()-x))>10)
        {
        drive((180*(999-x)/999),sqrt((loc_x()-x)*(loc_x()-x)));
        reazione();
        }
drive(0,0);
while(sqrt((loc_y()-y)*(loc_y()-y))>10)
        {
        drive((180*(999-y)/999)+90,sqrt((loc_y()-y)*(loc_y()-y)));
        reazione();
        }
drive(0,0);
}


reazione()
{
if ( (d=scan(ang,10)) && (d<850) ) 
  { 
   if (d=scan(ang+353,3)) cannon(ang+=353,d);
   else if (d=scan(ang,3)) cannon(ang,d);
   else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  }
 else
  {
   if ((d=scan(ang+21,10))&&(d<800)) {ang+=21;cannon(ang,d);}
   else if ((d=scan(ang+42,10))&&(d<800)) ang+=42;
        else ang+=63;
   }
}

lila()
{
xi+=999;if(xi>1500) {xi=0;xf=120;} else {xi=999;xf=870;}
while(sqrt((loc_x()-xi)*(loc_x()-xi))>20)
        {
        drive((180*(999-xi)/999),sqrt((loc_x()-xi)*(loc_x()-xi)));
        reazione();
        }
drive(0,0);
}
