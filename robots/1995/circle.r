/*  CIRCLE.R : Semplice robot sperimentale che si muove lungo una 
**             circonferenza di raggio 450 metri, centrata in 
**             (500,500). Quando viene colpito, fugge nel punto
**             diametralmente opposto rispetto alla posizione attuale.
**
**  Autore: EUGENIO GALLINA 
**
**  Supporto tecnico e logistico: 
**          ANDREA CODA
**
**
*/
          

main()
{
    int angle, sp, Cx, Cy, toll, range, z; 
    int radius, x, y, inc, sign, degree, width, dam;
  
    sp = 100;         /* Velocita' */
    Cx = 500;         /* Coordinata x del centro */
    Cy = 500;         /* Coordinata y del centro */
    radius = 450;     /* Raggio del cerchio */
    inc = 50;         /* Incremento della variabile x prop. al raggio */
    toll = 20;        /* Tolleranza per il posizionamento */ 
    width  = 5;       /* Apertura della scansione max=10 */
    z=degree=2*width; /* Angolo iniziale scansione e incremento */ 
    dam = 0;          /* Danno attuale */
    x = 50;           /* Ascissa di partenza */
    sign = 1;         /* Senso di rotazione iniziale (orario) */

  while (1) /* Ciclo principale */
  {
    /* Controllo i danni e se mi hanno beccato me la squaglio! */
    if (dam != damage())  
      {
        x = (Cx - x) + Cx; /* Punto simmetrico rispetto all'attuale pos. */
        dam = damage();
        inc *= (-1);     
        sign *= (-1);
      }

    /* Incremento X e calcolo il nuovo punto */
    x+=inc;    
    y=Cy+(sign*(sqrt((radius*radius)-((x-Cx)*(x-Cx)))));  

    /* Raggiungo il nuovo punto */ 
    angle = PlotCourse (x,y);                 
    drive(angle,sp);
    while ( (dist (loc_x(),loc_y(), x, y) > toll)  && speed() ); 
    drive (angle, 0);

    /* Cerco il bersaglio e sparo finche' e' a tiro */ 
    while (degree)
    {  
      degree = (degree + z) % 360; 
      range = scan(degree, width);   
      while( (range > 40) && (range<740) ) /* Sparo finche' l'avv. e' a tiro */ 
      {      
        cannon(degree, range);
        range = scan(degree, width);
        if (dam != damage()) /* Sono stato individuato: fuggo */
          range = degree = 0;
      }
      if (dam!=damage())
        degree=0;
    }

    degree = z;

    /* Guardo se sono arrivato agli estremi, cambio di segno all'incremento */   
    /* e alla funzione della traiettoria del cerchio. */ 
    if ((x <= (Cx - radius)) || (x >= (Cx + radius))) 
      { 
        inc *= (-1);     
        sign *= (-1);
      }
  } /* Fine ciclo principale */

}  /* Fine main */


/* Le seguenti funzioni sono "di libreria" :) */

/* classical pythagorean dist formula */
dist(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y, d;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}

/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */
PlotCourse(xx,yy)
int xx, yy;
{
  int x,y,d;
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

