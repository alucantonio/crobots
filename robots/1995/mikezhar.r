/* MIKEZ-HARD 
   Robot di MICHELE IACOBELLIS
*/


int headdx,limit,newstart;         /* parametri per il cannone */
int flag;                          /* flag di strategia */

main()
{
   int count;                      /* selettore di strategia */
   int count_limit;                /* tempo per il cambio di strategia */
   
   count = 0;

   /* Il count_limit serve per adeguare il robot al combattimento contro
      avversari veloci o meditabondi.
      Il valore 4 Š efficace per robot veloci che comprono tutta l'arena.
   */
   count_limit = 4;
   
   pos1();                         /* assunzione della posizione in basso */
      
   while (1) {
      count +=1 ;

      /* selettore della strategia */
      if (damage() > 50)      
         count_limit = rand(8);        

      if (count > count_limit) {
         count = 0;
         if (flag == 0) 
            pos2();
         else
            pos1();
      }

      /* gestione del moto orizzontale */

      drive(0,100);
      while(loc_x() < 850) firedx();
      drive(180,0);

      while(speed() > 49) firedx();

      drive(180,100);
      while(loc_x() > 80) firedx();
      drive(0,0);

      while(speed() > 49) firedx();
   }
}

/* Funzione per la posizione in basso */

pos1() 
{
   /* startegia 1 */
   flag = 0;
   
   /* inizializza la torretta di scansione per pos1 */

   headdx = 210;
   limit = -45;   
   newstart = 360;

   /* posizione in basso */
   
   drive(180,100);
   while(loc_x() > 80) firedx();
   drive(0,0);

   while(speed() > 49) firedx();

   drive(270,100);
   while(loc_y() > 80) firedx();      
   drive(90,0);
   while(speed() > 49) firedx();
}

/* Funzione per la posizione in alto */

pos2()
{
   /* strategia 2 */
   flag = 1;

   /* inizializzazione della torretta per pos2 */

   headdx = 390;
   limit = 150;
   newstart = 390;
   
   /* posizione in alto */
   
   drive(180,100);
   while(loc_x() > 80) firedx();
   drive(0,0);

   while(speed() > 49) firedx();

   drive(90,100);
   while(loc_y() < 900) firedx();      
   drive(270,0);
   while(speed() > 49) firedx();
} 

/* Funzione di mira e fuoco */

firedx()
{
   int obj;
   
   if(obj=scan(headdx,10)) 
      cannon(headdx,obj);
   else {
      headdx -= 20;
      if (headdx <= limit) headdx = newstart;
   }
}





