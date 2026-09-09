/*
  Hell v 2.25
  Programmato da 
  Bergamasco Mirko 

  Il robot si muove lungo i bordi dell'arena in senso antiorario e scanna
  in cinque  direzioni  differenti  incrementando  di  45ø  rispetto alla
  direzione (ad esempio in direzione 0ø scanna a  0ø,45ø,90ø,135ø e 180ø)
  e in caso abbia trovato un nemico continua a sparare finché a tiro.
*/

int range,drv,sp;

main ()
{
while (loc_y() > 30)          /* Sposta il robot verso il lato sud */
  drive(270,65)               /* dell'arena e fa iniziare il ciclo */
  ;                           /* di movimento lungo i lati in      */
  drive (0,0);                /* senso antiorario                  */
while (1)
  {
  drv=0;                      /* Imposta direzione */
  while (loc_x() < 930)       /* Inizio procedura di movimento rotatorio */
    {
    drive(0,100);             /* Movimento lungo il lato SUD      */
    EatThis();                /* Richiamo alla procedura di fuoco */
    }
  sp=30;
  while (sp>0)
    {
    drive(180,sp);            /*Frenata */
    sp=sp-10;
    }
  drv=90;                     /* Cambio direzione */
  while (loc_y() < 930)
    {
    drive (90,100);           /* Movimento lungo il lato EST      */
    EatThis();                /* Richiamo alla procedura di fuoco */
    }
  sp=30;
  while (sp>0)
    {
    drive(270,sp);            /*Frenata */
    sp=sp-10;
    }
  drv=180;                    /* Cambio direzione */
  while (loc_x() > 70)
    {
    drive(180,100);           /* Movimento lungo il lato NORD     */
    EatThis();                /* Richiamo alla procedura di fuoco */
    }
  sp=30;
  while (sp>0)
    {
    drive(0,sp);              /*Frenata */
    sp=sp-10;
    }
  drv=270;                    /* Cambio direzione */

  while (loc_y() > 70)
    {
    drive (270,100);         /* Movimento lungo il lato OVEST    */
    EatThis();               /* Richiamo alla procedura di fuoco */
    }

  sp=30;
  while (sp>0)               /* Frenata */
    {
    drive(90,sp);
    sp=sp-10;
    }

  }
}

EatThis()
{
while ((range=scan(drv,3)) > 0 && range < 700 )    /* Procedura di fuoco che */
  cannon (drv,range);                               /* scanna in 5 diverse    */
while ((range=scan(drv+45,3)) > 0 && range < 700)  /* direzioni rispetto al  */
  cannon (drv+45,range);                            /* movimento. Spara solo  */
while ((range=scan(drv+90,3)) > 0 && range < 700)  /* sotto i 700 di range,  */
  cannon (drv+90,range);                            /* utilizzando un ciclo   */
while ((range=scan(drv+135,3)) > 0 && range < 700) /* WHILE che continua a   */
  cannon (drv+135,range);                           /* sparare finchŠ il robot*/
while ((range=scan(drv+180,3)) > 0 && range < 700) /* rimane fermo, senza    */
  cannon (drv+180,range);                           /* aggiornare lo scanner. */
}
