/*
 Pippo 12
 Categoria: Micro

 Derivato da Pippo11A da cui copio la didascalia o racconto

 Tattica semplice: gira intorno al perimetro dell'arena di gioco
 in senso antiorario.
 Variante, ad ogni angolo controlla che non ci sia un robot nell'angolo
 opposto fermo ad aspettarlo, se lo scan ritorna un valore maggiore di 600 vuol
 dire che l'altro robot molto facilmente Š nell'angolo.

 La routine di fuoco Š la Š stata presa da pippo97, con un while in
 aggiunta.

 Tempo tiranno, spero per il prossimo anno di riuscire a fare meglio.
 Sopratutto grazie a Maurizio che come ogni anno organizza il torneo.

 OT: Nota. Oggi hanno esonarato Tesser e preso Mondonico, ricordo quando allenava
     l'Atalanta per l'ottima prestazione in coppa delle coppe.
 Cosa c'entra? Niente, ma volevo scriverlo.

*/

int rng,
    deg,
    orng,
    odeg,
    dir,
    px,
    py,
    cc,
    asin,
    acos;

main()
{
   while(1)
   {
    if (!scan(0,10)<600)
    while (loc_x()<850) fuoco(drive(dir=0,100));
    fuoco(drive(dir=90,0));

    if (!scan(90,10)<600)
    while (loc_y()<850) fuoco(drive(dir=90,100));
    fuoco(drive(dir=180,0));

    if (!scan(180,10)<600)
    while (loc_x()>150) fuoco(drive(dir=180,100));
    fuoco(drive(dir=270,0));

    if (!scan(270,10)<600)
    while (loc_y()>150) fuoco(drive(dir=270,100));
    fuoco(drive(dir=0,0));
   }
}


fuoco()
{
  if (speed()>90)
   {
    if (scan(dir,10)) deg=dir;
    if (rng>850) { deg+=120; }
   }
  if (scan(deg,10))
  {
    asin=(sin(deg-dir)/14384);
    acos=(cos(deg-dir)/3796)-230;
    Find();
    if (orng=scan(odeg=deg,3))
    {
      Find();
      cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,
             rng*230/(orng-rng-acos));
      return;
    }
  }
  Search();
}

Find()
{
  if(scan(deg-13,10)) deg-=5;
  else if(scan(deg+13,10)) deg+=5;
  if(scan(deg+12,10)) deg+=4;
  else if(scan(deg-12,10)) deg-=4;
  if(scan(deg-11,10)) deg-=2;
  if(scan(deg+11,10)) deg+=2;
}

Search()
{
   if (rng=scan(deg+=350,10)) return cannon(deg,rng);
   else if (rng=scan(deg+=20,10))  return cannon(deg,rng);
   else if (rng=scan(deg+=320,10)) return cannon(deg,rng);
   else if (rng=scan(deg+=60,10))  return cannon(deg,rng);
   else if (rng=scan(deg+=280,10)) return cannon(deg,rng);
   else if (scan(dir,10)) return(deg=dir);
   while (!scan(deg,10))deg+=21;
}
