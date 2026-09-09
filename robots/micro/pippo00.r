/*
 descrizione:

 Questo robot, sviluppato in circa 10 minuti fa:

 si sposta sul lato destro e da li oscilla.
 Per sparare esegue una scansione del terreno e in base al range
 attuale e precedente spara

 Fine.

*/
int rng,orng,deg;
main()
{
   drive(0,100);
   while(loc_x()<960) sp();
   drive(90,0);
   while(speed()>49) sp();

   while(1) 
   {
        drive(90,100);
        while(loc_y()<920) sp();
        drive(270,0);

        while(speed() > 49) sp();

        drive(270,100);
        while(loc_y()>80) sp();
        drive(90,0);

        while(speed() > 49) sp();
   }

}

sp()
{ 
  if (rng=scan(deg,10))
    {
     deg -= 5*(scan(deg-5,1)>0);
     deg += 5*(scan(deg+5,1)>0);
     deg -= 3*(scan(deg-3,1)>0);
     deg += 3*(scan(deg+3,1)>0);
     
     cannon(deg,rng+rng-orng);
     orng=rng;
     if (rng>700) deg+=10;
    }
  else
   {
    deg+=10;
    if (deg>=300) deg=80;
   }
}
