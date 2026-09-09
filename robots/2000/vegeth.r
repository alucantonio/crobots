/*
VV      VV    EEEEEEEEE     GGGGGGGGG     EEEEEEEEE    TTTTTTTTTT   HH     HH
VV      VV   EEEEEEEEEEE   GGGGGGGGGGG   EEEEEEEEEEE   TTTTTTTTTT   HH     HH   
 VV    VV    EE            GG       GG   EE                TT       HH     HH
 VV    VV    EEEE          GG       GG   EEEEE             TT       HH     HH
  VV  VV     EEEEE         GG            EEEEEEE           TT       HHHHHHHHH
  VV  VV     EE            GG     GGGG   OO                TT       HH     HH
   VVVV      EE            GG       GG   OO                TT       HH     HH
   VVVV      EEEEEEEEEEE   GGGGGGGGGGG   EEEEEEEEEEE       TT       HH     HH
    VV        EEEEEEEEE     GGGGGGGGG     EEEEEEEEE        TT       HH     HH

   Nome      : Vegeth.r  (28-10-2000)

   Autore    : Simone Ascheri

   Scopo     : Salvare l'universo dalla furia del perfido Majin-Bu

LA STORIA
=========

Ormai la pace sembra tornata sulla Terra: Gohan ha sconfitto Cell e si e'
rivelato essere il guerriero piu' forte dell'universo, superiore persino a
suo padre e a Vegeta, principe dei Sayian.
La sua vittoria purtroppo non e' stata completa, e l'androide, pur di
annientare i nemici, si autodistrugge.
Goku, per evitare la scomparsa del pianeta, teletrasporta Cell altrove, esplodendo
insieme a lui.
E' passato ormai molto tempo e, come premio per le sue buone azioni, a Ka_aroth
viene concessa la possibilit… di trascorrere una giornata sulla Terra: inutile
dire che la data scelta e' quella del grande torneo TenKaiChi.
Gli scontri hanno inizio, e il pericolo e' in agguato: non appena Gohan si
trasforma in SuperSayian due partecipanti lo immobilizzano e gli rubano tutta
l'energia, usandola in seguito per risvegliare il fortissimo Majin-Bu.
Questi, dopo aver assorbito un certo numero di combattenti, si rivela un nemico
troppo forte per chiunque. Anche ka_aroth, che ormai ha raggiunto il livello di
SuperSayian III non e' in grado di fermarlo.
Ma grazie ai magici Potara degli dei Kaioshin, Goku e Vegeta possono unirsi, per
formare quello che, auspicabilmente, sara' il guerriero piu' forte dell'universo....

COMPORTAMENTO
=============

Fase Iniziale
-------------
All' inizio del Match Vegeth cerca un angolo libero, cominciando da quello
piu' vicino, e (non troppo) prontamente lo raggiunge (in particolare ho notato
che, prima che il mio crobot spari un colpo, gli avversari ne hanno gia' esplosi
due).
Conta quindi gli avversari, e se ne trova solo uno lo attacca con il SuperVegeth.
Altrimenti inizia a muoversi parallelamente ad un lato e a sparare.
La scelta della direzione in cui oscillare dipende da alcuni fattori:

A) Se i danni sono inferiori all'80%:
   ==================================

   Se sono presenti avversari statici:
   ===================================

     -Vegeth li cerca innanzitutto nell' angolo seguente, e in caso affermativo
      li attacca...
     -Altrimenti guarda nell' angolo precedente e li attacca...

   Altrimenti controlla presenza e distanza dei nemici negli angoli adiacenti e:
   =============================================================================

     - Se e' all'inizio del match si dirige vero l'angolo libero oppure attacca
       l'avversario piu' lontano (in caso non vi fossero angoli vuoti)
     - Se sono trascorsi almeno 100000 cicli attacca sempre l'avversario piu'
       vicino.

Se i danni sono superiori all'80%:
==================================

   - Oscilla sulla bisettrice del quadrante con brevi movimenti: in pratica
     si tratta della mia personalissima versione del vincitore dello scorso
     anno, con la differenza che Vegeth utilizza, in questa situazione, la
     routine di fuoco piu' precisa di cui dispone: la sfera GenkiDama().
  
In ogni caso, se Vegeth subisce troppi danni o ha un nemico troppo vicino
cambia posizione.

Fase Finale
-----------
Ogni 10000 cicli  circa Vegeth conta gli avversari:

 1 * Se c' e' piu' di un superstite continua il movimento cambiando angolo
     se ha subito troppi danni.
 2 * Se invece si accorge di:
     - avere solo piu' un avversario
     - avere due nemici, ma danni inferiori al 70% e cicli di CPU superiori ai
       170000
     parte con l'attacco finale:
     Questi in realta' sono due.
     -  Il primo e' il SuperGhostKamikazeAttack (SGKA per gli amici), che altri non
        e' se non la mia implementazione di Jaja.r, incompreso robot del mitico
        Luigi Rafaiani. Tale routine ha il vantaggio di essere efficiente anche
        in presenza di due sopravissuti. Se si accorge che il superstite e' proprio
        uno, passa al...
     -  Secondo attacco: il SuperVegeth.
        Si tratta di una parziale rielaborazione del movimento di Satana.r,
        abbinata al particolare moto oscillatorio di Jaja.r
     La loro particolarit… e' di riuscire a sgusciare tra le maglie delle
     correzioni di fuoco delle toxiche.

Routine di Movimento
--------------------
La routine e' unica per tutte le posizioni dello schermo.
Calcola la distanza (al quadrato, evitando cosi' una radice) rispetto ad un
punto dato [(20,20)(980,20)(980,980)(20,980)], trova l' angolo necessario per
raggiungerlo e infine inizia a muoversi in quella direzione. Quando arriva a
destinazione si ferma.
Sceglie una direzione parallela ad uno dei lati con il sistema visto precedentemente
e si avvia, camminando fino a quando non si trova alla massima distanza stabilita dal
punto.
Inverte quindi il movimento e riinizia dal principio.

NOTE TECNICHE
=============

Il robot utilizza quattro diverse routine di fuoco:
  - Il KaiOKen() e' l'ormai nota variante della routine di fuoco di Arale:
    presenta la particolarita' di cambiare il tipo di puntamento dopo i 140000
    cicli di cpu virtuale.
  - La KameAmeA() e' la routine di sempre, con marginali modifiche.
  - Il SuperSayan() e' quasi completamente nuovo:
    1 - ho eliminato completamente i blocchi di puntamento della toxica base,
        sostituiti da altri a tempo di esecuzione costante;
    2 - ho ricalibrato tutti i parametri usando le divisioni (piu' personalizzabili)
        al posto degli shift;
    3 - la correzione avviene ora sul primo angolo di scansione, non piu'
        sull'ultimo.
  - La GenkiDama() e' la routine piu' precisa di cui dispone Vegeth.
    Purtroppo la sua efficacia e' massima quando la velocit… del robot e' compresa
    tra i 30 e i 60 metri, per cui e' usata solo nelle oscillazioni stile Dav46.r
    e negli attacchi finali.
    E' una rielaborazione della fire di Jaja.r. In particolare:
    1 - ho modificato la find() riducendola a circa 1/3 della sua lunghezza;
    2 - ho inserito dei correttivi per i tiri a breve distanza.

Lo spostamento da un angolo all'altro avviene utilizzando, in luogo del moto
rettilineo, il movimento di Jaja.r, in modo da evitare il piu' possibile i
toxici colpi degli avversari.

L'ampiezza dell'oscilazione base e' di circa 250 unita', ma puo' allungarsi o
accorciarsi a seconda dei danni subiti nell'unit… di tempo.

La penultima versione del SuperVegeth era arrivata al 97.7% in f2f9198, ma ho
dovuto modificarla, perdendo circa il 3%, perche' non vinceva una partita contro
lo jaja.r originale e contro Leader.r

RINGRAZIAMENTI
==============

Un sentito grazie a:
- Tom Poindexter (per averci donato Crobots [pero' .... questi sorgenti....])
- Maurizio 'JOSHUA' Camangi per le tonnellate di e-mail che ci siamo scambiati
- Il 'misterioso benefattore' per aver innalzato il limite di istruzioni di
  crobots.
- Michelangelo Messina per aver gentilmente assecondato tutte le mie richieste di
  modifica al suo Torneo2k e aver sviluppato ECAT.
- Marco Pranzo, per l'insostituibile CrobotsHelper 2.0 e per gli irresistibili
  commenti ai suoi robot.
- Tutti coloro con i quali ho scambiato pareri in questi mesi, che mi hanno spinto a
  continuare lo sviluppo.
   
Un enorme ringraziamento ad AKIRA TORIYAMA per aver creato DragonBall e
DragonBall Z.

INSULTI
=======

Una nutrita serie di improperi va chi ha deciso di trasmettere i Cavalieri
dello Zodiaco al posto di DragonBall il sabato e la domenica.

SCUSE
=====

Mi scuso in anticipo con i pochi che cercheranno di leggere il sorgente:
non solo e' molto intricato, ma quest'anno non ho proprio avuto il tempo di
commentarlo a dovere.... e' anche possibile che vi siano ancora riferimenti a
SonGohan.r
Mi scuso inoltre per gli eventuali strafalcioni nella documentazione di cui
sopra: il robot era pronto 3 mesi fa, e da allora l'ho riguardato pochissimo.
Potrei aver confuso un po' le cose.
*/

