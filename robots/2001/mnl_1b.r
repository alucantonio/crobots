/**
 * Micro NL 1.00 B (c)robot
 * data finale di realizzazione:    30/11/2001
 *
 * dati dell'autore:
 *              Tognon Stefano
 *
 * Il robot va nell'angolo più vicino e vi rimane sempre, osclillando orrizzontalmente.
 * Se rimane un solo nemico lo attacca.
 * Purtroppo avevo puntato su una strategia a cambio d'angolo intelligente, ma non c'è
 * stato tempo per renderla efficente, pertanto ho aggiunto in extremix il f2f di
 * carletto, per non mandarlo senza nessun f2f.
 * NL_5B implementa parzialnente tale tecnica di cambio d'angolo, ma come potete vedere
 * è troppo inefficente.
 * sono comunque curiosa di vedere se MNL 1B si comporti meglio di NL 5B.
 * Potenza: non va oltre il 10° posto in tutti i tornei simulati con i vecchi
 * micro :-((((
 */

int nx, dx, ny, dy;
int ango, range, dir;
int timmax, flag, flag1;

main() {
  /* va nell'angolo più vicino */
  dx=150+(loc_x(dy=120+(loc_y()>500)*720)>500)*600;
  /* va nel centro gravitazionale */
  dir=direct();
  while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>1000) {
    fire(100);
  }

  while (1) {
    dir=rand(20)-10;/*rand(360);-*/
    /* rimane vicino al centro gravitazionale */
    while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)<10000) {
      fire(100);
    }

    /* ritorna verso il centro gravitazionale */
    dir=direct();
    while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>5000) {
      fire(100);
    }

    /* conta i superstiti da caccola.r*/
    if (++timmax>20) {
      timmax=flag=flag1=10;
      while (flag<370) flag1-=(scan(flag+=20,10)>0);

      if (flag1>8) {   /* esegue f2f */
        /* attacco finale preso da carletto.r */
        if (loc_y()<500) dir=90;
	else dir=270;
        while(1) {
          if ((loc_y()<440)||(loc_y()>560)) {
            fire(100);
          } else {
	      dir=180;
              while (loc_x()>200) fire(100);
	      dir=0;
              while (loc_x()<800) fire(100);
            }
        }
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
