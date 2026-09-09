/* nome del Crobot:                  NL                      */
/* versione:                        2.00  B                  */
/* data finale di realizzazione:    25/8/93                  */
/*                                                           */
/* dati dell'autore:                                         */
/*               Tognon Stefano                              */
/*                                                           */
/* strategia: il Crobot si posiziona nell'angolo in alto a   */
/*            destra e vi rimane fermo; in questo modo la    */
/*            scansione viene limitata a soli 90ø.           */
/* modalità di tiro:                                         */
/*            la routine Spara_90 si occupa di cercare i     */
/*            Crobot con un range di 90ø.                    */
/*            Quando ne è stato trovato uno spara correggendo*/
/*            sia la gittata che l'angolo opportunamente.    */
/*            La routine Spara_360 spara invece a 360ø e     */
/*            serve solo durante lo spostamento iniziale.    */
/* punti deboli:                                             */
/*            Il punto debole principale è che rimane sempre */
/*            fermo, diventando quindi un facile bersaglio.  */

int ang, newrange, oldrange, oldang;

main()
{
  drive (0, 100);
  while (loc_x() < 960)
    spara_360();
  drive (90,0);
  while (speed() > 49)
    spara_360();

  drive(90,100);
  while (loc_y() < 960)
    spara_360();
  drive(90,0);
  while (speed() > 49)
    spara_90();

  ang=270;
  while (1)
   { spara_90();
     spara_90();
     spara_90();
   }
}

/* spara_90: spara valutando un range di 90ø (da 270ø a 180ø)                 */
/* all'angolo di sparo si somma la differenza con il precedente (dimezzata)   */
/* mentre per la gittata si spara pi— avanti o pi— indietro a seconda dei casi*/
/* nota:in C (NEWRANGE>OLDRANGE) da 0 per FALSE e qulsiasi altra cosa per TRUE*/
/* mentre in questa versione interpretata per TRUE viene restituito 1 che Š   */
/* il valore corretto per come si calcola la gittata                          */
spara_90()
{
 if (newrange = scan(ang, 5)) {
         cannon(ang+(ang-oldang)/2, (newrange>oldrange)*newrange*8/7+
                                    (newrange==oldrange)*newrange+
                                    (newrange<oldrange)*newrange*7/8);
         oldang = ang;
         oldrange = newrange;
  } else {
     ang -=10;
     if (ang <=165)
         ang = 270;

  }
}

/* spara_360: spara valutando un range di 360ø e corregge solo la gittata nel tiro */
spara_360()
{
 if (newrange = scan(ang, 10)) {
    if (oldrange < newrange) {
         cannon(ang, 8 * newrange /7);
         oldrange = newrange;
    } else
     {
       cannon(ang, 7 * newrange /8);
         oldrange = newrange;
     }
  } else {
     ang -=23;
     while (!(newrange = scan (ang, 10)))
            ang += 20;
     if (ang <= 5)
         ang = 360;
  }
}
