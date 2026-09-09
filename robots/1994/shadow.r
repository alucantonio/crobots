  /*{   Author  : Marco Varagnolo                                       }
    {   Robot   : Shadow                                                }

                              ¯ STRATEGY ®

    {  Il robot si muove sul campo di battaglia eseguendo  dei giri in  }
    {  senso orario, e a seconda del senso di marcia (right,down,left,  }
    {  up)  vengono  attivate  delle  procedure  (radar1,radar2,radar3  }
    {  radar4) che controllano dove sparare.                            }
    {  Quando pero' la percentuale dei danni supera il 50% (la percen-  }
    {  tuale effettiva è però nella maggior parte dei casi sempre mol-  }
    {  to  superiore al 50%) allora il robot cambia strategia e si ri-  }
    {  fugia sul lato sinistro dell'area di combattimento, e muovendo-  }
    {  si lungo questo  lato spara variando il  range a seconda  della  }
    {  distanza del bersaglio.                                          }


                               ¯  NOTE  ®

    {  Shadow non è altro che una versione migliorata del robot che ha  }
    {  partecipato al precedente torneo (Mutation). In particolare è    }
    {  stato ritoccato il range per il fuoco permettendomi ora di in-   }
    {  fligge più danni, ed è stato ritoccato il moviemnto per il campo }
    {  di battaglia che causava danni sbattendo sui muri.... L'idea non }
    {  mi sembra male cosi' ho deciso di continuare su questa strada,   }
    {  penso che al prossimo torneo (...beh, bisogna sempre pianifica-  }
    {  re tutto) mandero' un robot che si trasforma durante la batta-   }
    {  glia........eh...bella vaccat..mah.....si vedra'.                }*/



int d,ang,newrange,oldrange;
main()
{

 while ( d <= 50 )   /*Esegue la prima tattica finchŠ i danni sono < del 50%*/
 {
  if (loc_x()>=80) left();
    else
      right();
  if (loc_y()>=920) down();
    else
      up();
 }

if ( d > 50 )      /*Quando i danni superano il 50% adotta la seconda tattica*/
  {
   left();
   while(damage()!=100) defence();
  }
}



left()
{
 while(loc_x()>=100)
    {
     d=damage();
     drive(180,100);
     radar1();
    }
}

down()
{
 while(loc_y()>=100)
    {
     d=damage();
     drive(270,100);
     radar2();
    }
}

right()
{
 while(loc_x()<=900)
    {
     d=damage();
     drive(0,100);
     radar3();
    }
}

up()
{
 while(loc_y()<=900)
    {
     d=damage();
     drive(90,100);
     radar4();
    }
}

defence()            /* Tattica adottata in caso di danni superiori al 50% */
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

newfire()       /* Procedura per variare il range a seconda del bersaglio */
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
if (range=scan(180,10)) cannon(180,range);
if (range=scan(135,10)) cannon(135,range);
if (range=scan(45,10))  cannon(45,range);
if (range=scan(0,10))   cannon(0,range);
}

radar2() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(270,10)) cannon(270,range);
if (range=scan(225,10)) cannon(225,range);
if (range=scan(90,10))  cannon(90,range);
if (range=scan(135,10)) cannon(135,range);
}                                   

radar3() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(0,10))   cannon(0,range);
if (range=scan(315,10)) cannon(315,range);
if (range=scan(180,10)) cannon(180,range);
if (range=scan(225,10)) cannon(225,range);
}

radar4() /* Procedura di fuoco per la prima tattica */
{
if (range=scan(90,10))  cannon(90,range);
if (range=scan(45,10))  cannon(45,range);
if (range=scan(270,10)) cannon(270,range);
if (range=scan(315,10)) cannon(315,range);
}

