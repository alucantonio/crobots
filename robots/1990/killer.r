/*
           >>> killer <<<

   crobot che spara mentre si muove
    by Enrico Colombini, Aprile 91

*/


/* principali migliorie possibili:
   - correggere delta a seconda della distanza del bersaglio
     (ma va modificata la struttura se delta != 5)
   - cercare in giro se non c'e' nessuno a tiro nel ventaglio
   - dare la precedenza ai bersagli di fronte
   - muoversi su almeno due lati, meglio se su tutti e 4
   - cercare a pieno campo (questa e' piu' complessa)
   - migliorare la mira interpolando 2 misure
*/


/* variabili globali (poco pulito ma piu' breve e veloce) */

int px,py;              /* destinazione corrente */
int ang;                /* angolo corrente */
int z1,z2,z3;           /* angoli iniziali di scanning */
int a1,a2,a3;           /* angoli correnti di scanning */
int delta;              /* correzione di scanning */


main()
{
    int destx;
    int desty;

    vaVerso(900,100,100);               /* va a posizione iniziale */
    while (distance(loc_x(),loc_y(),px,py) > 100 && speed() > 0) { }

    delta = -5;                         /* delta per sinistra */
    z1 = 120;                           /* ventaglio di scanning a sinistra */
    z2 = z1+delta; z3 = z2+delta;
    a1 = z1; a2 = z2; a3 = z3;          /* default iniziali scanner */
    destx = 50;                         /* prima destinazione */
    desty = 30;                         /* (costante) */

    while (1) {                         /* ciclo di gioco */
        vaVerso(destx,desty,100);       /* va verso sinistra */
        Attacca();                      /* sparando */

        destx = 1000-destx;             /* nuova destinazione */
        z1 = 180-z1;                    /* inverte zero scanner */
        z2 = 180-z2;
        z3 = 180-z3;
        delta = -delta;                 /* inverte delta */
        a1 = 180-a1;                    /* inverte tenendo agganciato */
        a2 = 180-a2;
        a3 = 180-a3;
    }
}


/* Attacca: spara mentre si muove verso la destinazione */

Attacca()
{
    int s1,s2,s3;
    int d;

    while (distance(loc_x(),loc_y(),px,py) > 100 && speed() > 0)
    {
        /* inizia ricerca, ignora se fuori range */
        if ((s1 = scan(a1,10)) > 700) { s1 = 0; }
        if ((s2 = scan(a2,10)) > 700) { s2 = 0; }
        if ((s3 = scan(a3,10)) > 700) { s3 = 0; }

        if (s2) {                       /* bersaglio in settore centrale */
            if (s3) {                   /* se anche in settore posteriore */
                cannon(a3,s3);          /* gli spara */
                a1 = a2; a2 = a3;       /* e lo segue con lo scanner */
                a3 += delta;
            } else {
                cannon(a2,s2);          /* altrimenti gli spara e basta */
            }
        } else if (s3) {                /* se solo in settore posteriore */
            cannon(a3+delta,s3);        /* spara un po' piu' in la' */
            a1 = a2+delta;              /* e lo segue con piu' decisione */
            a2 = a3+delta;
            a3 += (delta+delta);
        } else if (! s1) {              /* se nessun bersaglio */
            a1 = z1; a2 = z2; a3 = z3;  /* riazzera scanning */
        }

        d = scan(ang,10);               /* se ha qualcuno davanti */
        if (d > 0 && d <= 700) {
            cannon(ang,d);              /* gli spara */
        }
        d = scan(180-ang,10);           /* se ha qualcuno alle spalle */
        if (d > 0 && d <= 700) {
            cannon(180-ang,d);          /* pure */
        }
    }                                   /* fine loop quando arriva */
}



/* vaVerso: si dirige verso il punto x,y a veloc. v, aggiorna px, py, ang */
/*          prima di muoversi aspetta che sia fermo per evitare risonanze */

vaVerso(x,y,v)
int x;
int y;
int v;
{
    drive(90,0);                        /* spegne il motore */
    while (speed() > 0) { }             /* aspetta che sia fermo */
    px = x; py = y;                     /* registra destinazione */
    ang = plot_course(x,y);
    drive(ang,v);
}



/* --------- questa roba e' presa di peso dagli esempi: --------- */


/* classical pythagorean distance formula */

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;
  int d;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}


/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */
  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {      /* x is zero, we either move due north or south */
    if (yy > cury)
      d = 90;        /* north */
    else
      d = 270;       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
        d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
        d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
    } else {
      if (xx > curx)
        d = atan((scale * y) / x);        /* north-east, quadrant 1 */
      else
        d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (d);
}


