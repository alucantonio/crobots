/****************************************************************************/
/* CRobot:     YURI.R                                 (Yuri il partigiano!) */
/*                                                                          */
/* Autore:     Marco Cimarosti                                              */
/*                                                                          */
/* Data:       30 settembre '96                                             */
/*                                                                          */
/* Folklore:      Yuri ä un partigiano antifascista e la sua missione ä     */
/*             -- di conseguenza -- quella di sparare ai nazi. Il suo       */
/*             nome ä mutuato da una canzone dei bolognesi CSI (giÖ CCCP)   */
/*             il cui ritornello suona "Spara, Yuri, spara...".             */
/*                Come partigiano, Yuri ä un po' imbranato: nei miei test   */
/*             non ä arrivato nemmeno al 10% di vittorie contro i           */
/*             vincitori delle due passate edizioni del torneo di MCLink    */
/*             (TOX.R nel '95 e LAZYII.R nel '94).                          */
/*                Nel torneo '96, ahimä, Yuri ä votato alla sconfitta;      */
/*             spero quindi che gli altri concorrenti chiudano un occhio    */
/*             sul fatto che le loro creazioni siano qui definite           */
/*             "i nazi"...                                                  */
/*                                                                          */
/* Scheda Tecnica:                                                          */
/*                Ho solo una cosa da dire a mia discolpa: ho scoperto      */
/*             CRobots solo una settimana fa, il 23 settembre '96,          */
/*             cercando tutt'altro su Internet... e questa settimana ho     */
/*             lavorato!                                                    */
/*                Mi si scuserÖ, pertanto, se non ho un granchÇ da dire     */
/*             sul versante tecnico!                                        */
/*                Mi sono immediatamente innamorato di questo bellissimo    */
/*             sport (si puï definirlo cosç?) ed ho cercato -- ovviamente   */
/*             senza riuscirci -- di impadronirmi delle finezze dei         */
/*             concorrenti delle passate edizioni.                          */
/*                Devo un grazie particolare a Michele Di Maria, autore     */
/*             di DIMA10.R (presentato alla quarta edizione del torneo).    */
/*                Di DIMA10.R ho cercato di emulare la compattezza (ma,     */
/*             ahimä, non ci sono riuscito: 17% suo contro 20% mio di       */
/*             utilizzo del codice) ed ho bellamente copiato il sistema     */
/*             di aggiustamento della distanza di tiro:                     */
/*                      Distanza = scan(..., ...);                          */
/*                      cannon(..., 2 * scan(..., ...) - Distanza);         */
/*                Veramente, non avevo pensato di copiare la formuletta:    */
/*             il concetto mi aveva affascinato ed ho cercato di trovare    */
/*             un mio sistema; poi ho confrontato il codice con quello di   */
/*             Michele e... Inutile nascondere la provenienza dell'idea!    */
/****************************************************************************/

main ()
{
   int Heading;                           /* Direzione di marcia (gradi).  */
   int Aim;                               /* Direzione di tiro (gradi).    */
   int Distance;                          /* Distanza di tiro ("metri").   */

 /**************************************************************************/
 /* 1: ... Bella ciao, bella ciao, bella ciao ciao ciao...    (Yuri parte) */
 /**************************************************************************/

   /* Parti di corsa in una direzione qualsiasi e guarda da quella parte.
   */
   drive((Heading = Aim = rand(360)), 100);

   while (1)
   {

 /**************************************************************************/
 /* 2: ... Scarpe rotte eppur bisogna andar...               (Yuri marcia) */
 /**************************************************************************/

      /* Se stai per sbattere contro il muro ovest, rallenta un po' e
         inverti la marcia (per la precisione, gira fra i 135¯ e i 225¯).
      */
      if (loc_x() < 100)
         drive((Heading = 315 + Aim % 90), 100);

      /* Stesso discorso per il muro est.
      */
      else if (loc_x() > 900)
         drive((Heading = 135 + Aim % 90), 100);

      /* Idem per il muro sud.
      */
      else if (loc_y() < 100)
         drive((Heading =  45 + Aim % 90), 100);

      /* Uguale uguale per il muro nord.
      */
      else if (loc_y() > 900)
         drive((Heading = 225 + Aim % 90), 100);

      /* Altrimenti, prosegui a tutta birra nella direzione scelta.
      */
      else
         drive(Heading, 100);

 /**************************************************************************/
 /* 3: ... Armammo le mani di bombe e mitraglia...   (Yuri spara ai nazi!) */
 /**************************************************************************/

      /* Se c'ä un nazi nei 20¯ che stai inquadrando...
      */
      if ((Distance = scan(Aim, 10)) > 40)
      {
         /* Correggi l'angolo di tiro con 2 o 3 occhiate successive...
         */
         if (scan(Aim + 5, 10))           /* Se il nazi ä a sinistra...    */
         {
            if (!scan((Aim += 15), 5))    /* Prova con 15¯ a sinistra.     */
               if (!scan((Aim -= 5), 5))  /* Prova con 10¯ a sinistra.     */
                  Aim -= 5;               /* Allora, 5¯ a sinistra.        */
         }
         else if (scan(Aim + 355, 10))    /* Se il nazi ä a destra...      */
         {
            if (!scan((Aim += 345), 5))   /* Prova con 15¯ a destra.       */
               if (!scan((Aim += 5), 5))  /* Prova con 10¯ a destra.       */
                  Aim += 5;               /* Allora, 5¯ a destra.          */
         }

         /* Correggi la distanza, con un'ultima occhiata, poi...
            >>> Spara, Yuri, spara!! <<<
         */
         cannon(Aim, 2 * scan(Aim, 10) - Distance);
      }

      /* Se invece di nazi non ce n'ä, prova 20¯ pió a sinistra.
      */
      else
         Aim += 20;
   }
}

