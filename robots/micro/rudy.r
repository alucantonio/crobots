/*                             R   U   D   Y


Programmato da: Alessandro Carlin

Scheda tecnica:
Robot non particolarmente innovativo e programmato per motivi di tempo in
7 ore. Si porta in alto a dx e oscilla orizzontalmente scegliendo la
lunghezza dell' oscillazione cosi':
- se va incontro ad un nemico lontano arriva fino a 700 metri da lui
- se va incontro ad un nemico vicino oscilla lungo
- se non c'e' nessuno oscilla ancora piu' lungo
Senza fare controlli a circa 140000 cicli attacca oscillando verticalmente
a meta' arena e sparando sempre con la stessa routine.
*/

int aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;

main(){
up(950);
dx(900);
while(t<1900){
if (!(dist=scan(180,10))) if (!(dist=scan(200,10))) dist=1200;
if ((aq=dist-700)>0) xora=loc_x()-aq;
else xora=650;
     sx(xora);
     dx(900);
}
sx(600);
while(1)
{
while(loc_y()>100) {drive(270,100);Fire();}drive(270,0);
up(900);
}
}

up(limt) {while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dx(limt) {while(loc_x()<limt) {drive(0,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}

Fire()
{
       ++t;
       if (!(oldr=scan(deg,10)))
       if (!(oldr=scan(deg-=20,10)))
       if (!(oldr=scan(deg+=40,10))) {deg+=40; return;} 
       if (rng=scan(deg,10)<760)
        cannon(deg+=7*(!(scan(deg+356,7)))+353*(!(scan(deg+4,7))),2*scan(deg,10)-oldr);
       else deg+=40;
}

