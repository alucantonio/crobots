/*   b115e2.r scritto da Marco Giunti

Il Crobot cerca il nemico con approssimazione dello scan massima,se lo 
trova riduce gradatamente l'approssimazione; quando perde il bersaglio 
l'approssimazione cresce,ma con coefficiente inferiore a quello di ridu-
zione dell'angolo.
Se il nemico Š troppo lontano,lo insegue.
Se Š bersaglio del fuoco nemico, scappa.
Il crobot Š in grado di comprendere il verso di spostamento del nemico ed
orienta il verso dello scan di conseguenza.

*/

scappa(angolo)    /* fugge verso il lato piu lontano */
{       
int x,y;
   x=loc_x();
   y=loc_y();
   drive (angolo+180,100);
if (y>500 && x>500)   
   {drive(225,100);return;}
if (y<500 && x<500)   
   {drive(45,100);return;}
if (y>500 && x<500)   
   {drive(315,100);return;}
if (y<500 && x>500)   
   drive(125,100);
}






main ()
{
int angolo,
    distanza,
    odistanza,
    verso,
    approssimazione,
    continuo,
    dan;
scappa(angolo);
verso=-1;
angolo=100;
continuo=1;
approssimazione=5;
while (1)
   {
   if (damage()>dan) scappa(angolo);  /* se il robot ha subito danni scappa */
   dan=damage();/* aggiorna il danneggiamento */
   angolo=angolo-approssimazione*verso;if (angolo<0) angolo+=365;/*orienta la ricerca nel verso e con l'approssimazione data */
   if (distanza=scan(angolo,approssimazione))/* Se individua il bersaglio....*/ 
     {     
     while(cannon (angolo,2*scan(angolo,approssimazione)-distanza)==0);/*Spara */
     if (continuo==0)/* Se il bersaglio Š individuato per la prima volta, inverte il verso*/ 
       { 
       verso=-1*verso;
       continuo=1;
       }
     else/* migliora l'approssimazione di scan*/
       {
       if (approssimazione-= 2 < 5) approssimazione =5;
       dan+=2;
       }
     if (distanza > 300) drive (angolo,100);/*Se il bersaglio Š pi— lontano di 300 lo insegue*/
     }
   else   
     { 
     if (++approssimazione > 20) approssimazione=20; /*se il bersaglio non e' stato individuato*/
        if (continuo==1)   
           {
           verso = -1*verso;
           continuo=0;
           }
      }
   }                                                  /*peggiora l'approssimazione*/
}                                                     /*ma fino al limite ed inverte il verso se Š la prima volta che non trova il bersaglio*/
