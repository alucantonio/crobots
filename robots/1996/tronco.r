/*---------------------------------------------------------------------------
        
        Nome   :  TRONCO.r   ( Tronco Cionco - Ver 2.1 )
        
        Autori    :  Marco Pranzo
                  :  Luca Pranzo


--------------------- SCHEDA  (non troppo)  TECNICA --------------------------
 
 * Ciao Marco! 
 - Ciao Luca. 
 * Che bel robot, come si chiama?
 - Tronco Cionco.
 * Che nome ridicolo. PerchŠ si chiama cos?
 - PerchŠ non si muove mai, Š come un albero. A dir la verit… volevo 
   chiamarlo Luca... 
 * Simpatico... Quali sono le sue altre caratteristiche?
 - Esegue una scansione inziale di 21 gradi riducendola fino ad 1 grado, 
   adotta strategie di fuoco diversificate contro nemici fermi, con sparo 
   immediato, e contro nemici in movimento con un secondo rilevamento 
   per prevedere dove sparare.
 * Ha dei punti deboli?
 - Si, non si muove MAI.
 * Ma allora fa proprio schifo! E' inutile mandarlo. Secondo me arriva ultimo.
 - Pure per me...


 Nel caso debba combattere un solo robot preferiamo far combattere Aleph. 
----------------------------------------------------------------------------*/

int
 dist1,dist2, /* Distanze di rilevamento          */
 Dd,          /* Delta delle distanze             */
 angolo,      /* Angolo di rilevamento del nemico */
 df,          /* Distanza di fuoco                */
 corrang,     /* Correzione angolare              */
 sx,          /* Flag di correzione angolare      */
 rilev,       /* Controllo per la ricerca         */
 angdx,angsx, /* Ausiliarie di ricerca            */ 
 delay;       /* Ciclo di ritardo per la ricarica */  

main()
{
 while(1) 
 {
/* Controllo della presenza del nemico */
  rilev=scan(angolo,10);
  if ( (rilev==0)||(rilev>740) ) 
    {
      angolo+=21; 
    }
  else
    {
      if (!scan(angolo,3))
       {
/* Riduzione da 21 a 7 gradi */
         angdx=scan(angolo-4,7);
         angsx=scan(angolo+4,7);
         if (angdx>0)  angolo -= 7;
         if (angsx>0)  angolo += 7;
       }
      else
       {
/* Riduzione da 7 a 1 grado */
         if (scan(angolo-3,1)) angolo-=3;
         if (scan(angolo+3,1)) angolo+=3;
         if (scan(angolo-1,0)) angolo-=1;
         if (scan(angolo+1,0)) angolo+=1;
/* Prima acquisizione della distanza */
         dist1=scan(angolo,8);
/* Controllo la presenza del nemico */     
         if (dist1)      
          {
           sx=0;
           0+0+0;
/* Check nemico fermo */
           if (dist1==scan(angolo,0)) 
            {
/* Sparo contro nemico fermo */
             cannon(angolo,dist1);
/* Delay di ricarica */
             delay=0;while(delay<7) ++delay;
             sin(0+0+0+0+0);
            }
           else 
            {
             0;
/* Sparo contro nemico in movimento */
/* Seconda acquisizione della distanza */
             dist2 = scan(angolo,8);
/* Calcolo dove sparer• */
             sin(0);      
             Dd = dist2-dist1;     
             df= ((dist1*208+80000)*Dd+dist1*20336+185000)/20000;
             if (scan(angolo+3,0)) sx=1;
             else sx=1-2;
             if ((Dd<-12)||(Dd>12))  
                corrang=( (356360000-1810000*Dd*Dd)/dist1
                       + (712720-3636*Dd*Dd) )/40000+0;
             else
                corrang=( (316666*(Dd+24)*(16-Dd))/dist1
                       + (1206*(Dd+16)*(17-Dd)) )/40000;
/* Fuoco! */ 
               cannon(angolo+sx*corrang,df);
             }
           angolo+=sx*corrang;
/* Delay comune di ricarica */
           sin(0);sin(0);
           sin(0);sin(0);      
           sin(0);sin(0);      
          }  
       }
    } 
 }
}
