/*
Nome            : ZifNab
Versione        : 5.3
Autore		: Simone Ascheri


Preludio
========

ZifNab altro non Š se non l'anagramma di FizBan!
Ma va!
Viene usato da Paladine per presentarsi in un altro ciclo, appartenente ad
un'altra saga di un altro universo con una diversa gerarchia celeste.
Come dire... in un posto dove non c'entrava proprio un fico secco.

Commento
========

Il robot Š una fusione tra Fizban, quello che restava di Daryl sottoposto a pesante
lifting, le toxiche di Raistlin e poco altro.
Il primo (e forse unico) motivo che avevo per mandarlo si e' dissolto come
neve al sole:
nella riscrittura dela wall di Daryl avevo ideato un'oscillazione basata su una
sola While, che alternativamente verificava la condizione di maggiore o di minore.
Purtroppo nelle ultime versioni e' stata eliminata.

Strategia
=========

La strategia e' esattamente quella di Fizban, con un'unica differenza:
Il robot si reca subito nell'angolo piu' vicino.
Conta gli avversari e decide se difendersi o attaccare: dato il maggior numero
istruzioni consentite, questo robot si attacca alle pareti piu' del suo compare.

        - Se scopre che il confronto Š a singolar tenzone passa il controllo
        all'Attacco FiduciosoXP. Come fa trapelare il nome, Š una banale
        estensione dell'attacco Fiducioso di BurrFoot.
        - Se gli avversari sono 2, o sono passati un certo numero di cicli
        di cpu e i danni sono superiori al 40% (ma comunque inferiori all'80%)
        inizia a comportarsi come Daryl: se pero', in una sola passata d'attacco
        subisce piu' del 15% di danni torna a fare il FizBan per un turno. Se invece
        i danni sono maggiori dell'80% torna alla main().
        - In caso trovi altri 3 avversari innesca la routine difensiva: per
        la verit… si tratta pi— che altro di una difesa attiva. Infatti ZifNab amunenta
        progressivamente il proprio perimetro di azione, cercando di raggiungere gli
        avversari piu' distanti.
        Ogni 10 quadrati completi conta il numero di avversari rimasti, e se ne
        trova solo uno parte con il FiduciosoXP.
        - Se subisce pi— dell'80% di danni si rintana nel proprio angolino,
        lasciando da parte le velleit… offensive, e descrive il quadrato pi—
        piccolo di cui Š capace.

Note Tecniche
=============

Il robot ha parecchie pecche ed Š scritto in maniera non troppo curata.
I due pezzi sono attaccati con il fil di ferro e la colla: credo se ne
possano accorgere tutti. Addirittura vi sono 2 routine per il conto degli
avversari, quella di Fizban e quella di Daryl. In una delle ultime versioni
ho persino trovato una funzione ripetuta tre volte, con lo stesso nome e le
stesse variabili.
I commenti interni al codice, dato il poco tempo, non ci sono: dovrete
accontentarvi di queste stringatissime note.
Se per caso doveste leggerlo non perdete le notti a domandarvi perchŠ la
coordinata x in realt… sia la y e viceversa: Š stato un errore che, per
scaramanzia, non ho mai corretto.
Il robot non cambia mai angolo: non per una scelta 'tattica' nŠ per la
mancanza di spazio. Mancavano le idee. Una fuga lineare dall'angolo Š un puro
suicidio. L'ideale era una ritirata a zig-zag come quella di Vegeth. Purtroppo,
con un ardito guizzo logico che forse avrebbe avuto ache il mio cane, ho
immaginato che nel prossimo torneo quella routine non avrebbe avuto vita facile.
Quindi, in mancanza di valide alternative, ho lasciato perdere.
La routine di fuoco principale Š una 'sintesi' del KaiOKen di SonGohan.
Il secondo sparo Š anche la seconda (e pi— importante) differenza con BurrFoot:
durante l'attacco finale niente pi— Toxiche. Sono state messe da parte a
favore di una routine che effettua una grezzissima correzione su angolo e
distanza.

Attacco FiduciosoXP:
====================

Si tratta della stessa idea su cui Š basato l'altro attacco, con un paio di
differenze nell'implementazione:
1- se il robot non Š in zona sicura (ovvero, se Š troppo attaccato al bordo)
se ne allontana muovendosi parallelamente alla bisettrice del quadrante.
2- ogni vota che viene ricalcolato un angolo il robot decelera e poi accelera
nella nuova direzione. Dopo di che continua il ciclo principale.
3- lo sparo Š una riesumazione del fuoco veloce di Goku e Ka_aroth, leggermente
modificato nel puntamento e nel calcolo della gittata.

La base vera e propria dell'attacco Š la focalizzazione quasi costante
sull'avversario.
ZifNab cerca di arrivargli al minimo a 680 unit…, per poi e iniziare ad
oscillare.
L'oscillazione e' realizzata in maniera molto semplice: se la velocit… supera
le 80 unit… si inverte l'angolo, altrimenti si spara.

Tra le novit… (o per lo meno presunte tali) introdotte segnalo:
===============================================================

        - Nessuna

Varie:
======

        - Nessuna

-----------------------------------------------------------------------------
(*)Tutti i nomi di luoghi e personaggi qui riportati, nonchŠ ogni riferimento
al ciclo di DragonLance(TM) appartengono ai loro proprietari.
-----------------------------------------------------------------------------
*/
int vettore;
int dx,dy,x,y;
int anti,how,count,dam;

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or,oa;
int time,run,gradi,conta;
int si,z;

