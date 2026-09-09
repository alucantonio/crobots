/*
   Babadook by Emanuele Marsigliani

   Sono anni che seguo CROBOTS e finalmente mi sono deciso a
   partecipare al torneo.
   Babadook e' il mio primo robot e come tale fa schifo (non che gli
   altri siano tanto meglio...). Babadook a dispetto del nome non fa
   proprio paura, anzi, cerca di tenersi a distanza descrivendo una
   specie di quadrato che si allunga verso l'avversario se troppo
   lontano o fugge da esso se troppo vicino. Il regolamento non lo
   vieta esplicitamente - secondo me dovrebbe - e io sono
   dispettoso... l'ho offuscato :-)
*/
int la,lj,lb,lc;int lp,li,ld,lf,le,lk;lh(lc,lm){drive(lc,lm);if(lb=
scan(lj=la,10)){if(scan(la-8,5)){if(scan(la-=5,2));else la-=4;}else{
if(scan(la+8,5)){if(scan(la+=5,2));else la+=4;}else{if(scan(la,1));
else if(scan(la-=3,2));else la+=6;}}return(cannon((la<<1)-lj,(scan(la
,10)<<1)-lb));}else{if(lb=scan(la+=20,10))cannon(la,lb);else if(lb=
scan(la-=40,10))cannon(la,lb);else if(lb=scan(la+=60,10))cannon(la,lb
);else if(lb=scan(la-=80,10))cannon(la,lb);else la+=120;}}ln(){if(lb>
650){return 1;}return-1;}lo()int lg;{lg=cos(lc-la);if(lg>45000){
return 1;}else if(lg<-45000){return-1;}return 0;}ll(){lh(lc+=90,0);if
(scan(lc,10))la=lc;++li;le=4;}main(){le=4;while(1){if(li&1)ld=loc_y();
else ld=loc_x();if(li&2)lf=ld>100;else lf=ld<900;if(lf){while(--le>0){
lh(lc,100);}if(lb&&speed()==100){ll();if(lk=lo()){le+=lk*ln();}}else{
lh(lc,100);}}else{ll();}}}
