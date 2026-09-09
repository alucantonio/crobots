/*

Torneo midi 2010

Enkidu.r ver.1.25 del 12-marzo-2010
Riesumato alla circolazione da Marco Borsari,
per incidenti rivolgersi all'ufficio Antica Babilonia.

Scheda tecnica (liberamente tratto):
Il robot e' un discendente diretto della famiglia di KakakaTz e
iLbEsTiO, alle cui note esplicative si rimanda, costituendone
una fusione. Innanzitutto il codice e' stato reso piu' leggibile
eliminando i cortocircuiti piu' strani e recuperando lo spazio perso
raccogliendo i brani piu' adatti. Durante questo passaggio, sono stati
corretti alcuni piccoli errori (almeno presunti tali) nelle direzioni
di frenata e nella sequenza if-else della routine di disturbo negli
angoli adiacenti. La modifica principale alla strategia risiede nello
spostamento delle oscillazioni corte nel caso appena descritto (il cui
comportamento e' stato reso piu' impavido) per integrarle con il
cambio di angolo difensivo, ora infatti se Enk. subisce dei danni ma
il nemico si trova lontano, preferisce rimanere dove si trova a
ciondolare alcune volte alternando i due assi. Questo nel tentativo di
distogliere da se stesso le malefiche attenzioni ed evitare di andare
a cacciarsi in guai peggiori. Inoltre nella routine di attacco f2f e'
stato aggiunto un controllo sulla variazione dell'angolo sulla
falsariga di quello presente in Satana (altra vecchia conoscenza), ed
e' stata tolta l'opzione cautelativa quando le condizioni siano
critiche, se si e' in ballo bisogna ballare. I parametri delle
scansioni nelle routine di fuoco sono stati ricalibrati, ho anche
invertito nella Toxica il peso della correzione sull'angolo,
nell'assunto che esso abbia maggiore rilevanza a corta distanza. Il
risultato non e' sempre positivo ma comunque mai peggiore, in ogni
modo sembra avere maggiore efficacia contro quegli avversari che
oscillano molto stretto.

*/

int oldang,oldrng,ang,range; /* angolo e distanza dell'avversario          */
int dir;                     /* direzione in cui camminare                 */
int clock,disturbo,cambio;   /* clock vale sempre 0 o 1, disturbo          */
                             /* e' la distanza a cui arrivare a rompere le */
                             /* scatole e cambio serve per contare i robot */
                             /* nell'arena                                 */
int sopra,destra;            /* posizione nell'arena (valore 0 o 1)        */
int attacco,flag;            /* attacco puo' valere 0 o 1 e flag e' un     */
                             /* contatore                                  */

/******************************************/
/*                                        */
/* Procedura Principale                   */
/*                                        */
/* Difesa ed Attacco                      */
/*                                        */
/******************************************/

main() {
  int danni,soglia,dir2;     /* danni    = % danni subiti               */
                             /* soglia   = tolleranza al dolore         */
                             /* dir2     = variabile d'appoggio per dir */

  /* va' all'angolino piu' vicino */

  ang=360;
  attacco=clock=disturbo=0;
  vai(180*(loc_x()<500));
  vai(270-180*(loc_y()>500));
  cambio=5;
  soglia=4;

  /* ciclo principale              */
  /* - pausa nell'angolino         */
  /* - oscillazioni d'attacco in 3 */
  /* - manovra evasiva             */
  /* e, in caso, attacco finale    */

  while(1) {
    danni=damage();
    while(damage()<danni+soglia) {

      /* robo-radar           */
      /* conteggio superstiti */
      /* nell'arena           */

      if (cambio>4) {
        ang=dir+353;
        cambio=9;
        flag=24;
        while(cambio && flag)
          if (scan(ang+15*((--flag)%8),7)) --cambio;
        flag=4;
        if (cambio>=6) {
          ++attacco;
          drive(dir,100);

        /* attacco finale                 */
        /* in caso di un solo superstite  */

          while(1) {
            serpiko(0);

            /* alla fine ho preferito un controllo */
            /* sulla distanza (vedi in Frena)      */

            if (--flag/*flag-=(oldang==ang)+1*/) {
              if (loc_y()>700) frena(270);
              else if (loc_y()<300) frena(90);
                   else if (loc_x()>700) frena(180);
                        else if (loc_x()<300) frena(0);
            }
            else frena(ang+135+90*(clock^=1));
          }
        } else if (cambio>=3) {

        /* disturbo quiete pubblica            */
        /* (attacco in caso di due superstiti) */

          ang+=7+90*clock;
          ++attacco;
          serpiko(1);
          if (oldrng)
            if (oldrng==range || damage()<60) {

              /* se vedi un robottino simil-statico */
              /* oppure hai abbastanza energia      */
              /* attaccalo con una oscillazione     */
              /* verso di lui                       */

              disturbo=1500-range;
              vai(dir2=dir+90*((ang%360)>(dir+45)));
              serpiko(0);
              disturbo=0;
              vai((dir2+180)%360);
              if (damage()>danni) { danni=damage(); clock^=1; }
            } else clock^=1;
          else { danni-=soglia; flag=0; }
          attacco=0;
        }
        cambio=0;
      }
      serpiko(1);
    }
    if ((!oldrng || oldrng>550) && flag)

      /* oscilla un poco           */
      /* (se il nemico e' lontano) */

      while(--flag) {
        disturbo=750;
        vai(dir2=dir+90*clock);
        disturbo=0;
        vai((dir2+180)%360);
        clock^=1;
      }
    else

      /* cambio angolino                  */
      /* (usato solo in caso di pericolo) */

      vai(dir+90*(scan(dir+8,10)>scan(dir+82,10)));
  }
}


