/*by Klausoft-Caserta.  "Rock around the clock"*/
/*Questo robot può, anzi deve essere migliorato*/
int corner;           /* Probabilmente c'è qualche variabile di troppo  */
int c1x, c1y;         /* Var punti iniziali (possono essere variati) */
int d;
int dist;

main()
{
  int ran;
  int ang; /* Var. direzione */
  c1x = 500;  c1y = 150;
  new_point();
  while (1) {         /* loop is executed forever */
      ang += 1;
      drive(ang,45);  /* Giro-giro-tondo */
      if (dist=scan(ran,3)) 
       cannon(ran,dist);   /* fire! */
      else {
       ran -= 23;
       if (!(dist=scan(ran,10))) 
        ran += 40;
       else 
        cannon(ran,dist);   /* fire! */
      }
  }
}

/* Tutto il resto che segue Š stato preso dagli esempi */

new_point() {
  int x, y;
  int angle;
  int new;
  int ran;
    x = c1x; 
    y = c1y; 

  angle = plot_course(x,y);

  drive(angle,100);

  while (distance(loc_x(),loc_y(),x,y) > 100 && speed() > 0) {
      if (dist=scan(ran,3))
       cannon(ran,dist);   /* fire! */
      else {
       ran -= 23;
       if (!(dist=scan(ran,10))) 
        ran += 40;
       else 
        cannon(ran,dist);   /* fire! */
      }
  }
  drive(angle,15);
  while (distance(loc_x(),loc_y(),x,y) > 10 && speed() > 0)
    ;

  drive(angle,0); 
}

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}


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
