/*
Nome del robot  : Cortez.r
Autore          : Gianni Ino

Il robot si muove a spasso per l' arena cercando di trovare un percorso che
lo renda inintercettabile dagli spari nemici.
Utilizza tre routine di fuoco diverse, prelevate da vari robot che si sono
presentati nei tornei scorsi.
Non e' molto forte.

*/

int sx,sy,dx1,dy1, quod, delta, y, dir, dx, dy, mxd, d, d1, t, quid, cont, ty1, vel, ciao, ty;

main()
 {
 t=21;
 ty=90;
 dx=150;
 dy=150;
 dx1=850;
 dy1=850;
 ciao=ty;
 mxd=770; /*770*/
 vel=100;
 quod=0;
 quid=16; /*16*/
 drive (ty,vel);
 while (1)
 {
 while (quid<35)
 {
 quod=quod+1;
 Inverti();
 Fuoco2();
 }
 quid=-quid;
 while (quid<-18)
 {
 quod=quod+1;
 Inverti();
 Fuoco3();
 }
 while (quid<16)
 {
 quod=quod+1;
 Inverti();
 Rapido();
 }
 }

}

Inverti()
{
sx=loc_x();
sy=loc_y();
ty1=0;
cont=0;
if (quod==30)
{quod=0;
quid=quid+3;}
if (sx>dx1)
{
ty1=ty1+180;
cont=cont+1;
}
if (sx<dx)
{
if (sy>dy1)
{
ty1=ty1+360;
}
cont=cont+1;
}
if (sy<dy)
{
ty1=ty1+90;
cont=cont+1;
}
if (sy>dy1)
{
ty1=ty1+270;
cont=cont+1;
}
if (cont>0)
{
Fuoco();
ty=ty1/cont+quid;
drive (ty,vel);
}
}
                                              
Fuoco2()
{
 if ( (d=scan(ciao,10)) && (d<770) ) 
  {
   if (d=scan(ciao+353,3)) cannon(ciao+=353,3*scan(ciao,10)-2*d);
   else if (d=scan(ciao,3)) cannon(ciao,3*scan(ciao,10)-2*d);
   else if (d=scan(ciao+7,3)) cannon(ciao+=7,3*scan(ciao,10)-2*d); 
  }
 else
  {
   if ((d=scan(ciao+21,10))&&(d<700)) {ciao+=21;cannon(ciao,d);}
   else if ((d=scan(ciao+42,10))&&(d<700)) ciao+=42;
        else ciao+=63;
  }  
}                         

Fuoco()
{
 drive (ty,40);
 while (speed()>49)
 {
  if ((d=scan(ciao,10))) {cannon(ciao,d);cannon (ciao,d);}
  else ciao+=21;
  }
d1=d;
}

Rapido()
{
  if ((d=scan(ciao,10))&&d<770) cannon(ciao,2*scan(ciao,10)-d);
  else ciao+=21;
}

Fuoco3()
{
if (!(d=scan(ciao,10)))
if (!(d=scan(ciao-=20,10)))
if (!(d=scan(ciao+=40,10))) { ciao+=40; return; }
if (!scan(ciao+=5,5)) ciao-=10;
if (!scan(ciao+=3,3)) ciao-=6;
if (d1=scan(ciao,10)) cannon(ciao,d1+d1-d);
if (d>705) ciao+=40;
} 
