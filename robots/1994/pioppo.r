/*
            ROBOT :      Pioppo

   Programmato da :    Caffo Pierpaolo

              ------------------------------------

Pioppo si muove per il campo di battaglia spostandosi da un punto ad un' altro calcolati a caso.

come fuoco usa una routine un' po' rudimentale (non ho avuto molto tempo per migliorarla)


 */

int a1,a2,dir,ang,r1,range;

int ang1,ang2,sw,sw1;

main()

{
 range=700;
 a1=100+rand(800);           /*    ricava il primo punto */
 a2=100+rand(800);
 dir = plot_course(a1,a2);
 drive(dir,100);             /* parti */
 ang=rand(360);
  while(1) 
{
  sw=sw+1;
  if (distance(a1,a2) < 50)  /* se sei vicino al punto di arrivo */
    {
     drive(dir,50);
     a1=100+rand(800);       /* ricava un nuovo punto */
     a2=100+rand(800);
     dir = plot_course(a1,a2);
     
    }
  drive(dir,100);
  r1=scan(ang,10);
  if ((r1 < range) && (r1 > 10))
    {
     cannon(ang,r1);         /* inizia con uno sparo */
     ang1=ang+4;             /* ora migliora la mira */
     ang2=ang-4;
     sw=0;
    }
  if ( sw == 1)
    {
     sw1=0;
     prova(ang1);            /* guarda a sinistra */
     if(sw1==0)
     prova(ang2);            /* guarda a destra   */
    }
  if (sw >1)
      {
       ang=ang+20;
      }
       
    
}/* end while */
}/* end main  */
 
prova(x)
int x;
{

  r1=scan(x,4);
  if ( (r1 < range )&& (r1 > 10))
    {
     ang=x;
     ang1=ang+4;
     ang2=ang-4;
     sw1=1;
    }
}

/*  seguono due routine classiche */

/* calcolo distanza tra due punti */

distance(x2,y2)
int x2,y2;

{
  int x, y,d;

  x = loc_x() - x2;
  y = loc_y() - y2;
  d = sqrt((x*x) + (y*y));

  return(d);
}

/* calcolo direzione tra il punto di partenza e quello di arrivo */

plot_course(xx,yy)
int xx, yy;
{
  int d,x,y,scale,ax,ay;

  scale = 100000;
  ax=loc_x();
  ay=loc_y();
  x = ax - xx;
  y = ay - yy;

  if (x == 0) {
    if (yy > ay)
      d = 90;
    else
      d = 270;
  } else {
    if (yy < ay) {
      if (xx > ax)
        d = 360 + atan((scale * y) / x);
      else
        d = 180 + atan((scale * y) / x);
    } else {
      if (xx > ax)
        d = atan((scale * y) / x);
      else
        d = 180 + atan((scale * y) / x);
    }
  }
  return (d);
}

  