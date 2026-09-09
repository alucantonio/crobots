/*
 Pippo10a.r
 Torneo: Micro

 Strategia:
 Causa poco ( ma molto poco tempo ) Š quasi la copia del precedente
 Grazie di Nuovo a nniele Nuzzo per la routine di fuoco, al limite se
 perdo posso dare la colpa a lui :) .

 Spero per il prossimo anno di avere tempo per crearne una mia......
 ( ogni anno lo dico ).

 Per la strategia, un attimo che vado a vedere sotto, visto che non la ricordo.
 Prima cosa che fa, come oramai fanno in molti, si mette vicino al lato piu' prossimo.
 Li comincia ad oscillare a destra e sinistra vicino al bordo in tutta tranquillita'.


 Passati circa 100000 cicli ( credo ) si mette ad oscillare al centro del campo.

 Le prender… da tutti, ma questo non Š importante, quello che conta Š che Maurizio
 non diventi il pie' veterano di tutti.

 Ciao

 p.s. spero per stasera di assemblare un secondo concorrente.

 Andrea Creola
*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1,
    ody,
    od,
    tt,xxx
    ;
    
main()
{
 if(loc_y(xxx=(loc_x(tt=120)<500)*600)>500) up(900);
 else dw(100);
 while(--tt) {  sx(200+xxx,180);  dx(210+xxx,0); }
 while(1)
 {
  while(loc_y()<810)
  {
   dx(512,2);
   sx(501,178);
  }
  while(loc_y()>200)
  {
   dx(512,358);
   sx(501,182);

  }
 }
}

fuoco()
{
  int asin,acos;
  if (scan(dir,10)) deg=dir;
  else deg+=120*(rng>850);

  if (scan(deg,10))
  {
    
    asin=(sin(deg-dir)/14384);
    acos=(cos(deg-dir)/3796)-230;
    Find();
    if (orng=scan(odeg=deg,3))
    {
      Find();

      return(cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,
             rng*230/(orng-rng-acos)));
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
   if (rng=scan(deg+=350,10));
   else if (rng=scan(deg+=20,10));
   else if (rng=scan(deg+=320,10));
   else if (rng=scan(deg+=60,10));
   else if (rng=scan(deg+=280,10));
   else Search(deg-=220);
   cannon(deg,rng);
}

up(xx) {   while(loc_y()<xx) vs(90);   stop(); }
dw(xx) {  while(loc_y()>xx) vs(270);  stop(); }
dx(xx,dd) {  while(loc_x()<xx) vs(dd);  stop(); }
sx(xx,dd) {  while(loc_x()>xx) vs(dd);  stop(); }
vs(xx) {  fuoco(drive(dir=xx,100)); }
stop() {  while(speed(drive(dir,10))>50);/* Fire(0);*/ }
