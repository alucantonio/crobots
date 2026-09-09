/* 
        Robot : MiaoMiao.R     Versione 1.0        \       /
        Autore :        Paolo Torda                 /-----|           /-\
                        MC6617@mclink.it            | o o |           | |
                                                   /  o  /---------\-/ /
                                                  | --- |           \/
                                                   \ - /-  -------  -\
                                                         ||       ||

        Robot derivato da baubau.r, usa le stesse subroutines di
        sparo e di movimento.
        Si sposta in un angolo e ci rimane fino a che non subisce
        danni consistenti, quindi si sposta in un altro angolo,
        controllando prima che sia libero.
        Se nessu angolo risulta libero rimane dov' e'.


*/


int range,orange,ang,oldang;

main()
{
int dato;
while (!(range = scan(ang,8)))
   ang+=16;
cannon(ang,range);

dato = s_e();

while(1)
        {
        if (dato == 1)   dato = n_e();
        if (dato == 2)   dato = n_w();
        if (dato == 3)   dato = s_w();
        if (dato == 4)   dato = s_e();
        }
}


s_e()
{
int d1,d2,d3;

go (900,100);

while (1)
        {
       /* guardo agli altri 3 angoli */
        d1 = scan (90,10);
        d2 = scan (180,10);
        d3 = scan (135,10);

        if (!d1)  return 1;
        if (!d2)  return 3;
        if (!d3)  return 2;
        spara();
        }
}


n_e()
{
int d1,d2,d3;

go (900,900);

while (1)
        {
       /* guardo agli altri 3 angoli */
        d1 = scan (180,10);
        d2 = scan (270,10);
        d3 = scan (225,10);

        if (!d1)  return 2;
        if (!d2)  return 4;
        if (!d3)  return 3;
        spara();
        }
}

n_w()
{
int d1,d2,d3;

go (100,900);

while (1)
        {
       /* guardo agli altri 3 angoli */
        d1 = scan (270,10);
        d2 = scan (0,10);
        d3 = scan (315,10);

        if (!d1)  return 3;
        if (!d2)  return 1;
        if (!d3)  return 4;
        spara();
        }
}

s_w()
{
int d1,d2,d3;

go (100,900);

while (1)
        {
       /* guardo agli altri 3 angoli */
        d1 = scan (90,10);
        d2 = scan (0,10);
        d3 = scan (45,10);

        if (!d1)  return 2;
        if (!d2)  return 4;
        if (!d3)  return 1;
        spara();
        }
}
/* GO(ax,ay)
   Sposta il robot alle coordinate (ax,ay) alla velocit… sp
   necessita di "angolo_rotazione" e di "distanza"                */


go(ax,ay)
int ax,ay;
{
int an,danni;

an = angolo_rotazione(ax,ay);
while(distanza(ax,ay))
  {
  drive(an,100);
  bomb();
  }
drive(an,0);
danni = damage();
while (damage() < (danni+12))
        spara();
}


/* Calcola l'angolo di rotazione */
angolo_rotazione(xx,yy)
int xx, yy;
{
/* versione migliorata, solo se non ci sono spostamenti a + 0 - 90 gradi */
  int x1,y1;

  x1 = loc_x() - xx;
  y1 = (loc_y() - yy)*100000;

/*	vecchio sistema */
  if (xx > loc_x())
        return (360 + atan(y1 / x1)); 
  else
        return (180 + atan(y1 / x1));


/*  return (180 >>(xx>loc_x()) + atan(y1 / x1)); */
}

distanza(x1,y1)
int x1;
int y1;
{
  int xx, yy;


  xx = x1 - loc_x();
  yy = y1 - loc_y();
  return (((xx*xx) + (yy*yy)) > 8100);

}


spara()
{
while ( !(range = scan(ang,10)))
        ang+=19;

if ((range>200) && (range < 700))
        {
        oldang=ang;
        orange=range;
        ang+=4-(scan(ang-4,4) != 0)*8;
        ang+=2-(scan(ang-2,2) != 0)*4;
        ang+=1-(scan(ang-1,1) != 0)*2;
        if (range=scan(ang,10))
                cannon(ang+(ang-oldang)*range/300,range+(range-orange)*range/300);
/* originale               cannon(ang+(ang-oldang)*range/200,range+(range-orange+50)*range/275);
*/
        }
else if (range < 200)
        cannon(ang,range);

else ang+=33;     /* range > 700 segui un altro bersaglio */
}


bomb()
{
int i;

if (range = scan(ang,5))
                ;
else if (range = scan(ang + 10, 5))
        ang +=12 ;
else if (range = scan(ang-10, 5))
        ang -=12;
else if (range = scan(ang + 20, 5))
        ang +=21;
else if (range = scan(ang - 20, 5))
        ang -=21;
else
        {
        i = 6;
        while (!(range = scan(ang += 20, 10)) && (--i))
                ;
        orange = range;
        return;
        }

cannon(ang,range+(range-orange)*range/300);
orange=range;
oldang = ang;
}
