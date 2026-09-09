/* Biro v4.7  30/09/1994 opera di Maurilio Longo (codice) & Teresa Cardellino  */
/*                       (supporto tecnico e morale)                           */
/*                                                                             */
/*                       Teresa Cardellino                                     */
/*                       Maurilio Longo                                        */
/*                                                                             */
/*                                                                             */
/* Il presente crobot e' uno sviluppo e (sperabilmente) un miglioramento di
   quello che abbiamo inviato lo scorso anno. Il crobot si posiziona nell'an_
   golo in basso a dx dell'area e li si sposta avanti e indietro tra un lato
   e l'altro, questa posizione ci e' sembrata tra le piu' idonee per tenerlo
   il piu' possibile fuori dalla mischia. Come ha mostrato Godel lo scorso anno
   la cosa piu' importante e' sparare poco ma bene... Abbiamo ritenuto piu'
   conveniente (soprattutto in un torneo con scontri a 4) mantenere sempre il
   crobot in movimento, anche se questo va a detrimento della precisione e del
   volume del fuoco. La routine usata per correggere la gittata sfrutta la
   conoscenza del numero di istruzioni di cui si compone il codice oggetto per
   cercare di sopperire alla mancanza di una funzione che ritorni il tempo tras_
   corso tra due eventi. La routine di correzione dell'angolo di tiro, invece,
   nonostante tutti i nostri sforzi non e' venuta come avremmo voluto ed e' la
   parte meno riuscita del crobot... sara' per il prossimo anno! Per il resto
   il crobot si basa sulle solite routines di posizionamento e non ha quindi
   nulla di particolare. La parte piu' difficile, come gia' detto si e' rivelata
   la ricerca e "l'inseguimento" degli obiettivi nemici, non siamo riusciti a
   far si che il crobot seguisse gli spostamenti (reali o opparenti) dei nemici
   con la stessa precisione e costanza con la quale altri crobot svolgono questa
   funzione.
*/

int CPU_2, CPU_3;

main()
{
   int angolo, distanza, verso, CPU_1;

   verso = 1;   /* inzia a cercare il nemico in senso anti-orario */
   CPU_1 = 42;  /* cicli di cpu tra 1a e 2a scan() */
   CPU_2 = 53;  /* cicli di cpu tra 2a scan() e cannon() */
   CPU_3 = 91;  /* cicli di cpu tra 2 scan() successive in scansione_fine() dopo un fuoco()

   /* posizionati */
   angolo = vai_a(850, 300, angolo, verso);
   while ((p_distanza(loc_x(), loc_y(), 850, 300) > 50) && speed())
      if (!(distanza = scan(angolo, 10)) || (distanza > 750))
         angolo += 20;
      else
         fuoco(angolo, distanza, scan(angolo, 10), 25);
         /* ultimo parametro = cicli cpu tra le due scan */

   while (1) {

      /* il crobot va su e giu' nell'angolo inferiore dx dell'arena */
      /* questa posizione lo tiene abbastanza fuori dalla mischia   */

      /* da 0 a 270 */
      angolo = vai_a(600, 100, angolo, verso);
      while ((loc_x() > 600) && speed())
         if (!(distanza = scan(angolo, 10)) || (distanza > 750))
            angolo += 18 * verso;
         else
            verso = scansione_fine(angolo, distanza, verso, CPU_1);

      /* da 270 a 0 */
      angolo = vai_a(900, 400, angolo, verso);
      while ((loc_y() < 400) && speed())
         if (!(distanza = scan(angolo, 10)) || (distanza > 750))
            angolo += 18 * verso;
         else
            verso = scansione_fine(angolo, distanza, verso, CPU_1);
   }
}


/* vediamo un po' di capire dove si trova esattamente il nemico.
   CPU_1 contiene il numero di cicli cpu tra due scan() successive  */
int scansione_fine(angolo, distanza, verso, CPU_1)
int angolo, distanza, verso, CPU_1;
{
   int n_distanza;

   if ((loc_y() > 400) || (loc_x() < 620) || !speed())
      return(verso);

   if (n_distanza = scan(angolo += 4, 5)) {
      fuoco(angolo - 2, distanza, n_distanza, CPU_1);
      return(scansione_fine(angolo + 2, n_distanza, 1, CPU_3));
      }
   else
      if (n_distanza = scan(angolo -= 9, 5)) {
         fuoco(angolo + 2, distanza, n_distanza, CPU_1 + 11);
         return(scansione_fine(angolo - 2, n_distanza, -1, CPU_3));
         }

   return(verso);
}


/* si occupa di sparare e di calcolare le correzioni di tiro necessarie */
fuoco(angolo, distanza, n_distanza, CPU_1)
int angolo, distanza, n_distanza, CPU_1;
{
   int speed, dist, posizione, fatt_correzione;

   speed = (((n_distanza - distanza) * 1000000) / CPU_1);
   dist = speed * CPU_2;
   posizione = n_distanza + (dist / 1000000);
   fatt_correzione = ((speed * posizione / 50) / 1000000);
   cannon(angolo, posizione + fatt_correzione);
   return;
}


/* effettua la conversione di rotta */
int vai_a(x, y, angolo, verso)
int x, y, angolo, verso;
{
   int heading, n_angolo;

   n_angolo = angolo;
   heading = direzione(x, y);
   drive(heading, 0);
   while (speed() > 50)
      if (scan(angolo, 10))
         n_angolo = angolo;
      else
         angolo += 15 * verso;
   drive(heading, 100);
   return(n_angolo);
}


/* ritorna la direzione per un punto. */
int direzione(x, y)
int x, y;
{
   int locx, locy, r;

   locx = loc_x();
   locy = loc_y();

   if (locx == x)
      if (y > locy) return(90);
      else return(270);
   else {
      r = atan(100000 * (locy - y) / (locx - x));
      if(y < locy)
         if (x > locx) return(360 + r);
         else return(180 + r);
      else if (x > locx) return(r);
           else return(180 + r);
   }
}


/* ritorna la distanza tra due punti */
int p_distanza(x1, y1, x2, y2)
int x1, y1, x2, y2;
{
   int x, y;

   x = x1 - x2;
   y = y1 - y2;
   return(sqrt((x*x) + (y*y)));
}


