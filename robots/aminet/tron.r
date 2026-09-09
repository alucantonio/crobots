/*A.U.G.U.P.
M.Scheler
 Dieser Robot fährt einfach ein Quadrat ab und ballert auf alles,
   was sich ihm in den Weg stellt.


   $VER: Tron's C-Robot V1.2 (25.04.93)

*/

int ddirec,pings;

shoot(direc)

int direc;

{
 int range;

 range=scan(direc+ddirec,15);
 if ((range>0)&&(range<700))
  {
   cannon (direc-5*ddirec+5,range);
   pings=pings+1;
   ddirec=(pings*5*100)/range;
  }
 else
  {
   pings=0;
   ddirec=0;
  }

 range=scan(direc+90,10);
 if (range>0) cannon (direc+90,range);
}

main()

{
 int ddirec;

 ddirec=0;
 pings=0;
 while (1)
  {
   /* nach oben Fahren (am linken Rand) */
   while (loc_y()<950)
    {
     drive (90,100);
     shoot (0);
    }
   drive (90,0);
   while (speed()>=50);

   /* nach rechts Fahren (am oberen Rand) */
   while (loc_x()<950)
    {
     drive (0,100);
     shoot (270);
    }
   drive (0,0);
   while (speed()>=50);

   /* nach unten Fahren (am rechten Rand) */
   while (loc_y()>50)
    {
     drive (270,100);
     shoot (180);
    }
   drive (270,0);
   while (speed()>=50);

   /* nach links Fahren (am unteren Rand) */
   while (loc_x()>50)
    {
     drive (180,100);
     shoot (90);
    }
   drive (180,0);
   while (speed()>=50);
  }
}
