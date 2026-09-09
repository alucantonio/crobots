/*
      KK    KK  AAAAAA  '''   AAAAAA   RRRRRR   OOOOOO  TTTTTTTT HH    HH
      KK   KK  AAAAAAAA '''' AAAAAAAA RRRRRRRR OOOOOOOO TTTTTTTT HH    HH
      KK  KK   AA    AA   '' AA    AA RR    RR OO    OO    TT    HH    HH
      KK KK    AA    AA   '  AA    AA RR    RR OO    OO    TT    HH    HH
      KKKK     AAAAAAAA      AAAAAAAA RRRRRRRR OO    OO    TT    HHHHHHHH
      KK KK    AA    AA      AA    AA RR RR    OO    OO    TT    HH    HH
      KK  KK   AA    AA      AA    AA RR  RR   OO    OO    TT    HH    HH
      KK   KK  AA    AA      AA    AA RR   RR  OOOOOOOO    TT    HH    HH
      KK    KK AA    AA      AA    AA RR    RR  OOOOOO     TT    HH    HH

   Nome        : Ka'aroth.r  (10-05-99)

   Provenienza : Pianeta Vegeta

   Razza       : Sayian

   Scopo       : Difendere la terra degli attacchi dei perfidi Sayian

   Autore      : Simone Ascheri

LA STORIA
=========

Un brutto giorno gli alieni del pianeta Vegeta, i potentissimi Sayian, arrivano
sulla Terra per sterminarne gli abitanti e vendere il pianeta al miglior
offerente.
Radish, Napa e Vegeta (praticamente e' come se l' imperatore del Giappone si
chiamasse Giappone) sono quasi invincibili: l' unico che puo' fermarli e'
Ka'aroth, anch' egli Sayian di nascita, ma terrestre d' adozione.
Attacca i nemici con tre tipi di colpi :
- Il SuperSayian:
  Usato quando si e' a una certa distanza dai bordi, e' il piu' preciso, ma
  anche il piu' lento. E' una routine di Diabolik.r (e di Tox prima) leggermente
  modificata, con il blocco di Scan() mutuato da Coppi.r.
- Il KaiOKen:
  Compromesso tra precisione e velocita'. Usato in prossimita' dei bordi e
  nei colpi ravvicinati e' derivato direttamente da Arale.r, robot di cui ho
  grande stima.
- L' onda KameAmeA:
  E' la piu' veloce, ma di scarsa precisione. E' usata nei rallentamenti.

COMPORTAMENTO
=============

La strategia di Ka'aroth e' abbastanza complicata.

Fase Iniziale
-------------
All' inizio del Match Ka'aroth cerca un angolo libero, cominciando da quello
piu' vicino, e (non troppo) prontamente lo raggiunge.
Inizia quindi a muoversi parallelamente ad un lato e a sparare.
Ka'aroth e' un po' misantropo.
Se infatti si accorge di condividere il suo bell' angoletto con un altro
crobottino cambia posizione.

Fase Finale
-----------
Dopo circa 150000 cicli Ka'aroth conta gli avversari:

 1 * Se c' e' piu' di un superstite continua il movimento

     I  * Con moto a pendolo sulla diagonale, se i danni sono inferiori al
          40%...
     II * ...Altrimenti descrivendo dei mini-quadrati nel settore di appartenenza,
          cambiando angolo ogni volta che i danni subiti sono ingenti.

 2 * Se invece si accorge di avere solo piu' un avversario Ka'aroth sceglie
     una delle strategie seguenti:

   A * Se il movimento precedente era sulla bisettrice e i danni inferiori al
       60%, inizia a scorrazzare lungo la diagonale, cambiando angolo ogni volta
       che quello base e' occupato.
   B * Altrimenti adotta un movimento a rombo con vertici nei punti medi dei
       lati dell' arena, alternato con movimento a clessidra inclinata con
       vertici negli stessi punti.

 3 * In tutti i casi, se ha subito piu' del 78% di danni, Ka'aroth lascia
     perdere cio' che stava facendo, cerca un angolo libero e ivi si ferma,
     adottando questo comportamento:

   1 * Se scopre che c' e' un solo superstite nell' arena, rimbalza di angolo
       libero in angolo libero per cercare di distruggerlo...
   2 * ...Altrimenti si ferma in un cantuccio sparando ai cattivi con la massima
       precisione di cui e' capace e muovendosi solo quando viene colpito.

     Teoricamente questa tattica dovrebbe aiutarlo a pareggiare l' incontro
     (Son-Goku.r non ci riusciva quasi mai), ma non so fino a che punto sia
     efficace.

Routine di Movimento
--------------------
La routine e' unica per tutte le posizioni dello schermo e per tre dei quattro
attacchi finali.
Calcola la distanza (al quadrato, evitando cosi' una radice) rispetto ad un
punto dato [(20,20)(980,20)(980,980)(20,980)], trova l' angolo necessario per
raggiungerlo e infine inizia a muoversi in quella direzione. Quando arriva a
destinazione si ferma.
Sceglie una direzione parallela ad uno dei lati (controllando dove si trova il
nemico) e si avvia, camminando fino a quando non si trova alla massima
distanza stabilita dal punto.
Inverte quindi il movimento e riinizia dal principio.

CONSIDERAZIONI
==============

Il programma e' abbastanza commentato, nel caso improbabile qualcuno si
prendesse il disturbo di leggerlo.
Sono partito dalla struttura di base di Son-Goku.r, di cui Ka'aroth.r e'
(teoricamente) un' evoluzione, ma nel corso del lavoro ho modificato radicalmente
ogni punto. Infatti alcune procedure sono state riscritte completamente ed altre
ulteriormente ottimizzate. In piu' e' differente il mix delle varie tattiche e la
modalita' di scelta della direzione. Ho aggiunto inoltre un' oscillazione in
diagonale e sostituito l' inefficiente !-like con una Kill!-like. Ho inserito infine
una routine difensiva auspicabilmente migliore della precedente, mentre ho eliminato
la fase iniziale di 'studio' degli avversari.
Per la spiegazione delle routine di fuoco rimando ai crobot citati, o ai loro
eventuali ispiratori.
In ogni caso ora Ka'aroth utilizza il piu' possibile la Tox-like, relegando le altre
due a compiti marginali.

RINGRAZIAMENTI
==============

Un sentito grazie a:
- Tom Poindexter (per averci donato Crobots)
- Maurizio 'JOSHUA' Camangi per:
   * le sue indispensabili utilities
   * la pazienza dimostrata nel 'guidarmi' alla scoperta di Linux
   * le tonnellate di e-mail che ci siamo scambiati
- Michelangelo Messina per aver gentilmente assecondato tutte le mie richieste di
  modifica alle sue utilities e aver trovato i bugs delle mie
- Tutti coloro con i quali ho scambiato pareri in questi mesi

Un enorme ringraziamento ad AKIRA TORIYAMA per aver creato DragonBall e
DragonBall Z.

*/

