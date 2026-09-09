/*
  Pippo98
  Creola Andrea

  Tattica: Il robot si porta nel lato destro dell'arena, e li si mette a
           oscillare nella parte alta del video . Fine della tattica,
           purtroppo a causa del tempo (poco) Š risultata semplice.

*/
int r, deg, rng, num;
main()
{
 drive(0,100);
 while(loc_x()<950) sp();
 drive(90,0);
 while(speed()>50) sp();

 while(1)
 { 
  drive(90,100);
  while(loc_y()<900) sp();
  drive(270,0);
  while(speed()>50) sp();
 
  drive(270,100);
  while(loc_y()>700) sp();
  drive(90,0);
  while(speed()>50) sp();
 }
}


sp()
{
if (!(rng=scan(deg,10)))
if (!(rng=scan(deg-=20,10)))
if (!(rng=scan(deg+=40,10)))
  {
    num = 6;
    while (!(rng = scan(deg += 20, 10)) && (--num));
    return;
  }
if (!scan(deg+=5,5)) deg-=10;
if (!scan(deg+=3,3)) deg-=6;
if (r=scan(deg,10))
 {
  if(r<700) cannon(deg,r+r-rng);
  else deg+=40;
 }
}

