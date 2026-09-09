/* ------------------------------------------------------------ */
/*  Robot:           Vocus                                      */
/*  Ultima release:  30/09/93                                   */
/*  Autore:          Davide Tretene                             */
/*                                                              */
/*  Note: Attualmente frequento il 5ø anno di informatica       */
/*        all' I.T.I.S. Pacinotti di Roma.                      */
/*          Ho partecipato gia' al torneo di MC di Crobots      */
/*        dello scorso anno (92) classificandomi al nono        */
/*        posto della classifica finale con il robot Phobos_1.  */
/*          Questo nuovo robot e' stato sviluppato nel mese di  */
/*        settembre su un PC-286/16Mhz ed ho potuto effettuare  */
/*        un numero molto basso di test rispetto alle mie       */
/*        previsioni, sia per la lentezza (relativa) del mio    */
/*        computer, sia perche' ero intento a creare due robot: */
/*                                                              */
/*        VOCUS.r e PHOBOS_2.r                                  */
/*                                                              */
/*          Per informazioni sul funzionamento del robot        */
/*        potete leggere il file associato VOCUS.TXT e le note  */
/*        inserite nel sorgente qui sotto.                      */
/* ------------------------------------------------------------ */

int Deg, Range, ORange,     /* Variabili per la funzione di sparo shoot() */
                            /* Deg e' l'angolo, Range e ORange sono       */
                            /* rispettivamente il nuovo e il vecchio      */ 
                            /* raggio di distanza dal nemico              */

    dam, num, destro,       /* Variabili per la funzione cambia():        */       
    problems, dir,          /* - dam e' il valore ritornato dalla         */    
    nothing, due;           /*   funzione damage();                       */
                            /* - num e' il numero di volte che            */
                            /*   damage() ritorna lo stesso valore;       */
                            /* - destro e' utilizzata come una variabile  */
                            /*   booleana che indica su quale lato del    */
                            /*   campo il robot si trova;                 */
                            /* - problems e' un contatore che indica      */
                            /*   l'eventuale presenza di robot nemici     */
                            /*   sullo stesso lato;                       */
                            /* - dir indica la direzione del robot;       */
                            /* - nothing indica l'eventuale assenza di    */
                            /*   robots nemici sullo stesso lato;         */
                            /* - due indica l'eventuale presenza di piu'  */ 
                            /*   nemici sullo stesso lato;                */


main()
{   
  Deg = 0; ORange = 100; nothing = 10; 

  /* Direzione OVEST */

  drive (0,100); 
  while (loc_x() < 960) shoot();    
  drive (90,0);                                                 
  while (speed() > 49)  shoot();
  
  destro = 1; dam = 0; num = 0; nothing = 0; 
  while (1) {
    if ( (!speed()) && (loc_y() > 500) ) drive (90,0);

    /* Direzione NORD */

    problems = 0; drive (90,100); dir = 90; 
    while ((loc_y() < 900) && (problems < 4) ) shoot();      
    drive (270,0);                        
    while (speed() > 49) shoot();        

    /* Se ci sono piu' nemici sullo stesso lato allora cambia lato */	

    if ( due >= 3 ) cambia();

    if ( (!speed()) && (loc_y() < 500) ) drive (270,0);

    /* Direzione SUD */

    problems = 0; drive (270,100); dir = 270; 
    while ((loc_y() > 100) && (problems < 4) ) shoot();      
    drive (90,0);                        
    while (speed() > 49) shoot();      

    /* Se ci sono piu' nemici sullo stesso lato allora   cambia lato */	
    /* senno se non vieni colpito per 5 volte da nessuno cambia lato */


    if ( due >= 3 ) cambia();
    else if (dam == damage()) {
      if (++num == 5) cambia();
    }
    else {
      num = 0;
      dam = damage();
    }  
  } 
} 

/* Routine per il cambio di lato OVEST <---> EST */

cambia()
{
  nothing = 10; problems = 0; 
  if (destro) {                         /* se ti trovi sul lato destro */
    drive (180,100);                    /* vai a OVEST */
    while (loc_x() > 60) shoot();    
  }  
  else {                                /* se ti trovi sul lato sinistro */
    drive (0,100);                      /* vai a EST */
    while (loc_x() < 940) shoot();    
  }
  drive (0,0);                          /* Rallenta */                       
  while (speed() > 49) shoot();
  num = 0; destro = !destro; due = 0;   /* Aggiornamento delle variabili */
  nothing = 0; problems = 0;            /* principali */
} 


/* Routine di ricerca e di sparo */

shoot ()
{
  if (Range = scan (Deg, 6)) {               /* Se il nemico e' ancora li' */
    if (Range < 50) cannon ( Deg, 50 );      /* NON SPARARTI ADDOSSO !! */
    else if (Range > ORange) cannon ( Deg, 8*Range/7 );  /* se e' piu' lontano */
         else                cannon ( Deg, 7*Range/8 );  /* se e' piu' vicino  */  
  }
  else {    /* se non vedi piu' il nemico cercalo (!) */
    Deg -= 40;                            
    while (!(Range = scan (Deg += 15, 8))); 
    if (Range < 50) cannon ( Deg, 50 );      /* NON SPARARTI ADDOSSO !! */
    else if (Range > ORange) cannon ( Deg, 8*Range/7 );   /* se e' piu' lontano */
         else                cannon ( Deg, 7*Range/8 );   /* se e' piu' vicino  */ 
   
  }
  ORange = Range;  

  Deg = Deg % 360;

  if (nothing < 6) {         /* se precedentemente c'era un robot o a NORD */
    if (scan(90,10) ) {      /* o a SUD allora ricontrolla la situazione   */
      Deg = 90; nothing = 0;
      if ( (dir == 90) && (loc_y() > 150) ) ++problems;  /* se stai andando    */
      if (scan(270,10)) { ++due; problems = 4; }         /* nella stessa       */
    }                                                    /* dir. dove si trova */
    else if (scan(270,10) ) {                            /* il nemico allora   */
      Deg = 270; nothing = 0;                            /* torna indietro e   */   
      if ( (dir == 270) && (loc_y() < 850) ) ++problems; /* fatti seguire      */
    }
    else if (!problems) { ++nothing; due = 0; }
  } 
  else if (nothing < 30) ++nothing;
       else nothing = 0;       
}
