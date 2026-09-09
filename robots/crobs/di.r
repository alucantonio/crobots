/* di.r Mike Saul */

main()
{ int z,d,g;

while (loc_y()>100)
  drive (270,100);
while (loc_y()>20)
  drive (270,40);
while (loc_x()>50)
  drive(180,100);
drive(180,0);
while (speed()>50);

while (1) {
  while (loc_x()<920) {
    drive(45,100);
    if (z=scan(315,3))
      cannon(315,z);
    if (z=scan(135,3))
      cannon(135,z);
    if (loc_x()<500) {
      if (z=scan(270,3))
        cannon(270,z);
      if (z=scan(180,3))
        cannon(180,z);
    } else {
      if (z=scan(0,3))
        cannon(0,z);
      if (z=scan(90,3))
        cannon(90,z);
    }
    if (z=scan(45,3))
        cannon(45,z);
      if (z=scan(225,3))
        cannon(225,z);
  }
  drive(45,49);
  while (speed()>50);
  while (loc_x()>80) {
    drive(225,100);
    if (z=scan(315,3))
      cannon(315,z);
    if (z=scan(135,3))
      cannon(135,z);
    if (loc_x()>500){
    if (z=scan(0,3))
      cannon(0,z);
    if (z=scan(90,3))
      cannon(90,z);
    } else {
      if (z=scan(270,3))
      cannon(270,z);
    if (z=scan(180,3))
      cannon(180,z);
    }
    if (z=scan(225,3))
      cannon(225,z);
    if (z=scan(45,3))
      cannon(45,z);
  }
  drive(225,49);
  while(speed()>50);
}
}