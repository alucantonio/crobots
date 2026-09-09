
/*                      Z        O        R        N





Programmato da:  Alessandro Carlin


Premessa:

Gli anni scorsi nel momento in cui si poneva il problema di iniziare il
nuovo robot ho sempre avuto la tendenza ad ispirarmi (copiare!!!) dalle idee
dal vincitore dell'anno prima... vedi The Invisible Man simile a Diabolik,
Cyborg ispirato a Goblin, lo stesso Rudolf_2 simile tatticamente al
predecessore ed a !.r.
Quest'anno mi sono trovato in una situazione nuova visto che Rudolf versione 6
lo avevo gia' ottimizzato io stesso ed avevo pressoche' saturato idee e Vb.
Tuttavia l'anno scorso ero rimasto molto impressionato da Fizban di Simone
Ascheri per la sua peculiarita' di avere un rendimento piu' o meno costante
in ogni torneo.
Mi sono allora chiesto da dove venisse questa peculiarita'... dopo aver
osservato il comportamento (grazie al mitico benefattore per il debugger)
in molteplici match, ho dedotto che Fizban non aveva particolari attitudini
offensive, ma un movimento (quadrato)che gli permetteva di essere molto piu'
sfuggente dei normali robot oscillanti.
L'unica pecca in tutto questo era la scarsa attitudine offensiva, che si
traduceva in un (a mio parere) poco convincente aumento delle dimensioni
del quadrato.
Da qui l'idea di trapiantare il movimento furbissimo di Fizban in un
"cervello" Rudolf_6-like, il quale attaccava l'uno o l'altro angolo adiacente
con certe regole e priorita' dipendenti da un discreto numero di parametri.
Ne e' uscito un moto a "rettangolo" che mi ha sorpreso da subito per
l'efficacia gia' dimostrata nei test preliminari del mio robot under1000
Enigma.


Strategia:

Come quasi tutti i crobot piu' recenti e furbi Zorn comincia l'incontro
raggiungendo l'angolo piu'vicino (spostandosi prima verticalmente e poi
orizzontalmente).
Qui verifica se sia il caso di attaccare subito l'eventuale unico avversario
altrimenti inizia un movimento del tutto fizban-like a quadrato.
Dopo un breve periodo passato in questa situazione inizia ad attaccare i robot
che occupano gli angoli adiacenti con un moto a rettangolo, con un lato
pari alla minima distanza che e' in grado di percorrere (circa 60 metri) e
l'altro tale da portarlo alla distanza ottimale dal nemico.
Questa distanza aumenta nel finale se Zorn non ha troppi danni, in modo
da evitare pareggi inutili.
Quando vede un solo avversario lo attacca con una routine differente dal
fratellone Rudolf_7.
Infatti la routine di attacco (oltre ad un paio di parametri) e' la differenza
principale tra  Zorn da Rudolf. Quest'ultimo presenta una versione upgradata
della tattica adottata dal predecessore Rudolf_6, mentre Zorn implementa in
realta' 2 diversi movimenti.
Questa scelta deriva dall'osservazione che il movimento a zig-zag di Rudolf
e' molto redditizio con moltissimi avversari, ma non con tutti; in particolare
contro i robots 2k1 soffre molto alcuni soggetti, ad esempio quegli
incredibili rompiscatole di Hammer e Thunder (ciao Mich) oltre a Vampire.
Un movimento lineare e regolare riesce invece a sopperire a questo difetto,
con la spiacevole faccia opposta della medaglia che si ha un tracollo
contro moltissimi altri robots.
La furbata sta allora nel fatto che Zorn, una volta raggiunto il centro
dell'arena fa una prima volata coast to coast Nord-Sud (o Sud-Nord) senza
indugiare in curve e decelerazioni... se alla fine vede che i colpi avversari
lo hanno alquanto menomato ripiega su un moto Rudolf-like, altrimenti continua
con lo stesso andazzo (simile ad es. a cyborg.r), pur rimanendo sempre pronto
a cambiare il suo movimento allorche' notasse un rapido incremento nei suoi
danni.
Va detto che contro robots "toxici" Zorn e' molto meno efficiente di Rudolf,
ma diciamo che conto sul fatto che quest'anno le toxiche abbiano pochi
ammiratori :-) 


Note tecniche:

1) Il movimento a quadrato non e' per niente nuovo, anche se non credo che
nessuno finora lo avesse trasformato in un moto a rettangolo, come detto
prima il pregio e' la straordinaria capacita' di non prenderle messa in evidenza
da Simone con Fizban.r

2) Lo sparo e' stato rifatto da zero, e credo in effetti che la routine, pur
essendo molto semplice, non sia mai stata usata prima anche se il punto
di partenza e' stato anche qui Fizban

3) Le temporizzazioni hanno un ruolo fondamentale, non chiedetevi perche' ci
siano istruzioni inutili e sovrabbondanti disseminate qua e la' per il
listato, il loro ruolo e' solo ritardare l'esecuzione di altre istruzioni

4) La routine di attacco rudolf_6-like e' stata migliorata essenzialmente
perche' e' stata rifatta la routine di sparo, simile a quella usata nel
corso del match e nella seconda routine di attacco di Zorn.

5) non ci sono le toxiche, ma questa non e' una grande novita'


Commenti:

Zorn e' un robot abbastanza "estremo", nel senso che si basa su un
delicatissimo equilibrio di parametri e accorgimenti.
Variare di 1% alcuni parametri si riflette in un crollo anche di 3-4% nell'
efficienza, ed eliminare alcune peculiarita' apparentemente secondarie del
suo comportamento lo penalizzano anche di 15% in alcuni tornei.
Tuttavia cosi' com'e' ha veramente un'efficienza notevole e una dipendenza
minima dagli aversari che trova, tanto da avere praticamente la stessa
efficienza contro i mini e contro i bigs dell'anno scorso.


Ringraziamenti:

Un ringraziamento a tutti gli autori di robot che mi hanno ispirato, in
particolare Fizban ma anche Disco di Mich Messina e Dna di Daniele Nuzzo.
Un enorme grazie al misterioso benefattore che ci ha deliziato con il suo
meraviglioso debugger e a Mich e Simone per le utilities che continuano a
migliorare ed aggiornare, grazie alle quali lo sviluppo e il testaggio dei
robot e' davvero user-friendly.                                             */





