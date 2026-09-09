/*---------------------------------------------------------------------------
        
        Nome   : CAMILLO  -- robot tranquillo --  
        
        Autore    :  Marco Pranzo

-----------------------------------------------------------------------------
   
          Camillo  adotta una strategia  molto  semplice:  all'inizio
        della partita  si  dirige  nell'angolo  Nord-Est  e lç rimane
        per  tutta la  durata della  partita, solo  in caso  di danno 
        decide di cambiare angolo.
          Per lo sparo  vengono adottate tre strategie di fuoco : due 
        da fermo ed una per il fuoco in movimento.
          Da fermo  il robot spazza l'arena  con uno scan di 21 gradi 
        riducendo l'ampiezza  prima a 7 gradi  e poi a 0 gradi;  dopo 
        aver esguito  due  puntamenti precisi  Camillo ä  in grado di 
        stabilire se  il  suo  avversario  ä  fermo  o  in movimento, 
        decidendo di eseguire una delle due strategie di fuoco.
          Per  il  fuoco  in  movimento, invece,  esegue uno scan  di 
        ampiezza 5 gradi sparando sul rilevamento.

---------------------------------------------------------------------------*/

int 
  ang, ang1, ang2,         /* Angolo dell'avversario */
  ric1, ric2,              /* Ausiliarie di puntamento */
  ciclo,                   /* Contatore del cerca a 360¯ */
  range,                   /* Range di fuoco */
  direz,                   /* Direzione inziale */
  dist, dist1, dist2,      /* Distanza dell'avversario */
  dannomax,                /* Limite di danno prima della fuga */
  uscita,                  /* Booleano di controllo sparo contro fermo */
  sottomira,               /* Booleano di memoria */
  angolo;                  /* Posizione angolare del robot */

/*-------------------------------------------------------------------------*/
main()
{  
/* Inizializzazione pre ciclo */     
        drive(direz=atan(100000*(980-loc_y())/(980-loc_x())),100);
        while ((loc_x()<950)||(loc_y()<950)) corsa();
        drive(direz,0);
        while (speed()>0) corsa();
        angolo=180;
        dannomax=20;
/* CICLO DI COMBATTIMENTO */
while (1)     
 {
        /* Se mi sono fatto male cambio angolo */
        if (damage()>dannomax) cambia();       
        /* Attacca */
        combat();
 }                                           
}/* fine main */
/*-------------------------------------------------------------------------*/

/* COMBAT------------------------------------------------------------------*/
combat()    
{  
   /* se vedi qualcuno... */
  if (sottomira) 
   /* ... primo target ...*/
   {
    ang=ang2; 
    target7(); 
    dist1=dist;
    ang1=ang;
   }
   /* ... altrimenti cercalo */
  else cerca();
  if (!sottomira) return;
/* Secondo targetting */ 
 ang=ang1;  
 target7();
 dist2=dist;
 ang2=ang;  
 if (!sottomira) return;
/* Riconoscimento */
 if (dist1==dist2)  
  { /* SPARO CONTRO FERMO */
       cannon(ang2,dist2);                                
       uscita=1;
       range=dist2;
        /* spara fino a che non si sposta */ 
       while (uscita)  
        {
         if ((scan(ang2,0)!=range)||(range>700)||(damage()>dannomax)) uscita=0;
         while (!cannon(ang2,range)) ;
        }
  }
 else 
  { /* SPARO CONTRO MOVIMENTO */
  /* Se si allontana... */ 
   if (dist2>dist1) range=2*dist2-dist1+dist2/6;
  /* ... se si avvicina... */
   else range=2*dist2-dist1-dist2/10;
  /* ... comunque: Fuoco! */     
   if ( range > 50 ) cannon(ang2+(ang2-ang1)*3,range);
   else cannon(ang2+(ang2-ang1)*3,50);    
  }
}/* fine combat */
/*-------------------------------------------------------------------------*/
                                                                           
/* CAMBIA ANGOLO-----------------------------------------------------------*/
cambia()
{
/* accende i motori */
  drive(angolo,100);
/* finche non arriva... */
  if (angolo==0) while (loc_x()<950) corsa();
  else if (angolo==90) while (loc_y()<950) corsa();
  else if (angolo==180) while (loc_x()>50) corsa();
  else while(loc_y()>50) corsa();
/* frena */
  drive(angolo,0);
/* finche non ä fermo ... */
  while (speed()>0) corsa();
/* setta l'angolo */
  angolo+=90;
  angolo%=360;
/* Inizializzazione da fermo */   
  sottomira=0;
  dannomax=damage()+20; 
}/* fine cambia */
/*-------------------------------------------------------------------------*/

/* FUOCO IN MOVIMENTO------------------------------------------------------*/ 
corsa()
{
 if ((dist=scan(ang,2))&&(dist>50)) cannon(ang,dist);
 else ang+=5;
}/* fine corsa */
/*-------------------------------------------------------------------------*/

/* CERCA-------------------------------------------------------------------*/
cerca()
{
/* Cerca 360¯ */
        ang1=angolo-10;
        ciclo=0;
        while (!( ( ric1>0 ) && ( ric1<700 ) ) )
         { 
           ang1+=21;
           ric1=scan(ang1,10);
           ciclo+=21;
           if (ciclo>360) {range=800;return;}
         };
        sottomira=1;
/* Primo targetting */         
        ric1=scan(ang1-4,7);
        ric2=scan(ang1+4,7);
        if ( (ric1>0) && (ric2>0) )
               { 
                ang=ang1; 
                target7(); 
                dist1=dist;
                ang1=ang;  
               }   
        else  if  (ric1>0)  
               { 
                ang=ang1-7; 
                target7(); 
                dist1=dist;
                ang1=ang; 
               }
        else  if (ric2>0)  
                { 
                 ang=ang1+7; 
                 target7(); 
                 dist1=dist;
                 ang1=ang;
                }
        else sottomira=0;
}/* fine cerca */                                       
/*-------------------------------------------------------------------------*/
                                                                           
/* PUNTAMENTO--------------------------------------------------------------*/
target7()
{
   if (dist=scan(ang+4,1)) ang=ang+3;
   else if (dist=scan(ang-4,1)) ang=ang-3;
   else if (dist=scan(ang+3,1)) ang=ang+2;
   else if (dist=scan(ang-3,1)) ang=ang-2;
   else if (dist=scan(ang+2,1)) ang=ang+1; 
   else if (dist=scan(ang-2,1)) ang=ang-1; 
   else if (dist=scan(ang,1)) ; 
   else sottomira=0;  /* perso */
}/* fine target7 */
/*-------------------------------------------------------------------------*/
