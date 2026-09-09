/**************************************************************************/
/***   DIABLO3.R   "Diablo III"                                         ***/
/***               ( Crobot per il Settimo Torneo di MCmicrocomputer )  ***/
/***                                                                    ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  15.09.1996  (24.06.1995)                            ***/
/***   Revisione :  30.09.1997                                          ***/
/**************************************************************************/

/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/** In DIABLO3.R la strategia di movimento e' di gran lunga piu'         **/
/** importante della precisione di tiro : rotea, infatti in senso        **/
/** orario lungo il campo di battaglia fermandosi a meta' di ogni lato   **/
/** per riposarsi. Per evitare di essere                                 **/
/** colpito in questi momenti adotta un moto a "pendolo", oscillando per **/
/** alcuni metri. Lo scan e' composto di 4 fasi successive di ricerca a  **/
/** precisione crescente, utile soprattutto per la sua rapidita'.        **/
/**************************************************************************/

int diablo;
int scan1, scan2, sx, dx;
int range1, range2, rangefuoco;
int old1, old2;
int dir;

main ()
{
   /* --- Preparazione variabili --- */
   scan1 = 36360;
     
   /* --- Posizionamento sul lato piu' vicino --- */
   sistemati();

   /*** ---  Inizia la battaglia ... --- ***/
   while (1) {
      gira();
   }  /*** --- "Until the end of world" --- ***/
}

cerca_e_spara()
{
   /*** La sequenza di scan si articola in quattro fasi :
        fase 0 : 3 volte con ampiezza 21 gradi (in totale 61 gradi)
        fase 1 : riduzione a 7 gradi con due soli rilevamenti
        fase 2 : ampiezza 7 gradi
        fase 3 : ampiezza 3 gradi (sufficiente visto che sono in
                                   continuo movimento)               ***/

   /*** Scanner principale ***/
   if (range1=scan(scan1,10)) spara1();            /* Centro */
   else if (range1=scan(scan1+=20,10)) spara1();   /*   SX   */
   else if (range1=scan(scan1-=40,10)) spara1();   /*   DX   */
   else {
       scan1-=40;      /* Il primo scanner ha fallito ... */
       /*** ... entra in azione lo scanner secondario ***/
       cerca_vicino();
   }
}

cerca_vicino()
{
   /*** Scanner secondario ***/
   if (diablo)        /* Se mi muovo in linea mi guardo le spalle */
      scan2 = dir + 180;
   else               /* Altrimenti guardo sul muro */
      scan2 = dir + 90;
   if (range2=scan(scan2,10)) spara2();            /* Centro */
   else if (range2=scan(scan2+=20,10)) spara2();   /*   SX   */
   else if (range2=scan(scan2-=40,10)) spara2();   /*   DX   */
}

spara1()
{
    {
        /*** Chiusure successive dello scanner principale ***/
        sx=scan(scan1-4,6);
        dx=scan(scan1+4,6);
        if (sx) scan1-=6;
        if (dx) scan1+=6;
        old1 = scan1;
        if (scan(scan1-3,3)) scan1-=3; else scan1+=3;
        if (scan(scan1-1,1)) scan1-=1; else scan1+=1;

        if (rangefuoco=scan(scan1,10))    /*** Correzione sull'angolo ***/
        {
           cannon(scan1+(scan1-old1), rangefuoco+(rangefuoco-range1));
        }

        if (range1>700) {    /* Se e' lontano modifico l'angolo */
           scan1-=40;
           cerca_vicino();
        } else               /* Se e' vicino gli sparo subito */
        if (range1<200) {
           cerca_vicino();
        }
    }
}

spara2()
{
    /*** Sparo senza nessuna correzione : visto che lo scan e' effettuato
         verso il muro il nemico non puo' trovarsi a piu' di 150 metri ***/

    if (range2>40) cannon(scan2, range2);
    else cannon(scan2, 50);   /* Non voglio spararmi addosso !!! */
}

