/**************************************************************************/
/***   TRICKY.R     " Tricky Ricky "                                    ***/
/***                ( Crobot per il Quinto Torneo di MCmicrocomputer )  ***/
/***                                                                    ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  22.09.1995    ( su idea di Riccardo Caruso )        ***/
/***   Revisione :  25.09.1995                                          ***/
/**************************************************************************/

/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/** TRICKY.R e' un crobot molto attento alla propria tattica che prefe-  **/
/** risce la velocita' alla precisione di tiro.                          **/
/** Dapprima fa tre giri a rombo con uno scan preciso (a 0 gradi) che    **/
/** utilizza due scanner simmetrici a precisione variabile in modo da    **/
/** seguire il piu' possibile il bersaglio pur evitando gli scontri      **/
/** corpo a corpo mentre i nemici diminuiscono.                          **/
/** Poi passa ad un movimento ad ottagono (piu' largo del rombo ma meno  **/
/** prevedibile del quadrato) con uno scan molto elementare a precisione **/
/** 7 gradi, visto che probabilmente anche il nemico e' in movimento;    **/
/** se subisce forti danni e' probabile che il suo nemico utilizzi una   **/
/** strategia migliore, dunque si ferma e spera nel pareggio.            **/
/**************************************************************************/

int scan1, scan2, centro;
int rangefuoco, primorange;
int fase;
int giri;

main ()
{
   /* --- Preparazione variabili --- */
   scan1 = scan2 = centro = 360;
   fase = 0;
   giri = 0;

   /* --- Posizionamento sul lato iniziale --- */
   sistemati();

      /*** ---  Inizia la battaglia ... --- ***/
   while (1) {
      gira();
   }  /*** --- "Until the end of world" --- ***/
}

cerca_e_spara()
{
   if (scan1<0) scan1+=360;   /* --- Serve ad evitare il cambio di segno --- */

   if (fase==0) {   
      /* --- Scan su 21 gradi --- */  
      if (scan(scan1, 10)) {
	 centro=scan1;      /* --- Cerco da una parte ... --- */
      } else {
	 if (scan(scan2, 10)) {
	    centro=scan2;   /* --- ... cerco dall'altra --- */
	 } else {
	    scan1-=21;
	    scan2+=21;
	    return(0);      /* --- Continuo a cercare --- */
	 };
      };
      scan1=centro-5;    /* --- Metto gli scanner in posizione --- */
      scan2=centro+5;    /* --- e mi preparo alla fase successiva --- */
      ++fase;
   };

   if (fase==1) {
      /* --- Scan su 13 gradi --- */
      if (scan(scan1, 6)) {
	 centro=scan1;
      } else {
	 if (scan(scan2, 6)) {
	    centro=scan2;
	 } else {
	    scan1-=7;       /* ---   Ero all'estremo dell'angolo   --- */  
	    scan2+=7;       /* --- dunque diminuisco la precisione --- */ 
	    --fase;
	    return(0);      
	 };
      };
      scan1=centro-3;    /* --- Tutto OK, si va avanti --- */
      scan2=centro+3;
      ++fase;
   };

   if (fase==2) {
      /* --- Scan su 7 gradi --- */
      if (scan(scan1, 3)) {
	 centro=scan1;
      } else {
	 if (scan(scan2, 3)) {
	    centro=scan2;
	 } else {
	    scan1-=4;
	    scan2+=4;
	    --fase;
	    return(0);   
	 };
      };
      scan1=centro-2;
      scan2=centro+2;
      ++fase;
   };

   if (fase==3) {
      /* --- Scan su 3 gradi --- */
      /* --- Arriva il momento della verita' ... --- */
      if (primorange=scan(scan1, 1)) {
	 if (rangefuoco=scan(scan1-1, 0)) 
	    cannon(scan1-1, rangefuoco);    /* ---  Tipo preciso  --- */
	 else cannon(scan1, primorange);    /* --- (se possibile) --- */
	 centro=scan1;
      } else {
	 if (primorange=scan(scan2, 1)) {
	    if (rangefuoco=scan(scan2+1, 0)) 
	       cannon(scan2+1, rangefuoco);
	    else cannon(scan2, primorange);
	    centro=scan2;
	 } else {
	    scan1-=7;
	    scan2+=7;
	    fase=1;
	    return(0);
	 }
      };

      if (rangefuoco>800) {     /* --- Sistemo gli scanner --- */
	 scan1=centro+19;
	 scan2=centro-19;       /* --- Incrocio gli angoli --- */
	 fase = 0;
      } else {
	 scan1=centro-1;        
	 scan2=centro+1;
      }
   }
}

blind_fire()
{
   if (damage()>89) drive(0, 0);   /* --- Mi fermo e miro al pareggio --- */
   
   if (rangefuoco=scan(centro,7)) {
      cannon(centro,rangefuoco);
      cannon(centro,rangefuoco);
      centro-=25;
   } else centro+=14;
}

gira()
{
   if (giri>=3) tricky();   /* --- Go Ricky ! Become Tricky ! --- */
   else ricky();
}
   
ricky()     /* --- Movimento a rombo --- */
{
   drive(315,100); while(loc_x()<900) cerca_e_spara();   
   drive(315,0);   while(speed()>49)  cerca_e_spara();
   drive(225,100); while(loc_y()>100) cerca_e_spara();
   drive(225,0);   while(speed()>49)  cerca_e_spara();
   drive(135,100); while(loc_x()>100) cerca_e_spara();
   drive(135,0);   while(speed()>49)  cerca_e_spara();
   drive(45,100);  while(loc_y()<900) cerca_e_spara();
   drive(45,0);    while(speed()>49)  cerca_e_spara();
   ++giri;
}

tricky()     /* --- Movimento ad ottagono --- */
{
   drive(0, 100);  while(loc_x()<600) blind_fire();
   drive(0, 0);    while(speed()>49)  blind_fire();
   drive(315,100); while(loc_x()<900) blind_fire();
   drive(315,0);   while(speed()>49)  blind_fire();
   drive(270,100); while(loc_y()>400) blind_fire();
   drive(270, 0);  while(speed()>49)  blind_fire();
   drive(225,100); while(loc_y()>100) blind_fire();
   drive(225,0);   while(speed()>49)  blind_fire();
   drive(180,100); while(loc_x()>400) blind_fire();
   drive(180, 0);  while(speed()>49)  blind_fire();
   drive(135,100); while(loc_x()>100) blind_fire();
   drive(135,0);   while(speed()>49)  blind_fire();
   drive(90, 100); while(loc_y()<600) blind_fire();
   drive(90, 0);   while(speed()>49)  blind_fire();
   drive(45,100);  while(loc_y()<900) blind_fire();
   drive(45,0);    while(speed()>49)  blind_fire();
}

sistemati()
{
   if (loc_x()<450) {
      drive(0,100);
      while (loc_x()<450) cerca_e_spara();
      drive(0,0);
   } else
   if (loc_x()>550) {
      drive(180,100);
      while (loc_x()>550) cerca_e_spara();
      drive(180,0);
   };

   while (speed()>49)  cerca_e_spara(); drive(90,100);
   while (loc_y()<900) cerca_e_spara(); drive(90,0);
   while (speed()>49);
}
