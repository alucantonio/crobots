/*
Torneo midi 2011

Ortica.r del 08-gennaio-2011,
assemblato da Marco Borsari.

Scheda tecnica:
Il robot e' un lieve miglioramento di Toppa del 2010, la cui
descrizione originale e' disponibile in archivio. Gli emendamenti piu'
importanti risiedono nella funzione di fuoco: la sequenza di
puntamento e' stata affinata, e i calcoli sulla rotazione non
producono piu' overflow. Di minore importanza, e' stata corretta la
direzione in cui si cerca un nemico sulla diagonale nelle oscillazioni
iniziali, e sono state modificate le distanze massime di ingaggio.
*/

int dmg,dir,ang,orng,
eng, /* limite di ingaggio */
sx,  /* sinistra o destra nell'arena */
dw,  /* sotto o sopra nell'arena */
t,   /* segna tempo */
n;   /* contatore */

main() {
int q; /* coordinata generica */

  ang=0;
  eng=750;
  /* raggiunge l'angolo piu' vicino */
  sx=dw=-1;
  if (loc_x()<500) sx=1;
  if (loc_y()<500) dw=1;
  dir=90+90*sx;
  vai(loc_x(),sx,0,0);
  dir=180+90*dw;
  vai(loc_y(),dw,1,1);
  /* controlla per un duello */
  dir=450-45*sx*(2-dw);
  if (guarda(dir)+guarda(dir-30)+guarda(dir+30)>1) t=124;
  else t=0;
  /* oscilla mentre attendi */
  while (t>4) {
    corri(150);
    if ((dmg=damage())>20 || (t<44 && !guarda(dir))) t=5;
    dir+=180;
    dove(0,(t==5));
    dir+=180;
    --t;
  }
  while (t>0) {
    /* guarda in senso orario */
    dir=135-45*sx*(2-dw);
    if (orng=scan(ang=dir-5,10));
    else orng=scan(ang-=20,10);
    if ((n=damage()-dmg)>6) {
      /* difenditi a quadrato */
      eng=600;
      n=n/2*4+1;
      while (--n) {
        if (!(n%4))
          if (orng && orng<250) q=250;
          else q=100;
        if (!(n%4) || (n%4==3))
          corri(q);
          else dove(0,(n==1));
        dir+=270;
      }
      dmg=damage();
      eng=750;
    } else if (orng>250) {
      /* attacca il nemico a triangolo */
      eng=1050;
      dmg=damage();
      drive(dir-=30,100);
      while (!orng || orng>550) spara();
      frena(1);
      dir+=120;
      n=3;
      while (--n) {
        dove(0,2-n);
        dir+=90;
      }
      eng=750;
    } else {
      /* avanza nell'angolo successivo */
      if (t>1) dove(1,1);
      --t;
    }
  }
  t=n=1;
  while (1) {
    /* attacco finale stile Boom */
    if(t%2) {
      if ((q=loc_x())>800) dir=180;
      else if (q<200) dir=0;
      else if ((q=loc_y())>800) dir=270;
      else if (q<200) dir=90;
      else if (orng<150) dir=(ang/90)*90;
      else dir=ang+60+210*(n^=1);
      drive(dir,100);
      spara();
    } else frena(1);
    ++t;
  }
}

int guarda(deg) {
int deg;

 if (scan(deg-10,10) || scan(deg+5,10)) return 1;
 else return 0;
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
  } else if (dir==90 || dir==270) {
    if (chg) dw=-dw;
    vai(loc_y(),dw,1,stop);
  } else {
    if (chg) {sx=-sx; dw=-dw;}
/*    if ((500-loc_x())*sx<(500-loc_y())*dw)
      vai(loc_x(),sx,0,stop);
    else*/ vai(loc_y(),dw,1,stop);
  }
}

vai(q,side,way,stop) {
int q,
side, /* lato nell'arena */
way,  /* in orizzontale o verticale */
stop; /* fermata o no */

  drive(dir,100);
  while ((500-q)*side<400) {
    spara();
    if (way) q=loc_y();
    else q=loc_x();
  }
  frena(0);
  if (stop) drive(dir,0);
}

corri(dist) {
int dist, /* distanza da percorrere */
x,y,xd,yd;

  x=loc_x();
  y=loc_y();
  xd=yd=0;
  drive(dir,100);
  while (sqrt(xd*xd+yd*yd)<dist) {
    spara();
    xd=loc_x()-x;
    yd=loc_y()-y;
  }
  frena(1);
}

spara() { /* STREssante Generatore di Attacco */
int rng,
rot,
dd; /* delta di Dirac */

  if ((orng=scan(ang,10)) && orng<eng) {
    rot=0;
    if (scan(ang,6)) {
      if (scan(ang-9,3)) rot=-1;
      if (scan(ang+9,3)) rot=1;
    } else if (scan(ang-=8,4));
    else if (scan(ang+=16,4));
    if (rng=scan(ang+10*rot,10)) {
      /* se in rotazione ad angolo almeno retto */
      if (rot && rng>orng)
        cannon(ang+rot*3*atan(sqrt((1<<16)-(1<<16)*orng/rng*orng/rng)*
          100000/(1<<8)*rng/orng)/2,rng);
      else {
        /* effetto tappeto mobile */
        if (rng-orng==0) dd=speed(); else dd=0;
        /* il proiettile non ha velocita' addittiva */
        cannon(ang,rng+2*(rng-orng)+cos(dir-ang)*rng*dd/(350-dd)/100000);
      }
    }
  } else if (scan(ang+=20,10));
  else if (scan(ang-=40,10));
  else ang-=40;
}
