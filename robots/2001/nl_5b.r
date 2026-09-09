/**
 * nome del Crobot:                    NL
 * versione:                         5.00  B
 * data finale di realizzazione:    30/11/2001
 *
 * dati dell'autore:
 *              Tognon Stefano
 *
 * Questo doveva essere il micro crobot (mnl 1b) che si muoveva tra gli angoli
 * in modo intelligente, ma non c'è stato tempo di completarlo.
 * Pertanto ho aggiunto il f2f di nl_5a per vedere quanto in basso può arrivare tra i big.
 * A differenza di mnl_1b, cerca di andare in uno dei 3 angoli liberi, dopo aver subito un
 * certo danno, altrimenti continua ad oscillare nel suo angolo.
 */

int nx, dx, ny, dy;
int ango, range, dir;
int timmax, flag, flag1;
int rng,orng,dir,deg,odeg,flag,q,t;
int angEnemy;                   /* angolo dove c'è il nemico */

main() {
  /* va nell'angolo più vicino*/
  dir=direct(dx=120+(loc_x(dy=120+(loc_y()>500)*720)>500)*600);
  while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>1000) {
    fire(100);
  }

  dam=damage();
  while (1) {
    dir=rand(20)-10;/*rand(360);-*/
    /* rimane vicino all'angolo */
    while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)<10000) {
      fire(100);
    }

    /* ritorna verso l'angolo */
    dir=direct();
    while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>5000) {
      fire(100);
    }

    if (damage()>dam+20) {
      /* cambia angolo perché hai subito molti danni */
      dir=direct(dx=120+(loc_x(dy=120+(loc_y()>500)*750)<500)*600);
      if (scan(dir, 10) !=0) {
        dir=direct(dx=120+(loc_x(dy=120+(loc_y()<500)*750)>500)*600);
	if (scan(dir, 10) !=0) {
	  dir=direct(dx=120+(loc_x(dy=120+(loc_y()<500)*750)<500)*600);
	}
      }
      if (scan(dir, 10)==0) {
        while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>5000) {
          fire(100);
	}
      }
      dam=damage();
    }

    /* conta i superstiti da caccola.r*/
    if (++timmax>20) {
      timmax=flag=flag1=10;
      while (flag<370) flag1-=(scan(flag+=20,10)>0);

      if (flag1>8) {   /* esegue f2f */
       f2f();
      }
    }
  }
}

/**
 * Return the direction to go
 */
int direct() {
  return dir=(360+((nx=dx-loc_x())<0)*180+atan(((dy-loc_y())*100000)/nx));
}

fire(sp) {
  drive (dir,sp);
  if((range=scan(ango,10))&&(range<770));
  else
    if((range=scan(ango+=339,10)));
    else
      if((range=scan(ango+=42,10)));
      else
        return (ango+=40);
    cannon (ango+=5+350*(scan(ango+355,5)>0),2*scan(ango,10)-range);
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

if (rng>300) {

    drive(angEnemy+45, 100);
    fire1();

    drive(angEnemy+45, 0);
    while (speed()>50)
      fire2();

    drive(angEnemy-90, 100);
    fire1();

    drive(angEnemy-90, 0);
    while (speed()>50)
      fire2();
} else {

    drive(-angEnemy+45, 100);
    fire1();

    drive(-angEnemy+45, 0);
    while (speed()>50)
      fire2();

    drive(-angEnemy-90, 100);
    fire1();

    drive(-angEnemy-90, 0);
    while (speed()>50)
      fire2();
  }
}
}


