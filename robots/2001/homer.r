/*

Crobots : Homer
Type : MiniCrobots type2
Version : 1.0
Author : Maurizio Camangi
Begin : 27-nov-2000
Revision : 02-dic-2000

Homer non si sposta mai dal suo angoletto, in cui descrive un pachidermico movimento triangolare che allarga
nel caso in cui sia rimasto un solo sopravvissuto.

*/

int ang, /* Angolo di scanning */
oang, /* Angolo di scanning precedente */
range, /* Gittata corrente */
orange, /* Gittata precedente */
dir, /* Direzione del cammino */
dist,
dist1,
dist2,
posx,
posy, /* Variabili temporanee ad un bit salva posizione */
nedflanders, /* Variabili temporanee */
duff; /* Massimo numero di cicli virtuali */

dehehihi() {

if(scan(ang-8,4)) ang-=8;
if(scan(ang+8,4)) ang+=8;
if(scan(ang-4,2)) ang-=4;
if(scan(ang+4,2)) ang+=4;
if(scan(ang-1,1)) ang-=1;
if(scan(ang+1,1)) ang+=1;

}

int DOH(x)
{
drive(dir,x);
if (orange=scan(ang,10)) {
if (dist<160) {
cannon(ang/*+=5+350*(scan(ang+355,5)>0)*/,2*scan(ang,10)-orange);
} else {
dehehihi();
if (orange=scan(oang=ang,10)) {
dehehihi();
if (range=scan(ang,10)) {
cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*165/(165+orange-range-(cos(ang-dir)/4167))));
}
}
}
return ang+=40*(orange>900);
}
if (orange=scan(ang+=340,10));
else if (orange=scan(ang+=40,10));
else if (orange=scan(dir,10)) ang=dir;
else return (ang+=40);
cannon(ang,2*scan(ang,10)-orange);
}

int burp(x,d) {
while (speed()>49) DOH(0);
if ((dir=x)%180)
while((dist=(posy*(1000-loc_y())+!posy*loc_y()))>d) DOH(100);
else while((dist=(posx*(1000-loc_x())+!posx*loc_x()))>d) DOH(100);
}

int main() /* Inizializza alcune variabili ed innesca la routine principale */
{

dist2=1000-(dist1=300); /* 250-300 */

posy=loc_y(posx=loc_x(duff=1)>500)>500;

burp(270-180*posy,120);

while (burp(180+180*posx,120))
{

DOH((dir=(90+180*posy))<0);
if ((duff-=1) <= (nedflanders=0)) {
while(duff < 380) { nedflanders+=(scan(ang+(duff+=20),10)!=0);}
if (nedflanders<=1) {
dist1=dist2=500;
} else duff=6;
}
while((dist=(!posy*(dist1-loc_y())+posy*(loc_y()-dist2)))>0) DOH(100) ;
burp((315-90*posx)-(270-180*posx)*posy,90);
}
}
