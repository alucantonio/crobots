/*
        ROBOT1.R
        By Andrea Roncoroni
*/

/*
La strategia de robot e' molto semplice:
Il robot continua a mouversi secondo uno schema fisso cercando in continuazione
un altro robot da colpire. Quando lo trova, continua a muoversi ma segue con
lo sparo il bersaglio.
*/

int rad,range;
main()
{
 rad=0;
 if(loc_x()<450)
  {
   drive(0,100);
   while(loc_x()<450) fire();
   drive(0,0);
  }
 else
  if(loc_x()>550)
  {
   drive(180,100);
   while(loc_x()>550) fire();
   drive(180,0);
  }
 while(speed()>10);
 drive(90,100);
 while(loc_y()<900) fire();
 drive(90,0);
 while(speed()>10);
 while(1)
 {
 drive(315,100);
 while(loc_x()<900)
  fire();
 drive(315,0);
 while(speed()>40) fire();
 drive(225,100);
 while(loc_y()>100)
  fire();
 drive(225,0);
 while(speed()>40) fire();
 drive(135,100);
 while(loc_x()>100)
  fire();
 drive(135,0);
 while(speed()>40) fire();
 drive(45,100);
 while(loc_y()<900)
  fire();
 drive(45,0);
 while(speed()>40) fire();
 }
}

fire()
{
   if(range=scan(rad,10))
     cannon(rad,range);
   rad+=20;
}
