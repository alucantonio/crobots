/* CARLA Nelle Notti D'Israele                                              */
/* By Andrea B. Previtera                                                   */
/* ------------------------------------------------------------------------ */
/* Carla cammina, cammina spedita                                           */
/* in sedici notti d'un fermo Israele                                       */
/* la Via Diagonale la porta alla vita                                      */
/* vi infonde la mente, la segue fedele.                                    */
/*                                                                          */
/* E' il codice stesso per lei a parlare                                    */
/* che l'anima sua di Ascii e C splende                                     */
/* e l'umile compito mio Š di narrare                                       */
/* di Carla il robot le alterne vicende                                     */
/* ------------------------------------------------------------------------ */

int     corner;    /* Carla Š in uno dei quattro angoli del deserto...   */
int     heading;   /* ...cammina senza posa e l'angolo Š la sua guida... */
int     distance;  /* ...quant'Š lontano il derviscio ? quanto ?...      */

main()
{
 teleport_to_israel();              /* ...Carla giunge in Israele...      */
 heading=315;                       /* ...la direzione non le Š ignota... */
 while (1) { walk(); attack(); }    /* ...l'eternit… la attende, il lungo */
                                    /* loop della vita e della morte...   */
}

attack()
{
 /* ...Carla fa attenzione, lo sguardo si muove rapido :       */
 /* ecco l'oriente di venti speziati                           */
 /* il freddo immutabile nord                                  */
 /* il frenetico occidente                                     */
 /* il torrido sud di fuoco e avorio                           */
 /* quattro angoli quattro correzioni quattro speranze di vita */
 /* propria e altrui peritura                                  */

 if((distance=scan( 45,10)))
 {
  if(corner==0) cannon(43,distance);
                else
                cannon(47,distance);
 }
 if((distance=scan(225,10)))
 {
  if(corner==0) cannon(227,distance);
                else
                cannon(223,distance);
 }
 if((distance=scan(135,10)))
 {
  if(corner==0) cannon(135,distance-5);
                else
                cannon(135,distance+5);
 }
 if((distance=scan(315,10)))
 {
  if(corner==0) cannon(315,distance+5);
                else
                cannon(315,distance-5);
 }
}

walk()
{
 /* La Diagonale segna il cammino di Carla */
 /* ed il suo cammino rimarca              */
 /* La Diagonale antica                    */
 /* mistica                                */
 /* e polverosa, anche.                    */

 if(corner==0){
               if(loc_y()<=100 && loc_y()>=10)
               {
                heading=135;
                corner=3;
               }
              }
        else  {
               if(loc_y()>=900 && loc_y()<=990)
               {
                heading=315;
                corner=0;
               }
              }
 drive(heading,100);
}

teleport_to_israel()
{
 int done;  /* Un atto da compiere, e poi il lungo cammino     */
 done=0;    /* trovare Israele, La Diagonale, e tutto il resto */
 corner=0;  /* tutto il resto. Tutto il resto.                 */

 while(done==0)
 {
  drive(135,100);                      
  if(loc_x()<=50)  { heading=90;  done=1; }
  if(loc_y()>=950) { heading=180; done=1; }
 }

 done=0;

 while(done==0)
 {
  drive(heading,100);
  if(heading==180)
  {
   if(loc_x()<=50) done=1; 
  }
  else
  if(loc_y()>=950) done=1;
 } 
}
