
/*                     Z     O     M     B     I     E



Programmato da:  Alessandro Carlin

Strategia:

E' nato come una mutazione di Rudolf_6, prima abbandonata e poi riesumata
(Zombie appunto) e sistemata.
La differenza dal fratellone e' che pareggia pochissimo, dato che non
rinuncia ad attaccare se sta morendo; in teoria e' una tattica suicida, ma
lui e' gia' un morto vivente....
Come quasi tutti i crobot piu' recenti Zombie comincia l'incontro
raggiungendo l'angolo piu'vicino (spostandosi prima verticalmente e poi
orizzontalmente).



-Qui Zombie esegue oscillazioni parallele ad un lato e la scelta della direzione
 viene fatta secondo un criterio secondo me abbastanza furbo che e' poi il
 principio attorno a cui ho sviluppato il crobot. In pratica se non subisce
 danni oscilla una volta orizzontale e una verticale. Se invece dopo
 un'oscillazione vede che ha preso un x% di danno, successivamente oscilla
 per x volte nell'altra direzione. Sempre che prima di completare le x
 oscillazioni non subisca danni anche in quella direzione.
 In questo modo non perde tempo in pesanti scansioni per vedere angoli liberi,
 vuoti, occupati da robot fermi o meno ecc.
 In compenso il tempo che guadagna lo usa per pensare quanto lungo oscillare.
 La scelta e' un po' complessa da spiegare, ma in poche parole se lo scontro
 e'all'inizio le oscillazioni sono piu' corte, poi piu' lunghe; inoltre sono
 influenzate dalla distanza dell'avversario (un po' come rudy del torneo di
 microbots 300); se infine il nemico e' vicino oscilla corto per alcune volte.

-Controlla sempre il numero dei nemici e se ne vede solo uno lo attacca
 oscillando a dx e sx vagando per il campo senza alcun controllo
 sull'avversario. La routine di sparo e' triviale (praticamente Rudolf)
 e non capisco bene perche' questa tattica renda cosi' tanto. Forse perche'
 elude le toxiche. (ti dicevo Simone che saresti rimasto deluso).
 Purtroppo tale routine crolla contro i microbi e quindi mi aspetto che con i
 robot di quest'anno non renda granche'.




Commenti:

Essenzialmente non c'e' tanto di nuovo.
La cosa piu' bella secondo me e' la scelta della direzione da seguire che e'
l'idea attorno a cui si e' sviluppato il crobot.
La lunghezza la sceglie come il primo rudy, quindi nulla di nuovo ma funziona,
e tra parentesi e' l'espediente che mi ha fatto guadagnare circa 7% in t2k.
L'obbiettivo da mirare lo sceglie in modo non casuale come vedete dal listato
(e' un po' lungo da dire, molto meglio leggere la riga di codice).
Conta i compagni di battaglia solo in base a certi criteri e non
periodicamente e scansionando solo una piccola area del campo.
E'interessante notare che non usa toxiche ne' simili, ma procedure
semplicissime (una deriva da Daryl con pochi accorgimenti, l'altra deriva
dalla notte dei tempi).
Occupa poco codice (75%) e quindi penso sia migliorabile (peccato aver avuto
poco tempo)



Ringraziamenti:

Tutti gli amici di crobots vecchi e nuovi, in particolare Simone, Mich e J che
con utilities e pagine web tengono sempre vivo il torneo.
Gli autori dei crobots precedenti, fonte di ispirazione continua.
Il mio nuovo pentium 3 con cui ho finalmente potuto effettuare qualche test
sensato dopo 2 anni che boccheggiavo col 486, nonostante abbia preparato
4 robot in 30 giorni.....                                             */







int ll,ul,b,tempo,oscar,aq,xora,aa,count,dax,flag,flag1,nas,dri,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;

