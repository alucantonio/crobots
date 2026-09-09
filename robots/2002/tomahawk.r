
/*                             T O M A H A W K                     */

/* Un robot di questo tipo non mi sarebbe mai venuto in mente di   */
/* farlo, se non che nel mezzo del cammin della mia vita...


/* TOM:-UŠ, Ale, che cosa stai smanettando con quel computer ? -   */
/* ALE:-Beh, sto facendo un nuovo robot per il torneo 2k2!         */
/*      Non te ne sarai anche quest' anno per l'ennesima volta     */
/*      dimenticato spero ? -                                      */
/* TOM:-OOOOOOOOOOPPPSSSSS -                                       */
/* ALE:-Hai 24 ore... ce la puoi ancora fare!!!! -                 */
/*                                                                 */
/*                       Tommaso De Pra                            */

/* DOPO AVER RAGGIUNTO IL SUO ANGOLO PREFERITO, OVVERO IL MENO LONTANO,
   INIZIA UN MOTO A TRIANGOLO VERSO L'UNO O L'ALTRO DEGLI ANGOLI ADIACENTI
   ATTACCA SOLO SE CONTRO UN SOLO AVVERSARIO CON UNA ROUTINE MERAVIGLIOSA
   CHE SI DIFFERENZIA DA QUELLA DELL'AMICO MEDIOMAN.R MA SEMPRE
   ISPIRATA A RUDOLF_6
                                                                   */

/* POICHE' SIA QUESTO ROBOT CHE MEDIOMAN.R SONO UNDER1000 Vb OPTO ACCIOCCHE'
   QUESTO PARTECIPI ANCHE AL TORNEO UNDER1000                      */
 
int torta,b,taw,ya,flag,opp,tortab,d,time,ru,rng,t,oldr,deg,odeg;

main(){
if (ya=(loc_y()>500)) up(920); else dn(80);
if (taw=(loc_x(t=4)>500)) dx(920); else sx(80);
b=ya*2+(taw!=ya);
while(t<10000){
if (b==0) {      while(loc_x()<150+ru) {Fire(45);} if (opp){dn(80);sx(80);} else {sx(80);dn(80);}}
else if (b==1) { while(loc_x()>850-ru) {Fire(135);} if (opp){dn(80);dx(920);}else {dx(920);dn(80);}}
else if (b==2) { while(loc_x()<850-ru) {Fire(225);} if (opp){up(920);dx(920);}else{dx(920);up(920);}}
else {           while(loc_x()>150+ru) {Fire(315);} if (opp){up(920);sx(80);}else {sx(80);up(920);}}
opp=!opp;

         if (++t>10)
              {
               if (++time>20) ru=100;
               tortab=2;
               flag=torta=90*b-30;
               while (tortab&&flag<torta+160) tortab-=(scan(flag+=20,10)>0);
               t=10002*((tortab>0));
              }
}
sx(550);
dx(450);
while(1)
{
while(loc_y()>250) {xcc(210,330);
                    }                                 
while(loc_y()<750) {xcc(150,30);
                     }
}
}

up(limt) { while(loc_y()<limt) {Fire(0,90);}drive(90,0);}
dn(limt) {while(loc_y()>limt) {Fire(0,270);}drive(270,0);}
dx(limt) {while(loc_x()<limt) {Fire(0,360);}drive(0,0);}
sx(limt) {while(loc_x()>limt) {Fire(0,180);}drive(180,0);}


Fire(po)
{
    drive(po,100);
    if ((oldr=scan(odeg=deg,10))&&(oldr<850)) {
        if (!scan(deg+=355,5)) deg+=10;
        if (!scan(deg+=357,3)) deg+=6;
        cannon(deg,2*scan(deg,10)-oldr);        

    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        deg+=40;
    }
}

xcc(aw,bw){
          while(loc_x()>540) {Fire2(1,aw);}
          while(loc_x()<550) {Fire2(1,bw);}
                    }

Fire2(po)
{
    drive(po,100);
    if (oldr=scan(odeg=deg,10)) {
        if (!scan(deg+=355,5)) deg+=10;
        if (!scan(deg+=357,3)) deg+=6;
        cannon(deg+(deg-odeg),2*scan(deg,10)-oldr);        

    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        deg+=40;
    }
}
