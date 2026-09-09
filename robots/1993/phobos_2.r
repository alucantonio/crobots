/* ------------------------------------------------------------ */
/*  Robot:           Phobos                                     */
/*  Generazione:     2                                          */
/*  Categoria:       TD-3                                       */
/*  Nome ufficiale:  PHOBOS_2                                   */
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
/*        potete leggere il file associato PHOBOS_2.TXT e le    */
/*        note inserite nel sorgente qui sotto.                 */
/* ------------------------------------------------------------ */


int Deg, Range, ORange;

main()
{   
  Deg = 105; ORange = 100; 
   
  drive (180,100);                  /*  Direzione OVEST a tutta velocita' */
  while (loc_x() > 60) shoot();    
  drive (90,0);                                                 
  while (speed() > 49)  shoot();
  
  while (1) {
    if (!speed() && loc_y() < 500) drive (90,0); 

    drive (90,100);                 /* Direzione NORD */ 
    while (loc_y() < 900) shoot();  /* Cerca e spara */     
    drive (270,0);                        
    while (speed() > 49)  shoot();        
	
    if (!speed() && loc_y() >= 500) drive (270,0); 

    drive (270,100);                /* Direzione SUD */ 
    while (loc_y() > 100) shoot();  /* Cerca e spara */
    drive (90,0);                        
    while (speed() > 49)  shoot();      
  } 
}

shoot ()
{
  if (Range = scan (Deg, 8)) {  
    if (Range < 50) cannon ( Deg, 50 );
    else if (Range > ORange) cannon ( Deg, 9*Range/8 );
         else                cannon ( Deg, 8*Range/9 );    

    ORange = Range;  
  }
  else if (Deg > -105) Deg -= 15;
       else Deg = 105;
}