/******************************************/
/*                                        */
/* Procedura Di Cambio Angolino           */
/* o di Oscillazione in Difesa            */
/*                                        */
/******************************************/

vai(newdir) {
  int limh1,limh2,liml1,liml2;
  while(speed()>=50);
  drive(dir=newdir,100);
  liml1=(limh1=150+disturbo)-60;     /* limiti x e y per lo spostamento */
  liml2=(limh2=850-disturbo)+60;     /* e/o oscillazione in attacco a 3 */

  /* alto           */

  if (dir==270)      {
    while(loc_y()>limh1) serpiko(0);
    if (!disturbo) { drive(dir,60); while(loc_y()>liml1); sopra=0; }
  }

  /* basso          */

  else if (dir==90)  {
    while(loc_y()<limh2) serpiko(0);
    if (!disturbo) { drive(dir,60); while(loc_y()<liml2); sopra=1; }
  }

  /* sinistra       */

  else if (dir==180) {
    while(loc_x()>limh1) serpiko(0);
    if (!disturbo) { drive(dir,60); while(loc_x()>liml1); destra=0; }
  }

  /* destra         */

  else               {
    while(loc_x()<limh2) serpiko(0);
    if (!disturbo) { drive(dir,60); while(loc_x()<liml2); destra=1; }
  }

  /* frenata finale */

  drive(dir,0);
  dir=180*sopra+90*(sopra^destra);
}


/******************************************/
/*                                        */
/* Procedura Di Frenata                   */
/* contro un solo avversario              */
/*                                        */
/* Con sparo veloce senza particolari     */
/* correzioni.                            */
/*                                        */
/******************************************/

frena(newdir) {
  if (dir!=newdir) {
    drive(dir,40);                   /* freno                           */
    while(speed()>=50) {             /* finche' freno sparo (ma veloce) */
      if (oldrng=scan(ang,10)) {
        oldang=ang;
        if (scan(ang+=5,5)); else ang-=10;
        if (scan(ang+=3,3)); else ang-=6;
        if (range=scan(ang,10))
          cannon(ang+(ang-oldang),range+(range-oldrng)*2);
      } else ang+=85;
    }
    drive(dir=newdir,100);           /* riaccelero                      */
  }
  if (oldrng<75) flag=4; else flag=2;
}


/******************************************/
/*                                        */
/* Procedura Di Sparo Preciso             */
/*                                        */
/* Con e senza correzione sulla direzione */
/* in cui si cammina.                     */
/*                                        */
/******************************************/

mira() {
  if (scan(ang+9,3)) ang+=9;
  if (scan(ang-9,3)) ang-=9;
  if (scan(ang+6,2)) ang+=6;
  if (scan(ang-6,2)) ang-=6;
  if (scan(ang+3,1)) ang+=3;
  if (scan(ang-3,1)) ang-=3;
}

serpiko(fermo) {
  if (oldrng=scan(ang,10));                    /* se non sto puntando un nemico          */
  else if (oldrng=scan(ang-=21,10));           /* ne cerco un'altro                      */
  else if (oldrng=scan(ang+=42,10));
  else return (ang+=42);
  if (oldrng<120) return cannon(ang,oldrng);   /* se e' troppo vicino lo sparo subito    */
  if (!attacco)                                /* se sto attaccando non cambio obiettivo */
    if (oldrng>730) { ang+=42; return ++cambio; }
  if (scan(ang-=5,5)); else ang+=10;           /* affinamento del tiro                   */
  mira();
  if (oldrng=scan(oldang=ang,10)) {
    mira();
    if (range=scan(ang,10))                    /* sparo con eventuale correzione sulla   */
                                               /* direzione di movimento                 */
      cannon(ang+(ang-oldang)*(/*(1200+range)>>9*/(950-range)>>8)-
        (1-fermo)*(sin(ang-dir)>>14),
        range*160/(160+oldrng-range-(1-fermo)*(cos(ang-dir)>>12)));
  }
}
