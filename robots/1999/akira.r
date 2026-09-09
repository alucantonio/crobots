/**************************************************************************/
/***   AKIRA.R   ( Y2K Crobots Tournament )                             ***/
/***                                                                    ***/
/***   Creatore  :  Katsuhiro Otomo                                     ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  12.10.1999                                          ***/
/***   Revisione :  30.11.1999                                          ***/
/**************************************************************************/


/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/**  Per costruire AKIRA sono andato a ripescare alcune buone idee dai   **/
/**  miei precedenti robot, DIABLO e GOLEM, tentando come tutti gli anni **/
/**  di prevedere (invano) la strategia dei robot piu' forti.            **/
/**  Per contrastare l'ormai dilagante diffusione dei robot-pendolo ho   **/
/**  deciso di utilizzare con un po' di coraggio un robot fermo.         **/
/**  AKIRA e' infatti come un timido bambino che gioca tranquillo in un  **/
/**  angolo. I suoi nemici non sanno pero' che la sua mente e' sveglia   **/
/**  ed attenta ai movimenti altrui; per questo spara con buona preci-   **/
/**  sione (utilizzando l'ottima routine di GOBLIN e di TOX, adattata    **/
/**  alla vita in un angolo) e fugge al primo segno di pericolo in un    **/
/**  angolo piu' tranquillo. Facendo questo cerca di farsi male il meno  **/
/**  possibile attendendo le mosse nemiche. Spesso pero' la paura della  **/
/**  morte prende il sopravvento su di lui e si getta in preda al panico **/
/**  in mezzo all'arena irradiando di accecante energia psionica tutto   **/
/**  cio' che lo circonda. Nella maggior parte dei casi questa mossa     **/
/**  equivale al suo suicidio, ma si rivela molto efficace qualora un    **/
/**  solo nemico abbia la sfortuna di incontrarlo.                       **/
/**************************************************************************/

/***  N O T A  ************************************************************/
/**  Chiedo scusa a chi stia tentando di comprendere questo listato per  **/
/**  i forzati riferimenti al fumetto ma la mia creaturina ha piu' la    **/
/**  pretesa di essere simpatica che di vincere premi ...                **/
/**************************************************************************/
      

int  tetsuo;             /* Contatore per possibile cambio strategia */
int  destx, desty;       /* Punto di arrivo attuale */

int   ang;      /*  Angolo di scansione  */
int  oang;      /*  Angolo di appoggio per operazioni  */

int  oriz;      /*  Direzione dei due lati di scansione  */
int  vert;      /*  dell'angolo attualmente occupato     */           

int  rng, orng; /*  Distanza di fuoco per l'arma */
int  nezu;      /*  Numero di ripetizioni prima di rilevare l'ultimo nemico */

int  sakaki;    /*  Direzione di movimento  */
int  kay;       /*  Danno accumulato nell'angolo  */

int  num;       /* Numero nemici */
int  s;         /* Contatore di servizio per il conto dei nemici */ 
   

main()   
{ 

   /**********************   A   K   I   R   A   **************************/
   /*A*                                                                 *A*/
   /***  ORE  23:59  del 30 Novembre 1999                               ***/
   /*K*  Un nuovo tipo di crobot venne sperimentato sul torneo Y2k ...  *K*/
   /***                                                                 ***/
   /*I*  Nove ore piu' tardi ebbe inizio la Piu' Grande Guerra.         *I*/
   /***  Furono bombardate dozzine di avversari ...                     ***/
   /*R*  Infine, per la decima volta nella loro storia, gli autori di   *R*/
   /***  crobots cominciarono un'opera di ricostruzione totale ...      ***/
   /*A*                                                                 *A*/
   /**********************   A   K   I   R   A   **************************/
   
   
   /* Impostazione costanti */ 
   ang=36000;  nezu = 0;
   
   desty=(loc_y()>500)*1000;    /*** Scelta angolo ***/
   destx=(loc_x()>500)*1000;

   kaneda(0);

   while (1) {
      tetsuo = 2150;     /***  E' finito l'effetto della pillola,  ***/
      while (tetsuo) {   /***  meglio fare scorta  ...             ***/ 
         kay=damage();   
         akira();      
      }
      if (damage()<70) luce_accecante();
   }
}  



dist(x2,y2)     /** Formula di Pitagora **/
int x2, y2;
{
  int x, y;

  x = loc_x() - x2;
  y = loc_y() - y2;
  return(sqrt((x*x) + (y*y)));
}



