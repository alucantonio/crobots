/*
 Pippo 20 B

 Tattica semplice: conta gli avversa, se ci sono piu' avversari
 gira a quadrato intorno al campo di gioco, ma prima di percorrere
 i tragitti orizzontali controlla che siano vuoti, il tutto per un certo
 numero di volte, poi passa alla fase 2

 nella fase 2, a cui si passa se all'inizio trova pochi avversari oppure dopo
 un certo numero di rotazioni intorno al campo.
 La tattica e' quella che ultimamente va molto di moda ( per mancanza di
 fantasia e di tempo mi sono adattato pure io ), ci si muove in funzione dell
 angolo di tiro facendo attenzione a andare contro il bordo, in tal caso
 arrivati vicini si inverte direzione

 la funzione di fuoco pensa di averla fregata come gi… altre volte a Daniele
 con qualche riduzione di codice e l'aggiunta di un controllo davanti e
 dietro ( scan(dir,10) e  scan(dir+180,10) ).


*/
int rng,
    deg,
    odeg,
    dir,
    px,
    py,
    tt,
    dd,
    ee,
    pdir;

main()
{
   tt=deg=2;
   while(deg<370)
    if(scan(deg+=25,10))++tt;
   if (tt>3) tt=48;

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
   fuoco();
   if(rng) dir=(deg)+180*(ee^1);
   dd=(pdir=(((px=loc_x(py=loc_y()))%850)<150)*(10+180*(px>500)))+(!pdir)*(((py%850)<150)*(100+180*(py>500)));
   if(dd)dir=dd;
   drive(dir,100);
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