int park, ux, uy, dx, dy;                               /*Variabili posizionali*/
int flag, vang, ang, ang2;                              /*Variabili direzionali*/
int dan, timmax;                                        /*Variabili temporali*/
int dir, ango, oang, range, orange;                     /*Variabili balistiche*/
int dang, alfa, corr, anco, nrg, rg;
int max, clock, gira, time, klik, scn;

main()                             
{
                                                        /*Calcola coordinate iniziali e agolo principale*/
ang2=(Trova((dy=980-(loc_x()>500)*960),
     (1000-(dx=(loc_y()>500)*960+20)))/90*90);

while (Ricerca(Trova(OooHoo(ang2+=90),dy=park))>400);
NuvolaSpeedy(dx,dy);

max=57000;

if (Reeft(ang2,37)<3)
  SuperVegeth();

while (timmax+=6)                                       /*Ciclo principale*/
  {
    while (--timmax)                                    /*Movimento oscillatorio*/
       {                                              
                                                        /*Decide se e' il momento di
                                                          cambiare angolo, in base ai danni
                                                          e alla posizione del nemico*/

          if ((dan<damage(flag=0)-15)||((orange)&&(orange<400))) Teleport(1);

          if ((time<5)&&(damage()>60)) max=30000;
          else if ((time>10)&&(damage()<40)) max=70000;

          if (damage()>80)
            {
               dan=damage();
               while (dan==damage()) Senzu();
            }
          else
          {
             if (orange=Ricerca(ang2+630))
               {
                 while (speed());
                 if ((orange=Ricerca(ang2+630))&&(Ricerca(ang2+630)==orange))
                   flag=630;
               }
             if (!flag)
               {
                 if (Ricerca(ang2))
                   {
                    while (speed(flag=630));
                    if ((range=Ricerca(ang2))&&(Ricerca(ang2)==range))
                      flag=0;
                    else if (!orange)
                           {
                             if (time>11) flag=0;
                           }
                    else if (range>orange) flag=0;
                   }
                 else if ((orange)&&(time>11)) flag=630;
               }

          drive (ang=(ang2+flag),100);                  /*Si allontana dall' origine*/
          while ((Dista(dx,dy)<max)&&(speed()))
               SuperSayian();
   
          KameAmeA();                                   /*Rallenta*/
          ang+=180;
          Arrivo(dx,dy);                           /*Torna all' origine*/
       }
   }

++time;

if (((park=Reeft(ang2+220,9))<2)||((park==2)&&(damage()<70)&&(time>18)))                        /*Controlla quanti sono i sopravvissuti*/
  SGKA();                     
else
  if ((park==2)&&(dan<damage()-5))
       {
         Teleport(0);
       }
  }
}

