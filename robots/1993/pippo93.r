/*
  Pippo93
  Creola Andrea

  Il robot prende un valore casuale per scegliere vari tipi di movimento
  2 e 3 stanno per i movimenti verticali , 0 e 1 per i movimenti obliqui
  valore calcolato dal random :
  0 : il robot si muove da basso sinistra a alto destra
  1 : ''   ''  ''   ''  ''  ''   destra   '' ''  sinistra
  2 : ''   ''  ''   ''  ''  ''   sinistra '' ''  sinistra
  3 : ''   ''  ''   ''  ''  ''   destra   '' ''  destra
  Per sparare una un range che dipende da quello precedente
*/

int angolo,range,rangepr,dir;

/********** MAIN **********/
main()
{
 int num;
 while(1)
  {
   num = rand(4);
   if (num == 0) v(100,100,900,900);
   if (num == 1) v(900,100,100,900);
   if (num == 2) v(020,100,020,900);
   if (num == 3) v(980,100,980,900);
  }
}
/********** V **********/

v(x1,y1,x2,y2)
{
 dir = direzione (x1,y1);
 drive (dir,100);
 while (1)
  {

   drive (dir,100);
   while ((loc_y() > y1) && speed()) spara();
   dir = direzione (x2,y2);
   drive (dir,0);
   while (speed() > 50) ;

   drive (dir,100);
   while ((loc_y() < y2) && speed()) spara();
   dir = direzione (x1,y1);
   drive (dir,0);
   while (speed() > 50) ;
  }
}
/********** SPARA **********/
spara()
{
 if (range = scan (angolo,5))
    {
     if (range > rangepr) cannon (angolo,range*8/7);
     else cannon (angolo,range*7/8);
     rangepr = range;
    }
 else
    {
     angolo -= 23;
     while (!(range = scan(angolo,10))) angolo += 20;
     if (range < 60) range = 60;
     if (range > rangepr) cannon (angolo,range*8/7);
     else cannon (angolo,range*7/8);
     rangepr = range;
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