main(){
if (loc_y()>500) up(920); else dn(80);
if (loc_x()>500) dx(920); else sx(80);
b=(loc_y()>500)*2+(loc_x()>500);
if (b==2) b=3;
else if (b==3) b=2;
ll=b*90-35;
ul=90*(b+1)-5;
t=11;
aa=1;
while(t<10000){
daa=damage(++t);
if (dor<dver){
     if (loc_x()>500){
     while(speed()>49);
     drive(180,100);
     if (!oldr||oldr>700) {if(!aa) {deg=180;aa=1;}} else adef();
     if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) dist=900-oscar;
     if ((aq=dist-800+oscar)>0) xora=loc_x()-aq;
     else xora=890;
     sx(xora);
     dx(925);
     }
     else {
     while(speed()>49);
     drive(0,100);
     if (!oldr||oldr>700) {if(!aa) {deg=0;aa=1;}} else bdef();
     if (!(dist=scan(10,10))) if (!(dist=scan(350,10))) dist=900-oscar;
     if ((aq=dist-800+oscar)>0) xora=aq+loc_x();
     else xora=110;
     dx(xora);
     sx(75);
     }
     dor+=((damage(dver-=1)-daa));
     }
else{
     if (loc_y()>500){
     while(speed()>49);
     drive(270,100);
     if (!oldr||oldr>700) {if(aa) {deg=270;aa=0;}} else cdef();
     if (!(dist=scan(260,10))) if (!(dist=scan(280,10))) dist=900-oscar;
     if ((aq=dist-800+oscar)>0) xora=loc_y()-aq;
     else xora=890;
     dn(xora);
     up(925);
     }
     else {
     while(speed()>49);
     drive(90,100);
     if (!oldr||oldr>700) {if(aa) {deg=90;aa=0;}} else ddef();
     if (!(dist=scan(80,10))) if (!(dist=scan(100,10))) dist=900-oscar;
     if ((aq=dist-800+oscar)>0) xora=loc_y()+aq;
     else xora=110;
     up(xora);
     dn(75);
     }
     dver+=((damage(dor-=1)-daa));
     }
         if ((t>2&&!(oldr<850)||t>10))
              {
               if (++tempo>20) oscar=100;
               flag=ll;
               flag1=2;
               while (flag<=ul) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1>0));
              }
}
if (b==0) dso();
else if (b==1) ddo();
else if (b==2) udo();
else uso();
while(1)
{
while(loc_y()>100) {while(loc_x()>500) {drive(190,100);Fuoco();}
                    while(loc_x()<500) {drive(350,100);Fuoco();}
                    }
while(loc_y()<900) {
                    while(loc_x()>500) {drive(170,100);Fuoco();}
                    while(loc_x()<500) {drive(10,100);Fuoco();}
                    }
}
}

up(limt) { while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}


Fire() {
  if (oldr=scan(deg,10)) pesta();
  else if (oldr=scan(deg-=20,10)) pesta();
  else if (oldr=scan(deg+=40,10)) pesta();
  else return deg+=40;
}

pesta()
{
         if (rng=scan(deg,1))   return cannon(deg,rng+(rng-oldr)/3);
    else if (rng=scan(deg-5,4)) return cannon(deg-=3,rng+(rng-oldr)/3);
    else if (rng=scan(deg+5,4)) return cannon(deg+=3,rng+(rng-oldr)/3);
}

Fuoco()
{
    if (oldr=scan(odeg=deg,10)) {
        if (!scan(deg+=355,5)) deg+=10;
        if (!scan(deg+=357,3)) deg+=6;
        cannon(deg+(deg-odeg),2*scan(deg,10)-oldr);        
    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=300,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=80,10)) return cannon(deg,oldr);
        deg+=60;
    }
}


udo(){
while(loc_x()>500) {while(loc_y()>885) {drive(240,100);Fuoco();}
                    while(loc_y()<885) {drive(120,100);Fuoco();}
                    }
}

uso(){
while(loc_x()<500) {while(loc_y()>885) {drive(300,100);Fuoco();}
                    while(loc_y()<885) {drive(60,100);Fuoco();}
                    }
}

ddo(){
while(loc_x()>500) {while(loc_y()>115) {drive(240,100);Fuoco();}
                    while(loc_y()<115) {drive(120,100);Fuoco();}
                    }
}

dso(){
while(loc_x()<500) {while(loc_y()>115) {drive(300,100);Fuoco();}
                    while(loc_y()<115) {drive(60,100);Fuoco();}
                    }
}

adef()
{
count=5; while(--count) {sx(920);dx(920);}
}

bdef()
{
count=5; while(--count) {dx(80);sx(80);}
}

cdef()
{
count=5; while(--count) {dn(920);up(920);}
}

ddef()
{
count=5; while(--count) {up(80);dn(80);}
}

