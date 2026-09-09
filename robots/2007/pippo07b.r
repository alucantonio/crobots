/*
 Pippo07b.r
 Torneo: Micro

 Strategia:
 Prima di tutto Grazie a Daniele Nuzzo, visto il tempo e le mie scarse se
 non nulle capacita' di creare una routine di fuoco, ho preso in prestito
 la sua funzione ( derivata da Caos ).
 Spero per il prossimo anno di avere tempo per crearne una mia......

 Per la strategia, un attimo che vado a vedere sotto, visto che non la ricordo.
 Prima cosa che fa, come oramai fanno in molti, si mette vicino al lato piu' prossimo.
 Li comincia ad oscillare a destra e sinistra in tutta tranquillita'.

 Passato uno certo numero di oscillazioni, si mette ad oscillare DX/SX sulla
 verticale al centro del campo.


 ciao

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
    tt;
    
main()
{
 if(loc_y(tt=30)>500) up(900);
 else dw(100);
 while(--tt) {  sx(200,180);  dx(800,0); }
 while(1)
 {
  while(loc_y()<610)
  {
   dx(502,2);
   sx(501,178);
  }
  while(loc_y()>400)
  {
   dx(502,358);
   sx(501,182);

  }
 }
}

fuoco()
{
  int asin,acos;
  if (speed()>90)  { if (scan(dir,10)) deg=dir; if (rng>850) { deg+=120; } }

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
  while(1)
  {
   if (rng=scan(deg+=350,10)) return cannon(deg,rng);
   if (rng=scan(deg+=20,10))  return cannon(deg,rng);
   if (rng=scan(deg+=320,10)) return cannon(deg,rng);
   if (rng=scan(deg+=60,10))  return cannon(deg,rng);
   if (rng=scan(deg+=280,10)) return cannon(deg,rng);
   deg-=220;
  }
}

up(xx) {   while(loc_y()<xx) vs(90);   stop(); }
dw(xx) {  while(loc_y()>xx) vs(270);  stop(); }
dx(xx,dd) {  while(loc_x()<xx) vs(dd);  stop(); }
sx(xx,dd) {  while(loc_x()>xx) vs(dd);  stop(); }
vs(xx) {  fuoco(drive(dir=xx,100)); }
stop() {  while(speed(drive(dir,0))>50);/* Fire(0);*/ }
