/* By Klausoft-Caserta. a nice robot anti-robocop2*/
int corner;
int c1x, c1y;
int s1;
int sc;
int a,b,d,min;
int dist,old;
int ran;

main()
{
  int ang;
  c1x = 996;  c1y = 4;  s1 = 0;
  new_point();
  ran = 270;
  a=186; b=90; 
  while (1) {
   while (ran < a) {
     while ((dist=scan(ran,2)) && (dist < 700 && dist > 30)) {
       if (old <= dist) {
       cannon(ran,15*dist/14);
       old=dist;
      } else {
        cannon(ran,7*dist/8);
        old=dist;
      }
      ran -= 4;
      if (damage() > 80 && s1 < 2) {
       c1x = 4; c1y = 996; s1 = 3;
       new_point();
       ran=90; a=360; b=264;
      }
     }
      ran += 4;
   }
   ran=b;
  }
}

/*Tutto il resto Š preso dagli esempi : Sniper.r*/

new_point() {
  int x, y;
  int angle;
  int new;
    x = c1x; 
    y = c1y; 
    sc = s1;

  angle = plot_course(x,y);

  drive(angle,100);

  while (distance(loc_x(),loc_y(),x,y) > 100 && speed() > 0) {
      if (dist=scan(ran,3))
       cannon(ran,dist);
      else {
       ran -= 23;
       if (!(dist=scan(ran,10))) 
        ran += 40;
       else 
        cannon(ran,dist);
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

  scale = 100000;  
  curx = loc_x();  
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {    
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