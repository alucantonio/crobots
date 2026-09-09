/*-----------------------------------------------------------------------------

	 *     * *     * * * * *      * * * *
	* *     *     *   *   *     *      *
       *   *   *         *           * *
      *     * *    *    *    *    *     *
     * *     *   * *   *   * *   * * * *

		 -=> NaTaS <=-

Written by: Daniele Fogazzi

Info about Natas:
   E' il mio primo cbot, Xcio' non pretendete troppo. 8-)
   La sua tecnica e' molto semplice: si posiziona nell'angolo in alto a destra
   e continua a percorrere la figura di un piccolo triangolo alla velocita'
   100.
   Questo gli permette di schivare molti colpi, sia da parte dei bot + semplici
   cerca-trova-spara, sia da parte dei bot + complessi che tentano di prevedere
   la futura posizione del bot.
   La funziona di sparo e' certamente la parte + debole del mio bot, d'altra
   parte ho preferito, almeno X il mio primo bot, non copiare neppure una riga
   di codice da altri bot di passati tornei.
   Comunque, la funzione di sparo scanna un angolo di 90 gradi a passi di 14
   (scannare 360 gradi sarebbe poco utile visto che il bot rimane sempre in un
   angolo), e quando trova un bot gli spara. Viene tentato anche di prevedere
   la futura posizione del bot con un algoritmo che potrebbe vincere il premio
   di pressapochismo del torneo 1996. 8-)
   Suppongo sia tutto, Natas non vincera' mai un torneo, Xo' oh... Oramai l'ho
   scritto, tanto vale presentarlo +ttosto che buttarlo no? 8-)
   (e poi oramai mi sono gia' bullato con gli amici dicendo che avrei
   partecipato! 8-))) )

-----------------------------------------------------------------------------*/

int range, angle, old_range;

/*-----------------------------------------------------------------------------
	MAIN ROUTINE
-----------------------------------------------------------------------------*/

main ()                                         /* MAIN ROUTINE */

{

range = 0;
angle = 180;
old_range = 0;

while (loc_x() > 900)				/* AM NOT I 2 NEAR THE WALL? */
   drive (180,100);
nail (0);
while (loc_y() > 850)				/* AM NOT I 2 NEAR THE WALL? */
   drive (270,100);
nail (90);

while (loc_x() < 900)				/* RUN ON THE EAST WALL */
   {
   drive (0,100);
   search ();					/* SCAN */
   }
nail (90);					/* BRAKE */
while (loc_y() < 850)				/* RUN NEAR THE NORTH WALL */
   {
   drive (90,100);
   search ();					/* SCAN */
   }
nail (135);					/* BRAKE */

while (1)					/* TRIAGLE */
   {
   drive (135,100);
   while (loc_y() < 900)			/* RUN ON THE 1ST SIDE */
      search();					/* SCAN */
   nail (0);					/* BRAKE */
   drive (0,100);
   while (loc_x() < 900)			/* RUN ON THE 2ND SIDE */
      search();					/* SCAN */
   nail (270);					/* BRAKE */
   drive (270,100);
   while (loc_y() > 850)			/* RUN ON THE 3RD SIDE */
      search();					/* SCAN */
   nail (135);					/* BRAKE */
   }

}

/*---------------------------------------------------------------------------*/

nail (angle)
int angle;

{
drive (angle,0);				/* BRAKE */
while (speed() > 50);				/* WAIT 4 THE SPEED IS
						   SUFFICIENT LOW */

return;
}

/*---------------------------------------------------------------------------*/

search()

{

range = scan (angle,14);
if (range != 0)
   {
   range = scan (angle,2);
   if (range != 0);
   else
      {
      range = scan (angle - 2,2);
      if (range != 0)
	 angle -= 2;
      else
	 {
	 range = scan (angle + 2,2);
	 if (range != 0)
	    angle += 2;
	 else
	    {
	    range = scan (angle - 5,4);
	    if (range != 0)
	       angle -= 5;
	    else
	       {
	       range = scan (angle + 5,4);
	       if (range != 0)
		  angle += 5;
	       else
		  {				/* LOST THE BOT DURING THE SCAN
						   */
		  angle = (angle - 14 + 90) % 90 + 180;
		  old_range = 0;
		  return;
		  }
	       }
	    }
	 }
      }

   if (old_range != 0)
      cannon (angle,range - (old_range - range));	/* BOOM! (FUTURE
							   POSITION) */
   else
      cannon (angle,range);			/* BOOM! (SIMPLE) */
   old_range = range;
   return;

   }

angle = (angle + 14) % 90 + 180;		/* NO BOT FOUND, PREPARE THE
						   FUTURE ANGLE 2 SCAN */
old_range = 0;
return;

}

/*---------------------------------------------------------------------------*/
