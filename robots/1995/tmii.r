/*NOME DEL ROBOT:  TmII.R                           
  NOME:            CARLO PERICH                              
  CARATTERISTICA: Sta fermo per un p• e poi si difende a quadrato 
  N.B.
  Nel caso si dovesse scegliere nel far combattere uno dei due crobots pre-
  ferisco che si faccia combattere KenII.R, grazie.*/

int x,rlead,range,dir,orange,ox,DeltaR,i,D,DeltaD,k,K,d;

main()
{
 while(damage()<40)
 {spara();}
 while(1)
 {
  while (loc_x()<750)  
  {drive(0,76);
   spara();}
  while (loc_y()>250)  
  {drive(270,76);
   spara();}
  while (loc_x()>250)  
  {drive(180,76);
   spara();}
  while (loc_y()<750 ) 
  {drive(90,76);
   spara();} 
 }
}

spara ()    /* la routine di fuoco da fermo ed in movimento    */
            /* presa da Godel.R: Eccezionale! */
{

    if(orange=scan(dir,10)) {

      if (orange>700) { dir+=19;--k;K=1;return;}

      if (scan(dir,2)) {
       if(scan(dir+=1,1));
        else dir+=359;
       }
      else if(scan(dir+6,4)) dir+=6; else dir+=354;

      if (K) {i=5;while(--i);}

      DeltaR=4;

      if (range=scan(dir,1)) DeltaD=0;

      else if(range=scan(dir+=4,2))
              DeltaD=7;
      else if(range=scan(dir+=352,2))
              DeltaD=353;
      else if(range=scan(dir+=12,2)) {
              DeltaD=8;
              DeltaR=3;
              }
      else if(range=scan(dir+=344,2)) {
              DeltaD=352;
              DeltaR=3;
              }
      else if(range=scan(dir+=20,2)) {
              DeltaD=10;
              DeltaR=3;
              }
      else if(range=scan(dir+=336,2)) {
              DeltaD=350;
              DeltaR=3;
              }
      else {dir+=330;K=1;return;}

      K=fuoco();

      k=30;

    }

    else {
     while (!(scan(dir+=19,10)));
     dir%=360;
     }
}

fuoco()
{
 return !(cannon(dir+DeltaD,(815+(range-orange)*DeltaR)*range/800));
}
