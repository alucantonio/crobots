/*
 Pippo15b.r
 Torneo: Micro

 Strategia:
 Nessuna, solo che mi piace la formula per il calcolo dell'angolo di movimento.
 Come ho visto che fanno molti robot, regola l'angolo di movimento in funzione
 dell'angolo di sparo.
 Se Š uno scontro 2v2 utilizzando tutto il campo, altrimenti restando solo nel suo
 quadrante.


 ciao

 Andrea Creola
 a.creola@libero.it
 www.baragin.it
*/
int rng,
    deg,
    orng,
    dir,
    un1,
    ody,
    od,
    tt,
    x,
    y,
    px1,
    px2,
    py1,
    py2;

main()
{
  tt=deg=0;
  while(deg<400) if (scan(deg+=25,20)) ++tt;
  if(tt<2)
   {
    px1=py1=200;
    px2=py2=800;
   }
  else
   {
    px1=200+(loc_x()>500)*300;
    py1=200+(loc_y()>500)*300;
    px2=px1+300;
    py2=py1+300;
   }

  while(1)
  {
   dir=(dir=(dir=180*((x=loc_x())>px2)+1*(x<px1))+
       (!dir)*(270*((y=loc_y())>py2)+90*(y<py1)))+
       (!dir)*(deg+180*(rng<150));
   fuoco(drive(dir,100));
  }
}

fuoco()
{
 if (rng=scan(deg,10))
  {
   if (scan(deg-8,5)) deg-=5;
   else if (scan(deg+8,5)) deg+=5;
   else if (scan(deg,1)) ;
   else if (scan(deg-=3,2)) ;
   else deg+=6;
  
   cannon(deg,scan(deg,10)*2-rng*7/8);
  }
 else
  {
   if(rng=scan(deg+=20,10));
   else if(rng=scan(deg-=40,10));
   else while(!scan(deg,10)) deg+=110;
 }
}
