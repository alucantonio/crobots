/**************************************************************************/
/***   GOLEM.R      ( Crobot per il Sesto Torneo di MCmicrocomputer )   ***/
/***                                                                    ***/
/***   Autore    :  Stefano Francesi                                    ***/
/***                                                                    ***/
/***   Creazione :  24.06.1995                                          ***/
/***   Revisione :  30.09.1996                                          ***/
/**************************************************************************/

/**************************************************************************/
/**                      STRATEGIA DI COMPORTAMENTO                      **/
/**                                                                      **/
/** GOLEM.R e' un crobot tanto intelligente quanto socievole : passa     **/
/** infatti la maggior parte del suo tempo ad oscillare in un angolo,    **/
/** aspettando che un qualsiasi nemico gli venga a tiro. Una volta       **/
/** trovato, tenta di tenerlo continuamente sotto tiro, ritardando di    **/
/** molto il colpo per essere sicuro di colpirlo.                        **/
/** Quando i danni sono aumentati del 15% si muove verso un angolo piu'  **/
/** tranquillo, mentre quando superano l'85% si getta scioccamente verso **/
/** il centro dell'arena per tornare poi subito al proprio posto.        **/
/**************************************************************************/
      
int dsic1, dsic2;       /* Distanze di sicurezza */
int inviaggio;          /* Booleano per inizio incontro */
int danno;              /* Danneggiamento */
int timer;              /* Contatore per cambio strategia */
int corner;             /* Angolo corrente */
int angolomov;          /* Direzione movimento attuale */
int destx, desty;       /* Punto di arrivo */
int rangefuoco;         /* Distanza 2. rilevamento */
int scan1, scan2;       /* Scanner primario e secondario */
int sx, dx;             /* Rilevamenti ausiliarii */
int oldscan, oldrange;  /* Rilevamenti precedenti */
int sc;                 /* Inizio scan corrente */


main()   
{  
   /* Preparazione variabili booleane */
   inviaggio = 1; 
   /* Impostazione costanti */ 
   dsic1 = 100;
   dsic2 = 50;
   timer = 135;

   while (1) {
      scegli_angolo();
      while (--timer) pendolo();
      nella_mischia();
   }      /*** --------- "Until the end of world" ------- ***/

}  

cerca1()         /*** Utilizzato dallo scanner primario ***/
{
    /** Riduzione angolo **/
    oldscan = scan1;
    oldrange = rangefuoco;
    sx=scan(scan1-4,6);
    dx=scan(scan1+4,6);
    if (sx) scan1-=6;
    if (dx) scan1+=6;
    if (scan(scan1-3,3)) scan1-=3; else scan1+=3;
    if (scan(scan1-1,1)) scan1-=1; else scan1+=1;
    rangefuoco=scan(scan1, 10);
}

cerca2()        /*** Utilizzato dallo scanner secondario ***/
{
    /** Riduzione angolo **/
    sx=scan(scan2-4,6);
    dx=scan(scan2+4,6);
    if (sx) scan2-=6;
    if (dx) scan2+=6;
    if (scan(scan2-3,3)) scan2-=3; else scan2+=3;
    rangefuoco=scan(scan2, 10);
}

cerca180()
{
    /*** Scanner primario : effettua uno scan sui 180 gradi che comprendono
         gran parte dell'arena, passando poi il controllo allo scanner
         secondario ***/

      if (rangefuoco=scan(scan1, 10)) fuoco1();
      else
      {
         scan1 += 20;
         if (scan1 > sc + 180) {
            cerca_dietro();
            scan1 = sc;
         }
      }
}

cerca360()
{
   /*** Scanner per le fasi iniziali e finali della partita ***/
   if (scan(scan2, 10)) fuoco_rapido();
      else scan2 += 20;
}

cerca_dietro()
{
   /*** Scanner secondario : controllo dell'angolo ***/
   scan2 = sc + 180;
   while (!scan(scan2,10)) scan2 += 20;
   fuoco2();
}

