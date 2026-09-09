/*
 Pippo25a

 Tattica:  Tattica semplice: gira intorno al perimetro dell'arena di gioco
           in senso antiorario. Presa da Pippo11a
           Fa un numero variabili di giri, non avevo abbastanza istruzioni
           per contare il numero effettivo di robot, sforavo le 500vb
           Poi parte a fare un movimento semplificato di Leader.
           Per contenere le istruzioni ho reso la routine di sparo piu'
           leggera, non diciamo meno precisa che e' brutto.
           Aggiornamento: per la routine di fuoco ho preso spunto, diciamo che
           ho copiato da coppi20

 */
int orng,
    rng,
    deg,
    odeg,
    dir,
    ccc;
main()
{
  ccc=3+rand(4);
  while(--ccc)
   {
    while (loc_x()<850) fuoco(0,100);
    fuoco(90,48);
    while (loc_y()<850) fuoco(90,100);
    fuoco(180,48);
    while (loc_x()>150) fuoco(180,100);
    fuoco(270,48);
    while (loc_y()>150) fuoco(270,100);
    fuoco(0,48);
   }

  while(1)
   {
    deg+=328;
    while(!(rng=scan(deg+=16,8)));
    cannon(deg,rng);
    if(rng>200) drive(dir=deg,100);
    while (rng)
     {
      if (rng>200)
      {
       odeg=deg;
       orng=rng;
       deg+=4-(scan(deg-4,4) != 0)*8;
       deg+=2-(scan(deg-2,2) != 0)*4;
       deg+=1-(scan(deg-1,1) != 0)*2;
       if (rng=scan(deg,10))
          cannon(deg+(deg-odeg)*rng/200,rng+(rng-orng+45)*rng/275);
       if (speed()<51 || ((deg-dir)*(deg-dir)>400)) drive(dir=deg,100);
      }
      else
       {
        deg+=20;
        while(rng<300)
         {
          deg+=320;
          while(!(rng=scan(deg+=20,10)));
          cannon(deg,rng);
          if(speed()<50 || rng>200) drive(dir=deg,100);
         }
       }
     }
   }
 }



fuoco(d,v)
{
int d,v;
   drive(dir=d,v);
   if((rng=scan(odeg=deg,10))&&(rng<808))
   {
           if (scan(deg-9,6)) {if (scan(deg-=6,3)); else deg-=6;}
      else if (scan(deg+9,6)) {if (scan(deg+=6,3)); else deg+=6;}
      else if (scan(deg,  2));
      else {if (scan(deg-=3,2)); else deg+=6;}
      return cannon(deg+deg-odeg,2*scan(deg,10)-rng);
   }
   else if (rng=scan(deg+=20,10));
   else if (rng=scan(deg-=40,10));
   else if (rng=scan(deg+=60,10));
   else {while(!scan(deg,10))deg+=19;}
}

