/*
 descrizione:

 Questo robot, sviluppato in circa 10 minuti fa:

 
 si sposta sul lato sinistro e da li oscilla.
 Per sparare esegue una scansione del terreno e in base al range
 attuale e precedente spara
 La differenza rispetto all'altro e' che ad ogni oscillazione
 si riposa fino a quando non e' colpito.
 La funzione di fuoco deriva da Tox.r

 
 
 Fine.

*/
int range,orange,ang,oang,dam,aa,rr;

main()
{
   drive(180,100);
   while(loc_x()>40) sp();
   drive(90,0);
   while(speed()>49) sp();

   while(1) 
   {
        while(loc_y()<920)
         {
          drive(90,100);
          sp();
         }
        stop(270);

        while(loc_y()>80) sp();
         {
          drive(270,100);
          sp();
         }

        stop(90);
   }

}

sp()
{ 
     if(scan(ang,5))
      {
       if(scan(ang-5,1)) ang-=5;
       if(scan(ang+5,1)) ang+=5;
       if(scan(ang-3,1)) ang-=3;
       if(scan(ang+3,1)) ang+=3;
       if (range=scan(ang,5))
         {
           orange=range;
           oang=ang;
             if (range=scan(ang,10))
               {
                 aa=(ang+(ang-oang)*((1200+range)>>9));
                 rr=(range*165/(165+orange-range));
                 cannon(aa,rr);
                 if (range>700) ang+=30;
               }
         }
      }
    else if(scan(ang-=10,10));
         else if(scan(ang+=20,10));
              else while ((scan(ang+=15,10))== 0);
   
}

stop(x)
{
        drive(x,0);

        while(speed() > 49) sp();
        dam=damage();
        while(dam>damage()-10)sp();
}
