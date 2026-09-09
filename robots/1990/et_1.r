/* et_1.r - Luigi Morelli */

int course;
int boundary;
int angle;
int d1,d2,d3,d4;
int d;

main()

{
int x;
int range;

angle = 270;
while(1) {
  d = damage();
  drive (angle+=90,50);
  while (loc_x()<974 && d==damage()) {
    if (loc_x()%93+rand(3))
      cannon(angle+90,470+rand(40));
      if (loc_x() = 475) {
        if((range=scan(angle,10)) > 0)
          cannon(angle,range+2);
        }
    }
      if((range=scan(angle+90,10)) > 0)
        cannon(angle+90,range+2);
      drive (angle,0);
      drive (angle+=90,50);
  d = damage();
  while (loc_y()<981 && d==damage()) {
      if((range=scan(angle,10)) > 0)
        cannon(angle,range+2);
    }
      if((range=scan(angle+90,10)) > 0)
       cannon(angle+90,range+2);
  drive (angle,0);
  drive (angle+=90,50);
  d = damage();
  while(loc_x()>19 && d==damage()) {
      if((range=scan(angle,10)) > 0)
        cannon(angle,range+2);
    }
      if((range=scan(angle+90,10)) > 0)
        cannon(angle+90,range+2);
  drive (angle,0);
  d = damage();
  drive (angle+=90,50);
  while (loc_y()>21 && d==damage()) {
      if((range=scan(angle,10)) > 0)
        cannon(angle,range+2);
    }
      if((range=scan(angle+90,10)) > 0)
        cannon(angle+90,range+2);
  drive (angle,0);
  }
}


