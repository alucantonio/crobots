/*
 Pippo01B

 Tattica:
         Il robot si posiziona sul lato destro dove inizia a
         oscillare in su e in giu'.
         Esegue questo movimento fino a quando credo di essere solo
         con un'altro robot (quindi in 2), per sapere questo ogni
         tanto controlla l'arena e conta i nemici, se ne trova uno solo
         si mette a andare in su ed in giu' sulla diagonale maggiore.
*/
int rng,orng,deg,odeg,dir,dam,un, t1;
main()
{
 drive(dir=0,100);
 while(loc_x()<950)sp();
 stop(dir=90);

 drive(dir=90,100);
 while(loc_y()<900)sp();
 stop(dir=90);

 un=(uno()<2)*45;
 t1=400;
 if (!un)
 {
  while((--t1)&&(damage()<13))sp();
 }
 t1=25;
 while(1)
 {
  drive(dir=90-un,100);
  while(loc_y()<900)sp();
  stop(dir=270-un);

  if((--t1==0)&&(!un))
   {
    if ((uno()<2)||(damage()<40)) un=45;
    else t1=100;
   }



  drive(dir=270-un,100);
  while(loc_y()>100)sp();
  stop(dir=90-un);

 }

}

sp(flag)
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (orng>700)
        {
            if (!scan(deg-=3,3)) deg+=6;
            cannon(deg,orng); deg+=40;
        }
        else
        {
          fnd();
          if (orng=scan(odeg=deg,5))
          {
              fnd();

              if (rng=scan(deg,10))
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
        else deg+=40;
     }
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


 uno()
 {
  int x,y;
  x=0;y=0;
  while(y<360)x+=scan(y+=20,10)>0;
  return(x);
 }

stop(x)
int x;
{
 drive(x,0);
 while(speed()>50);

}
