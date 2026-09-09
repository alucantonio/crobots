/**
 * Micro NL 1.00 A (c)robot
 * data finale di realizzazione:    30/11/2001
 *
 * dati dell'autore:
 *              Tognon Stefano
 *
 * Il robot rimane immobile in un angolo finchè non subisce qualche danno, in
 * tal caso va verso l'angolo adiacente in cui c'è il nemico più vicino
 * (o nessun nemico).
 * Per non incorrere in patte, verso 150.000 cicli, il robot va verso i nemici
 * muovendosi lungo i bordi.
 * Se rimane un solo nemico lo attacca.
 * Potenza: non va oltre il 10° posto in tutti i tornei simulati con i vecchi
 * micro :-((((
 */

int limx;          /* limite spostamento orrizzonatale */
int limy;          /* limite spostamento verticale */
int dir;           /* direzione */
int deg,odeg;      /* gradi dove fa lo scan*/
int range,orange;  /* distanza del target */
int rng, orng;
int sx;            /* segno di x */
int sy;            /* segno fi y */
int dam;           /* ultimo damage */
int cycle;         /* cycle per non incorrere in patte*/
int go;
int flag, flag1, timmax;

main() {
  sx=sy=go=1;
  cycle=590;
  /* va nell'angolo più vicino */
  if (loc_x()>500) sx=-1;
  slow(orr(sx));
  if (loc_y()>500) sy=-1;
  ver(sy);
  while (1) {
    dam=damage(slow())+3;
    while ((damage()<=dam) && go) {
      fire();
      go=(--cycle>=0);
      if (++timmax>25) {
               timmax=flag=flag1=10;
               while (flag<370) flag1-=(scan(flag+=20,10)>0);
	       if (flag1>8) cycle=-1;
      }
    }

    /* va dove non c'è nessuno o dove c'è il nemico più vicino */
    /* oppure verso il nemico se siamo in time-out */
    if ((scan((sy-1)*90, 10) > scan((1-sx)*90+90, 10)) ^ go) {
      orr(sx*=-1);
    } else {
        ver(sy*=-1);
      }
  }
}

/**
 * Si sposta tutto a sx o tutto a dx a seconda del segno
 * @param sign =-1 va a dx, =+1 va a sx
 */
orr(sign) {
  int sign;
  dir = (sign+1)*90;

  limx = 500-sign*370;
  while( (sign*loc_x()) > (limx*sign) ) fire(100);
}

/**
 * Si sposta tutto a up o tutto dn a seconda del segno
 * @param sign =-1 va up, =+1 va dn
 */
ver(sign) {
  int sign;
  dir = (sign+1)*90 + 90;
  limy = 500-sign*360;
  while ( (sign*loc_y()) > (limy*sign)) fire(100);
}

slow() {
  while (speed()>50) fire();
}

/**
 * Spara al nemico in modo lento ma preciso
 */
fire(sp) {
  drive(dir,sp);
  if (orng=scan(deg,10));
  else if (orng=scan(deg+=20,10));
  else if (orng=scan(deg-=40,10));
  else return deg+=80;

  if (orng<200) return (1-cannon(deg,orng));

  if (scan(deg-=5,5)); else deg+=10;
  fscan();
  if (orng=scan(odeg=deg,5)) {
    fscan();
    if (rng=scan(deg,10))
      cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
  }
}

fscan() {
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
  if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;
}




