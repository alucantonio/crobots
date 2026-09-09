/* DICOTOMIC                                                                */
/* By Andrea B. Previtera                                                   */
/* ------------------------------------------------------------------------ */
/* La stupidit… di questo robot Š apertamente dichiarata.                   */
/* Parimenti sia per il suo sicuro piazzamento in coda alla classifica.     */
/* E' vecchio ma assai sperimentale. Mi raccomando, se ci sar… carenza di   */
/* posti, mandate Carla.r allo sbaraglio. Che altro dire su questa inetta   */
/* creatura che comunque, mi si consenta, Š assai sperimentale ?            */
/* Si muove abbastanza, prova a scappicchiare negli angoli...               */
/* ah, gi…, ha anche una routine di scan "dicotomica", lenta lenta lenta    */
/* lenta lenta ma assai sperimentale.                                       */
/* Verr… annientato, ma sar… un trionfo per la sperimentazione.             */
/* ------------------------------------------------------------------------ */

int i;
int degree;
int range;
int distance;
int lastdamage;
int move;
int corner;
int lookingto;
int timeout;
int charging;

main()
{
 lastdamage=damage();
 corner=0;
 while(1)
 {
  move=0;
  timeout=0;
  charging=0;
  ncorn(corner);
  if(corner>=3) corner=0; else corner=corner+1;
  flowercannon();
 }
}

compute()
{
 if (charging==1) drive(degree,distance);
 if(move==0)
 {
  if((charging==0)&&(damage()>lastdamage+5))
  {
   lastdamage=damage();
   move=1;
  }
  else
  {
   if(timeout==500) move=1;else timeout=timeout+1;
  }
 }
}

flowercannon()    /* SPERIMENTALE ! SPERIMENTALEEEE ! */
{
 flowerscan();
 while((distance!=0)&&(move==0)) 
 {
  cannon(degree,distance);
  distance=scan(degree,1); 
  if(distance==0)
  {
   range=10;
   d_scan();
  } 
  else 
  if(distance<100) 
  {
   drive(degree,0);
   charging=1;
  }
 compute();
 }
}

flowerscan()
{
 i=1;
 while((i<6)&&(scan(lookingto+(i*20),10)==0)) i=i+1;
 degree=lookingto+(i*20);
 range=10;
 d_scan();
}

d_scan()
{
 if(range!=1)
 {
  range=range/2;
  if (scan(degree-range,range)!=0)
  {
   degree=degree-range;
   d_scan();
  }
  else
  if (scan(degree+range,range)!=0)
  {
   degree=degree+range;
   d_scan();
  }
 }
 else distance=scan(degree,range);
}

ncorn(corner) 
{
  int x, y;
  int angle;
  if (corner == 0) 
  { 
    lookingto = 0;
    x = 20;
    y = 20;
  } else
  if (corner == 1) 
  {
    lookingto = 270;
    x = 20;
    y = 980;            
  } else
  if (corner == 2) 
  {
    lookingto = 180;
    x = 980;
    y = 980;
  } else
  if (corner == 3) 
  {
    lookingto = 90;
    x = 980;
    y = 20;
  }
  angle = plot_course(x,y);
  drive(angle,100);
  while (dist(loc_x(),loc_y(),x,y) > 200 && speed() > 0) flowercannon();
  drive(angle,20);
  while (dist(loc_x(),loc_y(),x,y) > 50 && speed() > 0) flowercannon();
  drive(angle,0);
} 

dist(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;
  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));
  return(d);
}

plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;
  scale = 100000; 
  curx = loc_x();  
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;
  if (x == 0) {
               if (yy > cury)
               d = 90;
               else d = 270; 
               } else 
               {
                if (yy < cury) {
                                if (xx > curx)
                                d = 360 + atan((scale * y) / x);
                                else d = 180 + atan((scale * y) / x); 
                                } else 
                                {
                                 if (xx > curx)
                                 d = atan((scale * y) / x); 
                                 else d = 180 + atan((scale * y) / x);
                                 }
               }
  return (d);
}

