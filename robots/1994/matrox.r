/*NOME DEL ROBOT:  MatroX.R                           
  NOME:            CARLO PERICH                   
             
  CARATTERISTICA:  La routine di movimento del robot si base sul constatare  
  che più un robot si muove, più rischia di essere ucciso, ma daltronde se un
  robot rimane fermo, può essere sottoposto a molti pericoli!
  Martox all'inizio del combattimento si ferma per guardare come va l'incontro
  poi dopo essere stato infastidito un pò, entra in azione per più della metà
  del combattimento; dopo aver subito danni rilevanti si apposta su 2 degli angoli
  scelti, a seconda che si trova a nord o a sud. Quindi alterna la sua posizione
  in base al danneggiamento subito in quell'angolo. 
  
  N.B.
  Nel caso si dovesse scegliere nel far combattere uno dei due crobots pre-
  ferisco che si faccia combattere Ken.R, grazie.*/
           
int x,rlead,range,dir,orange,ox,DeltaR,i,D,DeltaD,k,K,d;
main()
{ 
  while(damage()<15)                /*finchŠ il damage Š inferiore a 15%*/
  { drive (0,0);                    /*stai fermo e spara*/
  spara();}                    
 spara();                         /*   spara1*/
 if(loc_y()<500)                   /*controlla posizione sull'asse delle y*/
  {while (loc_y() > 110)             /* se sei + vicino al sud vacci */
    {drive(270, 100);                /*   sparando*/
     spara();}
  }              
 else 
  {while (loc_y() < 910 )           /* se sei + vicino al nord vacci */
    {drive(90, 100);                 /*sparando*/      
     spara();}
  }             
 spara();                          /* se sei + vicino all'ovest vacci */ 
 if(loc_x()<500)                   /* fino a quando il damage Š < di 60%*/
 {while(damage()<60)
 {                                 /* sinistra*/
    while (loc_x() > 100)  
     {drive(180, 80);
      spara();}                       
      d=damage();                  /*  controllo danni*/ 
    while((damage()-d)<15)            /*finchŠ non Š danneggiato per un 15%*/  
     {drive(0,0);                      /*  stop e spara*/
      spara();}
   while (loc_x() < 900)             /*    destra*/
   {drive(0,80);
    spara();}
   d=damage();                          /*  controllo danni*/ 
   while((damage()-d)<15)           /*finchŠ non Š danneggiato per un 15%*/      
   {drive(0,0);                        /*  stop e spara*/   
    spara();}
 }
 }
 else                            /* se sei + vicino all'est vacci */  
 {                              
 while(damage()<60)             /*routine uguale a prima*/
 {
   while (loc_x() < 900)  
   {drive(0,80);
    spara();}
   d=damage();
   while((damage()-d)<15)         
   {drive(0,0);
    spara();}
    while (loc_x() > 100)  
     {drive(180, 80);
      spara();}
    d=damage();
    while((damage()-d)<15)         
     {drive(0,0);
      spara();}
 }
 }
 drive(180*(loc_x()>500),100);
 spara();
 x=336;
 rlead=50;
 while(damage()<100)          /*finche il damage Š arrivato al 100% fai fase*/
 fase();

} 

fase()  
{   while(!(range=scan(x+=16,8)));      /*se c'Š qualcuno entro 16ø*/
  {
    x+=328;                            /* sfasando di un po'*/
    while(!(range=scan(x+=16,8)));     /* finchŠ c'Š il nemico spara!*/
    cannon(x,range);
    if(range>200) drive(dir=x,100);     /*se Š lontano*/
    while (range)  
    {
      if (range>200)
      {
        ox=x;
        orange=range;
        x+=4-(scan(x-4,4) != 0)*8;       /* sfasa accuratamente*/
        x+=2-(scan(x-2,2) != 0)*4;
        x+=1-(scan(x-1,1) != 0)*2;
        if (range=scan(x,10))           /*quando lo vedi spara*/
          cannon(x+(x-ox)*range/200,range+(range-orange+rlead)*range/275);
        if (speed()<51 || ((x-dir)*(x-dir)>400))   /*se Š lontano inseguilo*/
        {
          drive(dir=x,100);
          rlead=25;
        }
        else rlead=50;
      }
      else
{      x+=20;
while(range<300)                         /*se Š vicino */
      {
        x+=320;
        while(!(range=scan(x+=20,10)));
        cannon(x,range);
        if(speed()<50 || range>200) drive(dir=x,100);
      } }
    }
  }
}
spara ()    /* la routine di fuoco da fermo, presa da Godel.r      */
            /* pochi commenti, dopo prova e riprova e' venuta cosi' */
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
