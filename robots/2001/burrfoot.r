/*
Nome            : Tasslehoff BurrFoot
Versione        : 5.2
Autore		: Simone Ascheri


Preludio
========

Rimarginate le ferite inflitte dalle "Guerre dei Draghi" il mondo di Krynn
precipit• in un nuovo conflitto, che passo alla storia come 'La Guerra dei
Gemelli': Raistlin Majere, l'arcimago, per non pagare il debito di sangue
contratto al tempo della Prova nella torre dell'alta magia della foresta di
Whyst (una delle 5 torri presenti, sede del conclave dei maghi), decise di
tornare indietro nel tempo per sconfiggere il suo 'creditore', il piu'
potente mago mai esistito, il terribile Fistandantilus.
Riuscito nell'impresa si trovo' a quel punto a ripercorrere le sue orme:
aprire uno dei portali che danno sull'abisso, penetrarvi e sconfiggere gli Dei
per prendere il loro posto. Piu' forte del predecessore fu sul punto di riuscire
nell'impresa, ma fu fermato da suo fratello gemello, Caramon Majere, che gli
mostro' gli orrori di un futuro con l'arcimago come Dio.
Il mondo ando' avanti, finche' Padre Caos se ne accorse, si indispetti'
alquanto e cerco' di distruggerlo, ma fini' rinchiuso in una gemma grigia a
vagare per l'universo (anche se i bene informati dicono che si fece di
propria volonta' rinchiudere li' dentro da Reorx, Dio dei nani e protettore
dei fabbri, per seminare disordine in un mondo troppo ordinato), fino a quando
le forze del bene non riuscirono a relegarlo su una delle lune.
La Gemma Grigia, pero', si manifesto' in sonno ad uno gnomo (appartenente ad un
popolo noto per il talento 'inventivo'). Questi comincio' a desiderarla piu'
di ogni altra cosa al mondo, con la possibile eccezione di un coltellino
tagliaburro multifunzione a vapore (oggetto peraltro impossibile ad ottenersi
in quanto il progetto era ancora arenato in sede di comitato) e costrui' una
macchina volante per raggiungerla.
Finalmente, dopo diverse peregrinazioni, la Gemma Grigia trovo' cio' che aveva
a lungo cercato: un popolo, gli Irda, dotati della magia sufficiente ad aprirla,
e dell'arroganza necessaria a pensare di poter tenere sotto controllo il suo
contenuto.
Una volta libero Padre Caos comincio' a seminare la morte e la distruzione per
il Krynn: gli eroi, purtroppo, erano morti: Tanis Mezz'elfo era morto,
Flint Fireforge era morto, Strum BrightBlade era morto, Caramon Majere era vecchio,
Raistlin Majere, tornato al mondo per salvare il nipote Palin, era stato privato
dei suoi poteri.
Per sconfiggere il Padre del Tutto e del Nulla basta poco, ed Š contemporaneamente
un'impresa al di l… delle possibilit… umane: una goccia del suo sangue deve
bagnare la Gemma Grigia, per bandire il Caos dal mondo.
Dove hanno fallito gli ultimi cavalieri, armati delle leggendarie Dragonlance,
potr… forse riuscire un Kender senza paura, dotato solo del prezioso Cucchiaio
Kender dell'allontanamento (prezioso regalo dello zio TrapSpringer)?(*)

Commento
========

Al solito questo robot non Š per nulla originale:
il suo ispiratore Š Carletto, vincitore dello scorso torneo microrobotico.
Le somiglianze si fermano pero' al movimento iniziale, dal momento che
l'implementazione e la strategia sono assolutamente diverse.

Strategia
=========

La strategia e' banalissima.
All'inizio del match cerca l'angolo pi— vicino e lo raggiunge.
Conta gli avversari (per la verit…, nel 75% dei casi lo fa in una posizione
piuttosto 'esposta', non essendo attaccato ai bordi dell'arena, ma non potevo
fare altrimenti) e decide se difendersi o attaccare:

        - Se scopre che il confronto Š a singolar tenzone passa il controllo
        all'Attacco Fiducioso. Il nome Š ispirato dalla banalit… stessa della
        routine: infatti non controlla mai la propria posizione, ma confida che,
        puntando sempre il nemico, non si trovi mai in una posizione troppo
        spalmata sui bordi.
        - Altrimenti innesca la routine difensiva: per la verit… si tratta pi—
        che altro di una difesa attiva. Infatti BurrFoot amunenta progressivamente
        il proprio perimetro di azione, cercando di raggiungere gli avversari
        piu' distanti.
        Ogni 10 quadrati completi conta il numero di avversari rimasti, e se ne
        trova solo uno parte con il Fiducioso.
        - Se subisce pi— dell'80% di danni si rintana nel proprio angolino,
        lasciando da parte le velleit… offensive, e descrive il quadrato pi—
        piccolo di cui Š capace.

Note Tecniche
=============

Il robot Š la mia prima opera che non utilizza la tecnica del quadrato della
distanza.
Ha parecchie pecche, tra cui quella di contare gli avversari in una zona
altamente pericolosa.
Se per caso doveste leggerlo non perdete le notti a domandarvi perchŠ la
coordinata x in realt… sia la y e viceversa: Š stato un errore che, per
scaramanzia, non ho mai corretto.
Il robot non cambia mai angolo: non per una scelta 'tattica', ma perche' le
routine che ho provato o erano troppo lunghe (e lente) o soffrivano del baco
della sovraesposizione comune al conto degli avversari.
La routine di fuoco principale Š una 'sintesi' del KaiOKen di SonGohan.
Le Toxiche vengono utilizzate solo durante l'attacco fiducioso: questa volta
non per una questione di spazio (bastava infatti sostituire

 -CucchiaioKender(90,0);
 con
 -CucchiaioKender(90,x_pos<500);

per utilizzarle anche durante la difesa con la certezza di non spiaccicarsi
sui bordi), ma perche' il rendimento del crobot crollava.

Attacco Fiducioso:
==================

Se non ricordo male Š il primo attacco che progetto da 0.
L'idea e' banalissima, l'implementazione ancora di piu':
Si tratta semplicamente di puntare un avversario, arrivargli al minimo a 680
unit… e iniziare ad oscillare. L'oscillazione e' realizzata in maniera molto
semplice: se la velocit… supera le 80 unit… si inverte l'angolo, altrimenti si
spara.

Tra le novit… (o per lo meno presunte tali) introdotte segnalo:
===============================================================

        - la toxica, molto rivisitata che ingloba le funzioni di una routine di
puntamento precisa, quelle di un puntamento approssimato e quelle di routine
veloce per i rallentamenti;

        - sempre a proposito di routine di fuoco, nuovo Š il blocco di sei scan
che affinano il puntamento: non solo ora non ha pi— bisogno di una previa
riduzione dell'angolo da 10 a 5 gradi, ma restituisce in uscita la distanza
del nemico, permettendo un puntamento pi— preciso e una riduzione dell'ingombro
del codice;

Varie:
======

Il robot non Š ne' particolarmente originale nŠ molto ottimizzato.
Ha per• una caratteristica degna di nota: in tutti i tornei che combatte ottiene
all'incirca lo stesso risultato, indipendentemente dagli avversari che si trova
ad affrontare.

-----------------------------------------------------------------------------
(*)Tutti i nomi di luoghi e personaggi qui riportati, nonchŠ ogni riferimento
al ciclo di DragonLance(TM) appartengono ai loro proprietari.
-----------------------------------------------------------------------------
*/

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or;
int time,run,d,gradi,conta;
int cl;

