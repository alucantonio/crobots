/*
  Pippo3b.r (secondo robot per il torneo)

  E' un de-evoluzione di pippo3 realizzata in circa 10 minuti,
  1 ora prima dello scadere delle iscrizioni

  Tatica si porta in un angolo, li attende che qualcuno lo faccia
  fuori, se lo attaccano o Š passato un po di tempo si mette ad
  oscillare sul lato orizzontale.

  Commento rapido, dato che devo ancora preparare il robot per
  il torneo dei pesi medi e massimi e manca meno di mezz'ora.

 La funzione di sparo Š derivata dalle "toxiche".

 Altro? Aggiungetelo voi, non ho tempo :-) .

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
    od2,
    dam;
    
main()
{

 un1=(loc_x()>500)*400;
 if(loc_y()>500) up(900);
 else dw(100);
 if(loc_x()>500) dx(900);
 else sx(100);
 dam=damage(tt=1000);
 while((damage()-10<dam)&&(--tt)) {if(!(tt%40))++dam;  fuoco();}

 while(1)
 {
   sx(200+un1);
   dx(400+un1);
 }
 
}


dx(xx) {  while(loc_x(vs(00))<xx) ;  stop(); }
sx(xx) {  while(loc_x(vs(180))>xx);    stop(); }
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

up(xx) {   while(loc_y(vs(90))<xx);   stop(); }
dw(xx) {  while(loc_y(vs(270))>xx);  stop(); }

