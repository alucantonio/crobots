/*
        Robot    : NINJA.R

        Autore   : Stefano Vaccari

 STRATEGIA:  Ninja si porta il piu` vicino possibile ad un lato dove 
             non ci siano robot, e da li` comincia ad oscillare parallelo
             alla parete; dopo un po' striscia verso l'angolo, a piccoli
             passi, ed in prossimita` di esso cambia lato. Si muove quindi
             in senso orario, sempre attaccato alle pareti; se pero` viene
             colpito si sposta piu` frequentemente, oppure cambia lato se
             il danno e` ingente.
             La routine di sparo scansiona un'area di 200 gradi, iniziando
             dall'esterno e poi chiudendosi a ventaglio; se trova un nemico
             distante affina molto l'angolo di tiro, se invece e` vicino
             lascia piu` margine. Infine corregge la distanza e spara.
             Se si trova vicino ad un angolo cambia metodo e scansiona solo
             un'area di 100 gradi, con la stessa procedura.

*/



int lato;       /* 1=alto / 2=destra / 3=basso / 4=sinistra */
int RAGGIO;     /* raggio oscillazione                      */
int centro;     /* centro oscillazione                      */
int turni;      /* numero di oscillazioni sul posto         */

int p;          /* priorita` dei danni subiti               */
int ang,ang2;   /* angolo di scan e angolo speculare        */
int zone;       /* zone gia` controllate                    */

main() {

  RAGGIO=70;
  zone=0;

  /* Raggiungo il lato senza nemici, */
  /* poi rallento                    */

  if ( ! scan(90,10) )
    lato=4;
  else if ( ! scan(0,10) )
    lato=1;
  else if ( ! scan(270,10) )
    lato=2;
  else if ( ! scan(180,10) )
    lato=3;

  prossimo_lato();

  while (1) {

    if (centro>RAGGIO+20 && centro<999-RAGGIO-20) {
      oscilla();
      turni++;                       
    } else                           /* Cambio lato se non c'e` spazio */
      prossimo_lato();

    if (turni%2==0)                  /* Ogni 2 turni controllo i danni */
      p=colpito();

    if ( turni>8 || p ) {

      if (lato==1 || lato==4)          /* Mi sposto sullo stesso lato  */
        centro+=RAGGIO;                /* in senso orario rispetto al  */
      else                             /* perimetro dell'arena.        */
        centro-=RAGGIO;

      if (p==2)                        /* Se il danno e` grande vado... */
        if (lato==1 || lato==4)
          centro=999-RAGGIO*2;         /* ...alla fine del lato         */
        else
          centro=RAGGIO*2;             /* ...all'inizio del lato        */

      p=0;
      turni=0;

    }

  }

}


prossimo_lato() {

  if (lato==1) {                /* Dal lato 1 al lato 2 */
    ang=290;
    while (loc_x()<940) {
      drive(0,100);
      sparo_angolo();
    }
    while (loc_x()<975) {       /* Frena! */
      drive(0,10);
      sparo_angolo();
    }
  }
  else
  if (lato==2) {                /* Dal lato 2 al lato 3 */
    ang=200;
    while (loc_y()>60) {
      drive(270,100);
      sparo_angolo();
    }
    while (loc_y()>25) {        /* Frena! */
      drive(270,10);
      sparo_angolo();
    }
  }
  else
  if (lato==3) {                /* Dal lato 3 al lato 4 */
    ang=110;
    while (loc_x()>60) {
      drive(180,100);          
      sparo_angolo();
    }
    while (loc_x()>25) {        /* Frena! */
      drive(180,10);
      sparo_angolo();
    }
  }
  else
  if (lato==4) {                /* Dal lato 4 al lato 1 */
    ang=20;
    while (loc_y()<940) {
      drive(90,100);
      sparo_angolo();
    }
    while (loc_y()<974) {       /* Frena! */
      drive(90,10);
      sparo_angolo();
    }
  }

  lato++;               /* Perche` ho raggiunto il lato nuovo */

  if (lato==5)
    lato=1;

  if (lato==1 || lato==3)        /* Assegno il centro iniziale */
    centro=loc_x();
  else
    centro=loc_y();

  if (lato==1 || lato==4)        /* Cosi` il centro si allontana */
    centro+=RAGGIO*2;            /* dai margini dell'arena       */
  else
    centro-=RAGGIO*2;

  ang=260-90*lato+360;           /* Angolo di inizio scan           */
  ang2=100-90*lato+360;          /* Angolo di inizio scan speculare */

}



