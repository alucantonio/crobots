/*
 Pippo01a.R

 Tattica: Si reca nell'angolo piu' vicino e si mette ad oscillare a
          destra e sinistra fino a circa 100.000 cicli dopo di che
          si mette ad andare sulla diagonale principale.
          Io ero convinto che la persoresse tutta, invece ora che scrivo
          la scheda scopro le ne percorre solo met….

*/
int rng,orng,deg,odeg,dir,dam,un1,ttt;
main()
{
 if(loc_y()>500) up(900,90);
 else dw(100,270);

 un1=(loc_x()>500);
 ttt=90;
 while(ttt)
 {
  if (damage()<60)--ttt;
  sx(200+un1*500);
  dx(300+un1*500);
 }
 sx(100);
 dw(100,270);
 while(1)
 {
  up(500,45);
  dw(100,225);
 }
 
}

/* funzione di sparo presa da goblin */
sp(flag)
{ 
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;

        if (orng>700)
        {
            if (!scan(deg-=3,3)) deg+=6;
            cannon(deg,orng); deg+=40; return;
        }

        fnd();

        if (orng=scan(odeg=deg,5))
        {
            fnd();

            if (rng=scan(deg,10))
            {
                if (flag)
                {
                cannon(deg+(deg-odeg)*((1200+rng)>>9),
                       rng*160/(160+orng-rng));
                }
                else
                {
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
                }
            }
        }
     }
     else
     {
        if (scan(deg-=20,10)) return;
        if (scan(deg+=40,10)) return;
        if (scan(dir,10))deg=dir;
        else deg+=40; return;
     }
}
up(xx,yy)
 {
   while(loc_y()<xx) vs(yy);
   stop();
 }
dw(xx,yy)
 {
  while(loc_y()>xx) vs(yy);
  stop();
 }
dx(xx)
 {
  while(loc_x()<xx) vs(00);
  stop();
 }
sx(xx)
 {
  while(loc_x()>xx) vs(180);
  stop();
 }

vs(xx)
 {
  drive(dir=xx,100);
  sp();
 }

stop()
 {
  drive(dir,0);
  while(speed()>50) sp(1);
 }


fnd()
{
 if(scan(deg-5,1)) deg-=5;
 if(scan(deg+5,1)) deg+=5;
 if(scan(deg-3,1)) deg-=3;
 if(scan(deg+3,1)) deg+=3;
 if(scan(deg-1,1)) deg-=1;
 if(scan(deg+1,1)) deg+=1;
}
