/*********************************/
/*                               */ 
/*          D ynamic             */
/*          I ntelligent         */
/*          M ultiscan           */ 
/*          A rchitecture        */ 
/*            REL. 9             */ 
/*                               */ 
/*      by Michele Di Maria      */
/*********************************/



main()
{
int drv,sca,a,b,aa,bb;

a=plot_course(500,500);    /* Si dirige verso il centro dell'arena (per evi-*/
drive(a,100);              /* tare di scontrarsi poi contro le pareti) */


while(1)
  {
 
    if ((aa=scan(a+5,5))!=0)   /* Se la torretta 'a' trova un bersaglio... */ 
    {
        cannon(a,aa);          /* allora spara alla distanza trovata   */
        b=a;                   /* e inizializza la torretta 'b' alla stessa */
    }                          /*  direzione */

      else
        a=a+10;                /* altrimenti incrementa l'angolo di scansione */

    if ((bb=scan(b-5,5))!=0)   /* Stesso discorso per la torretta 'b'  */
    {
        cannon(b,bb);        
        a=b;
    }
      else
        b=b-10;

    if ((aa=scan(a+5,5))!=0)   /* La procedura di attacco si ripete tre volte */
    {                          /* per diminuire drasticamente "l'overhead di  */
    cannon(a,aa);              /* rotta"  (cioe' il tempo utilizzato per tene-*/
        b=a;                   /* re la rotta che non puo' essere utilizzato  */
    }                          /* per attaccare gli altri robots              */ 

      else
        a=a+10;
    if ((bb=scan(b-5,5))!=0)
    {
        cannon(b,bb);        
        a=b;
    }
      else
        b=b-10;
    if ((aa=scan(a+5,5))!=0)
    {
        cannon(a,aa);
        b=a;
    }

      else
        a=a+10;
    if ((bb=scan(b-5,5))!=0)
    {
        cannon(b,bb);        
        a=b;
    }
      else
        b=b-10;
    drive(drv=(plot_course(500,500))+83,50);  /* Aggiunge al risultato della  */
                /* funzione plot_course 83 deg. per calcolare la rotta da se- */
                /* guire. Il tutto alla velocita' di 50 per evitare rallenta- */
                /* menti                                                      */
  }  

}


/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
/* Funzione riciclata dalla documentazione di Crobots */
/* nel file CROBOTS.DOC */

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
  x = curx - 500;
  y = cury - 500;

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

