/*beaver
ill
 beaver - sophisticated hit and flee robot */

int dam;
int grenze;
int kurs;


main()
{

 int rot, rot_ende, akt_x, akt_y, step;

 dam=damage();              /* Sind wir getroffen ? */
 kurs=0;

 rot=0; step=45;
 while(rot < 360) {
  look(rot);
  rot+=step;
 }

 while(1) {

  if(dam+15> damage()) flee(); /* Wenn mich jemand getroffen hat -> abhauen */
  dam=damage();

  akt_x=loc_x();
  akt_y=loc_y();
  step=10;

  if (akt_x<250 && akt_y<250) { rot=270; rot_ende=540; }
   else
    if (akt_x<250 && akt_y>=750) { rot=180; rot_ende=450; }
     else
      if (akt_x>750 && akt_y<250) { rot=0; rot_ende=270; }
       else
        if (akt_x>750 && akt_y>=750) { rot=90; rot_ende=360; }
         else { rot=0; rot_ende=360; step=30; }

  while(rot<rot_ende) {
   look(rot);
   rot+=step;
  }

  move(rand(800)+100,rand(800)+100); /* Ein wenig weitergehen */

 }
}

entfernung(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  return(sqrt(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2))));
}

move (dest_x, dest_y)
int dest_x, dest_y;
{
  int kurs,range;

  kurs = zielfahrt(dest_x,dest_y);
  while (entfernung(loc_x(),loc_y(),dest_x,dest_y) > 50)
  {
    drive (kurs,100);
    if (range = scan(kurs,3))
      cannon(kurs,range);
    if (range = scan(kurs-180,3))
      cannon(kurs-180,range);
  }
  drive(kurs,0);
}

zielfahrt(xx,yy)
int xx, yy;
{
  int d,
      x,y;

  x = loc_x() - xx;
  y = loc_y() - yy;

  if (x == 0) {
    if (y > 0)
      d = 90;
    else
      d = 270;
  }
  else {
    d = atan((100000 * y) / x);
    if (x >= 0)
      d += 180;
    else if ((y > 0) && (x < 0))
      d += 360;
  }
  return (d % 360);
}

ziele(d,r,l)
int d,r,l;
{
  if (r > l)
    {
      if (scan(d-r,r) > 0)
        return(ziele(d-r,r/2,l));
      else
        if (scan(d+r,r) > 0)
          return(ziele(d+r,r/2,l));
        else
          if (scan(d,r) > 0)
            return(ziele(d,r/2,l));
          else
            return (d);
    }
  else
    return(d);
}

flee_schnell() {
  if (kurs == 0) {
    grenze = 5;
    kurs = 180;
  } else {
    grenze = 995;
    kurs = 0;
  }
  drive(kurs,50);
  kurs=(kurs+180) % 360;
  cannon(kurs,100);
  move(loc_x()-150+rand(300),loc_y()-150+rand(300));
}


look(deg)
int deg;
{
  int range, tmp;

  while ((range=scan(deg,5)) > 0 && range <= 700) {
    drive(kurs,40);
    cannon(deg,range);

    tmp=ziele(deg,10,2);
    cannon(tmp,scan(tmp,2));

    if (range>0) cannon(deg,range);
    if (dam+20 >= damage()) {
      dam = damage();
      flee_schnell();
      flee();
      return;
    }
  }
}

flee() /* Weg hier ! Wenn was auf dem Weg liegt, ballern ! */
{
  int x,y,zufallskurs,range,tmp;

  x = 1000-rand(500);
  y = 1000-rand(500);
  zufallskurs= zielfahrt(x,y);
  while (entfernung(loc_x(),loc_y(),x,y) > 50) {
    drive (zufallskurs,100);
    range = scan (zufallskurs-180,10);
    if (range > 0) {
     tmp=ziele(zufallskurs-180,10,2);
     cannon(tmp,scan(tmp,2));
    }
    else
      cannon(zufallskurs-180,range-70);
  }
  drive(0,0);
}
