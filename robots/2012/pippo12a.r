/*
 Pippo12a.r
 Torneo: Micro

 Strategia:
 Praticamente ho recuperato pippo07 facendolo andare sulla diagonale.

 Uso le routine normali di movimenti ( su, giu, destra, sinistra, 
 indietro, pinguino.... ) e mi sposto sulla diagonale ( alla jazz ).

 Routine di fuoco, presa da una di Daniele Nuzzo ( che quest'anno e' tornato )
 con qualche variante, se non trova un robot si mette a cercarlo con un 
 ciclo While con un incremento di angolo di 21 gradi.
 Tutte le altre modifiche facevano perdere tutta l'efficenza.

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
 sx(150,180);
 dw(150);
 while(1)
  {
   dx(800,45);
   sx(200,225);
  }
}

fuoco()
{
  int asin,acos;
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
dw(xx) {  while(loc_y()>xx) vs(270);  stop(); }
dx(xx,dd) {  while(loc_x()<xx) vs(dd);  stop(); }
sx(xx,dd) {  while(loc_x()>xx) vs(dd);  stop(); }
vs(xx) {  fuoco(drive(dir=xx,100)); }
stop() {  while(speed(drive(dir,0))>50);/* Fire(0);*/ }
