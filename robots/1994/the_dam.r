/*************************************************************************
*  The_Dam                                                               *
**************************************************************************
*  by Giovanni D'Amico                                                   *
**************************************************************************
*                                                                        *
* Strategia: The_Dam si muove in maniera oscillante lungo                *
*            la parete sud alla massima velocita' possibile,             *
*            rimanendo cosi' distante dal centro del campo               *
*            di battaglia e rendendo difficile lo scan                   *
*            di altri robot che si trovino sulla stessa traiettoria      *
*            (a causa del bug dello scan sull'asse x).                   *
*                                                                        *
*            La tecnica di fuoco e' abbastanza rudimentale               *
*            e consiste nello sparare anzitutto a possibili              *
*            avversari che si trovino davanti sul percorso               *
*            (che si suppone abbiano "agganciato" The_Dam                *
*            e lo stiano inseguendo), dopodiche' si passa ad analizzare  *
*            l'ultimo angolo di scan (in cui si era rilevato un nemico)  *
*            dapprima grossolanamente e poi in maniera  piu' accurata.   *
*                                                                        *
*                                                                        *
*  Note:     The_Dam non e' molto potente a causa della limitata         *
*            strategia di movimento, tuttavia e' abbastanza efficace     *
*            e si rivela imbattibile contro i robot di tipo leader.      *
*                                                                        *
**************************************************************************/


int range;                       /*    distanza dal robot avversario    */
int angle;                       /*          direzione di scan          */
int dir;                         /*       direzione di movimento        */

main()
{
  angle=0;                        /*      inizializzazione scan         */

  while(loc_y()>60){              /*    se la parete sud e' lontana     */
      drive(270,100);             /*             va a sud               */
      while(!(range=scan(angle+=20,10)));
      cannon(angle,range);        /*     spara se avvisti un nemico     */
  }
  drive(dir=180*(loc_x()>500),0); /*               STOP!                */

/*                                                                      */
/* Ora The_Dam si trova in prossimita' della parete sud, per cui inizia */
/* ad oscillare rispetto al punto centrale della parete stessa.         */
/*                                                                      */

  while(1)                        /*          ciclo infinito            */
  {
      while(!wall()){             /*    finche' sei lontano da pareti   */
          drive(dir,100);         /*           avanti tutta             */
          if (range=scan(dir,10)) /*   se c'e' un nemico davanti a te   */
              forward();          /*           fallo fuori!             */
          else if (range=scan(angle,10)) /* altrimenti riprendi dall'   */
              shoot();            /*     ultima posizione analizzata    */
          else if((angle+=20)>190) angle=0;
      }
      drive(dir=180*(dir==0),0);  /*    fermati e inverti direzione     */
      drive(dir,50);              /*     riparti a mezza velocita'      */
  }
} /* main */


wall()
{
  return ( (dir==0 && loc_x()>900) || (dir==180 && loc_x()<100) );

} /* wall */

forward()
{
  if(range>5) cannon(dir,range-speed()/9);     /*        FUOCO!         */

} /* forward */

shoot()
{
  int orang,oang;

  cannon(angle,range);                         /*        FUOCO!         */

  orang = range;                               /*    ulteriore scan     */
  oang = angle;                                /*   rispetto ad angle   */
  if((range=scan(angle,2)));                   /*    0    -2  to   2    */
  else if((range=scan(angle -= 4,2)));         /*   -4    -6  to  -2    */
  else if((range=scan(angle += 8,2)));         /*    4     2  to   6    */
  else if((range=scan(angle -= 12,2)));        /*   -8   -10  to  -6    */
  else if((range=scan(angle += 16,2)));        /*    8     6  to  10    */
  else if((range=scan(angle -= 20,2)));        /*  -12   -14  to -10    */
  else if((range=scan(angle += 24,2)));        /*   12    10  to  14    */
  else if((range=scan(angle -= 28,2)));        /*  -16   -18  to -14    */
  else if((range=scan(angle += 32,2)));        /*   16    14  to  18    */

  cannon(angle+(angle-oang)/speed(),range+(range-orang)*2);  /*  FUOCO! */

} /* shoot */
