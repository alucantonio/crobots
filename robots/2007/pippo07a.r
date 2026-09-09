/*
 Pippo7a
 Torneo: Micro

 Per la strategia, un attimo che vado a vedere sotto, visto che non la ricordo.
 Prima cosa che fa, come oramai fanno in molti, si mette vicino al lato piu' prossimo.
 Li comincia ad oscillare a destra e sinistra in tutta tranquillita'.

 Passato uno certo numero di oscillazioni, si mette ad oscillare DX/SX sulla
 verticale al centro del campo, rispetto a Pippo07b, fa delle oscillazioni piu' ampie.

 La funzione di fuoco e' quella di pippo04, che era di pippo03, che era......
 che sicuramente ho copiato da qualcuno :).....

 ciao

 Andrea Creola

*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1,
    tt;
    
main()
{
 tt=40;
 if(loc_y()>500) up(900);
 else dw(100);
 while(--tt)
 {
  sx(200,180);
  dx(800,0);
 }
   
 while(1)
 {
  while(loc_y()<800)
  {
   dx(600,5);
   sx(400,175);
  }
  while(loc_y()>200)
  {
   dx(600,355);
   sx(400,185);

  }
 }
 
}



fuoco()
{
 if (orng=scan(deg,10));
 else if (orng=scan(deg-=20,10));
 else if (orng=scan(deg+=40,10));
 else return deg+=41; 

 if (!scan(deg+=354,6)) deg+=12;
 fnd();
 if (orng=scan(odeg=deg,10)) 
  { 
   fnd(); 
   if (rng=scan(deg,10)) 
    { 
     cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12)));
     if (orng>850)  deg+=41;
     return;
    } 
  } 
 else
  {
   while(!(orng=scan(deg+=35,10)));
   cannon (deg, 2*scan(deg,10)-orng);
  }
 
} 



fnd()
{
 if(scan(deg-7,3)) deg-=7; 
 if(scan(deg+7,3)) deg+=7;
 if(scan(deg-4,1)) deg-=4;
 if(scan(deg+4,1)) deg+=4; 
 if(scan(deg-2,1)) deg-=2; 
 if(scan(deg+2,1)) deg+=2; 
}


up(xx) {   while(loc_y()<xx) vs(90);   stop(); }
dw(xx) {  while(loc_y()>xx) vs(270);  stop(); }
dx(xx,dd) {  while(loc_x()<xx) vs(dd);  stop(); }
sx(xx,dd) {  while(loc_x()>xx) vs(dd);  stop(); }
vs(xx) {  fuoco(drive(dir=xx,100)); }
stop() {  while(speed(drive(dir,0))>50);/* Fire(0);*/ }
