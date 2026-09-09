/**************************************************************************/
/***   DIABLO.R  ( Crobot per il Quinto Torneo di MCmicrocomputer )     ***/
/***                                                                    ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  24.06.1995   ( su aiuto e sprone di Marco Pranzo )  ***/
/***   Revisione :  05.09.1995                                          ***/
/**************************************************************************/

/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/** DIABLO.R e' un crobot che come arma di difesa preferisce la velocita'**/
/** alla precisione di tiro : rotea, infatti in senso orario lungo il    **/
/** il campo di battaglia sparando con precisione +-1 grado a chiunque   **/
/** gli capiti a tiro; la novita' sta nella procedura di scan che consta **/
/** di 4 fasi successive di ricerca a precisione variabile.              **/
/**                                                                      **/
/** Lo scan, infatti, e' effettuato contemporaneamente alla destra e alla**/
/** sinistra del crobot finche' qualche nemico viene avvistato: a questo **/
/** punto si cerca di non perdere mai di vista il bersaglio variando di  **/
/** volta in volta la fase e dunque la precisione di ricerca dei due     **/
/** scanner simmetrici. La procedura attiva il cannone solo a precisione **/
/** +-1 grado, a mio avviso piu' che sufficiente per provocare danni     **/
/** ingenti senza alcun tipo di correzione.                              **/
/**************************************************************************/

int scan1, scan2, centro;
int rangefuoco;
int fase;
int dir;

main ()
{
   /* --- Preparazione variabili --- */
   centro = 360;
   scan1 = scan2 = centro;
   fase = 0;

   /* --- Posizionamento sul lato piu' vicino --- */
   sistemati();

      /*** ---  Inizia la battaglia ... --- ***/
   while (1) {
      gira();
   }  /*** --- "Until the end of world" --- ***/
}

cerca_e_spara()
{
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
      if (rangefuoco=scan(scan1, 1)) {
	 centro=scan1;
      } else {
	 if (rangefuoco=scan(scan2, 1)) {
	    centro=scan2;
	 } else {
	    scan1-=3;
	    scan2+=3;
	    --fase;
	    return(0); 
	 }
      };

      /* --- Fuoco !!! --- */
      cannon(centro, rangefuoco);


      scan1=scan2=centro;            /* --- Sistemo gli scanner --- */
      if (!speed()) drive(dir, 100); /* --- Se ho urtato il muro riparto --- */
   }
}

gira()
{
   if (dir==0) dir=270; else dir -=90;

   drive(dir, 100);
   if (dir== 0) while (loc_x() < 910) cerca_e_spara();
   else if (dir==90) while (loc_y() < 910) cerca_e_spara();
   else if (dir==180) while (loc_x() > 90) cerca_e_spara();
   else if (dir==270) while (loc_y() > 90) cerca_e_spara();

   drive(dir, 0);
   while (speed()>50) cerca_e_spara();
}

sistemati()
{
   if (loc_y()<500) {
      drive(270, 100);
      while((loc_y()>90) && speed()) cerca_e_spara();
      drive(270, 0);
      while (speed()>50) cerca_e_spara();
      dir = 270;
   } else {
      drive(90, 100);
      while((loc_y()<910) && speed()) cerca_e_spara();
      drive(90, 0);
      while (speed()>50) cerca_e_spara();
      dir = 90;
   }
}
