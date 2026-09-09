/*                                
                                  **********
                                 * PERIBOLO *
                                  **********

di Stefano Costa
                                                                            */

main()

{
int n,x,range;

while (loc_x()<920)                       /*Destra; va a prendere posizione */
    {drive(0,100);                        /*contro la parete. Intanto si    */   
     range=scan(x+=16,8);                 /*guarda intorno e spara se vede  */
     if (range!=0) cannon(x,range-40);    /*qualcosa.                       */
    }

drive(90,0);                              /*Cambia direzione.               */

while (speed()>50);                       /*Attende per rallentare          */

drive(90,100);                            /*Su.                             */

while (1)     
   
   { n=0;
     while ((loc_y()<920)&&(!scan(90,5))) /*Verso l'alto se Š lontano dal   */ 
         {drive(90,100);                  /*muro e non c'Š nessuno davanti. */
          
          range=scan(x=180+(n%20)*5,5);   /*Guarda dietro di sŠ per inter-  */
                                          /*valli di 5ø. Se non trova niente*/
                                          /*in ogni intervallo, ricomincia  */
                                          /*dall'inizio                     */

          if (range!=0)                   /*Se trova qualcuno...            */
             
             {cannon(x,range-45);         /*...gli spara...                 */
              
              while((range=scan(x,5))&&(loc_y()<920))   /*... e se, guardan-*/ 
                                                        /*do, lo rivede, ed */
                                                        /*Š ancora lontano  */
                                                        /*dal muro...       */

                  {cannon(x+6,range-45);  /*...continua a sparare nella     */
                                          /*stessa direzione...             */

                   drive(90,100);         /*e a muoversi.                   */
                  }
             }
          n+=1;                           /*Questo contatore serve a variare*/
                                          /*la direzione in cui il Peribolo */
                                          /*guarda.                         */
         }
     drive(180,0);                        /*Cambia direzione.               */

     while (speed()>50);                  /*Attende per rallentare.         */

     drive(180,100);                      /*Riparte verso sinistra          */

     n=0;    
     while ((loc_x()>80)&&(!scan(180,5))) /*Sinistra; le operazioni sono le */
                                          /*stesse di prima (e quindi evito */
                                          /*di commentarle); gli angoli sono*/ 
                                          /*ovviamente ruotati rispetto alla*/
                                          /*parte precedente.               */
         {drive(180,100) ;    
          range=scan(x=270+(n%20)*5,5);
          if (range!=0) 
             {cannon(x,range-45);
              while((range=scan(x,5))&&(loc_x()>80)) 
                  {cannon(x+6,range-45);
                   drive(180,100);
                  }
              }
          n+=1;
         }
     drive(270,0);
     while (speed()>50); 
     drive(270,100);
     
     n=0;
     while ((loc_y()>80)&&(!scan(270,5))) /* Gi—. */
         {drive(270,100);    
          range=scan(x=(n%20)*5,5);
          if (range!=0) 
             {cannon(x,range-45);
              while((range=scan(x,5))&&(loc_y()>80)) 
                  {cannon(x+6,range-45);
                   drive(270,100);
                  }
              }          
          n+=1;
         }
     drive(0,0);
     while (speed()>50); 
     drive(0,100);
    
     n=0;
     while ((loc_x()<920)&&(!scan(0,5))) /* Destra. */
         {drive(0,100);    
          range=scan(x=90+(n%20)*5,5);
          if (range!=0) 
             {cannon(x,range-45);
              while((range=scan(x,5))&&(loc_x()<920)) 
                  {cannon(x+6,range-45);
                   drive(0,100);
                  }
             }
          n+=1;
         }
     drive(90,0);
     while (speed()>50); 
     drive(90,100);
   }    
  } /* Fine del main */
