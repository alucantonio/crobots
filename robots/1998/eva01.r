/**************************************************************************/
/***   EVA01.R   "Macchina Umanoide Evangelion"                         ***/ 
/***             "Unita' ZERO-UNO"                                      ***/                                         
/***               ( Crobot per l'Ottavo Torneo di MCmicrocomputer )    ***/
/***                                                                    ***/
/***   Creatore  :  Yoshiyuki Sadamoto                                  ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  25.09.1998                                          ***/
/***   Revisione :  30.09.1998                                          ***/
/**************************************************************************/

/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/** L'unita' ZERO-UNO e' l'evoluzione dell'esemplare di test ZERO-ZERO   **/
/** e presenta maggiori capacita' decisionali nelle situazioni critiche: **/
/** dopo circa 130000 cicli, infatti, abbandona la propria condizione di **/
/** pendolamento e viaggia con furia omicida lungo un ottagono alla      **/
/** ricerca dei nemici rimasti (probabilmente tutti ...)                 **/
/**                                                                      **/
/** Dovendo scegliere, preferisco veder combattere EVA01.R               **/
/**************************************************************************/

int batterie;           /* Durata delle batterie */
int angolomov;          /* Direzione movimento attuale */
int destx, desty;       /* Punto di arrivo */
int rangefuoco;         /* Distanza 2. rilevamento */
int scan1, scan2;       /* Scanner primario e secondario */
int oldscan, oldrange;  /* Rilevamenti precedenti */
int oldscan1, oldscan2; /* Posizione di partenza degli scanner */
int range1, range2;     /* Distanza 1. rilevamento su ciascuno scanner */
int ang;                /* Angolo di attacco */
int check;              /* Booleano per la scelta tra il miglior scanner */

main()   
{  
   batterie = 262;  /***  Durata massima degli accumulatori  ***/

   /***   EMERGENZA : Rilevati TRE angeli nemici   ***/
   /***   Lancio dell'unita' Evangelion !!!        ***/

   while (1) {
      Entry_Plug();
      while (--batterie) shinji_ikari();
      Berserk();
   }    /***   Salviamo l'umanita'  ***/

}  

Progressive_Knife()         /***  Arma principale di attacco  ***/
{
    /** Riduzione angolo (tempo costante) **/
    if ((range1=scan(scan1, 10)) || (range2=scan(scan2,10)))
    {
       check=(((range1<range2) && (range1)) || (!range2));
       ang=scan1*check+scan2*(!check);
       oldrange=range1*check+range2*(!check);
       ang+=350*!(scan(ang+=5,5));
       ang+=354*!(scan(ang+=3,3));
       cannon(ang, 2*scan(ang,10)-oldrange); 
       scan1=ang; scan2=ang; 
    }
    else
    {  /***  DOPPIO SCANNER sfasato (si cerca quello con range inferiore) ***/
       oldscan1=scan1; oldscan2=scan2;
       scan1+=314*(!(!scan(scan1+314,10))); 
       scan2+=335*(!(!scan(scan2+335,10)));
       scan1+=17*(!(!scan(scan1+17,10)));
       scan2+=38*(!(!scan(scan2+38,10)));
       scan1+=59*(scan1==oldscan1);    /***  Nessun bersaglio in vista  ***/
       scan2+=59*(scan2==oldscan2);    /***  Continuare la ricerca ...  ***/  
    }  
}

cerca360()
{
       /***   Scanner per le fasi iniziali della partita   ***/
   if (rangefuoco=scan(ang, 10))
      cannon(ang, rangefuoco);
   else scan2 += 21;
}

occupato(x,y)
int x, y;
{
    angolomov = direz(destx=x,desty=y);  
    if (scan(angolomov, 10)) return(1); else return(0);
}  

Entry_Plug() 
{            
       /***  Capitano Katsuragi, elabori la strategia migliore   ***/
       /***      prima dell'inserimento nell'entry-plug !!!      ***/

      /***   Preparazione dell'uscita ...      ***/
      /***   Verifica percorso ... ALL GREEN   ***/
      /***   Unita' ZERO-UNO ... LANCIARE !!!  ***/

  angolomov = direz(500, 500);     /* --- Centro --- */
  drive(angolomov, 100);           

  while ((dist(500,500) > 100) && (speed())) cerca360();
  
  drive(angolomov, 0);             /* --- Frenata --- */
  while (speed()>49) cerca360();

  if (occupato(950, 950))
    if (occupato(950, 50))
       if (occupato(50, 50))
          if (occupato(50, 950));

  /* --- Dirigersi verso l'angolo scelto --- */

  drive(angolomov, 100);
  while ((dist(destx,desty) > 50) && (speed())) cerca360();

  drive(angolomov, 0);             /* --- Frenata --- */
  
      /***  Reset Nervo A10 ***/
  
  Reset_Nervo_A10();

      /***   Emergenza : distacco dell'umbelical cable                ***/
      /***   Durata delle batterie inferiore ai 200000 cicli di CPU   ***/
      /***   Vai SHINJI non farti distruggere dagli angeli !!!        ***/
} 

dist(x2,y2)     
int x2, y2;
{
  int x, y;

  x = loc_x() - x2;   y = loc_y() - y2;
  return(sqrt((x*x) + (y*y)));
}

direz(xx,yy)
int xx, yy;
{
      /***  Dottoressa Akagi, calcoli la direzione per condurre  ***/
      /***         l'Evangelion al punto prestabilito !!!        ***/
         
  int d;
  int x,y,r;
  int curx, cury;

  curx = loc_x();  cury = loc_y();
  x = curx - xx;   y = cury - yy;
  r = atan((100000 * y) / x); 

  if (!x) 
    d = 90 + 180*(yy < cury);   /* --- Nord / Sud --- */
  else 
    if (yy < cury) 
      d = r + 180 + 180*(xx > curx);  /* --- Sud-Est / Sud-Ovest --- */
    else 
      d = r + 180*(xx < curx);  /* --- Nord-Est / Nord-Ovest --- */

  return (d);
}

Reset_Nervo_A10()
{
      /***  Tasso di sincronia insufficiente ... Reimpostare ...  ***/
   
   scan1=angolomov; scan2=angolomov;
}

shinji_ikari()
{
        /*** Movimento a pendolo in un angolo lungo la diagonale ***/
   Reset_Nervo_A10();
   drive(angolomov+=180, 100);
   Progressive_Knife();
   Progressive_Knife();
   Progressive_Knife();
   drive(angolomov, 0);
   Progressive_Knife();
}

blind_fire()
{
   if ((rangefuoco=scan(ang,7)) && (rangefuoco<700)) {
      cannon(ang,rangefuoco);      
      ang+=345;
   } else ang+=15;
}

Berserk()
{
   /***   Pericolo : perduta connessione nervo A10  ***/
   /***   Perdita del tasso di sincronia ...        ***/
   /***   Condizione di berserk !!!                 ***/
   
   angolomov = direz(500, 900); 
   drive(angolomov,100);
   while (loc_y() < 900) blind_fire();
   drive(angolomov,0);
   while(speed()>49) blind_fire();
   
   /****   AT - FIELD   ****/
   while (1)
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
}


