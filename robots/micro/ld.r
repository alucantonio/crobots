/*
   LiveDeviL
   Version 0.1.8 (beta)
   Programmed by
   Fabio Gruppioni
   "Sigh... il mio primo pargolo, manco svezzato!"
*/
int dir,ang,ang2,angd,range,range2,ranged,x,y,x2,y2;
main() {
  gotoxy(975,25);
  while(1) {
    x = loc_x();
    y = loc_y();
    checkdir();
    ang = 8;
    while (ang<360) {
      range = scan(ang,8);
      if (range)
        uccidi();
      ang += 16;
    }
  }
}
gotoxy(x2,y2) {
  if (x2==x) /* Elimino i casi di divisione per 0 */
    x2 += 1;
  drive(dir=180 + 180*(x2>x)+atan(100000*(y-y2)/(x-x2)),100);
}

checkdir() {
  if (y<500)
    gotoxy(975,975);
  else
    gotoxy(975,25);
}

uccidi() {
  cannon(ang,range);
  ang2 = ang;
  if(scan(ang2-4,4)) ang2 -= 4;
  else ang2 += 4;
  if(scan(ang2-2,2)) ang2 -= 2;
  else ang2 += 2;
  if(scan(ang2-1,1)) ang2 -= 1;
  else ang2 += 1;
  range2 = scan(ang2,1);
  while (range2) {
    angd = ang2-ang;
    ranged = range2-range;
    cannon(ang2+angd,range2+ranged);
    drive(ang2,100);
    if(speed()==0)
      drive(ang2,100);
    cannon(ang2-angd,range2+ranged);
    ang=ang2;
    range=range2;
    range2=scan(ang2,1);
  }
  ang -= 32;
}