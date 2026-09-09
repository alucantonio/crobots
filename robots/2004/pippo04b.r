/*
  Pippo4b.r

  Fregandosene altamente del fatto che ci siano o no 2,3,4,5,6,7 o 8 robot
  si mette ad oscillare in senso orizzontale per tutto il campo
  di battaglia.

  dopo 35 oscillazioni complete, si sposta al centro del campo (in
  senso verticale) e si mette ad oscillare come prima.

 La funzione di sparo Š derivata dalle "toxiche".

 ciao

 Andrea Creola


*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    tt;
    
main()
{
 tt=35;
 while(--tt)
 {
  while(loc_x(vs(0))<800);
  stop();
  while(loc_x(vs(180))>200);
  stop();
 }
 while(loc_y(vs(90))<500);
 stop();
 while(loc_y(vs(270))>500);
 stop();
 while(1)
 {
  while(loc_x(vs(0))<800);
  stop();
  while(loc_x(vs(180))>200);
  stop();
 }
 
}
vs(xx) {  fuoco(drive(dir=xx,100)); }
stop() {    while(speed(drive(dir,0))>50);/* Fire(0);*/ }

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
