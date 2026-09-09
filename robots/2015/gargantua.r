/*
   Gargantua by Emanuele Marsigliani
   
   Sono anni che seguo CROBOTS e finalmente mi sono deciso a
   partecipare al torneo.
   In onore al "Sommo" grazie al quale la competizione sopravvive
   ho preso una vecchia versione del suo Jedi e gli aggiunto un F2F
   più moderno. Siccome però che il regolamento non lo vieta
   esplicitamente - secondo me dovrebbe - e io sono dispettoso...
   l'ho offuscato :-)
*/
int la,le,lc,ll,l7,lb,li,lf,lh,lj,lk,lt,lg,lv,lp;l6(){return(scan(lg,
10)!=0)+(scan(lg+20,10)!=0)+(scan(lg+40,10)!=0)+(scan(lg+60,10)!=0)+(
scan(lg+80,10)!=0)+(scan(lg+100,10)!=0);}l2(lb){int ls,l0;if(speed()<
100)drive(lb,100);if(scan(la,10)>50){ls=(sin(la-lb)/14384);l0=(cos(la
-lb)/3796)-230;la-=18* (scan(la-18,10)>0);la+=18* (scan(la+18,10)>0);
if(scan(la-16,10))la-=8;else if(scan(la+16,10))la+=8;if(scan(la-12,10
))la-=4;else if(scan(la+12,10))la+=4;if(scan(la-11,10))la-=2;if(scan(
la+11,10))la+=2;if(ll=scan(le=la,3)){if(scan(la-13,10))la-=5;else if(
scan(la+13,10))la+=5;if(scan(la+12,10))la+=4;else if(scan(la-12,10))la
-=4;if(scan(la-11,10))la-=2;if(scan(la+11,10))la+=2;cannon(la+(la-le) *
((880+(lc=scan(la,10)))/482)-ls,lc*230/(ll-lc-l0));}else lq();}else lq
();}lq(){if(scan(la-=350,10))return ld();if(scan(la-=20,10))return ld
();if(scan(la-=320,10))return ld();if(scan(la-=60,10))return ld();if(
scan(la-=280,10))return ld();if(scan(la-=100,10))return ld();if(scan(
la-=240,10))return ld();if(scan(la-=140,10))return ld();if(scan(la-=
200,10))return ld();if(scan(la-=180,10))return ld();if(scan(la-=160,
10))return ld();if(scan(la-=220,10))return ld();if(scan(la-=120,10))return
ld();if(scan(la-=260,10))return ld();if(scan(la-=80,10))return ld();
if(scan(la-=300,10))return ld();if(scan(la-=40,10))return ld();if(
scan(la-=340,10))return ld();}ld(){if(lc=scan(le=la,10)){if(lc>500)return
cannon(la,lc);if(scan(la-10,10))la-=5;else la+=5;if(scan(la-10,10))la
-=3;else la+=3;cannon((la<<1)-le,(scan(la,10)<<1)-lc);}else lq();}ln(
lb,l5){drive(lb,l5);if(lc=scan(le=la,10)){if(scan(la-8,5)){if(scan(la
-=5,2));else la-=4;}else{if(scan(la+8,5)){if(scan(la+=5,2));else la+=
4;}else{if(scan(la,1));else if(scan(la-=3,2));else la+=6;}}return(
cannon((la<<1)-le,(scan(la,10)<<1)-lc));}else{if(lc=scan(la+=20,10))cannon
(la,lc);else if(lc=scan(la-=40,10))cannon(la,lc);else la+=80;}}l8(lb){
drive(lb,0);while(speed()>59);drive(lb,100);}lw(){if(scan((le=la)-7,3
))la-=7;if(scan(la+7,3))la+=7;if(scan(la-4,2))la-=4;if(scan(la+4,2))la
+=4;if(scan(la-2,1))la-=2;if(scan(la+2,1))la+=2;return(scan(la,10));}
int l4(lx)int lx;{drive(lb,100);if(lx);else if(scan(la,10)){if((ll=lw
())<850){if(lc=lw())return cannon((le+(la-le) *3-(sin(la-lb)/19500)),
(lc*220/(220+ll-lc-(cos(la-lb)/4167))));}}if((lc=scan(la,10))&&(lc<
850));else if((lc=scan(la+=339,10)));else if((lc=scan(la+=42,10)));
else if((lc=scan(lb,10)))la=lb;else return(la+=40);cannon(la,(scan(la
,10)<<1)-lc);}l1(lh,lj)int lh,lj;{return(lb=(360+((lh-=loc_x())<0) *
180+atan(((lj-loc_y()) *100000)/lh)));}ly(lo,lm)int lo,lm;{return(((
lo-=loc_x()) *lo+(lm-=loc_y()) *lm));}lz(){l1(lh=20+960*li,lj=20+960*
lf);while((lt=ly(lh,lj))>8100)l4(lt<25600);drive(lb,0);}main(){int lu
,lk,lr,l3;lf=loc_y(li=loc_x(lu=123450)>500)>500;lk=(60* (li^lf))-30;
lz();while(1){while(--lv>-1){lb=lp* (540*li-lk)+(!lp) * (90+180*lf+lk
);while(ly(lh,lj)<(lu-4925* (damage()>lr)))l2(lb);drive(lb,0);lr=
damage(lz(lp^=1))+4;}lg=90* ((lf<<1)+(li^lf));if((lv=l6())<2){while(1
){if(((li=loc_x())%880)<120)lb=180* (li>500);else if(((lf=loc_y())%
880)<120)lb=90+180* (lf>500);else if(lc>600)lb=la+25;else if(lc<150)lb
=la+195;else lb=la+180* (l3^=1);ln(lb,100);ln(lb,100);ln(lb,100);}}}}
