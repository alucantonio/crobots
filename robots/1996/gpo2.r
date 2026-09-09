/* 
  
   CROBOT:  Gpo2.r 
   
   AUTORE:  Guido Masotti (04.07.1968)

                    
                          SCHEDA TECNICA

   Il robot e' molto semplice: si sposta sul lato inferiore del
   campo di gioco e si muove alternativamente a destra e a si-
   nistra lungo tale lato scegliendo in modo casuale il punto
   in cui invertire il verso di marcia. 
   Contemporaneamente esegue una ricerca dell'avversario e ten-
   ta di colpirlo (solo se lo trova nel range utile) calcolando 
   una correzione sulla distanza.

   Nel caso non fosse possibile far partecipare entrambi i miei 
   robot, vorrei far giocare Gpo2.r
*/

  
int nr,nr1;
int ang,corner,posx;

main()
{
  ang=170;
  drive(270,100);
  while (loc_y()>=60) shot();
  while (speed()>49) drive(270,0);
  drive(0,100);
  while (loc_x()<=930) shot();
  drive(0,0);
  while(speed()>49) drive(0,0);
  corner=1;

  while (1)
  { 
    if (corner)
      posx=70+rand(320);
    else
      posx=930-rand(320);
    race();
  }
}

race()
{
  if (corner==0)
  {
    drive(0,100);
    ang=4;
    while (loc_x()<posx)
      shot();
    drive(0,0);
    while (speed()>49) drive(0,0);
    corner=1;
  }
  else
  {
    drive(180,100);
    ang=176;
    while (loc_x()>posx)
      shot();
    drive(180,0);
    while (speed()>49) drive(180,0);
    corner=0;
  }
}

shot()
{
  int count;

  if ( ((nr=scan(ang,10))>28) && (nr<115) )
    cannon(ang,nr);
  else
  {
    if ( (nr>115) && (nr<701) )
    {
      ang -= 4+corner*8;
      count = 2;
      while (count && !(nr1 = scan(ang,5))) {
          ang += 10-corner*20;
          --count;
      }
      if (nr1)
      {
        cannon(ang,nr1+(nr1-nr)*18/10);
        ang-=5+corner*10;
      }
      else
        ang+=10-corner*20;  
    }
    else
      ang+=20-corner*40;
  }
  if ( ang > 185 ) 
    ang=4+172*corner;
  if (speed()<15) drive(180*corner,100);
}
