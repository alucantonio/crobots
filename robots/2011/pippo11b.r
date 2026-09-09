/*
 Pippo 11 B

 Tattica semplice: gira intorno al perimetro dell'arena di gioco
 in senso antiorario facendo il zighezagiagamaneto ( se qualcuno riesce
 a tradurmi questo termine mi fa un piacere ).

 La routine di fuoco Š la variante di non ricordo quale robot.
 Viene fatto un primo controllo se un avversario e' presente nel mirino,
 in caso positivo si cerca di migliorare la precisione.
 Nel caso negativo si cerca l'avversario con una precione minore che pero'
 permette una rapidita' maggiore.

 Ho notato che anhe senza l'abbassamento della velocit… sotto i 50 non si
 creano problemi nel cambio di direzione.


*/
int
    odeg,
    deg,
    rng;
main()
 {
  while(1)
   {
    while(loc_y()>150)
     {
      while(loc_x()>200) {drive(190,100);fuoco();}
      while(loc_x()<200) {drive(350,100);fuoco();}
     }
    while(loc_x()<850)
     {
      while(loc_y()>200) {drive(280,100);fuoco();}
      while(loc_y()<200) {drive(80,100);fuoco();}
     }

    while(loc_y()<850)
     {
      while(loc_x()>800) {drive(170,100);fuoco();}
      while(loc_x()<800) {drive(10,100);fuoco();}
     }
    while(loc_x()>150)
     {
      while(loc_y()>800) {drive(260,100);fuoco();}
      while(loc_y()<800) {drive(100,100);fuoco();}
     }

   }
}

fuoco()
{
 if (rng=scan(odeg=deg,10))
  {
   if (scan(deg-=7,4))
    {
     if (!(scan(deg+=2,2))) deg-=4;
     cannon(deg+(deg-odeg),2*scan(deg,10)-rng);
    }
   else if (scan(deg+=14,4))
    {
     if (!(scan(deg-=2,2))) deg+=4;
     cannon(deg+(deg-odeg),2*scan(deg,10)-rng);
    }
   else if (scan(deg-=7,4))
    {
     if (!(scan(deg+=2,2))) deg-=4;
     cannon(deg+(deg-odeg),2*scan(deg,10)-rng);
    }
  }
 else
  {
   if (rng=scan(deg+=340,10)) return cannon(deg,rng);
   if (rng=scan(deg+=40,10)) return cannon(deg,rng);
   if (rng=scan(deg+=300,10)) return cannon(deg,rng);
   if (rng=scan(deg+=80,10)) return cannon(deg,rng);
   if (rng=scan(deg+=260,10)) return cannon(deg,rng);
   if (rng=scan(deg+=120,10)) return cannon(deg,rng);
   deg+=80;
  }
}



