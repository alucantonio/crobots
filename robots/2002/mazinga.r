
/*                              M A Z I N G A                      */

/* Un robot di questo tipo non mi sarebbe mai venuto in mente di   */
/* farlo, se non che nel mezzo del cammin della mia vita...


/* TOM:-UŠ, Ale, che cosa stai smanettando con quel computer ? -   */
/* ALE:-Beh, sto facendo un nuovo robot per il torneo 2k2!         */
/*      Non te ne sarai anche quest' anno per l'ennesima volta     */
/*      dimenticato spero ? -                                      */
/* TOM:-OOOOOOOOOOPPPSSSSS -                                       */
/* ALE:-Hai 24 ore... ce la puoi ancora fare!!!!              -    */
/*                                                                 */
/*                       Tommaso De Pra                            */


/* DOPO AVER RAGGIUNTO IL SUO ANGOLO PREFERITO, OVVERO IL MENO LONTANO,
   INIZIA UN MOTO A TRIANGOLO DEL TUTTO SIMMETRICO
   ATTACCA SOLO SE CONTRO UN SOLO AVVERSARIO CON UNA ROUTINE SUICIDA
   ( O SUDICIA?? )                                                 */

int torta,b,taw,ya,flag,tortab,d,rng,t,oldr,deg,odeg;

main(){
if (ya=(loc_y()>500)) up(920); else dn(80);
if (taw=(loc_x(t=4)>500)) dx(920); else sx(80);
b=ya*2+(taw!=ya);
while(t<10000){
if (b==0) {dx(200); while(loc_x()>80) {Fire(135);} dn(80);}
else if (b==1) {sx(800); while(loc_x()<920) {Fire(45);}dn(80);}
else if (b==2) {sx(800); while(loc_x()<920) {Fire(315);}up(920);}
else {dx(200); while(loc_x()>80) {Fire(225);} up(920);}

         if (++t>10)
              {
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
          while(loc_x()>540) {Fire(1,aw);}
          while(loc_x()<550) {Fire(1,bw);}
                    }

