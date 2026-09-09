/*
   Pantagruel by Emanuele Marsigliani

   Sono anni che seguo CROBOTS e finalmente mi sono deciso a
   partecipare al torneo.
   Pantagruel è Daryl al quale ho aggiunto un F2F più moderno: Daryl
   è un robot che considero speciale, innovativo e per questo l'ho
   sempre ammirato. E' stato un onore modificarlo.
   Siccome però che il regolamento non lo vieta esplicitamente -
   secondo me dovrebbe - e io sono dispettoso... l'ho offuscato :-)
*/
int ld,lg,la,lo,lb,lc;int ll,lk,l3,lt,le,lj;int ln,lp,lm,l0,lh,l2,lw;
main(){int li;lw=loc_y(l2=loc_x()>499)>499;ll=980-960* (l3=((le=loc_x
(lk=980-960* (lt=((lj=loc_y(lh=90* ((lw<<1)+(l2^lw))))<500))))<500));
if(le-=ll)la=540+180* (le>0)+atan(((lj-lk) *100000)/le);else la=630-
180*lt;drive(ld=la+180,100);while((le=ll-loc_x()) *le+(lj=lk-loc_y()) *
lj>5200)lf();lq();lu(ld=(lg=225-180*lt+90* (l3^lt)));lp=65000;li=45;
while(1){lu();if(lc&&(lc<770)){l0=damage();ly(lg+90*ln-45);if(damage(
)>l0+8){lp=65000;li=21-li;ln^=1;}}else if((lb=scan(lg+li-21,10)+scan(
lg+li,10))&&(lb<770)){ly(la=lg+90* (ln^=1)-45);lp=65000;li=21-li;}
else{if(scan(lg-li,10)+scan(lg-li+21,10)){if(lb);else if(scan(lg,10));
else lv(lh);l1();}else if(lb){if(scan(lg,10));else lv(lh);lp=65000;li
=21-li;l1(ln^=1);}else lv(lh);}}}ly(lz){lm=2;while(lm){lu();if(lc&&(
lc<770))lm=2;else if((lb=scan(lz,10))&&(lb<770)){la=lz;lm=2;}else--lm
;}}lu(){ls(drive(ld,100));lq(ld=180+((le=ll-loc_x())<0) *180+atan(((
lk-loc_y()) *100000)/le));lf(lf(lf(lf(lf(drive(ld,100))))));while((le
=ll-loc_x()) *le+(lj=lk-loc_y()) *lj>5200)lf();lq();return ld=lg;}l1(
){la=lg+90*ln-45;lf(drive(ld+=60*ln-30,100));lm=10;while(--lm)lf();
while((le=ll-loc_x()) *le+(lj=lk-loc_y()) *lj<lp)if(lc>800)lr(ld,100);
else lf();lq(lp+=1000);lf(drive(ld,100));lm=10;while(--lm)lf();while(
(le=ll-loc_x()) *le+(lj=lk-loc_y()) *lj>5200)lf();lq();return ld=lg;}
lq(){drive(ld+=180,0);while(speed()>50)if(lc=scan(la,10)){lo=la;if(
scan(la+=5,5));else la-=10;if(scan(la+=3,3));else la-=6;if(lb=scan(la
,10))cannon(la+(la-lo),lb+(lb-lc) *2);}else if(lc=scan(la-=20,10))cannon
(la,lc);else if(lc=scan(la+=40,10))cannon(la,lc);else la+=40;}lf(){if
(lc=scan(la,10)){if(lb=scan(la,1))return cannon(la,lb);else if(lb=
scan(la-5,4))return cannon(la-=3,lb);else if(lb=scan(la+5,4))return
cannon(la+=3,lb);}else if(lb=scan(la-=20,10))return cannon(la,lb);
else if(lb=scan(la+=40,10))return cannon(la,lb);else return la+=40;}
ls(lx){if(lc=scan(la,10));else if(lc=scan(la-=20,10));else if(lc=scan
(la+=40,10));else{la+=40;return ls(lx);}if(lc<200){cannon(la,lc);
return ls(lx);}if(scan(la-=5,5));else la+=10;if(scan(la+8,5))la+=5;if
(scan(la-8,5))la-=5;if(scan(la+7,5))la+=3;if(scan(la-7,5))la-=3;if(
scan(la+5,5))la+=1;if(scan(la-5,5))la-=1;if(lc=scan(lo=la,5)){if(scan
(la+8,5))la+=5;if(scan(la-8,5))la-=5;if(scan(la+7,5))la+=3;if(scan(la
-7,5))la-=3;if(scan(la+5,5))la+=1;if(scan(la-5,5))la-=1;if(lb=scan(la
,10))return cannon(la+(la-lo) * ((1200+lb)>>9)-(sin(la-ld)>>14),lb*
192/(192+lc-lb-(cos(la-ld)>>12)));}else if(lx)return ls();}lv(lh){if(
((scan(lh,10)!=0)+(scan(lh+20,10)!=0)+(scan(lh+40,10)!=0)+(scan(lh+60
,10)!=0)+(scan(lh+80,10)!=0)+(scan(lh+100,10)!=0))<2){while(1){if(((
ll=loc_x())%880)<120)ld=180* (ll>500);else if(((lk=loc_y())%880)<120)ld
=90+180* (lk>500);else if(lb>600)ld=la+25;else if(lb<150)ld=la+195;
else ld=la+180* (ln^=1);lr(ld,100);lr(ld,100);lr(ld,100);}}}lr(ld,l4){
drive(ld,l4);if(lc=scan(la,10));else if(lc=scan(la+=20,10));else if(
lc=scan(la-=40,10));else return la+=80;if(lc<200)return cannon(la,lc);
if(scan(la-=5,5));else la+=10;if(scan(la+13,10))la+=5;if(scan(la-13,
10))la-=5;if(scan(la+12,10))la+=3;if(scan(la-12,10))la-=3;if(scan(la+
10,10))la+=1;if(scan(la-10,10))la-=1;if(lc=scan(lo=la,5)){if(scan(la+
13,10))la+=5;if(scan(la-13,10))la-=5;if(scan(la+12,10))la+=3;if(scan(
la-12,10))la-=3;if(scan(la+10,10))la+=1;if(scan(la-10,10))la-=1;if(lb
=scan(la,10))return cannon(la+(la-lo) * ((1200+lb)>>9)-(sin(la-ld)>>
14),lb*192/(192+lc-lb-(cos(la-ld)>>12)));}}
