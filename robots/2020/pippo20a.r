/*
 Pippo 20 A ( tattica quasi copio/incolla da pippo20b )

 Tattica semplice: gira a quadrato intorno al campo di gioco, ma prima di percorrere
 i tragitti orizzontali controlla che siano vuoti, il tutto per un certo
 numero di volte, poi passa alla fase 2

 nella fase 2, sale e scende dall'arena di campo facendo movimenti obliqui
 destra-sinistra

 la funzione di fuoco pensa di averla fregata come gi… altre volte a Daniele
 con qualche riduzione di codice e l'aggiunta di un controllo davanti e
 dietro ( scan(dir,10) e  scan(dir+180,10) ).


*/
int rng,
    deg,
    odeg,
    dir,
    tt;

main()
{
   tt=48;
   while((--tt)>4)
   {
    if (!scan(0,10)){-tt;while (loc_x()<900) fuoco(drive(dir=0,100));}
    fuoco(drive(dir=90,0));
    --tt;while (loc_y()<900) fuoco(drive(dir=90,100));
    fuoco(drive(dir=180,0));
    if (!scan(180,10)){-tt;while (loc_x()>100) fuoco(drive(dir=180,100));}
    fuoco(drive(dir=270,0));
    --tt;while (loc_y()>100) fuoco(drive(dir=270,100));
    fuoco(drive(dir=0,0));
   }
  while(1)
  {
   while(loc_y()<800)
   {
    while (loc_x()<900) fuoco(drive(dir=10,100));
    fuoco(drive(dir=170,0));
    while (loc_x()>100) fuoco(drive(dir=170,100));
    fuoco(drive(dir=10,0));
   }
   while(loc_y()>200)
   {
    while (loc_x()<900) fuoco(drive(dir=350,100));
    fuoco(drive(dir=190,0));
    while (loc_x()>100) fuoco(drive(dir=190,100));
    fuoco(drive(dir=350,0));
   }
  }
}

fuoco()
{
 if (rng=scan(odeg=deg,10))
  {
   if (scan(deg-8,5))
    {
     if (scan(deg-=5,2)) ;
     else deg-=4;
    }
   else
    {
     if (scan(deg+8,5))
      {
       if (scan(deg+=5,2)) ;
       else deg+=4;
      }
     else
      {
       if (scan(deg,1)) ;
       else if (scan(deg-=3,2)) ; else deg+=6;
      }
    }
   return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng));
  }
 else
  {
   if(rng=scan(deg+=20,10));
   else if(rng=scan(deg-=40,10));
   else if(rng=scan(deg+=60,10));
   else if(rng=scan(deg-=80,10));
   else if(rng=scan(dir,10));
   else if(rng=scan(dir+180,10));
   else while(!(rng=scan(deg,10)))deg+=19;
  }

}

