
/*                           F  A  L  C  O





Programmato da:  Alessandro Carlin


Premessa:

Falco altro non e' che un'evoluzione di Tigre (che lo
era di Cobra), il minibot che
avevo fatto l'anno scorso per il torneo under500 Vb
E' stato sistemato in 1 ora... in particolare l'f2f fa rabbrividire i sorci
                                                            

Strategia:

Vedi Tigre... gli accorgimenti che lo differenziano da quest'ultimo sono piu'
tecnici che tattici


                                            */

int flagu,b,xa,ya,flag,flag1,nas,dri,d,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;

main(){
if (ya=(loc_y()>500)) up(920); else dn(80);
if (xa=(loc_x()>500)) dx(920); else sx(80);
b=ya*2+(xa!=ya);           /* grazie a Simone Ascheri per la dritta */
while(t<10000){
daa=damage(flag1=2);
if (dver>0){
     if (xa){
     d=180;
     sx(790+daa);
     dx(920);         }
     else {
     d=0;
     dx(210-daa);
     sx(80);         }
     dver-=((3*(damage()-daa)+1));
     }
else{
     if (ya){
     d=270;
     dn(790+daa);
     up(920);         }
     else {
     d=90;
     up(210-daa);
     dn(80);         }
     dver+=((3*(damage()-daa)+1));
     }
         if (++t>4)
              {
               flag=flagu=90*b-30;
               while (flag1&&flag<flagu+160) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1>0));
              }
}
while(1)
{
while(loc_y()>180) {zz(210,330);
                    }                                 
while(loc_y()<820) {zz(150,30);
                     }
}
}

up(limt) { while(loc_y()<limt) {Fire(0,90);}drive(90,0);}
dn(limt) {while(loc_y()>limt) {Fire(0,270);}drive(270,0);}
dx(limt) {while(loc_x()<limt) {Fire(0,360);}drive(0,0);}
sx(limt) {while(loc_x()>limt) {Fire(0,180);}drive(180,0);}


Fire(qwe,po)
{
    drive(po,100);
    if ((oldr=scan(odeg=deg,10))&&(oldr<850)) {
        if (scan(deg+350,10)) deg-=5;else deg+=5;
        if (scan(deg+350,10)) deg-=4;else deg+=4;
        cannon(deg+(deg-odeg)*qwe,2*scan(deg,10)-oldr);        

    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        if (scan(d,10)) return(deg=d);
        deg+=40;
    }
}

zz(aw,bw){
                    while(loc_x()>500) {Fire(1,aw);}
                    while(loc_x()<500) {Fire(1,bw);}
                    }

