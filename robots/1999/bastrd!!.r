/**************************************************************************/
/***   BASTARD!!.R   ( Y2K Crobots Tournament )                         ***/
/***                                                                    ***/
/***   Creatore  :  Kazushi Hagiwara                                    ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  30.11.1999                                          ***/
/***   Revisione :  30.11.1999                                          ***/
/**************************************************************************/


/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/**  BASTARD!! e' il fratello gemello di AKIRA; come lui tenta (invano)  **/
/**  di prevedere la strategia dei robot piu' forti.                     **/
/**  Per contrastare l'ormai dilagante diffusione dei robot-pendolo ho   **/
/**  deciso di utilizzare con un po' di coraggio un robot fermo.         **/
/**  BASTARD!! resta tranquillo ben inserito in un angolo a rigenerare   **/
/**  ferite procuratosi in combattimenti precedenti. Non ama molto la    **/
/**  compagnia di altri robot maschi, dunque non appena infastidito va a **/
/**  cercarsi un angolo piu' tranquillo. I suoi incantesimi d'attacco    **/
/**  sono un adattamento di quelli di GOBLIN e di TOX.                   **/
/**  A differenza di AKIRA, BASTARD!! e' troppo occupato a meditare un   **/
/**  piano per ricostruire il suo harem per decidere di sconfiggere      **/
/**  tutti i suoi nemici. Tuttavia se l'ultimo rimasto si rifiuta di     **/
/**  riconoscerlo come eroe super-bellissimo, allora lo devasta con il   **/
/**  suo incantesimo piu' potente.                                       **/
/**************************************************************************/

/***  N O T A  ************************************************************/
/**  Chiedo scusa a chi stia tentando di comprendere questo listato per  **/
/**  i forzati riferimenti al fumetto ma la mia creaturina ha piu' la    **/
/**  pretesa di essere simpatica che di vincere premi ...                **/
/**************************************************************************/
      

int  abigail;            /* Contatore per possibile cambio strategia */
int  destx, desty;       /* Punto di arrivo attuale */

int   ang;      /*  Angolo di scansione  */
int  oang;      /*  Angolo di appoggio per operazioni  */

int  oriz;      /*  Direzione dei due lati di scansione  */
int  vert;      /*  dell'angolo attualmente occupato     */           

int  rng, orng; /*  Distanza di fuoco per l'arma */
int  seanharri; /*  Numero di ripetizioni prima di rilevare l'ultimo nemico rimasto */

int  lars;      /*  Direzione di movimento  */
int  yoko;      /*  Danno accumulato nell'angolo  */

int  kallsu;    /* Numero nemici */
int  s;         /* Contatore di servizio per il conto dei nemici */ 
   

main()   
{ 


   /*////////////////////////////////////////////////////////////////*/
   /*//                                                            //*/
   /*//  Un'epoca senza legge, ne' ordine.                         //*/
   /*//  Solo sangue e acciaio, carne e ossa.                      //*/
   /*//  E IL POTERE DELLA MAGIA.                                  //*/
   /*//                                                            //*/   
   /*//////////////////////////////////////////////////////////////////


   /* Impostazione costanti */ 
   ang=36000;  abigail = 2500;  seanharri = 0;
   
   desty=(loc_y()>500)*1000;    /*** Scelta angolo ***/
   destx=(loc_x()>500)*1000;

   megadeth(0);

   while (abigail) { 
      yoko=damage();   
      bastard();     
   }
   venon();
}  



dist(x2,y2)     /** Formula di Pitagora **/
int x2, y2;
{
  int x, y;

  x = loc_x() - x2;
  y = loc_y() - y2;
  return(sqrt((x*x) + (y*y)));
}



gara(xx,yy)     /** Trova la direzione che mi porti nell'angolo scelto **/
int xx, yy;    /** Versione ridottissima adattata a questa strategia **/
{
  int r;
  int curx, cury;

  curx = loc_x();  
  cury = loc_y();

  if (curx==xx) return (36090 + 180*(yy < cury));   /* --- Sud / Nord --- */

  r = 36000 + atan((100000 * (cury - yy)) / (curx - xx)); 
 
  if (xx > curx)
     return (r + 360*(yy < cury));  /* --- Est --- */
  else
     return (r + 180);              /* --- Ovest --- */
}


 
megadeth(mana)       /*** "Esplosione dell'universo" ***/
int mana; 
{
  /***  Procedura di avvicinamento ad un angolo  ***/
  
  int dsic;    /*  Distanza e velocita' max  */

  dsic = 100;

  while (dsic) {
        lars = gara(destx,desty);  /*  Si dirige verso l'angolo scelto  */
        drive(lars, dsic);
        while ((dist(destx,desty) > dsic) && speed()) egsodus(0);
        
        drive(lars,0);             /*  Frenata */
        if (mana) {                /***  Devo rigenerarmi ... ***/
           while(speed()>49);      /***  Meglio sbrigarsi !!  ***/
           dsic=0;
        } else {
           dsic=10*(dsic==45) + 45*(dsic==100);   /*** Un if con due else! ***/
           while (speed()>dsic) egsodus(0);       /* Rallentamento */          
        }
  }

  oriz = 36000 + 180*(destx>500);       /*** Margini di scansione ***/
  vert = 36090 + 180*(desty>500);      

  acquisd(); 
}

