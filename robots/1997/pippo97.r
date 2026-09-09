/*
  ********    ** ********    ********    ********  ********** **********
  **********  ** **********  ********** ********** ********** **********
  **      **  ** **      **  **      ** **      ** **      **         **
  **      **  ** **      **  **      ** **      ** **********         ** 
  **********  ** **********  ********** **      ** **********         **
  ********    ** ********    ********   **      **         **         **
  **          ** **          **         **********         **         **
  **          ** **          **          ********          **         **


  Pippo97
  Creola Andrea


  Tattica:  Inizialmente il robot si posiziona nel bordo in alto a destra,
            da qui inizia una breve oscillazione vertiale, ripete questo
            movimento per quaranta volte dopo, controlla se ci sono altri
            robot, se quelli rimasti sono solamente uno va a posizionarsi
            sulla diagonale principale, altrimenti ricomincia dall'inizio.
            La routine di fuoco deriva da !, con la differenza che se
            il robot Š a distanza maggiore di 700 non spara.
*/

int a1;
int num;
int ang,range,rangepr,dir;
int conta1;
main()
{
 drive(0,100);
 while(loc_x()<950)sp();
 drive(90,0);
 while(speed()>50);
 
 while(1) 
  {
   conta1=40;
   while(--conta1)
   {
    
    while(loc_y()<800)
     {
      drive(90,100);
      sp();
     }
    drive(270,0);
    while(speed()>50);

    while(loc_y()>500)
     {
      drive(270,100);
      sp();
     }
  
    drive(90,0);
    while(speed()>50);
   }
   solo();
  }
}


sp ()  
{
if (!(rangepr=scan(ang,10)))
if (!(rangepr=scan(ang-=20,10)))
if (!(rangepr=scan(ang+=40,10))) { ang+=40; return; }
if (!scan(ang+=5,5)) ang-=10;
if (!scan(ang+=3,3)) ang-=6;
if (range=scan(ang,10))
 { 
  if(range<700) cannon(ang,range+range-rangepr);
  else ang+=40;
 }
}


solo()
{
 a1=0;
 num=0;
 while(a1<370)
  {
   if(scan(a1+=20,10))++num;
  }
 if(num==1)
  {
   v(100,100,900,900);
  }
}

/********** V **********/

v(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
 while (1)
  {
   dir = direzione (x1,y1);
   drive (dir,100);
   while (loc_y() > y1)  sp();
   dir = direzione (x2,y2);
   drive (dir,0);
   while (speed() > 50) ;

   drive (dir,100);
   while (loc_y() < y2) sp();
   dir = direzione (x1,y1);
   drive (dir,0);
   while (speed() > 50) ;
  }
}
/********** DIREZIONE **********/
direzione (dest_x,dest_y)
int dest_x,dest_y;
{
 int dir,locx,locy;
 locx = loc_x();
 locy = loc_y();
 if (locx == dest_x )
    {
     if (dest_y > locy)
        dir = 90;
     else
        dir = 270;
    }
 else
    {
     if (dest_y < locy)
        {
         if (dest_x > locx)
            dir = 360 + atan ((100000 * (locy-dest_y)) / (locx - dest_x) );
         else
            dir = 180 + atan ((100000 * (locy-dest_y)) / (locx - dest_x) );
        }
     else if (dest_x > locx)
             dir = atan (100000 * (locy-dest_y) / (locx-dest_x));
          else
             dir = 180 + atan(100000 * (locy-dest_y) / (locx-dest_x));
    };
 return (dir);
}


