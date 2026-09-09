/*
 Pippo2B
 Andrea Creola
 Categoria: <500


 Molto simile a pippo2a, sono stati creati per caso durante una pausa pranzo,
 stavo testando altri 2 robot (che erano praticamente definitivi), ho messo
 insieme vari blocchi di istruzioni e sono usciti questi due.



 Tattica: calcola il quadrante in cui si trova e in base a questo
 va a tracciare un percorso quadrato vicino al suo angolo.
 Dato che la funzione di sparo (che non ricordo da chi ho copiato, anche
 se ho dovuto aggiungere una funzione per ridurre lo spazio richiesto)
 mi ha preso troppo spazio, onde per cui non ho potuto cercare di capire
 se la partita era un 2x2 o 4x4.


*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1,
    un2;


main()
{
 
 un1=(loc_x(un2=(loc_y()>500))>500);




 while(1)
 {
  sx(150+un1*600);
  dw(150+un2*600);
  dx(250+un1*600);
  up(250+un2*600);
 }
 
}


up(xx)
 {
   while(loc_y()<xx) vs(90);
   stop();
 }
dw(xx)
 {
  while(loc_y()>xx) vs(270);
  stop();
 }
dx(xx)
 {
  while(loc_x()<xx) vs(00);
  stop();
 }
sx(xx)
 {
  while(loc_x()>xx) vs(180);
  stop();
 }


vs(xx)
 {
  drive(dir=xx,100);
  fuoco();
 }


stop()
 {
  drive(dir+180,0);
  while(speed()>50);/* Fire(0);*/
 }





fuoco() 
{
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=20,10));
    else if (orng=scan(deg+=40,10));
    else return deg+=41; 
    { 
        if (orng>850)  {return deg+=41;}
        if (!scan(deg+=354,6)) deg+=12; 
        if(scan(deg-6,2)) deg-=6; 
        else if(scan(deg+6,2)) deg+=6;
        fnd();
        if (orng=scan(odeg=deg,10)) 
        { 
           if(scan(deg-7,3)) deg-=7; 
           else if(scan(deg+7,3)) deg+=7;
           fnd(); 
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
           } 
 
        } 
        else { 
                if (!(orng=scan(deg+=339,10))){  
                        if (!(orng=scan(deg+=41,10))) { 
                                if(!(orng=scan(deg+=21,10))) { 
                                        return deg+=41; 
                                } 
                        } 
                } 
                else if (!scan(deg+=354,6)) deg+=12;  
                return cannon (deg, 2*scan(deg,10)-orng);
        }
     } 
} 



fnd()
{
 if(scan(deg-4,1)) deg-=4;
 if(scan(deg+4,1)) deg+=4; 
 if(scan(deg-2,1)) deg-=2; 
 if(scan(deg+2,1)) deg+=2; 
}