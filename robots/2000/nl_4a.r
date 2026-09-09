/**
 * nome del Crobot:                    NL
 * versione:                         4.00  A
 * data finale di realizzazione:    30/10/2000
 *
 * dati dell'autore:
 *              Tognon Stefano
 *
 * strategia:
 *  Questo crobots è la quello dello scorso anno, modificato per renderlo un
 *  pò più efficiente.
 *  In particolare, grazie al maggior numero di istruzioni ora permesse, la
 *  fase f2f è stata completamente cambiata e risulta abbastanza buona.
 *  Si noti che il movimento nella fase f2f è a zig zag e il crobot tende ad
 *  andare verso il nemico. La routine di fuoco è quella di satana.r,
 *  modificata solo quel che basta per rendere il movimento del robot "sicuro"
 *  Infatti, non viene effettuato nessun controllo su dove il crobot stia
 *  andando, in modo da non sprecare tempo e essere pronti a sparare non appena
 *  il colpo viene ricaricato, pertanto è essenziale andare sempre verso il
 *  robot nemico, in modo da non impattare sui muri.
 *  Purtroppo la routine finale di attacco è appositamente studiata per il f2f,
 *  pertanto deve essere attivata solo con 1 nemico presente (altrimenti sarebbe
 *  un suicidio).
 *  Pertanto non c'è nessun controllo per evitare di incorrere in patte, se ci
 *  stiamo scontrando con robot difensivi (cosa che era presente in quello dello
 *  scorso anno).
 *
 * nota personale:
 *  ora che ho a disposizione 2000 istruzioni, non ho il tempo materiale per
 *  costruire un crobot che le utilizzi in modo efficiente (le idee non mancano,
 *  il tempo invece si)!!!
 *  Purtroppo la innatra efficienza avrà poca storia con il nuovo sistema di
 *  punteggio. Comunque l'importante è partecipare ...
 *  Un grazie a tutti gli autori dei crobots a cui è stato attinto, ma di cui ho
 *  perso il conto...
 */


int rng,orng,dir,deg,odeg,flag,q,t;

int temp1,temp2,temp3,dam;

int cycle;
int strat; /* strategia attuale: angolo: 0=dxup 1=sxup 3=sxdn 2=dxdn */

int i;                          /* variabile per cicli  */
int tmp;                        /* variabile temporanea */
int angEnemy;                   /* angolo dove c'è il nemico */


/**
 * Restituisce vero se è rimasto un solo robot
 * Routine di scansione veloce, ma può sbagliare nel caso di robot che stanno
 * sullo stesso cono di scansione
 *
 * @return vero se c'è un solo robot
 */
int only1() {
  i=-10;
  tmp=0;
  while (i<360) {
    if (scan(i+=20, 10))
      if (++tmp>1) return 0;
  }
  return 1;
}


main() {
  strat=0;
  if (loc_x()<500) {sx(100); ++strat;} else dx(900);
  if (loc_y()<500) {dw(100); strat+=2;} else up(900);

  while(1) {

    /**
     * come prima cosa controlla se c'è solo un robot, perchè in uno scontro
     * diretto è meglio essere subito pronti
     */
    if (only1())                  /* ne rimane 1?   */
      f2f();                      /* esegui il F2F  */
    else v4s4();                  /* esegui il 4vs4 */
  }
}

/**
 * Esegue lo scontro face 2 face.
 * Si avvicina al nemico con un movimento a zig-zag.
 * Stare vicino al nemico pùo significare sparare con più precisione rispetto
 * ai robot toxed based.
 * Non viene effettuato nessun controllo su dove stiamo andando!!!
 * Si spera che tutti i robot nemici non stiano sui bordi o negli angoli nella
 * fase f2f, così se si va verso il robot nemico, non si dovrebbe incappare
 * nei muri.
 * Il movimento alla max velocità è molto lento: dopo aver sparato un colpo
 * (in modo sicuro e non), si cambia subito direzione.
 */
f2f() {
  while (1) {
    drive(angEnemy+45, 100);
    fire1();
    fire2();
    drive(angEnemy+45, 100);

    drive(angEnemy+45, 0);
    while (speed()>50)
      fire2();

    drive(angEnemy-90, 100);
    fire1();
    fire2();
    drive(angEnemy-90, 100);

    drive(angEnemy-90, 0);
    while (speed()>50)
      fire2();
  }
}

/**
 * Esegue lo scontro 4 contro 4.
 */
v4s4() {
  if (damage()<(dam+4)) {

    Fire(1);

  } else {
      if (strat==0) strat=StDxUp();            /* scegli la strategia */
      else if (strat==1) strat=StSxUp();
           else if (strat==3) strat=StSxDn();
                else strat=StDxDn();
      dam=damage();
    }
}

