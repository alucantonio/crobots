  
/* 
  
   CROBOT:  Risk.r 
   
   AUTORE:  Guido Masotti

                    
                          SCHEDA TECNICA

   Il robot si porta sul lato superiore del campo di gioco e si 
   muove alternativamente a destra e a sinistra lungo tale lato.
   Contemporaneamente esegue una ricerca dell'avversario e ten-
   ta di colpirlo (solo se lo trova nel range utile) calcolando 
   una correzione sulla distanza ed una sull'angolo.

   Nel caso non fosse possibile far partecipare entrambi i miei 
   robot, vorrei far giocare Gpo2.r
*/


int r1,ang1,dang,angf,rangef,range;
int ang,corner,posx;

main()
{
  ang=170;
  drive(90,100);
  while (loc_y()<=940);
  while (speed()>49) drive(90,0);
  drive(0,100);
  while (loc_x()<=860) shot();
  drive(0,0);
  while(speed()>49) drive(0,0);
  corner=1;

  while (1)
  {
    if (corner)
      posx=140;
    else
      posx=860;
    race();
  }
}


race()
{
  if (corner==0)
  {
    drive(0,100);
    ang=356;
    while (loc_x()<posx)
      shot();
    drive(0,0);
    while (speed()>49) shot();
    corner=1;
  }
  else
  {
    drive(180,100);
    ang=184;
    while (loc_x()>posx)
      shot();
    drive(180,0);
    while (speed()>49) shot();
    corner=0;
  }
}


shot()
{
   if (scan(ang,5))
   {
     if (getpos())
     {
       ang1=ang;
       r1=range;
       if (getpos())
       {
         dang=ang-ang1;
         rangef=range+(range-r1)*range/300;
         angf=ang+dang*range/180;
         cannon(angf,rangef); 
         if (rangef<700) 
           ang=angf; 
         else 
           ang-=8+corner*16;
       }
     }
   }
   else
   {
     ang-=10+corner*20;
     if (ang>364)
       ang=184;
     else
       if (ang<176)
         ang=356;
   }
   if (speed()<15) drive(180*corner,100);
}


getpos()
{
   if ( scan(ang+3,2) )
      if ( scan(ang+4,1) ) 
         { 
         if ( scan(ang+3,0) ) 
            ang+=3; 
         else   
            ang+=4;
         }
      else
         if ( scan(ang+2,0) )
            ang+=2; 
         else
            ang+=1; 
   else
      if ( scan(ang-4,2) )
         if ( scan(ang-2,1) ) 
            ang-=2;
         else
            ang-=3;        
      else
         if ( scan(ang-1,0) )
            ang-=1;
         else
            ang-=0;           

   if (range=scan(ang,5))
     return 1;
   else return 0;
}

