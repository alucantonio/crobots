/*
Torneo micro 2010

Macchia.r ver.### del 12-aprile-2010
Procurata da Marco Borsari con agente inquinante ignoto,
si declina ogni addebito dovuto alla decontaminazione.

Scheda tecnica (per quanto leggibile):
Questo robot ritiene (sconsideratamente) che la miglior strategia sia
l'attacco. Infatti appena preso posto nel suo angolo iniziale comincia
a tracciare una figura triangolare (1) con una inclinazione di 30ø
rispetto al lato vicino, verso il primo occupante in senso orario.
Finito con (da) questo, prosegue con il prossimo. Non fa nessuna conta
dei superstiti ne' controlla i propri danni, essendo privo di un
briciolo di cervello. Beh, non e' poi cosi' nera. Il movimento resta
ampio e regolato sulla distanza rilevata, dato che e' a ciclo continuo
dovrebbe almeno permettere di tenersi fuori portata dall'altro robot
adiacente. Inoltre se vede che l'avversario e' molto vicino o ha
lasciato libero il suo angolo, vi si reca. In realta' poi quando ha
compiuto 3 di questi spostamenti, Mac. si rende conto che e' probabile
si trovi in un faccia a faccia, e innesca l'attacco finale (2). Questo
consiste nel vibrare raccolto al centro dell'arena, con un angolo
sfasato di 120ø. La funzione di fuoco integra la caratteristica di
avere la correzione sull'angolo parametrizzata, sebbene non sia una
novita' essa e' in stretta simbiosi con il tipo di movimento in atto,
durante (1) e' massima quando si percorre il cateto corto, in (2) e'
alternata (piglia che ti piglio).
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
    if (orng>250) {
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
    if (t%600) {
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
int chg, /* cambia posizione */
stop;

  if ((dir%=360)==0 || dir==180) {
    if (chg) sx=-sx;
    vai(loc_x(),sx,0,stop);
  } else {
    if (chg) dw=-dw;
    vai(loc_y(),dw,1,stop);
  }
}

vai(q,pos,way,stop) {
int q, /* coordinata generica */
pos,   /* posizione nell'arena */
way,   /* in orizzontale o verticale */
stop;  /* fermata o no */

  drive(dir,100);
  while ((500-q)*pos<400) {
    spara();
    if (way) q=loc_y();
    else q=loc_x();
  }
  frena(0);
  if (stop) drive(dir,0);
}

spara() {
int oang;

  if ((orng=scan(oang=ang,10)) && orng<750) {
    if (scan(ang-=8,4));
    else if (scan(ang+=16,4));
    if (!scan(ang+=2,2)) ang-=4;
    /* peso variabile sull'angolo */
    cannon(ang+n*(ang-oang),2*scan(ang,10)-orng);
  } else if (scan(ang+=20,10));
  else if (scan(ang-=40,10));
  else ang-=40;
}
