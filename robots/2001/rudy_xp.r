
/*                     R    U    D    Y         X    P



Programmato da:  Alessandro Carlin

Il nome e'dedicato al nostro sommo Tournament director J.

Strategia:

Come quasi tutti i crobot piu' recenti Rudy_xp comincia l'incontro
raggiungendo l'angolo piu'vicino (spostandosi prima verticalmente e poi
orizzontalmente). Qui il motore e' lo stesso di rudolf_6, con ovvie
semplificazioni:


-L'oscillazione e' parallela ad un lato e la scelta della direzione
 viene fatta secondo un criterio secondo me abbastanza furbo che e' poi il
 principio attorno a cui ho sviluppato il crobot. In pratica se non subisce
 danni oscilla una volta orizzontale e una verticale. Se invece dopo
 un'oscillazione vede che ha preso un x% di danno, successivamente oscilla
 per x volte nell'altra direzione. Sempre che prima di completare le x
 oscillazioni non subisca danni anche in quella direzione.
 In questo modo non perde tempo in pesanti scansioni per vedere angoli liberi,
 vuoti, occupati da robot fermi o meno ecc.
 La lunghezza dell'oscillazione e' 250 metri fuorche' nelle prime battute e
 nel caso in cui i danni tendano ad aumentare troppo (nel qual caso diventa
 100 metri).

-Controlla sempre il numero dei nemici e se ne vede solo uno lo attacca
 oscillando a dx e sx vagando per il campo senza alcun controllo
 sull'avversario. La routine di sparo e' triviale (praticamente Rudolf)
 e non capisco bene perche' questa tattica renda cosi' tanto. Forse perche'
 elude le toxiche. (ti dicevo Simone che saresti rimasto deluso).
 Purtroppo tale routine crolla contro i microbi e quindi mi aspetto che con i
 robot di quest'anno non renda granche'.
 La routine di sparo e' la stessa per tutto il match, con una piccola variabile
 interna che tiene conto della fase del match (nell'attacco vale 1).




Commenti:

E' una versione magra di Rudolf_6.
La cosa piu' bella secondo me e' la scelta della direzione da seguire che e'
l'idea attorno a cui si e' sviluppato il crobot.
L'obbiettivo da mirare lo sceglie in modo non casuale come vedete dal listato
(e' un po' lungo da dire, molto meglio leggere la riga di codice che a
differenza del fratellone e' nella routine di sparo).
E'interessante notare che non usa toxiche ne' simili anche perche' non avrei
saputo dove metterle, ma un'unica procedura molto antiquata.



Ringraziamenti:

Tutti gli amici di crobots vecchi e nuovi, in particolare Simone, Mich e J che
con utilities e pagine web tengono sempre vivo il torneo.
Gli autori dei crobots precedenti, fonte di ispirazione continua.
Il mio nuovo pentium 3 con cui ho finalmente potuto effettuare qualche test
sensato dopo 2 anni che boccheggiavo col 486, nonostante abbia preparato
4 robot in 30 giorni.....                                             */








int tempo,oscar,xa,ya,flag,flag1,nas,dri,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;

main(){
if (ya=(loc_y()>500)) up(920); else dn(80);
if (xa=(loc_x(t=4)>500)) dx(920); else sx(80);
while(t<10000){
daa=damage(++t);
if (dver>0){
     if (xa){
     sx(750+oscar);
     dx(920);         }
     else {
     dx(250-oscar);
     sx(80);         }
     dver-=((damage()-daa+1));
     }
else{
     if (ya){
     dn(750+oscar);
     up(920);         }
     else {
     up(250-oscar);
     dn(80);         }
     dver+=((damage()-daa+1));
     }
         if (t>2&&(!oldr||oldr>850))
              {
               flag=flag1=2;
               oscar=130*(damage()>75||++tempo<15);
               while (flag<362&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1>0));
              }
}
sx(550);
dx(450);
while(1)
{
while(loc_y()>100) {zz(190,350);
                    }                      
while(loc_y()<900) {zz(170,10);
                    }  
}
}

up(limt) { while(loc_y()<limt) {Fire(0,dir=90);}drive(90,0);}
dn(limt) {while(loc_y()>limt) {Fire(0,dir=270);}drive(270,0);}
dx(limt) {while(loc_x()<limt) {Fire(0,dir=360);}drive(0,0);}
sx(limt) {while(loc_x()>limt) {Fire(0,dir=180);}drive(180,0);}


Fire(qwe,po)
{
    drive(po,100);
    if (oldr=scan(odeg=deg,10)) {
        if (!scan(deg+=355,5)) deg+=10;
        if (!scan(deg+=357,3)) deg+=6;
        cannon(deg+(deg-odeg)*qwe,2*scan(deg,10)-oldr);        
        if (!qwe&&oldr>850) deg=dir;
    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        deg+=40;
    }
}

zz(aq,bq)
{
                    while(loc_x()>500) {Fire(1,aq);}
                    while(loc_x()<500) {Fire(1,bq);}
}
