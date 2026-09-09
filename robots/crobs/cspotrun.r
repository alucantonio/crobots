/* CSPOTRUN                                   BY ANDRES NELSON */
main(){
 int Range,Heading,Direction;
 Heading=0;
 Direction=90;
 while(1){
  drive(Direction,100);
  if((Heading==0&&loc_y()>575)||(Heading==1&&loc_x()<150)||
  (Heading==2&&loc_y()<425)||(Heading==3&&loc_x()>850)){
   drive(Direction,50);
   Heading=(Heading+1)%4;
   Direction+=90;}
  else{
   if(Range=scan(0,10))cannon(0,Range);
   else if(Range=scan(30,10))cannon(30,Range);
   else if(Range=scan(60,10))cannon(60,Range);   
   else if(Range=scan(90,10))cannon(90,Range);
   else if(Range=scan(120,10))cannon(120,Range);
   else if(Range=scan(150,10))cannon(150,Range);
   else if(Range=scan(180,10))cannon(180,Range);
   else if(Range=scan(210,10))cannon(210,Range);
   else if(Range=scan(240,10))cannon(240,Range);
   else if(Range=scan(270,10))cannon(270,Range);
   else if(Range=scan(300,10))cannon(300,Range);
   else if(Range=scan(330,10))cannon(330,Range);}}}

/*     CCCC   SSSS   PPPP   OOOO   TTTT   RRRR   U  U   N  N
       C       S     PP P   O  O    TT    R  R   U  U   NN N
       C        S    P P    O  O    TT    R R    U  U   N NN 
       CCCC   SSSS   P      OOOO    TT    R  R   UUUU   N  N

                                             BY ANDRES NELSON */