/*                                                 \       /
        Robot : baubau.R     Versione 1.10          /-----|           /-\
        Autore :        Paolo Torda                 | o o |           | |
                        MC6617@mclink.it           /  o  /---------\-/ /
                                                  | --- |           \/
                                                   \ - /-  -------  -\
                                                         ||       ||

cambiamenti rispetto alla precedente versione
        1.00    prima versione
	1.10	cambio la routine di fuoco per far in mode che 
                ignori bersagli a distanza > 700, minori modifiche
                alla routine di fuoco


   Il Robot segue un percorso a rombo, si sposta da un vertice
   all'altro e vi rimane fino a che i danni non si fanno troppo
   pesanti. Usa due diverse subroutine di fuoco a secondo che si
   trovi in movimento o fermo ad un vertice.
   Questo robot e' fatto per rimanere per la maggior parte del
   tempo fermo e muoversi solo per scappare in caso di necessita'.



*/


int range,orange,ang,oldang;

main()
{
while (!(range = scan(ang,8)))
   ang+=16;
cannon(ang,range);

while (1)
        {
        go(100,500);
        go(500,900);
        go(900,500);
        go(500,100);
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
while (damage() < (danni+23))
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