acquisd()        /*** "Maledizione del germe malefico dell'unghia blu" ***/
{
   /***  Riallineamento scanner rispetto ai margini dell'angolo scelto ***/
   if ((oriz+90)==vert)       /* Angolo iniziale */ 
      ang=oriz-18;      /***  SO / NE  ***/
   else ang=vert-18;    /***  NO / SE  ***/
}

bastard()
{
   /***  Procedura principale di stazionamento in un angolo ***/
  
   acquisd();
    
   oang=ang-21;
   kallsu=0; s=7;
   while (--s)                 /*** Ricerca nemici ... ***/
      kallsu += (scan(oang+=21, 10)>0);
   if (kallsu<2) ++seanharri; else seanharri=0;

   if (seanharri>1) venon();  /*** Strategia F2F ***/
   else {
      while ((--abigail)%10) {      /***  Controllo ogni dieci pillole  ***/
         if (yoko<damage()) {       /***  FUGA: Cambio angolo  ***/
               if (scan(vert-10, 10) || scan(vert+10, 10)) {         /* C'e' nessuno? */
                  if (!scan(oriz-10, 10) && !scan(oriz+10, 10)) {    /* Ehila' ? */
                     destx = 1000*(destx<500);
                     desty = loc_y();
                     megadeth(1); return; 
                  }
               } else {
                     desty = 1000*(desty<500);
                     destx = loc_x();
                     megadeth(1); return;	  
               }
	 } else egsodus(1);
      }	
   }
}


egsodus(mana)          /*** "L'inferno delle fiamme violente di Satana" ***/
int mana;
{
   /***  Procedura di attacco -  Fermo / In movimento  ***/

   if (orng=scan(ang,10))
   {
        if (!scan(ang-=5,5)) ang+=10;
        if (orng>650)
        {
	    if (!scan(ang-=3,3)) ang+=6;
            cannon(ang,orng); ang+=21; 
        } else {
           if(scan(ang-5,1)) ang-=5;
           if(scan(ang+5,1)) ang+=5;
           if(scan(ang-3,1)) ang-=3;
           if(scan(ang+3,1)) ang+=3;
           if(scan(ang-1,1)) ang-=1;
           if(scan(ang+1,1)) ang+=1;

           if (orng=scan(oang=ang,5))
           {
               if(scan(ang-5,1)) ang-=5;
               if(scan(ang+5,1)) ang+=5;
               if(scan(ang-3,1)) ang-=3;
               if(scan(ang+3,1)) ang+=3;
               if(scan(ang-1,1)) ang-=1;
               if(scan(ang+1,1)) ang+=1;
      

               if (rng=scan(ang,10))
               {
                   if (mana)        /***  Da fermo  ***/
                   {
                   cannon(ang+(ang-oang)*((1200+rng)>>9),
                          rng*160/(160+orng-rng));
                   }
                   else
                   {
                   cannon(ang+(ang-oang)*((1200+rng)>>9)-(sin(ang-lars)>>14),
                          rng*160/(160+orng-rng-(cos(ang-lars)>>12)));
                   }
                   return;                
               }
           }
        }
   } else {
        if (scan(ang-=21,10));
        else if (!scan(ang+=42,10)) ang+=21;
   } 
        
   if (mana) {                      /* Da fermo conviene limitare          */
      if ((oriz+90)==vert) {        /* l'ampiezza dell'angolo di scansione */
          if (ang>oriz+120) ang=oriz-18;
      } else {
          if (ang>vert+120) ang=vert-18;
      }
   }
}


venon()          /*** "L'inferno delle anime lacerate" ***/
{ 
   /*//////////////////////////////////////////////////////////////*/
   /*//                                                          //*/
   /*//   Pensavi di potermi sconfiggere con la tua forza ?!     //*/
   /*//   Riconosci i tuoi limiti !!                             //*/
   /*//   ZAHZARD ZAHZARD SKUROWNOH ROWNOSUHK !!!                //*/
   /*//   Fuoco che arde nei recessi tenebrosi dell'inferno,     //*/
   /*//   diventa la mia spada e annienta il nemico !!           //*/
   /*//                                                          //*/
   /*//////////////////////////////////////////////////////////////*/

   /***   Strategia Finale : pendolamento corto orizzontale 
                             al centro dell'arena                ***/

   drive(lars=gara(500, 500), 100);        /*** Il Cuore della Distruzione ***/
   while (dist(500,500)>70) egsodus(0);
   drive(lars,0); egsodus(0);
   while(speed()>49);
   
   while(1) {
      drive(lars=36180, 100);               /*** A Sinistra ***/
      while (loc_x()>450) egsodus(0);
      drive(36180, 0); 
     
      while (speed()>49);                                  
  
      drive(lars=36000, 100);                 /*** A Destra   ***/
      while (loc_x()<550) egsodus(0);
      drive(36000,0); 
        
      while (speed()>49);      
   }      /*** Chi sara' il vero crobot super-bellissimo ??!??! ***/
}


