/* Biro v3.4 30/09/1993 opera di Maurilio Longo (codice) & Teresa Cardellino  */
/*                      (supporto tecnico e morale)                           */
/*                                                                            */
/*                      Teresa Cardellino                                     */
/*                      Maurilio Longo                                        */
/*                                                                            */
/* Questo robot si muove in diagonale nell'angolo in alto a sinistra cercando */
/* di correggere oltre alla gittata anche l'angolo di tiro.                   */
/* Tuttavia, a causa della lentezza della cpu simulata rispetto ai robot,     */
/* non e' possibile fare calcoli troppo precisi (infatti finora hanno vinto   */
/* quei Crobot che sparavano molto anche se con scarsa precisione).           */
/* Non solo, ma abbiamo notato che il tempo perso a fare calcoli piu' precisi */
/* e' sufficiente a permettere al "nemico" movimenti tali da non poter piu'   */
/* essere calcolati ;-).                                                      */
/* Il movimento e' stato scelto nella speranza di porlo, quanto piu'          */
/* possibile, fuori dalla mischia (pur senza renderlo troppo "codardo").      */
/* Il robot, anche a causa del poco tempo dedicatogli, non e' particolarmente */
/* agguerrito, ma l'importante e' partecipare !!                              */


main()
{
   int angolo, distanza;

   angolo = 90;

   while (1) {

      /* da 180 a 90 */
      point_to(400, 900);
      while ((loc_y() < 900) && speed())
         if (!(distanza = scan(angolo, 10)))
            angolo -= 20;
         else
            angolo = fuoco(angolo, distanza);


      /* da 90 a 180 */
      point_to(100, 600);
      while ((loc_x() > 100) && speed())
         if (!(distanza = scan(angolo, 10)))
            angolo -= 20;
         else
            angolo = fuoco(angolo, distanza);
   }
}


/* si occupa di sparare e di calcolare le correzioni di tiro necessarie */
int fuoco(angolo, distanza)
int angolo, distanza;
{
   int n_distanza;   /* seconda scan per valutare comportamento avversario */

   angolo += delta(angolo);   /* cerca dov'e' andato */
   if ((n_distanza = scan(angolo, 10)) < distanza)
      if (n_distanza > 50) {
         /* il difficile sta nel calcolare se sono io a muovermi, l'avversario o entrambi.
            Purtroppo pare che sia assai pi— conveniente sparare piuttosto che
            cercare di rispondere alla precedente domanda. :)
         */
         cannon(angolo, ((70 * n_distanza / 79) + (n_distanza - (70 * distanza / 79))));
         angolo += delta(angolo);   /* cerca di seguirlo nel movimento */
         }
      else
         ;
   else
      if (n_distanza > 50) {
         /* la "* 79 / 70" e' la solita formula, alla quale pero' sommo la
            differenza fra la posizione attuale e quella alla quale il nemico
            "avrebbe dovuto trovarsi". Alle medie distanze il tutto funziona
            abbastanza bene.
         */
         cannon(angolo, ((79 * n_distanza / 70) + (n_distanza - (79 * distanza / 70))));
         angolo += delta(angolo);            
         }
   return(angolo);
}


/* cerca di prevedere di quanto l'obiettivo si sposta rispetto all'angolo
   sotto il quale e' stato visto la prima volta mediante una serie di scan
   successive "ai lati" di quella iniziale.
*/
int delta(angolo)
int angolo;
{
   if (scan(angolo + 5, 5))
      return(10);
   else
      if (scan(angolo - 5, 5))
         return(-10);
      else
         if (scan(angolo + 10, 5))
            return(15);
         else
            if (scan(angolo - 10, 5))
               return(-15);
            else
               if (scan(angolo + 15, 5))
                  return(20);
               else
                  return(-20);   /* non avendolo ancora trovato posso solo
                                    sperare che sia li.
                                 */
}


/* effettua la conversione di rotta */
point_to(x, y)
int x, y;
{
   int heading;   /* direzione da prendere */

   heading = direzione(x, y);
   while (speed() > 50)       /* mi raccomando!, curva bene.... */
      drive(heading, 50);
   drive(heading, 100);
   return;
}


/* ritorna la direzione per un punto, come da manuale */
int direzione(xx, yy)
int xx, yy;
{
  int d;
  int x, y;
  int scale;
  int curx, cury;

  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {
    if (yy > cury)
      d = 90;
    else
      d = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + atan((100000 * y) / x);  /* south-east, quadrant 4 */
      else
        d = 180 + atan((100000 * y) / x);  /* south-west, quadrant 3 */
    } else {
      if (xx > curx)
        d = atan((100000 * y) / x);        /* north-east, quadrant 1 */
      else
        d = 180 + atan((100000 * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (d);
}

