/*

Torneo Crobots MCmicrocomputer 1996

ROBOT : ANDREA96.R

Luigi Cimini


*/

int r, a;

main()
{
    drive(270,100); while(loc_y() > 40) fuoco();
    drive(90,0);    while(speed() > 49) fuoco();
    a = 180;
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
    if (r = scan(a,2)) cannon(a, r); else {a -= 4; if (a < 4) a = 180;}
}
