/* Pippo99.R

   Nel mezzo del torneo di nostra.....

   Tattica: All'inizio si porta nell'angolo piu' vicino, li rimane fino
   a quando i danni non raggiungono il 10%, da quel momento oscilla nei
   dintorni dell'angolo cercando di non andare incontro a qualche altro
   concorrente, questo lo esegue per un breve periodo, circa 80000
   cicli di clock, poi si mette a oscillare in diagonale nello stesso angolo
   per poi finire a oscillare per tutto il perimetro con un inclinazione
   di circa 45 gradi.
   Nel caso in cui all'inizio il robot conta un solo avversario riduce i tempi
   di attesa delle prime due oscillazioni.

   Purtroppo a causa del tempo, 2 giorni, ho dovuto utilizzare alcune funzioni
   gi… scritte, in particolare quella di fuoco e di Radar che sono del
   Goblin.

   Teoricamente dovrebbe essere migliore di Pippo98, ma questo Š tutto
   un discorsco teorico, e dato che dal dire al fare c'Š di mezzo un mare,
   oppure non c'Š pi— la mezza stagione, non dire gatto se non ce l'hai
   nel sacco e cosi via.

   P.S. Attenzione questo robot ha l'influenza e questa Š contagiosa.

*/
int rng,orng,deg,odeg,dir,dam,cc,dd,t;
main()
{
 if (loc_x()<500) sx(100);
 else dx(900);
 if (loc_y()<500) dw(100);
 else up(900);

 dx=(loc_x()>500)+(loc_y()>500)*2;
 while(damage()<10)sp();
 cc=50;
 dd=30;
 if (radar())
 {
   cc=20;
   dd=30;
 }
 while(--cc)
 {
  if (dx==0)
   {

    if (!scan(090,10))
     {
      up(300);
      dw(100);
     }
    else
     {
      dx(300);
      sx(100);
     }
   }
  else if (dx==1)
   {
    if (scan(90,10)) 
     {
      sx(700);
      dx(900);
     }

    else
     {
      up(300);
      dw(100);
     }
   }

  else if (dx==2)
   {
    if (!scan(270,10))
     {
      dw(700);
      up(900);
     }
    else
     {
      dx(300);
      sx(100);
     }

   }

  else 
   {   
    if (scan(270,10)) 
     {
      sx(700);
      dx(900);
     }
    else
     {
      dw(700);
      up(900);
     }
   }
  
 }
  while(--dd)
  {
   if (dx==0)
     {
      vai(100,400);
      vai(400,100);
     }
   else if (dx==1)
     {
      vai(900,400);
      vai(600,100);
     }
   else if (dx==2)
     {
      vai(100,600);
      vai(400,900);
     }
   else 
     {
      vai(900,600);
      vai(600,900);
     }

  }
 while(1)
{
 vai(500,100);
 vai(900,500);
 vai(500,900);
 vai(100,500);

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

        if(scan(deg-5,1)) deg-=5;
        if(scan(deg+5,1)) deg+=5;
        if(scan(deg-3,1)) deg-=3;
        if(scan(deg+3,1)) deg+=3;
        if(scan(deg-1,1)) deg-=1;
        if(scan(deg+1,1)) deg+=1;

        if (orng=scan(odeg=deg,5))
        {
            if(scan(deg-5,1)) deg-=5;
            if(scan(deg+5,1)) deg+=5;
            if(scan(deg-3,1)) deg-=3;
            if(scan(deg+3,1)) deg+=3;
            if(scan(deg-1,1)) deg-=1;
            if(scan(deg+1,1)) deg+=1;

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
/* funzione di movimento */
up(xx)
 {
   while(loc_y()<xx)
     {
      drive(dir=90,100);
      sp();
     }
   stop();
 }
dw(xx)
 {
  while(loc_y()>xx)
   {
    drive(dir=270,100);
    sp();
   }
  stop();
 }
dx(xx)
 {
  while(loc_x()<xx)
   {
    
    drive(dir=0,100);
    sp();
   }
  stop();
 }
sx(xx)
 {
  while(loc_x()>xx)
   {
    if ((deg==90)&&(rng)) xx=300;
    drive(dir=180,100);
    sp();
   }
  stop();
 }

vai(xx,yy)
{
 if (loc_y()==yy) ++yy;
 drive(dir=180+180*(xx>loc_x())+atan(100000*(loc_y()-yy)/(loc_x()-xx)),100);
 while(dist(xx,yy)>10000) sp();
 stop();
}

/* distanza da un punto dato */
dist(xx,yy)
{
 int x,y;
 x=xx-loc_x();
 y=yy-loc_y();
 return((x*x)+(y*y));
}

/* funzione di ricerca avversari presa da goblin */
radar()
{
    deg=-10; t=0;
    while((deg+=20)!=710) if (scan(deg,10)) ++t;
    return(t<3);
}
/* funzione per fermarsi (non ci posso credere!!!) */
stop()
 {
  drive(dir,0);
  while(speed()>50) sp(1);
 }
