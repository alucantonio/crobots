/*
 Nome C-Robot : Mancino.r
 
 Autore : Lamberto Leoncavallo
 
Questo robot era stato scritto per la competizione del 1999 e lo avrei voluto modificare per il 2000, ma la concomitanza con
la presentazione della mia tesi in Ingegneria Elettronica del 27 Ottobre mi ha impedito qualsiasi tipo di intervento. Desiderando
confrontarmi con i migliori C-Robots disponibili in circolazione con limiti portati a 2000 istruzioni e con le novità di punteggio
iscrivo il mio vecchio robot. Buona fortuna vecchio Mancino!!!
 
 
COMPORTAMENTO DEL ROBOT :

Questo, essendo il mio primo robot è molto semplice.
Ad inizio match conoscendo la pericolosità del centro arena
Mancino cerca riparo vicino alle pareti dell'arena e quindi
individua la parete più prossima e vi si dirige alla massima
velocità. Ivi giunto in pratica inizia quella che sarà la sua
routine per tutto il match e cioè percorre tutto il perimetro
dell'arena in modo ripetitivo alla massima velocità. Particolarità
rilevanti a mio avviso di questa corsa sono :

1) Senso di rotazione. Ho notato che contro molti avversari la
rotazione oraria porta ad una maggiore efficienza rispetto a quella
antioraria, probabilmente a causa degli algoritmi di scanning usati
dalla maggior parte dei Robots. Quindi Mancino ruota in senso orario.

2) La distanza dal muro che è superiore ai 100 "metri". Questo permette 
al mio robot di percorrere traiettorie sfalsate rispetto ad altri robot
che preferiscono una maggior vicinanza alle pareti e quindi penso che lo renda più "sfuggente". (E' una mia teoria priva di ogni fondamento dimostrabile...)

3) La rotazione continua permette al mio robot di raggiungere senza problemi con il suo sparo qualsiasi punto dell'arena e quindi impedisce qualsiasi rischio di patta. Questo mi pare un fattore positivo visto che una eventuale vittoria viene pagata 3 volte più della patta. Un pò come nel calcio una patta è una mezza sconfitta. (Lo stesso fattore è molto negativo nella fase iniziale, ma questo giocatore è volutamente rozzo)

Infine ovviamente Mancino non dimentica di sparare senza pietà a qualsiasi oggetto rientri nel suo range di sparo.

Questo è tutto. 

Bye
 
*/

int dist, /* Imposta la distanza alla quale iniziare a frenare per impostare la curva in prossimità dei muri */
    direzione, /* Indica la direzione nella quale si muove il Robot */
    /* Usate nella routine di sparo */
    mira,
    miraPrec,
    range,
    rangePrec;

/*
Semplice funzione aritmetica che implementa il calcolo 
del valore assoluto dell'argomento "a" passatele restituendo
il risultato come valore di ritorno.
*/
int abs(a)
int a;
{
 if (a<0) return(a*(-1));
 return a;
}

/*
Questa funzione viene chiamata per impostare la direzione nella quale il robot
si deve muovere allo start. In particolare il robot sceglie di andare verso il
muro più vicino scegliendo la traiettoria più breve e quindi quella perpendicolare
al muro. In pratica questa funzione imposta la variabile "direzione" con la
direzione desiderata
*/
sceltadir()
{
 if (abs(500-loc_x())>abs(500-loc_y()))
  if (loc_x()<500) direzione = 180;
  else direzione = 0;
 else if (loc_y()<500) direzione = 270;
      else direzione = 90;
}

/*
Di questa routine non posso andare fiero personalmente, in quanto è un adattamento
della routine di sparo utilizzata da Goblin nell'ultima edizione con qualche piccolo
correttivo.
*/
spara()
{
    if (rangePrec=scan(mira,10))
    {
        if (!scan(mira-=5,5)) mira+=10;
        if (rangePrec>700)
        {
		 mira+=40;
		 return;
        }

        if(scan(mira-5,1)) mira-=5;
        if(scan(mira+5,1)) mira+=5;
        if(scan(mira-3,1)) mira-=3;
        if(scan(mira+3,1)) mira+=3;
        if(scan(mira-1,1)) mira-=1;
        if(scan(mira+1,1)) mira+=1;

        if (rangePrec=scan(miraPrec=mira,5))
        {
            if(scan(mira-5,1)) mira-=5;
            if(scan(mira+5,1)) mira+=5;
            if(scan(mira-3,1)) mira-=3;
            if(scan(mira+3,1)) mira+=3;
            if(scan(mira-1,1)) mira-=1;
            if(scan(mira+1,1)) mira+=1;

            if (range=scan(mira,10))
            { cannon(mira+(mira-miraPrec)*((1200+range)>>9)-(sin(mira-direzione)>>14),
                       range*160/(160+rangePrec-range-(cos(mira-direzione)>>12)));
            }
        }
     }
     else
     {
        if (scan(mira-=20,10)) return;
        if (scan(mira+=40,10)) return;
        mira+=40; return;
     }
}

main ()
 {
   dist = 150 ; /*Distanza di staccata */
   vaila () ;
   while (1) corri() ;
 }

/*
Questa routine gestisce il transitorio iniziale e cioè la fase precedente al ciclo infinito che seguirà.
L'obiettivo di questa routine è portare il robot nell'angolo in alto a sinistra. Per fare questo il
robot prima viene diretto verso il muro più vicino e poi inizia il movimento che lo caratterizzerà
durante tutto il torneo, cioè inizia a percorrere tutto il perimetro dell'arena in senso orario fino
ad arrivare nell'angolo in alto a sinistra. Durante la sua folle corsa ai "100 all'ora" il robot è alla
continua ricerca di avversari a portata di sparo (<700) da potere colpire e possibilmente distruggere.
*/ 
 vaila ()
 {
  sceltadir();
   if (direzione==0)
  {
   while (loc_x() < (999-dist)) {drive (0,100); spara();}
   drive (270,0) ;
   while (speed()>49) ;
   direzione = 270;
  }
  if (direzione==270)
  {
   while (loc_y() > dist) {drive (270,100); spara();}   
   drive (180,0) ;
   while (speed()>49) ;
   direzione = 180;
  }
  if (direzione==180)
  {
   while (loc_x() > dist) {drive (180,100);  spara();}   
   drive (90,0) ;
   while (speed()>49) ;
   direzione = 90;
  } 
  if (direzione==90)
  {
   while (loc_y() < (999-dist)) {drive (90,100);  spara();}   
   drive (0,0) ;
   while (speed()>49) ;
  }
 }


/*
L'esecuzione di questa routine comporta l'esecuzione di un giro completo di campo in senso orario
a partire dall'angolo in alto a sinistra per arrivare all'angolo in alto a sinistra. Anche qui 
durante la corsa il robot è alla continua ricerca di bersagli.
*/ 
 corri ()
{
  while (loc_x() < (999-dist)) {drive (direzione=0,100); spara();}
  drive (270,0) ;
  while (speed()>49) ;
  while (loc_y() > dist) {drive (direzione=270,100); spara();}   
  drive (180,0) ;
  while (speed()>49) ;
  while (loc_x() > dist) {drive (direzione=180,100);  spara();}   
  drive (90,0) ;
  while (speed()>49) ;
  while (loc_y() < (999-dist)) {drive (direzione=90,100);  spara();}   
  drive (0,0) ;
  while (speed()>49) ;
 }

