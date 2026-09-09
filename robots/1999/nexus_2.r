
/* #questa e' una piccola variante al vecchio nexus_1 di Vincenzo Benincasa# */

/* Guardando il robot e vedendo com'e' veloce mi sono domandato come mai non */
/* fosse imbattibile e ho creduto di capire il perche'; la differenza sta    */
/* tutta in due punti (segnalati); Antonio Pennino                           */

/* (il robot e' un pelino piu' lento ma molto piu' sicuro da inchiodamenti)  */

int d, pa, ang;
main()
{
   drive(0,100);
   while(loc_x()<960) spara();
   drive(90,0);
   while(speed()>49) spara();

   ang=270;
   while(speed()) /* modificato */
   {
        drive(90,100);
        while(loc_y()<920) spara();
        drive(270,0);

        while(speed() > 49) spara();

        drive(270,100);
        while(loc_y()>80) spara();
        drive(90,0);

        while(speed() > 49) spara();
   }

  main();  /* nuovo! */
}

spara()
{
   int range;

   if(range=scan(ang,10))
       cannon(ang,range);
   else
   {
      ang-=20;
      if(ang<=70) ang=270;
   }
}