zona()
{
   if (loc_y()>500) return(0); else return(1);
}

 
scegli_angolo() 
{
  if (inviaggio) corner = zona(); else corner = (++corner) % 2;
  if (corner) {
    destx = 900; desty = 100; sc = 36045; 
  } else { 
    destx = 900; desty = 900; sc = 36135; 
  }

  inviaggio = 1;
  angolomov = direz(850, 500);     /* --- Si dirige verso il centro --- */
  drive(angolomov, 95);            /* --- del semicampo destro      --- */

  while ((dist(850,500) > dsic1) && (speed())) cerca360();

  drive(angolomov, 0);             /* --- Frenata --- */
  angolomov = direz(destx,desty);  /* --- Si dirige verso l'angolo scelto --- */
  cerca360();
  while (speed()>49);
  drive(angolomov, 95);
  
  while ((dist(destx,desty) > dsic1) && (speed())) cerca360();

  inviaggio = 0; 
  drive(angolomov, 0);             /* --- Frenata --- */
  angolomov = direz(destx,desty);  /* Perfeziona la direzione verso l'angolo */
  cerca360();
  while (speed()>49);
  drive(angolomov, 95);

  while ((dist(destx,desty) > dsic2) && (speed())) cerca180();
  drive(angolomov, 0);             /* --- Frenata --- */
  cerca180();
  while (speed()>49);
  
  danno = damage();
  scan1 = sc;                      /* --- ... Inizia la missione ... --- */
} 

dist(x2,y2)     /** Formula di Pitagora **/
int x2, y2;
{
  int x, y;

  x = loc_x() - x2;
  y = loc_y() - y2;
  return(sqrt((x*x) + (y*y)));
}

direz(xx,yy)   /** Trova la direzione che mi porti nell'angolo scelto **/
int xx, yy;
{
  int d;
  int x,y,r;
  int curx, cury;

  curx = loc_x();  
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;
  r = atan((100000 * y) / x); 

  if (x == 0) {      
    if (yy > cury)
      d = 90;         /* --- Nord --- */
    else
      d = 270;        /* --- Sud --- */
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + r;  /* --- Sud-Est --- */
      else
        d = 180 + r;  /* --- Sud-Ovest --- */ 
    } else {
      if (xx > curx)
        d = r;        /* --- Nord-Est ---*/
      else
        d = 180 + r;  /* --- Nord-Ovest --- */
    }
  }
  return (d);
}

fuoco1()
{
   int ok;

   ok = 0;

   /* Questa procedura impiega parecchi cicli di CPU */
   /* (nel caso peggiore 200), dunque e' bene limitare l'ampiezza */
   /* del pendolamento per evitare di urtare il muro */

   while(!ok)
   {
      cerca1();
      if (rangefuoco>40)
         ok = cannon(scan1+(scan1-oldscan), rangefuoco+(rangefuoco-oldrange));
      else
      {
         cannon(scan1+(scan1-oldscan), 70);   /**** Fuoco !!!!! ****/
         ok = 1;
      }
   }
}

fuoco2()
{
   int ok;

   /* Questa procedura impiega parecchi cicli di CPU */
   /* (nel caso peggiore 200), dunque e' bene limitare l'ampiezza */
   /* del pendolamento per evitare di urtare il muro */

   while(!ok)
   {
      cerca2();
      if (rangefuoco>40)
         ok = cannon(scan2, rangefuoco);
      else
      {
         cannon(scan2, 70);   /**** Fuoco !!!!! ****/
         ok = 1;
      }
   }
}

fuoco_rapido()
{
   /*** Sparo durante la scelta dell'angolo ***/
   cerca2();
   if (rangefuoco>40)
      cannon(scan2, rangefuoco);
   else cannon(scan2, 50);
}

pendolo()
{
   /*** Movimento a pendolo in un angolo ***/
   if (danno+14<damage()) scegli_angolo();
   
   if (corner) angolomov=135; else angolomov=225;

   drive(angolomov, 100);
   while ((loc_x()>878) && (speed())) cerca180();
   drive(angolomov, 0);
   if (damage()>85) timer = 1; 
   while(speed()>49);

   drive(angolomov+180, 100);
   while ((loc_x()<882) && (speed())) cerca180();
   drive(angolomov+180, 0);
   if (damage()>85) timer = 1; 
   while(speed()>49);
}

nella_mischia()
{
   /*** Tentativo di evitare il pareggio ***/
   while(1)
   {
      timer = 10;
      danno = 100;

      while(loc_x()>500)      /* Movimento tremolante */
      {
         drive(angolomov-45,95); 
         while(speed()<95) cerca360();
         drive(angolomov-45,0);
         while(speed()>49) cerca360();
         drive(angolomov+45,95); 
         while(speed()<95) cerca360();
         drive(angolomov+45,0);
         while(speed()>49) cerca360();
      }
   
      while (--timer) pendolo();    /* Non mi fido ! Torno nel mio angolo */
   }
}
