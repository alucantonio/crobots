/*********************************/
/*                               */ 
/*          D ynamic             */
/*          I ntelligent         */
/*          M ultiscan           */ 
/*          A rchitecture        */ 
/*            REL. 10            */ 
/*                               */ 
/*      by Michele Di Maria      */
/*********************************/




main()
{
int drv,a,b,inizio,aa,bb;
inizio=1;
drv = 180;
while(1)
   {

   /*  PROCEDURE DI ATTACCO */
       
       drive(drv,100);          
       if (((aa=scan(a,7))!=0))      /* Se la torretta 'a' trova un bersaglio.*/
	 {
	  cannon(a,(2*scan(a,7)-aa)); /* Spara in quella direzione cercando di*/
				      /* compensare la distanza a seconda del */
				      /* movimento del bersaglio              */
	  b=a;                        /* Assegna alla torretta 'b' la stessa  */
				      /* angolazione della torretta 'a'       */
	 }
       else
	  a=a-15;                     /* Altrimenti decrementa l'angolo di    */
				      /* scansione di 15 deg.                 */

       if (((bb=scan(b,7))!=0))       /* Stesso discorso per la torretta 'b'  */
	 {
	  cannon(b,(2*scan(b,7)-bb));
	  a=b;
	 }
       else
	  b=b+15;

   /*  PROCEDURA DI DIFESA  */

   /* Verifica se il robot si trova in prossimita' degli angoli e assegna  */
   /* la nuova direzione necessaria a muoversi lungo il perimetro in senso */
   /* orario                                                               */


       if (((loc_x()>900)&&(loc_y()>900))||((inizio==1)&&(loc_x()<100)))
	  {                                         /* angolo alto destro */
	   drv=270;
	   inizio=0;
	  }
       
       if ((loc_x()<100)&&(loc_y()>900))   /*   angolo alto sinistro */
	  drv=0;
       
       if ((loc_x()>900)&&(loc_y()<100))   /*   angolo basso destro  */
	  drv=180;
       
       if ((loc_x()<100)&&(loc_y()<100))   /*   angolo basso sinistro */
	  drv=90;
   }  
}

