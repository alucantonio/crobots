/* ------------------ K I L L ! . R ----------------------------

   Autore:      Turino Andrea


   SCHEDA TECNICA DEL ROBOT:
   Il robot fa una rapida scansione delle quattro direzioni e si porta
   nell'angolo che al momento sembra il pi— tranquillo.
   Giunto all'angolo, si muove descrivendo un quadrato.
   Lo sparo si basa sulla bisezione (come in !.r), individua cioŠ 
   un range di 20ø in cui Š situato il robot da colpire (sostanzialmente
   uguale alla parte iniziale della routine fuoco di !.r) e poi ripete
   la ricerca all'interno di questi 20ø a passi di 4ø. Non si usa nessuna
   correzione n‚ sulla distanza, n‚ sulla direzione. Vi Š inoltre un'unica
   routine di sparo per tutte le fasi del gioco.
   Passati circa 70000 cicli di CPU, il robot inizia (se i danni sono
   inferiori a 90%) la fase finale, si muove cioŠ seguendo i lati di un
   rombo inscritto nel quadrato di battaglia.

   VARIABILI GLOBALI:
   _rob: direzione dell'ultimo sparo (cioŠ il robot trovato)
   _ango: angolo in cui Š situato il robot:
                1====> alto a destra
                2====> alto a sinistra
                3====> basso a sinistra
                4====> basso a destra

   VARIABILI DEL MAIN:
   _time:       contatore del numero di volte che il robot ha compiuto un
                quadrato. Quando raggiunge il valore 40 (circa 70000 cicli)
                inizia la fase di attacco.
   _nord
   _sud
   _ovest
   _est:        indicano quanti robot sono presenti in queste coordinate.
                Servono per stabilire l'angolo migliore verso cui muoversi
*/

int rob, ango;

main()
{
   int time, nord, sud, ovest, est;

/* INIZIALIZZAZIONI    */
   time=40;
   nord=sud=ovest=est=0;
   ango=1;
/* CONTROLLO DELLE DIREZIONI */
   if (scan(180,10))
      ovest+=1;
   if (scan(0,10))
      est+=1;
   if (scan(90,10))
      nord+=1;
   if (scan(270,10))
      sud+=1;
   if (scan(135,10))
   {
      ovest+=1;
      nord+=1;
   }
   if (scan(225,10))
   {
      ovest+=1;
      sud+=1;
   }
   if (scan(45,10))
   {
      est+=1;
      nord+=1;
   }
   if (scan(315,10))
   {
      est+=1;
      sud+=1;
   }

/* SCELTA DELL'ANGOLO PIU' SICURO  */
   if (ovest<est)
   {
      while(loc_x()>150)           
      {                                
         sp();                         
         drive(180,100);
      }
      ango=2;
   }
   else
      while(loc_x()<850)           
      {                                
         sp();                         
         drive(0,100);
      }
   if (nord<sud)
   {
      if (ango!=2)
         ango=1;
      while(loc_y()<850)           
      {                                
         sp();                         
         drive(90,100);
      }
   }
   else
   {
      if (ango==2)
         ango=3;
      else
         ango=4;
      while(loc_y()>150)           
      {                                
         sp();                         
         drive(270,100);
      }
   }

/* CICLO PRINCIPALE  */
   while(1)
   {
      if (time<=0)
         if(damage()<90)
            gira();
      oscilla(); 
      time-=1;
   }
}

oscilla()
{
    if (ango==2 || ango==1)
       while(loc_y()>859)
       {
          sp();
          drive(270,100);
       }
    else
       while(loc_y()>159)
       {
          sp();
          drive(270,100);
       }
    if (ango==2 || ango==3)
       while(loc_x()<180)
       {
         sp();
         drive(0,100);
       }
    else
       while(loc_x()<850)
       {
         sp();
         drive(0,100);
       }
    if (ango==1 || ango==2)
       while(loc_y()<860)
       {
          sp();
          drive(90,180);
       }
    else
       while(loc_y()<160)
       {
          sp();
          drive(90,180);
       }
    if (ango==2 || ango==3)
       while(loc_x()>189)
       {
          sp();
          drive(180,100);
       }
    else
       while(loc_x()>859)
       {
          sp();
          drive(180,100);
       }
}

                      
gira()
{
   int hlim, llim, time;

   llim=150;
   hlim=850;
   time=10;
   if (ango==1)
      while (loc_y()>550)
      {
         drive(270,100);
         sp();
      }
   else
      if (ango==2)
         while (loc_x()<450)
         {
            drive(0,100);
            sp();
         }
      else
         if (ango==3)
            while (loc_y()<450)
            {
               drive(90,100);
               sp();
            }
         else
              while (loc_x()>550)
              {
                 drive(180,100);
                 sp();
              }
/* ATTACCO FINALE  */
   while(1)   
   {
       while(loc_y()<hlim && ango<=1)
       {
          drive(135,100);
          sp();      
       }
       while(loc_x()>llim && ango<=2)
       {
          drive(225,100);
          sp();
       }
       while(loc_y()>llim && ango<=3)
       {
          drive(315,100);
          sp();
       }
       while(loc_x()<hlim && ango<=4)
       {
          drive(45,100);
          sp();
       }
       ango=0;
   }
}

int sp()
{  int x;

   if (!scan(rob,10))
      if (!scan(rob-=20,10))
         if (!scan(rob+=40,10)) { rob+=40; return 0; }
   if (x=scan(rob,2))
   {
      cannon(rob,x);
      cannon(rob,x);
      if (x>800)
         rob+=40;
      return(x);
   }
   if (x=scan(rob+=4,2))
   {
      cannon(rob,x);
      cannon(rob,x);
      if (x>800)
         rob+=40;
      return(x);
   }
   if (x=scan(rob+=4,2))
   {
      cannon(rob,x);
      cannon(rob,x);
      if (x>800)
         rob+=40;
      return(x);
   }
   if (x=scan(rob-=12,2))
   {
      cannon(rob,x);
      cannon(rob,x);
      if (x>800)
         rob+=40;
      return(x);
   }
   if (x=scan(rob-=4,2))
   {
      cannon(rob,x);
      cannon(rob,x);
      if (x>800)
         rob+=40;
      return(x);
   }
} 


