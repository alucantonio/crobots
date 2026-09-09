/*---------------------------------------------------------------------------
        
        Nome   : Aleph.r
        
        Autori    :  Marco Pranzo  (18-11-74)
                  :  Luca Pranzo   (04-05-76)


---------------------------- SCHEDA  TECNICA --------------------------------
 
  Aleph  all'inzio  della partita  si posiziona nell'angolo  di Nord-Est,  e 
  resta  fermo,  fino a  quando  non  viene  colpito,  in  tal  caso  scappa 
  in un altro angolo  eseguendo un  movimento  a  zigzag.  Se  non  riesce a 
  trovare  nemici a portata di sparo, e  se non Š stato  troppo danneggiato, 
  dopo un certo lasso di tempo  Aleph  si muove cambiando angolo cercando di 
  evitare che lo scontro finisca in parit….
  Da fermo effettua due rilevamenti ed usa varie strategie di fuoco cercando
  di riconoscere  i robot  vicini,  fermi,  pendoli  e quelli  in movimento. 
  Quando Š in movimento Aleph spara sul semplice rilevamento di 21 gradi.
  Tecnicamente  Aleph  Š stato  scritto  in maniera tale da  ottimizzare  la 
  frequnza di fuoco  da fermo. 
  
  Nel caso debba combattere un solo robot preferiamo far combattere Aleph.

----------------------------------------------------------------------------*/

int
 dist1,dist2,df,range,        /* Distanze di rilevamento e fuoco */
 angolo,ang,rilev,angdx,angsx,/* Angoli di rilevamento           */
 oldang,olddist,pendolo,      /* Riconoscimento pendoli          */
 direz,corner,                /* Posizione angolare              */
 orario,timer,distmax,danno;  /* Variabili di comportamento      */ 
           
main()
{          
/* Posizionamento iniziale */        
        direz=atan(100000*(900-loc_y())/(900-loc_x()));
        drive(direz,100);
        while ((loc_x()<850)||(loc_y()<850)) attacca();
        drive(direz,0);
        while (speed()>0) attacca();
/* Inizializzazione */
        corner=180; 
        angolo=173; 
        timer=0;
        distmax=740;
        danno=damage();

 while(1) 
 {
/* Controllo la presenza del nemico */
  if ( ((rilev = scan(angolo,10))==0)||(rilev>distmax) ) 
    {
/* Cerca il nemico */      
      if (angolo >= 98+corner)  
        {
         angolo=corner+353;
         angolo%=360;
        }
      else angolo+=21;
      if (++timer > 1500) 
        {
/* Cambio strategia */
         distmax=2000;
         if (damage() < 90) 
          { 
           orario=0;
           cambia();
          }
        }
    }
  else
    {
/* Riduzione da 21 a 7 gradi */
      angdx = scan(angolo+356,7);
      angsx = scan(angolo+4,7);
      if (angdx && angsx) angolo+=0+0;
      else if (angdx) angolo += 353;
           else       angolo += 7+0; 
/* Prima acquisizione della distanza */
      if (dist1=scan(angolo,3))    
       {
         pendolo = (8 > sqrt(olddist-dist1)); 
/* Riduzione da 7 a 1 grado */
         if (scan(angolo+357,1)) angolo+=357; else 0+0+0;
         if (scan(angolo+3,1))   angolo+=3;   else 0+0+0;
         if (scan(angolo+359,0)) angolo+=359; else 0+0+0;
         if (scan(angolo+1,0))   angolo+=1;   else 0+0+0;
/* Seconda acquisizione della distanza */
         if (dist2=scan(angolo,6))
          {
/* Controllo nemico molto vicino */
           if (dist2<250) 
            {
/* Sparo nemico vicino */
             cannon(angolo,scan(angolo,6));
            }
           else
            {
/* Controllo nemico pendolo o fermo */
             if (pendolo) 
              {  
/* Sparo nemico fermo */
               if (dist1==dist2) cannon(angolo,dist2);
/* Sparo contro nemico pendolo */
               else cannon(oldang,dist1);
              }
             else
              {
/* Sparo contro nemico in movimento */
               df=(350*dist2-100*dist1)/(250+dist1-dist2);
               cannon(angolo,df);  
              }
            }
/* Memoria */
           angolo %= 360;
           oldang = angolo;
           olddist = dist1;
/* Controllo sul danno */
           if (damage()!=danno) cambia();
/* Cerco la via di fuga migliore */
           if (distmax==2000) 
             {
              timer+=50;
/* Cambia strategia */
              if (timer > 1500) if (damage() < 90) cambia();
              sin(0);sin(0);sin(0);
              sin(0);sin(0);sin(0);
              0;
             }
           else 
             { 
              if ( (scan(corner+3 ,10)+scan(corner+24,10)) 
                   > (scan(corner+87,10)+scan(corner+66,10)) )
                     orario=1;
              else orario=0+0;
              timer = 0;
             }
/* Delay comune di ricarica */ 
           0+0+0+0;
        }
       }
    }
/* Controllo sul danno */    
  if (damage()!=danno) cambia();
 }
}/* end main */

cambia()
{
/* Senso di percorrenza */  
  if (orario) {corner+=90;corner%=360;}
/* Accende i motori */
  drive(corner,50);
/* Finche non arriva... */
 if (corner==0)   while (loc_x()<825) 
                  { 
                   zig();
                   delay=0+0+0;
                   zag();
                  }
 if (corner==90)  while (loc_y()<825)
                  { 
                   zig();
                   delay=0+0+0;
                   zag();
                  }
 if (corner==180) while (loc_x()>175)
                  { 
                   zig();
                   delay=0+0+0;
                   zag();
                  }
 if (corner==270) while(loc_y()>175)
                  { 
                   zig();
                   delay=0+0+0;
                   zag();
                  }
/* Frena */
  drive(corner,0);
/* Finche non Š fermo ... */
  while (speed()>0) attacca();
/* Inizializzazione */
  if (orario) corner+=180;
  else corner+=90; 
  corner%=360; 
  angolo=corner+353;
  angolo%=360;
  timer=0;    
  danno=damage();
}/* fine cambia */

zig() 
{
  drive(corner+45,100); 
  while(speed()<100) attacca();
  drive(corner+45,0);
  while(speed()>49) attacca();
}

zag()
{
  drive(corner+315,100); 
  while(speed()<100) attacca();
  drive(corner+315,0);
  while(speed()>49) attacca();
}

attacca()
/* Routine di sparo in movimento */
{
 if (range=scan(ang,10)) cannon(ang,range);
 else  ang=ang+21+0;
}