int timmax, max, min, ang, ang2, dx, dy;
int dan, park, ango, oang, range, orange;
int quad, flag3, flag2, flag1, flag;

main()                            
{
ang2=(Trova((dy=980-(loc_x(min=8500)>(flag2=500))*960),
     (1000-(dx=(loc_y(max=70000)>500)*960+20)))/90*90);

Go(timmax=80);                                        /*Trova un angolo libero e lo raggiunge*/

while (timmax+=6)                                     /*Inizia il ciclo principale*/
   {
    while ((--timmax)&&(damage()<79))                 /*Movimento oscillatorio*/
       {
         if (!(flag%=630))                            /*Se il movimento non e' diagonale...*/
           if (Ricerca(ang2))                         /*...sceglie la direzione in base alla posizione del nemico*/
             flag=630;
         drive (ang=(ang2+flag)%360,100);             /*Si allontana dall' origine*/
         while ((Dista(dx,dy)<max)&&(speed()))        /*Finche' non e' troppo lontano spara*/
              SuperSayian(1,1,0);

         KameAmeA();                                  /*Rallenta*/

         if (Ricerca(ang+=180))                       /*Controlla se ha un nemico alle spalle:*/
           Go();                                      /*e cambia angolo..*/
         else Arrivo(dx,dy,min);                      /*..altrimenti torna all' origine*/
        }

/*Comportamenti dopo i primi 100000 cicli o dopo il 78% di danni */

if (damage(flag1=(Reeft(ang2+205,5)))>78)             /*Gioca in difesa*/
  {
    while(Go())                                       /*Cambia di angolo, fermandoti un po' se c'e' piu' di un superstite*/
         while((dan==damage())&&(flag1))              /*Fai il finto Tox*/
              SuperSayian(0,0,0);
  }
else if (!flag1)                                      /*Controlla quanti sono i sopravvissuti*/
       {
         if ((flag==315)&&(damage()<60))              /*Se il movimento era sulla bisettrice allora l' attacco finale e' diagonale*/
           max=1350000;                               /*Nuova ampiezza dell' oscillazione*/
         else
         {
         while (NuvolaSpeedy(500,60))                 /*Attacco finale romboidale*/
              {
                NuvolaSpeedy(flag2,flag2=1440-flag2);
                NuvolaSpeedy(flag2,1440-flag2);
                NuvolaSpeedy(60,500);
              }
         }
      }
   else
      {
        if (damage(min=15000)<40)                     /*Pendolo sulla bisettrice: Gundam-like*/
           {
             flag=315;
           }
        else
            {
              while (((dan=damage())<79)&&(Reeft((ang=ang2)+205,5)))             /*Quadrato nell' angolo*/
                   {
                     while ((++quad)%5)
                          {
                            Arrivo(dx+=26000000/cos(ang),dy+=26000000/sin(ang),8000); /*Calcola di volta in volta le nuve coordinate*/
                            ang+=270;
                          }
                     if (dan<damage()+(timmax=-5)) Go();                         /*Decide se muoversi in un altro angolo*/
                   }
            }
       }
   }
}

