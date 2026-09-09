/* Biro v5.1  30/09/1995 opera di Maurilio Longo (codice) & Teresa Cardellino */
/*                       (supporto tecnico e morale)                          */
/*                                                                            */
/*                       Teresa Cardellino:                                   */
/*                       Maurilio Longo:                                      */
                                                                              
/* Si tratta di un sostanziale miglioramento rispetto al C-robot dell'anno    */
/* scorso. E' stata rifatta la logica di ricerca e puntamento del nemico -ora */
/* piu' efficace- ed e' stata spostata la zona d'azione del robot.            */
/* La parte riguardante il calcolo della gittata non e' stata modificata in   */
/* quanto funzionante. Per il resto il robot si basa sulle normali routines di*/
/* spostamento.                                                               */



main()
{
   int angolo, distanza, verso; /*, dir_x, dir_y;*/

   verso  = 1;     /* inzia a cercare il nemico in senso anti-orario */
   angolo = 0;     /* a partire da 0 */
   
   /* posizionati */
   vai_a(850, 800);
   while ((p_distanza(loc_x(), loc_y(), 850, 800) > 50) && speed())
      if (!(distanza = scan(angolo, 10)) || (distanza > 750))
         angolo += 20;
      else
         fuoco(angolo, distanza, scan(angolo, 10), 17, 3);
         /* ultimi due parametri = cicli cpu tra le due scan() e tra scan() e fuoco() */

   while (1) {

      /* il crobot va su e giu' nell'angolo superiore dx */
   
      /*dir_x = 550;
      dir_y = 870;*/ 
      
      vai_a(550, 870);
      while ((loc_y() < 870) && speed())
         if (!(distanza = scan(angolo, 10)) || (distanza > 750))
            angolo += 19 * verso;
         else {
            angolo = trova(angolo, distanza);
            while ((distanza = scan(angolo, 10)) && (loc_y() < 870))
               angolo = trova(angolo, distanza);
            if (scan(angolo + 10, 10)) { 
               verso = 1;
               angolo += 8;
               }
            else {
               verso = -1;
               angolo -= 8;
               }
            }

      
      /*dir_x = 850;
      dir_y = 730;*/
      
      vai_a(850, 730);
      while ((loc_y() > 730) && speed())
         if (!(distanza = scan(angolo, 10)) || (distanza > 750))
            angolo += 19 * verso;
         else { 
            angolo = trova(angolo, distanza);
            while ((distanza = scan(angolo, 10)) && (loc_y() > 730))
               angolo = trova(angolo, distanza);
            if (scan(angolo + 10, 10)) { 
               verso = 1;
               angolo += 8;
               }
            else {
               verso = -1;
               angolo -= 8;
               }
            }
   }
}


/* cerca di localizzare il nemico con una serie di scan() successive */
/* se lo trova spara con una correzione fissa di 1 grado ogni 150m   */

int trova(angolo, distanza)
int angolo, distanza;
{
   int n_distanza;

   if (scan(angolo + 5, 5))
      if (n_distanza = scan(angolo + 3, 2))
         if (scan(angolo + 1, 1)) {
            fuoco(angolo += (2 + n_distanza / 150), distanza, n_distanza, 30, 24); 
            return(angolo);
            }
         else {
            fuoco(angolo += (4 + n_distanza / 150), distanza, n_distanza, 30, 24);
            return(angolo);
            }
      else
         if (n_distanza = scan(angolo + 8, 2))
            if (scan(angolo + 6, 1)) {
               fuoco(angolo += (7 + n_distanza / 150), distanza, n_distanza, 40, 24);
               return(angolo);
               }
            else {
               fuoco(angolo += (9 + n_distanza / 150), distanza, n_distanza, 40, 24);
               return(angolo);
               }
         else   
            return(angolo + 5);
   else
      if (scan(angolo - 5, 5))
         if (n_distanza = scan(angolo - 3, 2))
            if (scan(angolo - 1, 1)) {
               fuoco(angolo -= (2 + n_distanza / 150), distanza, n_distanza, 38, 24);
               return(angolo);
               }
            else {
               fuoco(angolo -= (4 + n_distanza / 150), distanza, n_distanza, 38, 24);
               return(angolo);
               }
         else
            if (n_distanza = scan(angolo - 8, 2))
               if (scan(angolo - 6, 1)) {
                  fuoco(angolo -= (7 + n_distanza / 150), distanza, n_distanza, 48, 24);
                  return(angolo);
                  }
               else {
                  fuoco(angolo -= (9 + n_distanza / 150), distanza, n_distanza, 48, 24);
                  return(angolo);                    
                  }
            else
               return(angolo - 5);
      else
         return(angolo); /* chi sa dov'e' ? */
}


/* si occupa di sparare e di calcolare le correzioni di tiro necessarie    */
/* CPU_1 = cicli tra le due scan(); CPU_2 = cicli tra 2nda scan() e fuoco()*/

int fuoco(angolo, distanza, n_distanza, CPU_1, CPU_2)
int angolo, distanza, n_distanza, CPU_1, CPU_2;
{
   int velocita, spostamento, posizione, fatt_correzione, gittata;

   velocita = (((n_distanza - distanza) * 1000000) / CPU_1);
   
   spostamento = velocita * (CPU_2 + 51);
   /* 51 sono i cicli di cpu dall'inizio della fuoco() alla cannon() */

   posizione = n_distanza + (spostamento / 1000000);
   fatt_correzione = ((velocita * posizione / 50) / 1000000);
   gittata = posizione + fatt_correzione;

   if (gittata > 40)
      cannon(angolo, gittata);
   else
      cannon(angolo, 50);
      /* lo sparo un po' oltre il minimo, forse riesco ad infiggere dei danni al nemico */
   return;
}


/* effettua la conversione di rotta */

int vai_a(x, y)
int x, y;
{
   int heading;

   heading = direzione(x, y);
   drive(heading, 40);

   while (speed() > 50)
      ;

   drive(heading, 100);
   return;
}


/* ritorna la direzione per un punto. */

int direzione(x, y)
int x, y;
{
   int locx, locy, r;

   locx = loc_x();
   locy = loc_y();

   if (locx == x)
      if (y > locy) 
         return(90);
      else 
         return(270);
   else {
      r = atan(100000 * (locy - y) / (locx - x));
      if(y < locy)
         if (x > locx) 
            return(360 + r);
         else 
            return(180 + r);
      else 
         if (x > locx) 
            return(r);
         else 
            return(180 + r);
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