/*Operazioni di servizio*/

Teleport(si)
int si;
  {
     if (!Ricerca(vang=ang2))                 /*La scelta e' effettuata in maniera
                                                leggermente diversa dal solito*/
       {
         ang2+=270;
         park=dy;
         dy=1000-dx;
         Drunken(dx=park,dy);
       }
     else
       if (!Ricerca(vang=ang2+630))
         Drunken(OooHoo(ang2+=90),dy=park);
       else if (si)
              {
                if (!Ricerca(vang=ang2+315))
                  {
                     ang2+=180;
                     Drunken(dx=1000-dx,dy=1000-dy);
                  }
                else
                  {
                     while (++dan<=damage()) Senzu();
                     NuvolaSpeedy(dx,dy);
                  }
              }
     dan=damage();
  }


/*Routine di spostamento verso coordinate date*/

Senzu()
  {
     if (Dista(dx,dy)<18000) fuoco(ang2+315);
     if (Dista(dx,dy)>10000) fuoco(Trova(dx,dy));
     if (scn<ang2+700)
       {
         if ((range=scan(scn,10))&&(range<nrg))
           ango=scn;
         scn+=315;
      }
    else scn=ang2;
  }

NuvolaSpeedy(tx,ty)
int tx, ty;
   {
     Trova(tx,ty);
     Arrivo(tx,ty);
     scn=ang2;
   }