/*Operazioni di servizio*/

/*Routine di spostamento verso coordinate date*/

NuvolaSpeedy(tx,ty)
int tx, ty;
   {
    Trova(tx,ty);                                     /*Cerca la direzione in cui muoversi*/
    return Arrivo(tx,ty,6800);
   }

/*Vai alla distanza minima dal punto*/

Arrivo(fx,fy,m)
int fx, fy, m, h;
   {
     drive (ang,100);
     while (((h=Dista(fx,fy))>m)&&(speed()))
          SuperSayian(1,0,h<25000);
     return KameAmeA();
   }

/*Individua l' angolazione necessaria per raggiungere le coordinate (mx,my)*/

Trova(mx,my)
int mx, my;
  {
    return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/mx)));
  }

/*Calcola la distanza rispetto ad un punto dato: si lascia il quadrato per risparmiare tempo*/

Dista(nx,ny)
int nx, ny;
  {
    return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

/*Valuta se un angolo e' libero*/

Go()
  {
    while (Ricerca(Trova(OooHoo(ang2+=90),dy=park))>400);
    return(dan=damage(NuvolaSpeedy(dx,dy)));
  }

/*Effettua la rotazione degli angoli da controllare*/

OooHoo()
  {
     park=dx;
     return(dx=(1000-dy));
  }

/*Scan allargato a 40 gradi: non cade nel bug di scansione*/

Ricerca(an)
int an;
{
 return (scan(an+350,10))+(scan(an+10,10));
}

/*Conta i superstiti*/

Reeft(dsiete,dand)
int dsiete, dand, qsiete;
  {
    while (--dand)
         qsiete+=(Ricerca(dsiete+=40)!=0);
    return (qsiete>1);
  }

/*Procedure di fuoco (spudoratamente copiate)*/

/*Spara con media precisione*/

KaiOKen()
{
  if((orange=scan(ango,10))&&(orange<770))
  {
   if (range=scan(ango+353,4))
     cannon(ango+=350,3*range-2*orange);
   else if (range=scan(ango,3))
          cannon(ango,3*range-2*orange);
   else if (range=scan(ango+7,4))
          cannon(ango+=10,3*range-2*orange);
   }
  else
    if((range=scan(ango+=339,10))&&(range<700))
      cannon(ango,range);
    else
      if((range=scan(ango+=42,10))&&(range<700))
        cannon(ango,range);
      else
        if((range=scan(ango+=297,10)))
          cannon(ango,range);
        else
          if((range=scan(ango+=84,10)))
            cannon(ango,range);
          else
            return (ango+=40);
}

/*Spara mentre decelera*/

KameAmeA()
   {
     drive(ang,0);
     while (speed()>49)
          if ((range=scan(ango,10))&&(range<770))
            cannon (ango,range);
          else
            Ceck();
   }

/*Se non ha trovato avversari nella direzione originaria li cerca intorno e nella direzione in cui si sta muovendo*/

Ceck()
   {
          if (range=scan(ango+=340,10));
          else if (range=scan(ango+=40,10));
          else if (range=scan(ang,10))
                 ango=ang;
          else
             return (ango+=40);
          return cannon(ango,2*scan(ango,10)-range);
    }

/*Spara con buona precisione sia da fermo che in movimento*/

SuperSayian(muovi,sposta,no)
int muovi, sposta, no;
{
    if (orange=scan(ango,10))
      {
        if ((((orange<400)||(orange>700))&&(sposta))||(no))
          return KaiOKen();
        else
        {
        if (scan(ango-=5,5));else ango+=10;
        ObaBa();
        if (orange=scan(oang=ango,5))
          {
            ObaBa();
            if (range=scan(ango,10))
              return cannon((ango+(ango-oang)*((980+range)>>9)-(sin(ango-ang)>>14)*muovi),(range*200/(200+orange-range-(cos(ango-ang)>>12)*muovi)));
          }
        else
          return KaiOKen();
        }
      }
    else
      return Ceck();
}

/*Questo viene da Coppi.r*/

ObaBa()
{
  if(scan(ango+354,1)) ango+=354;
  if(scan(ango+6,  1)) ango+=6;
  if(scan(ango+356,1)) ango+=356;
  if(scan(ango+4,  1)) ango+=4;
  if(scan(ango+358,1)) ango+=358;
  if(scan(ango+2,  1)) ango+=2;
}

