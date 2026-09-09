
/*                              Rambo.r                                    */
/*       scritto da: 
   
         Daniele Scopelliti 

*/

int ang, direction;
main()
{
   drive(0,100);
   while(loc_x()<960) fire();  /* si sposta verso il lato destro del campo */
   drive(90,0);                /* ad alta velocit… sparando                */
   while(speed()>49) fire();

   ang=270;
   
   drive(90,100);              /* si porta nell'angolo in alto           */
   while(loc_y()<960) fire();  /* a destra del campo di battaglia        */
   drive(180,0);
   while(speed() > 49) fire();
   
   while(1)
   {
        ang=185;direction=1;           /* si porta nell'angolo in alto  */
        drive(180,100);                /* a sinistra                    */
        while(loc_x()>40) fire1();
        drive(270,0);

        while(speed() > 49) fire1();
        
        ang=275;direction=1;           /* si porta nell'angolo in basso  */
        drive(270,100);                /* a sinistra                     */
        while(loc_y()>40) fire2();
        drive(360,0);

        while(speed() > 49) fire2();

        ang=5;direction=1;            /* si porta nell'angolo in basso  */
        drive(360,100);               /* a destra                       */
        while(loc_x()<960) fire3();
        drive(90,0);
        
        while(speed()>49) fire3();
        
        ang=95;direction=1;           /* si porta nell'angolo in alto  */
        drive(90,100);                /* a destra                      */
        while(loc_y()<920) fire4();
        drive(180,0);

        while(speed() > 49) fire4();

   }


}

fire()                        
{                             
   int range;

   if(range=scan(ang,10))   /* se Š presente un bersaglio */
       cannon(ang,range);   /* spara                      */
   else                     /* altrimenti                 */
   {                        /* scandisce la zona tra 270ø e 90ø  */
      ang-=20;              /* con passo 20ø                     */
      if(ang<=70) ang=270;
   }
}


fire1()
{
   int range;               

   if(range=scan(ang,10))  /* se Š presente un bersaglio */
       cannon(ang,range);  /* spara                      */
   else                    /* altrimenti                 */
   {
    if (direction==1)      /* scandisce la zona tra 180ø e 0ø  */
      {ang+=20;            /* con passo 20ø in entrambe le direzioni */
       if (ang>=365) 
          {ang=355;
           direction=0;
          };
      }
     else
      {ang-=20;
       if (ang<=175)
          {ang=185;
           direction=1;
          };
      };
   };

}

fire2()
{
   int range;

   if(range=scan(ang,10))     /* se Š presente un bersaglio */
       cannon(ang,range);     /* spara                      */
   else                       /* altrimenti                 */
   {
    if (direction==1)         /* scandisce la zona tra 270ø e 90ø  */
      {ang+=20;               /* con passo 20ø in entrambe le direzioni */
       if (ang>=455) 
          {ang=445;
           direction=0;
          };
      }
     else
      {ang-=20;
       if (ang<=265)
          {ang=275;
           direction=1;
          };
      };
   };

}

fire3()                     
{                           
   int range;

   if(range=scan(ang,10))   /* se Š presente un bersaglio */
       cannon(ang,range);   /* spara                      */
   else                     /* altrimenti                 */
   {
    if (direction==1)       /* scandisce la zona tra 0ø e 180ø  */
      {ang+=20;             /* con passo 20ø in entrambe le direzioni */
       if (ang>=185) 
          {ang=175;
           direction=0;
          };
      }
     else
      {ang-=20;
       if (ang<=-5)
          {ang=5;
           direction=1;
          };
      };
   };

}


fire4()
{
   int range;

   if(range=scan(ang,10))    /* se Š presente un bersaglio */ 
       cannon(ang,range);    /* spara                      */
   else                      /* altrimenti                 */
   {
    if (direction==1)       /* scandisce la zona tra 90ø e 270ø  */
      {ang+=20;             /* con passo 20ø in entrambe le direzioni */
       if (ang>=275) 
          {ang=265;
           direction=0;
          };
      }
     else
      {ang-=20;
       if (ang<=85)
          {ang=95;
           direction=1;
          };
      };
   };

}











