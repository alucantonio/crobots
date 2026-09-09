/*
Torneo macro 2011

Digitale.r del 27-gennaio-2011,
assemblato da Marco Borsari.

Scheda tecnica:
Il robot e' uno sviluppo del midi Ortica. Usualmente, dopo un attacco
a triangolo che ha causato danni consistenti, si metteva a girare a
quadrato nel proprio angolo. Adesso, quando le condizioni fanno
ritenere di trovarsi in una fase di medio gioco (vedi la riga di
codice), in cui probabilmente sono rimasti solo 3 superstiti, Dig.
taglia per la diagonale verso l'angolo opposto. Visto il maggior
spazio a disposizione e' stata anche sostituita la funzione di fuoco
con una derivata da !Alien.
*/

int dmg,dir,ang,orng,
eng, /* limite di ingaggio */
sx,  /* sinistra o destra nell'arena */
dw,  /* sotto o sopra nell'arena */
t,   /* segna tempo */
n;   /* contatore */

main() {
int q;  /* coordinata generica */

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
      if (t==2 && damage()>80) {
        /* salta all'angolo opposto */
        dir+=315;
        dove(1,1);
        --t;
      } else {
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
        eng=750;
      }
      dmg=damage();
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
    if ((500-loc_x())*sx<(500-loc_y())*dw)
      vai(loc_x(),sx,0,stop);
    else vai(loc_y(),dw,1,stop);
  }
}

vai(q,side,way,stop) {
int q,
side, /* lato nell'arena */
way,  /* in orizzontale o verticale */
stop; /* fermata o no */

  drive(dir,100);
  while ((q=(500-q)*side)<400) {
    if (q<325) spara();
    else cerca();
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

spara() { /* Toxica 2nda generazione */
int oang,rng,
asin,acos;

  if (scan(ang,10)<eng) {
    asin=(sin(ang-dir)/14384);
    acos=(cos(ang-dir)/3796)-230;

    ang-=18*(scan(ang-18,10)>0);
    ang+=18*(scan(ang+18,10)>0);

    if (scan(ang-16,10)) ang-=8;
    else if (scan(ang+16,10)) ang+=8;
    if (scan(ang-12,10)) ang-=4;
    else if (scan(ang+12,10)) ang+=4;
    if (scan(ang-11,10)) ang-=2;
    if (scan(ang+11,10)) ang+=2;

    if (orng=scan(oang=ang,3)) {
      if (scan(ang-13,10)) ang-=5;
      else if (scan(ang+13,10)) ang+=5;
      if (scan(ang+12,10)) ang+=4;
      else if (scan(ang-12,10)) ang-=4;
      if (scan(ang-11,10)) ang-=2;
      if (scan(ang+11,10)) ang+=2;

      cannon(ang+(ang-oang)*((880+(rng=scan(ang,10)))/482)-asin,
        rng*230/(orng-rng-acos));
    } else cerca();
  } else cerca();
}

cerca() {
  if ((orng=scan(ang+=10,10)) && orng<eng)
    return cannon(ang,2*scan(ang,10)-orng);
  if ((orng=scan(ang-=20,10)) && orng<eng)
    return cannon(ang,2*scan(ang,10)-orng);
  if (scan(ang+=40,10));
  else if (scan(ang-=60,10));
  else ang-=40;
}
