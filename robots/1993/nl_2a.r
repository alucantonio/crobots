/* nome del Crobot:                  NL                      */
/* versione:                        2.00  A                  */
/* data finale di realizzazione:    24/8/93                  */
/*                                                           */
/* dati dell'autore:                                         */
/*               Tognon Stefano                              */
/*                                                           */
/* strategia: il Crobot percorre il lato destro del campo di */
/*            battaglia in modo da limitare la scansione     */
/*            per il tiro a 180ø circa.                      */
/* modalità di tiro:                                         */
/*            la routine Spara si occupa di cercare i Crobot.*/
/*            Quando ne è stato trovato uno spara correggendo*/
/*            sia la gittata che l'angolo opportunamente.    */
/* punti deboli:                                             */
/*            il fatto di combattere contro 3 avversari porta*/
/*            a improvvisi cambiamenti (per sovvrapposizione */
/*            di un crobot su quello che si stava sparando)  */
/*            tra vecchio e nuovo angolo e vecchia e nuova   */
/*            gittata che fonno 'sballare' il tiro.          */

int ang, newrange, oldrange, oldang;

main()
{
  drive (0, 100);
  while (loc_x() < 962)
    spara();
  drive (90,0);
  while (speed() > 49)
    spara();

  ang = 270;
  while (1) {
    drive (90, 100);
    while (loc_y() < 920)
      spara();
    drive (270, 0);

    while (speed() > 49)
      spara();

    drive (270, 100);
    while (loc_y() > 82)
      spara();
    drive (90, 0);

    while (speed() > 49)
      spara();
  }
}


/* all'angolo di sparo si somma la differenza con il precedente (dimezzata)   */
/* mentre per la gittata si spara pi— avanti o pi— indietro a seconda dei casi*/
/* nota:in C (NEWRANGE>OLDRANGE) da 0 per FALSE e qulsiasi altra cosa per TRUE*/
/* mentre in questa versione interpretata per TRUE viene restituito 1 che Š   */
/* il valore corretto per come si calcola la gittata                          */
spara()
{
 if (newrange = scan(ang, 5)) {
         cannon(ang+(ang-oldang)/2, (newrange>oldrange)  *newrange*8/7+
                                    (newrange==oldrange) *newrange+
                                    (newrange<oldrange)  *newrange*7/8);
         oldang = ang;
         oldrange = newrange;
  } else {
     ang -=10;
     if (ang <=70)
         ang = 270;
  }
}


