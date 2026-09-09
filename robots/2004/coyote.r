
/*                     C    O    Y    O    T    E





Programmato da:  Alessandro Carlin


Premessa:

Continua la saga "animalesca" dopo Falco, Tigre e Cobra quest'anno vanno di
moda i mammiferi con Puma e Coyote. In effetti visti i risultati potevo
chiamarli Pulce e Pidocchio... 20 minuti netti di test tra tutti e due e differenze
abbastanza marginali sui robot dell'anno scorso per Puma mentre Coyote gira su un
quadrato

Strategia:

Simile a Tigre ma con movimento base quadrato e cerca le differenze... un po' come
sulla settimana enigmistica

                                                        */


int flagu,b,xa,ya,flag,flag1,nas,dri,d,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;

main(){
if (ya=(loc_y()>500)) up(920); else dn(80);
if (xa=(loc_x(t=4)>500)) dx(920); else sx(80);
b=ya*2+(xa!=ya);         
while(t<10000){
flag1=2;
     if (xa){
     d=180;
     sx(910);
     if(ya) {dn(910);}
     else up(90);
     dx(910);
     if(ya) {up(910);}
     else dn(90);
             }
     else {
     d=0;
     dx(90);
     if(ya) {dn(910);}
     else up(90);

     sx(90);
     if(ya) {up(910);}
     else dn(90);
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
        if (!scan(deg+=355,5)) deg+=10;
        if (!scan(deg+=357,3)) deg+=6;
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

