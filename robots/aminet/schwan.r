/*Gio's home & Users
Andre,Gio,Peter
 'sterbender Schwan'
   der Ästhet unter den Robots - er tänzelt über das
   Spielfeld und zermantscht dabei seine Gegner */

main() {
 int px, py;
 int stepwidth;
 int r, alpha;
 int direction;
 int range;
 int olddam;
 int tmp;
 int i;

 stepwidth=10;
 drive(0,0);

 r=distance(loc_x(),loc_y(),500,500);
 alpha=degree(loc_x(),loc_y(),500,500);
 while (r>499) {
  alpha=degree(loc_x(),loc_y(),500,500);
  drive(alpha,49);
  r=distance(loc_x(),loc_y(),500,500);
 }
 drive(0,0);
 alpha=180+alpha;

 while (1) {
  olddam=damage();
  alpha=alpha+stepwidth;
  px=500+(r*cos(alpha))/100000;
  py=500+(r*sin(alpha))/100000;
  direction=degree(loc_x(),loc_y(),px,py);
  drive(direction,50);
  while (distance(loc_x(),loc_y(),px,py)<10) {
  }
  tmp=shoot(direction);
  if (rand(10)==1) {
   r=r+(rand(200)-100);
   if (r>450) r=450;
   if (r<100) r=100;
  }
  if (olddam!=damage())
   if (stepwidth<90) stepwidth+=20;
  else
   if (stepwidth>13) --stepwidth;
 }
}

/* Den Winkel der Verbindungsstrecker zweier Punkte am 2. Punkt
   ausrechnen */

int degree(x1,y1,x2,y2)
{
 int dx,dy;
 dx=(x2-x1);
 dy=(y2-y1);
 if (dx>0)
 {
  if (dy>0)
  {
   return (atan((100000*dy)/dx));         /* 1. Quadrant */
  } else if (dy==0) {
   return (0);
  } else {
   return (360-atan((100000*-dy)/dx));    /* 4. Quadrant */
  }
 } else {
  if (dy>0)
  {
   return (180-atan((100000*dy)/-dx));    /*  2. Quadrant */
  } else if (dy==0) {
   return (180);
  } else {
   return (180+atan((100000*-dy)/-dx));   /* 3. Quadrant */
  }
 }
}

int distance(x1,y1,x2,y2)
{
 return(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)));
}

int shoot(direction)
{
 int i;
 int range;

/* ZZA:
   Hier stand eine auskommentierte Befehlsgruppe, die Gio mich
   händeringend zu entfernen bat. Da sie auf dem Netz nur Platz
   verschwendet, tat ich ihm den Gefallen. Das Original findet
   sich selbstverständlich noch auf meiner Platte 8-)
*/
 i=-180;
 while ((i+=20)<180) {
  if ((range=scan(direction+i,10))>0) {
   cannon(direction+i,range);
   i=180;
  }
 }
 return(0);
}
