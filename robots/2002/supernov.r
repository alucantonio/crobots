
/*
SUPERNOVA                                            ÄÄÄ
by Pizzocaro Marco                               / -   -   \
ispirato al p-robots nova.pr                   / /  \   /  \ \
					 [   [  ³     *     ³  ]   ]
C Robots: Supernova                            \ \  /   \  / /
Autore: Pizzocaro Marco                          \ _   _    /
File: supernov.r                                    ÄÄÄÄ
Classe: Microbots 500
VB:499 (24%)


*/

int dir, ang, range, mr;
int x1, y1, x2, y2;
int t, c;

main()
{
/*si reca nell'angolo + vicino e calcola alcune variabili*/
turn (x1=(loc_x()>500)*1000,y1=(loc_y()>500)*1000);
fire();
t=325;
x2=150+(x1==1000)*700;
y2=150+(y1==1000)*700;
mr=950;
c=0;

/*ciclo della strategia iniziale*/
while((--t)>0)
{
while (loc_x()>60&&loc_x()<940) fire();
rip(x2,y2);
fire();

/*controlla se non ci sono nemici negli angoli e aggiorna t*/
if (!scan(dir+c,10)) t-=12;

while (loc_x()<95||loc_x()>905) fire();
rip(x1,y1);

/*varia c per cambiare l'angolo in cui controlla*/
c=(t%3-1)*40;
}

/* attacco finale a stella */
if (loc_x()<500)
turn(800,1000);
else turn(200,1000);
mr=2000;
while(1)
{

 while (loc_y() < 900) fire();
 rip(500,0);

 while (loc_y() > 200) fire();
 rip(0,1000);

 while (loc_x() > 100) fire();
 rip(1000,500);

 while (loc_x() < 800) fire();
 rip(0,0);

 while (loc_y() > 100) fire();
 rip(500,1000);

 while (loc_y() < 800) fire();
 rip(1000,0);

 while (loc_x() < 900) fire();
 rip(0,500);

 while (loc_x() > 200) fire();
 rip(1000,1000);
}


}


/*cambia direzione*/
rip(xd,yd)
{
drive(dir,40);
turn(xd,yd);
while (speed() > 50) turn(xd,yd);
}

/*routine di fuoco*/
fire()
{
drive(dir,100);
if ((range=scan(ang,7))&&range<mr)
  {
   if (range<100) return cannon(ang,range);
   else
   cannon(ang+=5*(!(scan(ang+355,6)))+355*(!(scan(ang+5,6))), 2*scan(ang,10)-range);
  }
  else if (scan (ang-=16,10));
  else if (scan (ang+=32,10));
  else ang+=20;
}


/*calcola la direzione per un punto*/
turn(xx,yy)
{dir=(180+180*(xx>loc_x())+atan(100000*(loc_y()-yy)/(loc_x()-xx)));}
