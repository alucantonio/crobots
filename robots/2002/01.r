/*01.r (pippo2c)
----------------------
Autore: Andrea Creola
Robot minimale.
*/

int ang,rng,rp;
main()
{
while(1)
{
while(loc_y()<800) sp(drive(90,100));
while(speed(drive(270,0))>50);
while(loc_y()>200) sp(drive(270,100));
while(speed(drive(90,0))>50);
}


}
sp()
{
if(rng=scan(ang,10))cannon(ang,2*(rp=rng)-rp);
else ang+=10;
}