gira()
{
   /*** Rotazione lungo il muro in senso orario ***/
   if (dir==0) dir=270; else dir -=90;

   drive(dir, 95);
   if (dir==0)
   {                        
      while((loc_x()<450) && speed()) cerca_e_spara();

      SNpendolo();

      while (loc_x() < 920) cerca_e_spara();
   }
   else if (dir==90)
   {

      while((loc_y()<450) && speed()) cerca_e_spara();

      EWpendolo();

      while (loc_y() < 920) cerca_e_spara();
   }
   else if (dir==180)
   {
      while((loc_x()>550) && speed()) cerca_e_spara();

      SNpendolo();

      while (loc_x() > 080) cerca_e_spara();
   }
   else if (dir==270)
   {
      while((loc_y()>550) && speed()) cerca_e_spara();

      EWpendolo();

      while (loc_y() > 080) cerca_e_spara();
   }

   /* Rallentamento */
   drive(dir, 0);
   cerca_vicino();
   while (speed()>49);
}

SNpendolo()
{
   /*** Pendolo verticale ***/
   int y;
   int ripeti;

   /* Posizione fissa di pendolamento */
   if (loc_y()>500) y=880;
   else y=120;

   /* Rallentamento */
   diablo = 0;
   drive(dir, 0);
   cerca_vicino();
   while (speed()>49);

   /* Ciclo normale */
   ripeti = 0;
   while(ripeti<40)
   {                    /*** Non piu' di 30000 cicli ***/
      /*** E VADO GIU GIU GIU ***/
      drive(270, 95);
      while ((loc_y()>y-10) && speed()) cerca_e_spara();
      drive(270, 0);

      if (in_linea(90)) ripeti = 0;

      while (speed()>40);           /* Non so perche' */
      /*** E VADO SU SU SU ***/
      drive(90, 95);
      while ((loc_y()<y+10) && speed()) cerca_e_spara();
      drive(90,0);
      
      if (in_linea(270)) ripeti = 0;

      while (speed()>40);           /* Non so perche' */
      ++ripeti;               /*** Provaci ancora DIABLO ***/
   }

   /* Si riparte !!! */
   diablo = 1;
   drive(dir, 95);
}

EWpendolo()
{
   /*** Pendolo orizzontale ***/
   int x;
   int ripeti;
  
   /* Posizione fissa di pendolamento */
   if (loc_x()>500) x=880;
   else x=120;

   /* Rallentamento */
   diablo = 0;
   drive(dir, 0);
   cerca_vicino();
   while (speed()>49);

   /* Ciclo normale */
   ripeti = 0;
   while(ripeti<40)  
   {                    /*** Non piu' di 30000 cicli ***/
      /*** VADO A DESTRA ***/
      drive(360, 95);
      while ((loc_x()<x+10) && speed()) cerca_e_spara();
      drive(360, 0);

      if (in_linea(0)) ripeti = 0;

      while (speed()>40);           /* Non so perche' */
      /*** VADO A MANCA ***/
      drive(180, 95);
      while ((loc_x()>x-10) && speed()) cerca_e_spara();
      drive(180, 0);

      if (in_linea(180)) ripeti = 0;

      while (speed()>40);           /* Non so perche' */
      ++ripeti;               /*** Provaci ancora DIABLO ***/
   }

   /* Si riparte !!! */
   diablo = 1;
   drive(dir, 95);
}

in_linea(gradi)          /* Serve a perdere qualche ciclo */
int gradi;
{
   /*** Il nemico e' di fronte a me, probabilmente e' :
        1) un pendolo, dunque non puo' prendermi (forse)
        2) un laterale o un giro, dunque non posso difendermi in
           alcun modo se non restando fermo nella mia posizione.  ***/

   if (((scan1%360)<gradi+10) &&
       ((scan1%360)>gradi-10)) return 1; else return 0;
}
  
sistemati()
{
   /*** Scelgo il muro piu' vicino (Nord o Sud) ***/
   diablo = 1;
   if (loc_y()<500) {
      drive(270, 95);
      while((loc_y()>080) && speed()) cerca_e_spara();
      dir = 270;
   } else {
      drive(90, 95);
      while((loc_y()<920) && speed()) cerca_e_spara();
      dir = 90;
   }

   /* Rallentamento */
   diablo = 0;
   drive(dir, 0);
   cerca_vicino(); 
   while (speed()>49);
}