main()
{
        r_coord=822;
        while (run+=conta=gradi=10)
             {
                if (damage()>80)
                  {
                    r_coord=837;
                    time=10;
                  }

                x_pos=(loc_y(y_pos=(loc_x()<(vel=500))*(r_coord-=15*(++time>6)))<500)*r_coord;

                while ((loc_x()%890)>110)
                     CucchiaioKender(ang=(loc_x()<500)*180);
                vel=0;
                CucchiaioKender(ang);

                while ((loc_y(vel=100)%890)>110)
                     CucchiaioKender(ang=90+(loc_y()<500)*180);
                vel=0;
                CucchiaioKender(ang);

                while (((gradi+=21)<390))
                     if (scan(gradi,10)>0)
                       {
                         ++conta;
                         CucchiaioKender(a=gradi);
                       }

                if (conta<12)
                  attack();

                if (damage()<80)
                  if ((conta<13)||((time>15)&&(damage()>40)))
                     offende();
                vel=100;
                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270);
                        while(loc_x() <910-y_pos) CucchiaioKender(0);
                     }

             }
}


offende() {
  int delta;

  dy=(loc_y(dx=(loc_x()>500)*960+20)>500)*960+20;

  Medita(ang=(vettore=45+180*(dy>500)+90*(dx!=dy)));

  how=65000; delta=45;

  while(Medita()) {
    if (or && (or<770)) {
      dam=damage();
      Miskal(vettore+90*anti-45);
      if (damage()>dam+8) {how=65000; delta=21-delta; anti^=1;}
    }
    else if ((r=scan(vettore+delta-21,10)+scan(vettore+delta,10))&&(r<770)) {
      Miskal(a=vettore+90*(anti^=1)-45);
      how=65000; delta=21-delta;
    }

    else {
      if (scan(vettore-delta,10)+scan(vettore-delta+21,10)) {
        if (r);
        else if (scan(vettore,10));
        else f2f();

        Etciu();
      }
      else if (r) {
        if (scan(vettore,10));
        else f2f();

        how=65000; delta=21-delta;
        Etciu(anti^=1);
      }
      else f2f();
    }

    if (damage()>80)
      main();
  }
}

Miskal(look) {
  count=2;

  while(count) {
    Medita();

    if (or && (or<770)) count=2;
    else if ((r=scan(look,10)) && (r<770)) {a=look; count=2;}
    else --count;
  }
}

Medita() {
  while (speed()<90) PallaDiPelo(drive(ang,100));
  Pensa(ang=180+((x=dx-loc_x())<0)*180+atan(((dy-loc_y())*100000)/x));

  CercaCappello(CercaCappello(CercaCappello(CercaCappello(CercaCappello(drive(ang,100))))));
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) CercaCappello();
  Pensa();

  return ang=vettore;
}

Etciu() {
  a=vettore+90*anti-45;

  CercaCappello(drive(ang+=60*anti-30,100));
  count=10; while(--count) CercaCappello();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y<how)
    if (or>800) PallaDiPelo(); else CercaCappello();
  Pensa(how+=1000);

  CercaCappello(drive(ang,100));
  count=10; while(--count) CercaCappello();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) CercaCappello();
  Pensa();

  return ang=vettore;
}

Pensa()
{
  CercaCappello(CercaCappello(CercaCappello(drive(ang+=180,0))));
}

CercaCappello() {
  if (or=scan(a,10)) {
         if (r=scan(a,1))   return cannon(a,r);
    else if (r=scan(a-5,4)) return cannon(a-=3,r);
    else if (r=scan(a+5,4)) return cannon(a+=3,r);
  }
  else if (r=scan(a-=20,10)) return cannon(a,r);
  else if (r=scan(a+=40,10)) return cannon(a,r);
  else return a+=40;
}

f2f() {
  int three;

  oang=vettore-53;
  count=(three=16); while(three && (count>11))
    if (scan(oang+15*((--three)%8),7)) --count;

  if (count>=14)
    attack();
}

attack() {
                while (vel=100)
                     {
                        if (((loc_x()%800)<200)||((loc_y()%800)<200))
                          {
                            si=45+180*(loc_y()>500)+90*((loc_x()>500)!=(loc_y()>500));
                            if (((z=(ang-si)%360)*z)>0)
                              {
                                C(vel=0);
                                ang=si;
                                C(C(vel=100));
                              }
                          }
                        else if (r>700)
                          {
                            if (((z=(ang-a)%360)*z)>25)
                              {
                                C(vel=0);
                                ang=a;
                                C(C(vel=100));
                              }
                          }
                        else if ((speed()>80))
                             {
                                C(vel=0);
                                ang+=180;
                                C(C(vel=100));
                             }
                        C();
                     }
}

PallaDiPelo()
{
  if (scan(a,10)>200)
    {
      if ((or=Rivela()))
        {
          if (r=Rivela())                
             return cannon((oang+(a-oang)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10)));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang,10))) a=ang;
        else
          return a+=40;
  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oang=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

CucchiaioKender(dir)
int dir;
  {
     drive (dir,vel);
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

C()
  {
     drive (ang,vel);
     if(or=scan(a,10))
        {
           if (r=scan(a,4)) return cannon(a,3*scan(a,10)-r-or);
           else if (r=scan(a-=7,3)) return cannon(a-6,3*scan(a,10)-r-or);
           else if (r=scan(a+=16,4)) return cannon(a+6,3*scan(a,10)-r-or);
           else return 1;
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
         return (a+=84);
  }  
