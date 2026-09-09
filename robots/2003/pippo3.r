/*
  Pippo3.r

  E' un evoluzione di pippo2a o pippo2b, non ricordo e sul
  momento non ho tempo per vedere :-)


  Se in presenza di 4 amici all'arena:
     All'inizio si reca all'angolo vicino.
     Si mette ad oscillare a destra e sinistra rimanendo vicino al bordo
     Questo lo fa fino a circa 150.000 cicli poi passa alla parte 2

 Parte2, che si ha quando Pippo conta un solo avversario oppure dopo
    150.000 cicli
    Si posiziona al centro del campo ed oscilla in orizzontale

 La funzione di sparo Š derivata dalle "toxiche".

 Altro? Aggiungetelo voi.

 Rilasciato sotto licenza GPL (forse il primo a dichiararlo).

 ciao

 Andrea Creola
 a.creola@lycos.it

*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1,
    ody,
    od,
    tt,
    od2;
    
main()
{
 rng=od2=0;
 
 while (rng<360) { if (scan(rng+=20,10)) od2+=1; }
 
 un1=(loc_x(tt=1+100*(od2>1))>500)*400;
 if(od2>1)
 {
  if(loc_y()>500) up(900);
  else dw(100);

  while(--tt)
  {
   sx(200+un1);
   dx(400+un1);
  }
 }
 up(500);dw(500);
 while(1)
 {
  sx(200);
  dx(800);
 }
 
}


dx(xx) {  while(loc_x(vs(00))<xx) ;  stop(); }
sx(xx) {  while(loc_x(vs(180))>xx);    stop(); }
vs(xx) {  fuoco(drive(dir=xx,100)); }


stop()
 {  
  while(speed(drive(dir,0))>50);/* Fire(0);*/
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
     deg+=41*(orng>850);/*if (orng>850)  deg+=41;*/
     return;
    } 
  } 
 else
  {
   if (!(orng=scan(deg+=339,10)))
    {
     if (!(orng=scan(deg+=41,10)))
      {
       if(!(orng=scan(deg+=21,10)))
        {
         return deg+=41; 
        } 
     } 
   } 
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

up(xx) {   while(loc_y(vs(90))<xx);   stop(); }
dw(xx) {  while(loc_y(vs(270))>xx);  stop(); }