up(l) { dir=90;  while(loc_y()<l) { drive(90,100);  Fire(); } drive(270,0); }
dw(l) { dir=270; while(loc_y()>l) { drive(270,100); Fire(); } drive(90,0);  }
dx(l) { dir=0;   while(loc_x()<l) { drive(0,100);   Fire(); } drive(180,0); }
sx(l) { dir=180; while(loc_x()>l) { drive(180,100); Fire(); } drive(0,0);   }

/* Calcola le distanze dai bersagli negli angoli (e lati) */
dist(ang) {
  temp1=scan(ang,10)+scan(ang+20,10);
  temp2=scan(ang+60,10)+scan(ang+80,10);
}

int StDxUp() {
  dist(185);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    sx(100);
    return 1;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dw(100);
    return 2;
  }
  if (temp1<temp2) {   /* vado dove c'è più distanza  */
    dw(600);
    up(900);
  } else {
      sx(600);
      dx(900);
    }
  return 0;
}

int StSxUp() {
  dist(275);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dw(100);
    return 3;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dx(900);
    return 0;
  }
  if (temp1<temp2) {   /* vado dove c'è più distanza */
    dx(400);
    sx(100);
  } else {
      dw(600);
      up(900);
    }  
  return 1;
}

int StSxDn() {
  dist(5);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dx(900);
    return 2;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    up(900);
    return 1;
  }
  if (temp1<temp2) {
    up(400);
    dw(100);
  } else {
      dx(400);
      sx(100);
    }
  return 3;
}

int StDxDn() {
  dist(85);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    up(900);
    return 0;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    sx(100);
    return 3;
  }
  if (temp1>temp2) {
    sx(600);
    dx(900);
  } else {
      up(400);
      dw(100);
    }
  return 2;
}

Fire(flag) {
  if (orng=scan(deg,10)) {
    if (!scan(deg-=5,5)) deg+=10;
    if (orng>700) {
      if (!scan(deg-=3,3)) deg+=6;
      cannon(deg,orng);
      deg+=40;
      return;
    }

    if(scan(deg-5,1)) deg-=5;
    if(scan(deg+5,1)) deg+=5;
    if(scan(deg-3,1)) deg-=3;
    if(scan(deg+3,1)) deg+=3;
    if(scan(deg-1,1)) deg-=1;
    if(scan(deg+1,1)) deg+=1;

    if (orng=scan(odeg=deg,5)) {
      if(scan(deg-5,1)) deg-=5;
      if(scan(deg+5,1)) deg+=5;
      if(scan(deg-3,1)) deg-=3;
      if(scan(deg+3,1)) deg+=3;
      if(scan(deg-1,1)) deg-=1;
      if(scan(deg+1,1)) deg+=1;

      if (rng=scan(deg,10)) {
        if (flag) {
          cannon(deg+(deg-odeg)*((1200+rng)>>9), rng*160/(160+orng-rng));
        } else {
            cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
          }
      }
    }
  } else {
      if (scan(deg-=20,10)) return;
      if (scan(deg+=40,10)) return;
      deg+=40; return;
    }
}


/**
 * Spara al nemico, ma si accerta di aver sparato. Dato che stiamo andando alla
 * massima velocità, siamo meno vulnerabili, perciò possiamo permetterci di
 * essere sicuri di aver sparato
 */
int fire1() {
  while (1) {
    if (orng=scan(deg,10)) {
      odeg=deg;
      if (scan(deg+=5,5)); else deg-=10;
      if (scan(deg+=3,3)); else deg-=6;
         if (rng=scan(deg,10))
           angEnemy=(deg+(deg-odeg));
           if (cannon(angEnemy,rng+(rng-orng)*2)) {
             return 1;
           }
    }
    else if (scan(deg+=21,10));
         else if (scan(deg-=42,10));
              else deg+=84;
  }
}

/**
 * Spara come nel caso precente, ma dato che stiamo rallentando, è preferibile
 * essere veloci, perciò non viene accertato se effettivamente si è sparato
 */
int fire2() {
    if (orng=scan(deg,10)) {
      odeg=deg;
      if (scan(deg+=5,5)); else deg-=10;
      if (scan(deg+=3,3)); else deg-=6;
         if (rng=scan(deg,10))
           angEnemy=(deg+(deg-odeg));
           if (cannon(angEnemy,rng+(rng-orng)*2)) {
             return 1;
           }
    }
    else if (scan(deg+=21,10));
         else if (scan(deg-=42,10));
              else deg+=84;
}

