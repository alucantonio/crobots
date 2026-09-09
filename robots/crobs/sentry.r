/**************SENTRY by Nicola Vaglica****************/
/*He moves back and forth horizontally and fires only at
  N,E,S,W,NE,SE,SW,NW                                  */

main()
{
 int range;

 while (loc_y()<400)
   drive(90,100);
 while (loc_y()>600)
   drive(270,100);
 
 while(1)
 {
 while (loc_x()<920)
  {
   drive(0,100);
   if (range=scan(90,10))
       cannon(90,range);
   if (range=scan(270,10))
       cannon(270,range);
   if (range=scan(0,10))
        cannon(0,range);
   if (range=scan(180,10))
       cannon(180,range);
   if (range=scan(45,10))
       cannon(45,range);
   if (range=scan(135,10))
       cannon(135,range);
   if (range=scan(225,10))
        cannon(225,range);
   if (range=scan(315,10))
       cannon(315,range);
  }
 while (loc_x()>80)
  {
   drive(180,100);
   if (range=scan(90,10))
      cannon(90,range);
   if (range=scan(270,10))
      cannon(270,range);
   if (range=scan(0,10))
      cannon(0,range);
   if (range=scan(180,10))
       cannon(180,range);
   if (range=scan(45,10))
       cannon(45,range); 
   if (range=scan(135,10))
       cannon(135,range);
   if (range=scan(225,10))
        cannon(225,range);
   if (range=scan(315,10))
       cannon(315,range);
  }
 }
}