int old_danno;          /* Tiene conto del damage precedente */

colpito() {

  if (damage()>=old_danno+6)       /* danno tra 6 e 13: spostamento    */
    if (damage()>=old_danno+14) {  /* danno oltre i 13: cambio di lato */
      old_danno=damage();
      return 2;
    } else {
      old_danno=damage();         
      return 1;                  
    }
  else
    return 0;

}

int oscilla()
{

  if (lato==1 || lato==3) {
    while (loc_x()<centro+RAGGIO/2) {           /* A destra */
      drive(0,100);
      sparo();
    }
    while (speed()>50) {                        /* Frena! */
      drive(0,0);
      sparo();
    }
    while (loc_x()>centro-RAGGIO/2) {           /* A sinistra */
      drive(180,100);
      sparo();
    }
    while (speed()>50) {                        /* Frena! */
      drive(180,0);
      sparo();
    }
  }

  if (lato==2 || lato==4) {
    while (loc_y()<centro+RAGGIO/2) {           /* In alto */
      drive(90,100);
      sparo();
    }
    while (speed()>50) {                        /* Frena! */
      drive(90,0);
      sparo();
    }
    while (loc_y()>centro-RAGGIO/2) {           /* In basso */
      drive(270,100);
      sparo();
    }
    while (speed()>50) {                        /* Frena! */
      drive(270,0);
      sparo();
    }
  }

}

int dist_old;    /* vecchia posizione del nemico             */
int dist;        /* distanza obiettivo                       */

sparo()                                 
int temp_ang;                           
{

  if ( ! (dist_old=scan(ang,10)) || dist_old>740 )
    if ( ! (dist_old=scan(ang2,10)) || dist_old>740 ) {
      if (zone>4) {
        ang=260-90*lato+360;            /* Ho gia` controllato tutto */
        ang2=100-90*lato+360;
        zone=0;
      } else {
        ang+=18;                        /* Cambio angoli             */
        ang2-=18;
        zone++;
      }
      return;
    } else {
      temp_ang=ang;
      ang=ang2;
    }

  if ( (dist=scan(ang-5,5)) )
    cannone(ang-5);
  else
    cannone(ang+5);

  ang=temp_ang;

}

sparo_angolo() {

  if ( ! (dist_old=scan(ang,10)) || dist_old>740 ) {
    ang-=20;
    if ( zone++ > 5 ) {
      zone=0;
      ang=360-lato*90;          /* Il nuovo angolo di scansione */    
    }
    return;
  }

  if ( (dist=scan(ang-5,5)) )
    cannone(ang-5);
  else
    cannone(ang+5);


}

cannone(ang)             /* Qui lancio il missile */
int ang;
{

  if (dist<300) {        /* Se l'avversario e` vicino non affino la mira */

    if ( (dist=scan(ang-3,3)) )
      if ( dist + (dist-dist_old) > 50 )         /* Non mi sparo addosso */
        cannon(ang-3, dist + (dist-dist_old) );
    else {
      dist=scan(ang+3,3);
      if ( dist + (dist-dist_old) > 50 )
        cannon(ang+3, dist + (dist-dist_old) );
    }

  } else {

    if ( scan(ang-3,3) )
      ang-=3;
    else
      ang+=3;

    if ( (dist=scan(ang-1,1)) )
      cannon(ang-1, dist + (dist-dist_old) );
    else {
      dist=scan(ang+1,1);
      cannon(ang+1, dist + (dist-dist_old) );
    }

  }

}

