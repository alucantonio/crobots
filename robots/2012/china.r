/*
Torneo micro 2012

China.r del 15-novembre-2011,
assemblato da Marco Borsari.

Scheda tecnica:
Il robot e' ormai la terza generazione del suo progetto base, questo
differisce per pochi particolari rispetto a Piperita del 2011. Ho
corretto un refuso nella temporizazzione della routine di attacco
finale che conduceva ad avere delle oscillazioni sempre troppo corte.
A livello di strategia ho reso piu' lasca la distanza alla quale Chi.
si risolve, tenuto conto del danno, a rubare l'angolo all'avversario
in carica.
*/

int dir,ang,orng,
sx, /* sinistra o destra nell'arena */
dw, /* sotto o sopra nell'arena */
t,  /* segna tempo */
n;  /* contatore */

main() {
  ang=t=n=0;
  /* raggiunge l'angolo piu' vicino */
  sx=dw=-1;
  if (loc_x()<500) sx=1;
  if (loc_y()<500) dw=1;
  dir=90+90*sx;
  vai(loc_x(),sx,0,0);
  dir=180+90*dw;
  vai(loc_y(),dw,1,1);
  while (t<4) {
    /* guarda in senso orario */
    dir=135-45*sx*(2-dw);
    if (orng=scan(ang=dir-5,10));
    else orng=scan(ang-=20,10);
    if (orng>600-2*damage()) {
      /* attacca il nemico a triangolo */
      drive(dir-=30,100);
      while (!orng || orng>550) spara();
      frena(1);
      dir+=120;
      n=2;
      while (n) {
        --n; /* sincronizzato con lo sparo */
        dove(0,1-n);
        dir+=90;
      }
    } else {
      /* avanza nell'angolo successivo */
      if (t<3) dove(1,1);
      ++t;
    }
  }
  /* raggiunge il centro */
  drive(dir-=45,100);
  while ((500-loc_x())*sx>50) spara();
  t=0;
  while (1) {
    /* attacco finale */
    if (!(t%6)) {
      frena(1);
      if (n^=1) dir=ang+120;
      else dir+=180;
      drive(dir,100);
    }
    spara();
    ++t;
  }
}

frena(raw) {
int raw; /* avvicinamento */

  drive(dir,40);
  while (speed()>=50)
    if (raw) spara();
}

dove(chg,stop) {
int chg, /* cambia lato */
stop;

  if ((dir%=360)==0 || dir==180) {
    if (chg) sx=-sx;
    vai(loc_x(),sx,0,stop);
  } else {
    if (chg) dw=-dw;
    vai(loc_y(),dw,1,stop);
  }
}

vai(q,side,way,stop) {
int q, /* coordinata generica */
side,  /* lato nell'arena */
way,   /* in orizzontale o verticale */
stop;  /* fermata o no */

  drive(dir,100);
  while ((500-q)*side<400) {
    spara();
    if (way) q=loc_y();
    else q=loc_x();
  }
  frena(0);
  if (stop) drive(dir,0);
}

spara() {
int oang;

  if (orng=scan(oang=ang,10)) {
    if (scan(ang-=8,4));
    else if (scan(ang+=16,4));
    if (!scan(ang+=2,2)) ang-=4;
    /* peso variabile sull'angolo */
    cannon(ang+n*(ang-oang),2*scan(ang,10)-orng);
  } else if ((orng=scan(ang+=20,10)) && orng<750);
  else ang-=60;
}
