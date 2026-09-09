/*
Nome            : Fizban
Versione        : 7.1
Autore		: Simone Ascheri


Preludio
========

Le cronache del Krynn narrano che gli dei, bont… loro, amano passeggiare
e mescolarsi tra gli esseri che popolano la terra, per sentire le loro preghiere,
compiacersi delle loro invocazioni, punire le loro intemperanze.
Pare che Paldine fosse, tra le divinit…, quello che pi— si gratificava di
tali visite a sorpresa.
Se sia vero questo nessuno sa dirlo. Fatto sta che spesso insieme alla compagnia
degli eroi delle lance fu visto marciare un maghetto svampito, grande amico
del Kender TassleHoff BurrFoot (e gi… questo, da quelle parti, Š sintomo
quantomeno di uno squilibrio psichico). Quando non era alla disperata
ricerca del proprio cappello (che peraltro era saldamente ancorato alla sua zucca),
FizBan, questo il suo nome, passava il tempo allenandosi a lanciare
l'incantesimo pi— potente a lui noto: la Palla Di Pelo.

Commento
========

Ennesimo robot non innovativo:
il suo ispiratore Š Carletto, vincitore dello scorso torneo microrobotico.
Le somiglianze si fermano pero' al movimento iniziale, dal momento che
l'implementazione e la strategia sono assolutamente diverse.

Strategia
=========

La strategia e' esattamente quella di BurrFoot, con un'unica, piccola miglioria.
All'inizio del match cerca l'angolo pi— vicino e lo raggiunge.
Conta gli avversari e decide se difendersi o attaccare: dato il maggior numero
istruzioni consentite, questo robot si attacca alle pareti piu' del suo compare.

        - Se scopre che il confronto Š a singolar tenzone passa il controllo
        all'Attacco FiduciosoXP. Come fa trapelare il nome, Š una banale
        estensione dell'attacco Fiducioso di BurrFoot.
        - Altrimenti innesca la routine difensiva: per la verit… si tratta pi—
        che altro di una difesa attiva. Infatti FizBan amunenta progressivamente
        il proprio perimetro di azione, cercando di raggiungere gli avversari
        piu' distanti.
        Ogni 10 quadrati completi conta il numero di avversari rimasti, e se ne
        trova solo uno parte con il Fiducioso.
        - Se subisce pi— dell'80% di danni si rintana nel proprio angolino,
        lasciando da parte le velleit… offensive, e descrive il quadrato pi—
        piccolo di cui Š capace.

Note Tecniche
=============

Il robot Š la mia prima creaturina (se si eccettuano Caccola e Pirla) dove ho
volutamente e scientemente abbandonato le toxiche.
Ha parecchie pecche ed Š scritto in maniera non troppo curata.
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
FizBan cerca di arrivargli al minimo a 680 unit…, per poi e iniziare ad
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

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or;
int time,run,d,gradi,conta;
int si,z,oa,lim,cl;

main()
{
        r_coord=822;
        while (run+=conta=gradi=10)
             {
                if (damage()>80) r_coord=837;
                x_pos=(loc_y(y_pos=(loc_x()<(vel=500))*(r_coord-=15*(++time>6)))<500)*r_coord;
                while ((loc_x()%890)>110) CucchiaioKender(ang=(loc_x()<500)*180);
                vel=0;
                CucchiaioKender(ang);
                while ((loc_y(vel=100)%890)>110) CucchiaioKender(ang=90+(loc_y()<500)*180);
                vel=0;
                CucchiaioKender(ang);
                while (((gradi+=21)<390)&&(conta<12))  if (scan(gradi,10)>0) {++conta;CucchiaioKender(a=ang=gradi);}
                vel=100;
                while (conta<12)
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
                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270);
                        while(loc_x() <910-y_pos) CucchiaioKender(0);
                     }

             }
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
     if(or=scan(oa=a,10))
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

