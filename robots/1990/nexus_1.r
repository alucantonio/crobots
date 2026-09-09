
/*                              mio.r                                    */
/* Vincenzo Benincasa */

int d, pa, ang;
main()
{
   drive(0,100);
   while(loc_x()<960) spara();
   drive(90,0);
   while(speed()>49) spara();

   ang=270;
   while(1)
   {
        drive(90,100);
        while(loc_y()<920) spara();
        drive(270,0);

        while(speed() > 49) spara();

        drive(270,100);
        while(loc_y()>80) spara();
        drive(90,0);

        while(speed() > 49) spara();
   }


}

spara()
{
   int range;

   if(range=scan(ang,10))
       cannon(ang,range);
   else
   {
      ang-=20;
      if(ang<=70) ang=270;
   }
}














