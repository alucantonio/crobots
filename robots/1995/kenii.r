/*NOME DEL ROBOT:  Ken.R                           
  NOME:            CARLO PERICH                   
             
  CARATTERISTICA:    
  Sta fermo e poi alla fine diventa un Kamikaze!
  N.B.
  Nel caso si dovesse scegliere nel far combattere uno dei due crobots pre-
  ferisco che si faccia combattere Ken.R, grazie.*/
           
int x,rlead,range,dir,orange,ox,DeltaR,i,D,DeltaD,k,K,d;
main()
{ 
  while(damage()<76)                /*finchŠ il damage Š inferiore a 76%*/
  { drive (0,0);                    /*stai fermo e spara*/
  spara();}                    
 x=336;
 rlead=50;
 while(damage()<100)          /*fino alla fine kamikaze*/
 fase();     cannon(x,range);    

} 

fase()  
{   while(!(range=scan(x+=16,8)));/*finchŠ vedi il nemico in un angolo di 16ø*/ 
  {
    x+=328;
    while(!(range=scan(x+=16,8)));
    cannon(x,range);    
    if(range>200) drive(dir=x,100);      /*se il nemico Š a+ di 200, vacci!*/
    while (range)  /* && range<700 */       /*finchŠ il nemico Š a+ di 200*/ 
    {
      if (range>200)                         /*  se Š lontano!*/       
      {
        ox=x;                                       /*angolo ox=x*/    
        orange=range;                                 /*vecchia distanza=range*/  
        x+=4-(scan(x-4,4) != 0)*8;              /*sfasatura angolo di fuoco*/ 
        x+=2-(scan(x-2,2) != 0)*4;                 /*a seconda di dove Š*/   
        x+=1-(scan(x-1,1) != 0)*2;
        if (range=scan(x,10))                             /*se la distanza ESISTE!*/   
          cannon(x+(x-ox)*range/200,range+(range-orange+rlead)*range/275);  /*FUOCO!*/ 
         if (speed()<51 || ((x-dir)*(x-dir)>400)) /*se Š lontano raggiungilo!*/
        {
          drive(dir=x,100);
          rlead=25;                         /*distanza ottimale*/  
        }
        else rlead=50;
      }
      else                                 /*SE LA DISTANZA Š MInore di 300: Š vicino*/ 
{      x+=20;                                 /*controlla sfasando di 20ø*/    
while(range<300)
      {
        x+=320;                           /*controlla in un angolo di 60ø*/ 
        while(!(range=scan(x+=20,10)));  /*se esiste entro 20ø allora fuoco!*/
        cannon(x,range);
        if(speed()<50 || range>200) drive(dir=x,100);/*  se Š lontano vacci!*/  
      } }
    }
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
controlla()
{
   if (damage()>60)    
     {
 drive(180*(loc_x()>500),100);
 spara();
 x=336;
 rlead=50;
 while(damage()<100)         
 fase(); }
}