ryu(xx,yy)     /** Trova la direzione che mi porti nell'angolo scelto **/
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


 
kaneda(clown)
int clown; 
{
  /***  Procedura di avvicinamento ad un angolo  ***/
  
  int dsic;    /*  Distanza e velocita' max  */

  dsic = 100;

  while (dsic) {
        sakaki = ryu(destx,desty);  /*  Si dirige verso l'angolo scelto  */
        drive(sakaki, dsic);
        while ((dist(destx,desty) > dsic) && speed()) chiyoko(0);
        
        drive(sakaki,0);            /*  Frenata */
        if (clown) {                /***  Ci sono teppisti in giro ***/
           while(speed()>49);       /***  Meglio sbrigarsi !!      ***/
           dsic=0;
        } else {
           dsic=10*(dsic==45) + 45*(dsic==100);   /*** Un if con due else! ***/
           while (speed()>dsic) chiyoko(0);       /* Rallentamento */          
        }
  }

  oriz = 36000 + 180*(destx>500);       /*** Margini di scansione ***/
  vert = 36090 + 180*(desty>500);      

  reset(); 
}

reset()
{
   /***  Riallineamento scanner rispetto ai margini dell'angolo scelto ***/
   if ((oriz+90)==vert)       /* Angolo iniziale */ 
      ang=oriz-18;      /***  SO / NE  ***/
   else ang=vert-18;    /***  NO / SE  ***/
}

akira()
{
   /***  Procedura principale di stazionamento in un angolo ***/
  
   reset();
    
   oang=ang-21;
   num=0; s=7;
   while (--s)                 /*** Ricerca nemici ... ***/
      num += (scan(oang+=21, 10)>0);
   if (num<2) ++nezu; else nezu=0;

   if (nezu>1) luce_accecante();  /*** Strategia F2F ***/
   else {
      while ((--tetsuo)%10) {      /***  Controllo ogni dieci pillole  ***/
         if (kay<damage()) {       /***  FUGA: Cambio angolo  ***/
               if (scan(vert-10, 10) || scan(vert+10, 10)) {       /* C'e' nessuno? */
                  if (!scan(oriz-10, 10) && !scan(oriz+10, 10)) {  /* Ehila' ? */
                     destx = 1000*(destx<500);
                     desty = loc_y();
                     kaneda(1); return; 
                  }
               } else {
                     desty = 1000*(desty<500);
                     destx = loc_x();
                     kaneda(1); return;	  
               }
	 } else chiyoko(1);
      }	
   }
}


chiyoko(takatataka)
int takatataka;
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
                   if (takatataka)       /***  Da fermo  ***/
                   {
                   cannon(ang+(ang-oang)*((1200+rng)>>9),
                          rng*160/(160+orng-rng));
                   }
                   else
                   {
                   cannon(ang+(ang-oang)*((1200+rng)>>9)-(sin(ang-sakaki)>>14),
                          rng*160/(160+orng-rng-(cos(ang-sakaki)>>12)));
                   }
                   return;                
               }
           }
        }
   } else {
        if (scan(ang-=21,10));
        else if (!scan(ang+=42,10)) ang+=21;
   } 
        
   if (takatataka) {                /* Da fermo conviene limitare          */
      if ((oriz+90)==vert) {        /* l'ampiezza dell'angolo di scansione */
          if (ang>oriz+120) ang=oriz-18;
      } else {
          if (ang>vert+120) ang=vert-18;
      }
   }
}


luce_accecante()
{ 
   /********************   A   K   I   R   A   *********************/
   /*A*                                                          *A*/
   /*K*   AAARRRGH !                                             *K*/
   /*I*   Oh no! Ti prego, AKIRA, non farlo!                     *I*/
   /*R*   Cos'e' questa luce accecante?!   Non e' possibile!     *R*/
   /*A*   Si sta irradiando da AKIRA!                            *A*/
   /***                                                          ***/
   /********************   A   K   I   R   A   *********************/


   /***   Strategia Finale : pendolamento corto orizzontale 
                             al centro dell'arena                ***/

   drive(sakaki=ryu(500, 500), 100);        /*** Il Cuore della Distruzione ***/
   while (dist(500,500)>70) chiyoko(0);
   drive(sakaki,0); chiyoko(0);
   while(speed()>49);
   
   while(1) {
      drive(sakaki=36180, 100);               /*** A Sinistra ***/
      while (loc_x()>450) chiyoko(0);
      drive(36180, 0); 
     
      while (speed()>49);      /***  Non perdo tempo : qui in mezzo  ***/
                               /***  Sta esplodendo tutto quanto !!  ***/
  
      drive(sakaki=36000, 100);                 /*** A Destra   ***/
      while (loc_x()<550) chiyoko(0);
      drive(36000,0); 
        
      while (speed()>49);      
   }      /*** Ci sara' un futuro per gli altri crobots ??!??! ***/
}


