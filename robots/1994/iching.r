/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   !! NB Tutti i file IChing.xxx rappresentano lo stesso robot.    !!
   !! Sono state fatte numerose copie per limitare la possibilita' !!
   !! di perdere il robot in seguito al danneggiamento parziale    !!
   !! del dischetto durante la spedizione.                         !! 
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

/* +++ IChing.r +++
   Cisana Gianluca
*/

int angle,range,old_range;

main()
{
  /* Raggiunge la parete di destra e si ferma in seguito all'urto */

  range=0;
  drive(0,100);
  while(loc_x()<995) 
  { 
    if (range<20 || range>700) trova();
    spara();
  }

  /* Loop */  
  /* Esegue movimento verticale lungo parete di destra e chiama le 
     funzioni di ricerca e di fuoco.                              */

  while (1)
  {
    while (loc_y()<800)
    {
      drive (90,50);
      /* Se e' fuori tiro il precedente bersaglio ne cerca uno nuovo */
      if (range<20 || range>700) trova();
      /* Routine di tracciamento e fuoco */
      spara();
    }
    
    while (loc_y()>200)
    {
      drive (270,50);
      if (range<20 || range>700) trova();
      spara();
    }
  } /* End loop */
}

trova()
/* Effettua la ricerca solo quando il sistema di tracking della
   routine spara() perde il bersaglio                           */
{
    if (scan(270,2)>20)  /* controlla in basso */
    {
      angle=269;
    }
    else
    { 
      /* Controlla partendo dall'alto in senso antiorario.       
         Questa procedura con il precedente controllo            
         fa' si che sia privilegiata la verticale nella ricerca.  
         Inoltre si da' la precedenza ad obiettivi piu' vicini:  
         ricerca prima da 20 a 400 m e poi da 20 a 700 m.       */

      angle=71;
      while ((range>400 || range<20) && angle<260) 
      {
        angle=angle+20;
        range = scan (angle,10);
      }
      if (angle>260)
      {
        angle=71;
        while ((range>700 || range<20) && angle<260) 
        {
          angle=angle+20;
          range = scan (angle,10);
        }
      }
    }
}

spara()
{      
  /* Ricerca il nemico attorno all'ultima posizione in cui era stato
     individuato
  */
  old_range = scan(angle-20,10);
  if (old_range > 0) angle=angle-20; 
  else  
  {
    old_range = scan(angle+20,10);
    if (old_range>0) angle=angle+20; else old_range=scan(angle,10);
  }
  /* Affina la rilevazione dell'angolo effettuata sopra ed
     ottiene anche una nuova distanza                      */
  range=scan(angle-6,4);
  if (range > 0) 
  {
    angle=angle-6;
    if (angle<90) angle=91;
  }
  else
  {
    range = scan(angle+6,4);
    if (range>0) 
    {
      angle=angle+6; 
      if (angle>270) angle=269;
    }  
    else range=scan(angle,2);
  }
  
  /* Usa le due distanze per prevedere la nuova
     posizione in cui sparare (se distanza >20 m)  */

  range=range+(range-old_range)*range/110;
  if (range>20) cannon(angle,range);
}

