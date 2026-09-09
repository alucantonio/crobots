/*

Torneo Crobots MCmicrocomputer 1996

ROBOT : CARLO96.R

Luigi Cimini

*/

int a, r, o;

main()
{
    drive(270,100); while(loc_y() > 40) fuoco();
    drive(90,0);    while(speed() > 49) fuoco();
    a = 180; o = 60;
    while(1)
   {
    drive(0,100);   while(loc_x() < 900) fuoco();
    drive(180,0);   while(speed() > 49)  fuoco();
    drive(180,100); while(loc_x() > 99)  fuoco();
    drive(0,0);     while(speed() > 49)  fuoco();
   }
}
fuoco()
{
    if (r = scan(a,2))
      {if (r == o) cannon(a, r); else {cannon(a,r+r-o); o=r;}}
    else
      {a -= 4; if (a < 4) a = 180;}
}