main()
{
        r_coord=822;
        run-=8;
        while (run+=conta=gradi=10)
             {
                if (damage()>80) r_coord=837;
                x_pos=(loc_y(y_pos=(loc_x()<(vel=500))*(r_coord-=15*(++time>6)))<500)*r_coord;
                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90,0);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180,0);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270,0);
                        while(loc_x() <910-y_pos) CucchiaioKender(0,0);
                     }
                drive(0,0);
                while (((gradi+=21)<390)&&(conta<12))  if (scan(gradi,10)>0) {++conta;CucchiaioKender(a=ang=gradi,vel=0);}
                while (conta<12)

                     {  /*Fiducioso Attack!!!*/

                        if (scan(a,10)>650) ang=a;
                        else if ((speed()>80))
                             {
                                CucchiaioKender(ang+=180,vel=0);
                                while (speed()>49);
                             }

                        CucchiaioKender(ang,vel=100);
                     }

             }
}

CucchiaioKender(dir,prec)
int dir, prec;
  {
     drive (dir,vel);
     if (prec)
       if (scan(a,10)>180)
         {
           if (or=Sfera())
             {
               if (r=Sfera())                
                  return cannon((oang+(a-oang)*3-(sin(a-dir)/19500)),(r*200/(200+or-r-(cos(a-dir)/4167))));
             }
         }

     if((r=scan(a,10))&&(r<850))
        {
           if (r=scan(a,4));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return;
           cannon (a,r);
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
           if(scan(dir,10)) a=dir;
           else
             return (a+=84);
  }  

Sfera()
{
  if(scan((oang=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

