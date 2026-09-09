/* Mutation Ver. 1.0

 ***************************************************************
 Programmato da:

 Marco Varagnolo


 Strategia:
 Il robot si muove sul campo di battaglia eseguendo  dei giri in
 senso orario, e a seconda del senso di marcia (right,down,left,
 up)  vengono  attivate  delle  procedure  (radar1,radar2,radar3
 radar4) che controllano dove sparare.
 Quando pero' la percentuale dei danni supera il 60% (la percen-
 tuale effettiva è però nella maggior parte dei casi sempre mol-
 to  superiore al 60%) allora il robot cambia strategia e si ri-
 fugia sul lato sinistro dell'area di combattimento, e muovendo-
 si lungo questo  lato spara variando il  range a seconda  della
 distanza del bersaglio.

 ***************************************************************/


int d,ang,newrange,oldrange;

main()
{
 while(d<=60) /*Esegue la prima tattica finché i danni sono < del 60% */
 {
  if (loc_x()>=80) left();
    else
      right();
  if (loc_y()>=920) down();
    else
      up();
 }
if (d>60)     /*Quando i danni superano il 60% adotta la seconda tattica */
{
 left();
 while(damage()!=100) defence();
}
}



left()
{
 while(loc_x()>=80)
{
 d=damage();
 drive(180,100);
 radar1();
}
}

down()
{
 while(loc_y()>=80)
{
 d=damage();
 drive(270,100);
 radar2();
}
}

right()
{
 while(loc_x()<=920)
{
 d=damage();
 drive(0,100);
 radar3();
}
}

up()
{
 while(loc_y()<=910)
{
 d=damage();
 drive(90,100);
 radar4();
}
}

defence()  /* Tattica adottata in caso di danni superiori al 60% */
{
 ang=270;
 drive(90,0);
 while(speed()>50) newfire();
 while(damage()!=100)
 {
  drive(90,100);
  while(loc_y()<920) newfire();
  drive(270,0);
  while(speed()>50) newfire();
  drive(270,100);
  while(loc_y()>80) newfire();
  drive(90,0);
  while(speed()>50) newfire();
 }
}

newfire()  /* Procedura per variare il range a seconda del bersaglio */
{
 if(newrange=scan(ang,10))
 {
  if (oldrange<newrange)
   {
    cannon(ang,8*newrange/7);
    oldrange=newrange;
   }
    else
     {
      cannon(ang,7*newrange/8);
      oldrange=newrange;
     }
   }
    else
     {
       ang+=14;
      if(ang>359)
       ang-=354;
       else
      if(ang>90)
       ang+=186;

     }
}


radar1() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(180,10)) cannon(180,7*range/8);
if (range=scan(135,10)) cannon(135,7*range/8);
if (range=scan(45,10))  cannon(45,7*range/8);
if (range=scan(0,10))   cannon(0,7*range/8);
}

radar2() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(270,10)) cannon(270,7*range/8);
if (range=scan(225,10)) cannon(225,7*range/8);
if (range=scan(90,10))  cannon(90,7*range/8);
if (range=scan(135,10)) cannon(135,7*range/8);
}

radar3() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(0,10))   cannon(0,7*range/8);
if (range=scan(315,10)) cannon(315,7*range/8);
if (range=scan(180,10)) cannon(180,7*range/8);
if (range=scan(225,10)) cannon(225,7*range/8);
}

radar4() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(90,10))  cannon(90,7*range/8);
if (range=scan(45,10))  cannon(45,7*range/8);
if (range=scan(270,10)) cannon(270,7*range/8);
if (range=scan(315,10)) cannon(315,7*range/8);
}
