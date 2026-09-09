/*
 Pippo94b.r  (In caso di limitamento questo è il prescelto)

 Andrea Creola

 Tattica:
  All'inizio il robot sta fermo a sparare fino a quando il damage risulta
  minore del 5%.
  Dopo che qusta soglia è stata superata il robot si muove seguendo un
  percorso a forma di stella. A ogni angolo, si ferma e rimane in quel punto
  fino a quando il danneggiamento non si sia incrementato di tre unità.
  La funzione  di sparo:Questa funzione, controlla se trova un avversario
  nella direzione corrente, in caso positivo, controlla se è a una distanza
  accettabile, se la risposta è affermativa, esegue un controllo con un
  'range' di errore inferiore e se l'avversario non lo trova prova a
  cercarlo aggiungendo una deviazione all'angolo in base al presunto
  spostamento dell'avversario, l'istruzione di cannon viene effetuata
  se la distanza è inferiore a 700.


*/
int ang;          /* Angolo primario per lo sparo */
int range;        /* Forza con cui sparare */
int sfas;         /* Sfasamento dell'angolo */
int rangepr;      /* Forza calcolata precedentemente  */
int app;          /* Serve per fare molte cose  */
int old_dam;      /* serve per ricordare il damage a ogni 'fermata' */
int ang2;         /* angolo secondario */
int range2;       /* range secondario */
int dis;          /* distanza corrente dalla destinazione */
int dir;          /* direzione da seguire  */

/********** MAIN **********/
 main()
 {
  while(damage()<5) spara();
  while(1)
   {
    go(500,900,900,100);
    go(900,100,100,500);
    go(100,500,900,500);
    go(900,500,100,100);
    go(100,100,500,900);
   }
 }
/********** GO **********/
 go (x1,y1,x2,y2)        /* x1,y1 cordinate dell destinazione */
 int x1,y1,x2,y2;        /* x2,y2 cordinate dell destinazione succesiva */
 {
  dir = direzione(x1,y1);
  drive(dir,100);
  while(dist(x1,y1)>80) spara();
  dir = direzione(x2,y2);
  old_dam=damage();
  drive(dir,0);
  while(speed()>50) spara();
  while(damage()<old_dam+3) spara();
 }
/********** DIREZIONE **********/
/* Š la funzione 'plot_course(x,y)' del manuale */
direzione (dest_x,dest_y)
int dest_x,dest_y;
{
 int dir,locx,locy;
 locx = loc_x();
 locy = loc_y();
 if (locx == dest_x )
    {
     if (dest_y > locy)
        dir = 90;
     else
        dir = 270;
    }
 else
    {
     if (dest_y < locy)
        {
         if (dest_x > locx)
            dir = 360 + atan ((100000 * (locy-dest_y)) / (locx - dest_x) );
         else
            dir = 180 + atan ((100000 * (locy-dest_y)) / (locx - dest_x) );
        }
     else if (dest_x > locx)
             dir = atan (100000 * (locy-dest_y) / (locx-dest_x));
          else
             dir = 180 + atan(100000 * (locy-dest_y) / (locx-dest_x));
    };
 return (dir);
}
/********** DIST **********/
dist (x,y)
int x,y;
{
 int x1,y1,dis;
 x1 = loc_x() - x;
 y1 = loc_y() - y;
 dis = sqrt((x1 * x1)+(y1 * y1));
 return (dis);
}
/********** SPARA **********/
spara()
{
 if (!(range = scan (ang, 4)))
  {
   if (!range=scan (ang, 5))
   if (range = scan(ang -= 10, 5))sfas = -6;
   else if (range = scan(ang -= 15, 10)) sfas = -10;
   else if (range = scan(ang += 35, 5)) sfas = 6;
   else if (range = scan(ang += 15, 10)) sfas = 10;

   if((!range)||(range>700))
     {
      app = 10;
      while (!(range = scan(ang += 25, 7)) && (--app));
      sfas = 0;
      rangepr = range;
      return;
     }
  }
 if (range<700)
  {
   cannon(ang+sfas,range*(233+range-rangepr)/228);
  }
 range2 = scan (ang2 -= 20, 10);
 if ((range2 > 0) && (range2 < (range - 50)))
   {
    ang = ang2;
    rangepr = range2;
   }
 else rangepr=range;

}