/*Vai alla distanza minima dal punto*/

Drunken(qx,qy)
int qx, qy;
  {
        MoonWalk();
        NuvolaSpeedy (qx,qy);
  }

MoonWalk()
int f;
  {
     Trova(500,500);
     ux=(loc_x(uy=(loc_y()>500)*1000)>500)*1000;
     while ((Dista(ux,uy)<15000))
          {
            drive (ang,100);
            KaiOKen();
          }
     ux=loc_x(uy=loc_y());
     if (sin(vang)) uy=1000*(uy<500);                   /*Calcola le nuove coordinate della destinazione*/
     if (cos(vang)) ux=1000*(ux<500);
     while (Dista(ux,uy)>37000)
          {
               fuoco(vang+50);
               fuoco(vang-50);
          }
  }

Arrivo(fx,fy)
int fx, fy, h;
  {
     drive (ang,100);                 
     while (((h=Dista(fx,fy))>5200)&&(speed()))
          if (h<25000)
            KaiOKen();
          else
            SuperSayian();
     return KameAmeA();
  }

Trova(mx,my)                                            /*Individua l' angolazione necessaria per raggiungere un punto dato*/
int mx, my;
  {
     return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/mx)));
  }

Dista(nx,ny)                                            /*Calcola la distanza rispetto ad un punto dato*/
int nx, ny;
  {
     return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

OooHoo()                                                /*Effettua la rotazione degli angoli da controllare*/
  {
     park=dx;
     return(dx=(1000-dy));
  }

Ricerca(an)
int an;
  {
     return (scan(an+350,10))+(scan(an+10,10));
  }

KameAmeA()                                              /*Procedura di rallentamento standard*/ 
  {
     drive(ang,0);
     TrovaAura();
          if ((range=scan(ango,10))&&(range<850))
            cannon (ango,range);
          else
            Ceck(ang);
  }

Stop()                                                  /*Procedura di rallentamento speciale*/
  {                                                     
     drive (dir,40);
     ango+=10;
     while(!scan(ango+=21,10));
     KaiOKen();
  }


Reeft(dsiete,dand)                                      /*Conta i superstiti*/
int dsiete, dand, qsiete;
  {
     while (--dand)
          qsiete+=(scan(dsiete+=20,10)!=0);
     return (qsiete);
  }

SuperVegeth()
int z;
  {
    NuvolaSpeedy(time=500,500);
    vang=((ango+180)/90)*90;
    while (fuoco(vang+50))
          {
            fuoco(vang-50);
            if (((loc_x()%750)<250)||(z=((loc_y()%750)<250)))
              {
                if (nrg) cannon(ango+(ango-oang)*3,nrg);
                vang=180*(!z)*(loc_x(gira=3)>500)+(90+180*(loc_y()>500))*z;
              }
            else
             {
               if (--gira);
               else
                 {
                   vang=((ango+180)/90)*90;
                   gira=3;
                   if ((nrg>350)||(!nrg))
                     {
                        dan=damage();
                        while (dan==damage())
                             {
                               fuoco(vang-90);
                               fuoco(vang+90);
                             }
                     }
                 }
             }
          }
  }

SGKA()                                                /*Super Ghost Kamikaze Attack*/
int wait;
  {
    while (ang2+=90)
          {
             if (Ricerca(vang=ang2+540))
               {
                 vang=ang2+225;
                 ang2+=90;
               }
             MoonWalk();
             dan=damage(wait=20);
             while ((dan==damage())&&(--wait))
                  {
                    fuoco(ang2);
                    if (Dista(ux,uy)>20000) fuoco(ang2-180);
                  }
             if (!wait)
                if (Reeft(ang2,37)<3) SuperVegeth();
          }
  }

TrovaAura()
  {
    if (TrovaB()) return 1;
    if (TrovaB(ango-=19)) return 1;
    if (TrovaB(ango+=38)) return 1;
    return 0;
  }


TrovaB()

{

if ( nrg = scan(ango,10) )  
 { if ( scan(ango+6,5) )
   {  if ( scan(ango+2,2) )
      {  if ( scan(ango+4,1) ) 
         {  if ( scan(ango+3,0) ) 
             ango+=3; 
	    else
             ango+=4;
	 }
	 else
            if ( scan(ango+2,0) )
             ango+=2; 
	    else
             ango+=1; 
      }
      else
      {  if ( scan(ango+8,1) ) 
         {  if ( scan(ango+7,0) ) 
             ango+=7; 
	    else
             ango+=9;
	 }
      else
         if ( scan(ango+6,0) )
            ango+=6; 
	 else
            ango+=5; 
      }
   }
   else
   {  if ( scan (ango-1,2) )
      {  if ( scan(ango-3,1) )
         {  if ( scan(ango-2,0) ) 
             ango-=2;
	    else
             ango-=3;        
	 }
	 else
           if ( scan(ango-1,0) )
            ango-=1;
	   else
            ango-=0;        
      }
      else
      {  if ( scan(ango-4,1) )
         {  if ( scan(ango-5,0) ) 
             ango-=5;
	    else
             ango-=4;        
	 }
	 else
           if ( scan(ango-6,1) )
            ango-=6;
	   else
            ango-=8;        
      }
   }
 return 1;
 }
return 0;
}

/*Procedure di fuoco*/

fuoco(a)
int a;
  {
     drive (dir=a,100);
     if (TrovaAura())
       {
         drive(dir,100);
         GenkiDama();
       }
     else
         Stop();
  }

GenkiDama()
  {
     if (TrovaAura(oang=ango))
       {    
         drive (dir,40);
         if (nrg<130)
           {
             if (nrg<50) return cannon(ango+(ango-oang)*3,2*scan(ango,10)-nrg);
             return KaiOKen();
           }
         corr=cos(alfa=(ango-dir)-((ango-dir)/360)*360);
         dang=ango+(ango-oang)*3-sin(alfa)/17600;
         if (rg=scan(ango,10))
           cannon (dang,rg*350/(350+nrg-rg-corr/3000));
         else   
            Ceck(oang);
       }
     else
       Stop();
  }

/*Spara con media precisione*/

KaiOKen()
  {
    if((orange=scan(ango,10))&&(orange<850))
     {
       if (time>13)
         return cannon (ango+=5-10*(scan(ango-5,5)>0),2*scan(ango,10)-orange);
       if (range=scan(ango+353,4))
         cannon(ango+=353,range);
       else if (range=scan(ango,3))
              cannon(ango,range);
       else if (range=scan(ango+7,4)) 
              cannon(ango+=7,range);
     }
    else
      if((range=scan(ango+=339,10))&&(range<770))
        cannon(ango,range);
      else
        if((range=scan(ango+=42,10))&&(range<770))
          cannon(ango,range);
        else
            return (ango+=40);
  }                            

Ceck(direz)
int direz;
  {  
     if (range=scan(ango+=340,10));
     else if (range=scan(ango+=40,10));
     else if (range=scan(direz,10))
            ango=direz;
     else
       return (ango+=40);
     return cannon(ango,2*scan(ango,10)-range);
  }     
 
/*Spara con buona precisione sia da fermo che in movimento*/

SuperSayian()
  {
    if (TrovaAura())
      {
        if (nrg>700) return KaiOKen();
        else if (nrg<150)
                {
                  cannon (ango,nrg);
                }
        else
        {
        if (orange=scan(oang=ango,10))
          {
            TrovaB();
            if (range=scan(ango,10))                
              cannon((oang+(ango-oang)*3-(sin(ango-ang)/19500)),(range*160/(160+orange-range-(cos(ango-ang)/4167))));
          }
        else
          return Ceck(ang);
        }
      }      
    else
      Ceck(ang);
  }