int asb,asa,ss,dimitri,dp,d,or,ul,ll,b,tempo,oscar,xora,flag,flag1,daa,rng,t,oldr,deg,odeg,dist;

main(){
if ((asb=(loc_y()>500))) up(920); else dn(80);
if ((asa=(loc_x(t=11)>500))) dx(920); else sx(80);
b=asb*2+(asb!=asa);
ll=90*b-35;
ul=ll+142;
               flag=ll;
               flag1=2;
               while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1));
or=1;
while(t<10000){
daa=damage(++t);

     if (loc_x()>500){
     while(speed()>49);
     drive(d=180,100);
       if (ss){if (or) {if (!(dist=scan(170,10))) if (!(dist=scan(190,10))) dist=850;}
       else {if (!(dist=scan(80+180*asa,10))) if (!(dist=scan(100+180*asa,10))) dist=850;}}
     xora=loc_x()-45-or*ss*(dist-850+oscar);
     
     sx(xora);
     dimitri=45+!or*ss*(dist-850+oscar);
     if(b==1) {up(loc_y()+dimitri);}
     else {dn(loc_y()-dimitri);}
     d=90+180*(loc_y()>500);
     dp=d;dp=d;dp=d;
     dx(920);
     if(b==1) {d=90;d=90;d=90;d=90;dn(80);}
     else {d=270;d=270;d=270;d=270;up(920);}
     }
     else {
     while(speed()>49);
     drive(d=360,100);
       if (ss){if (or) {if (!(dist=scan(350,10))) if (!(dist=scan(10,10))) dist=850;}
       else {if (!(dist=scan(80+180*asa,10))) if (!(dist=scan(100+180*asa,10))) dist=850;}}

     xora=loc_x()+45+or*ss*(dist-850+oscar);
         
     dx(xora);
      dimitri=45+!or*ss*(dist-850+oscar);
     if(b==0) {up(loc_y()+dimitri);}
     else {dn(loc_y()-dimitri);}
     d=90+60*b;
     dp=d;dp=d;dp=d;
     sx(80);
     if(b==0) {d=90;d=90;d=90;d=90;dn(80);}
     else {d=270;d=270;d=270;d=270;up(920);}
     }
     if (ss) if((damage())>daa+5) or=!or;
     if (tempo>22) or=!or;
         if ((t>3&&!(oldr<800)||t>6))
              {
               oscar=((++tempo-15)*5);
               if (oscar>60) oscar=60;
               if (tempo>5) ss=1;
               if (damage()>85) {ss=0;}
               flag=ll;
               flag1=2;
               while (flag<ul&&flag1) flag1-=(scan(flag+=20,10)>0);
               t=10002*((flag1));
              }
}
fine();
}

up(limt) {while(loc_y()<limt) {drive(90,100);Fire();}drive(90,0);}
dn(limt) {while(loc_y()>limt) {drive(270,100);Fire();}drive(270,0);}
dx(limt) {while(loc_x()<limt) {drive(360,100);Fire();}drive(0,0);}
sx(limt) {while(loc_x()>limt) {drive(180,100);Fire();}drive(180,0);}

Fire() {
 if((oldr=scan(deg,10))&&(oldr<835))
        {
           if (oldr=scan(deg,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else if (oldr=scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else if (oldr=scan(deg+=14,4)){if (!(scan(deg+=2,2))) deg-=4;}
           else return;
           cannon (deg,oldr);
        }
     else
       if(scan(deg+=20,10));
       else
         if(scan(deg-=40,10));
         else
           if(scan(d,10)) deg=d;
           else
             return (deg+=80);
}


Fuoco()
{
    if (oldr=scan(odeg=deg,10)) {
           
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg+=14,4)){if (!(scan(deg-=2,2))) deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
    } 
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=300,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=80,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=260,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=120,10)) return cannon(deg,oldr);
        deg+=80;
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


fine()
{
if (b==0) dso();
else if (b==1) ddo();
else if (b==2) udo();
else uso();
daa=damage();
if(b>1){
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
}
else{
while(loc_y()<850) {drive(90,100);Fuocoe();
                     }
}
daa-=5;
while (damage()<(daa+16)) {
daa=damage();
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
while(loc_y()<850) {drive(90,100);Fuocoe();
                    }                      
}
while(1)
{
while(loc_y()>150) {while(loc_x()>500) {drive(190,100);Fuoco();}
                    while(loc_x()<500) {drive(350,100);Fuoco();}
                    }
while(loc_y()<850) {
                    while(loc_x()>500) {drive(170,100);Fuoco();}
                    while(loc_x()<500) {drive(10,100);Fuoco();}
                    }
}
  
}

Fuocoe()
{
    if (oldr=scan(odeg=deg,10)) {
           
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg+=14,4)){if (!(scan(deg-=2,2))) deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-oldr));}
    }                
    else {
        if (oldr=scan(deg+=340,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=40,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=300,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=80,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=260,10)) return cannon(deg,oldr);
        if (oldr=scan(deg+=120,10)) return cannon(deg,oldr);
        deg+=80;
    }
}
