/*               SSSSSSSSSSS       OOOOOOOOOOO    NN       NN
                SSSSSSSSSSSSS     OOOOOOOOOOOOO   NNNN     NN
                SS         SS     OO         OO   NN NN    NN
                SS                OO         OO   NN  NN   NN
                 SSSSSSSSSSS      OO         OO   NN   NN  NN
                   SSSSSSSSSS     OO         OO   NN    NN NN
                SS         SS     OO         OO   NN     NNNN
                SSSSSSSSSSSSS     OOOOOOOOOOOOO   NN      NNN
                 GSSSSSSSSSS       OOOOOOOOOOO    NN       NN

       GGGGGGGGGGG       OOOOOOOOOOO      KK       KK     UU         UU
      GGGGGGGGGGGGG     OOOOOOOOOOOOO     KK      KK      UU         UU
      GG         GG     OO         OO     KK     KK       UU         UU
      GG         GG     OO         OO     KK    KK        UU         UU
      GG                OO         OO     KKKKKKK         UU         UU
      GG       GGGG     OO         OO     KK    KK        UU         UU
      GG         GG     OO         OO     KK     KK       UU         UU
      GGGGGGGGGGGGG     OOOOOOOOOOOOO     KK      KK      UUUUUUUUUUUUU
       GGGGGGGGGGG       OOOOOOOOOOO      KK       KK      UUUUUUUUUUU

   Nome      : Son-Goku.r  (13-09-98)

   Allenatore: Muten - Il genio delle tartarughe di mare - 

   Autore    : Simone Ascheri 

   Scopo     : Partecipare all' VIII torneo di Crobots di MC

LA STORIA
=========

Son-Goku un bel giorno decide di partecipare al grande torneo TenKaiChi.
Salta quindi sulla sua nuvoletta Speedy, regalo del vecchio Muten (il genio
delle tartarughe di mare),  e va alla pugna.
Attacca i nemici con tre tipi di colpi :
il GreatSayian, (il piu' preciso), il Sayian (un compromesso tra precisione
e velocita') e l' onda KameAmeA (la piu' veloce, ma di scarsa precisione).

COMPORTAMENTO
=============
La strategia di Goku e' abbastanza complicata.
Il crobot infatti puo' adottare diverse tattiche a seconda della posizione,
del tempo trascorso, dei danni subiti ed infine del caso.
La parte piu' difficile di tutto il lavoro e' stata la ricerca del giusto
equilibrio tra le varie parti di Goku. Quello attuale sembra funzionare
discretamente, ma e' ben lungi dall' essere quello ideale.

Fase Iniziale
-------------
All' inizio del Match Goku cerca un angolo libero, cominciando da quello piu'
vicino, e (non troppo) prontamente lo raggiunge.
A questo punto controlla i danni e decide:

 1 * Se ne ha subiti meno del 5% si ferma e spara ai crobot che gli capitano
     a tiro. Si comporta come NCMPLT.R fino a quando non subisce un altro 6%
     di danni. Seleziona quindi il movimento finale a rombo e pasa al punto
     due.
     Se invece trascorrono pacificamente circa 100000 cicli di CPU inizializza
     il movimento finale in diagonale e passa direttamente ai movimenti
     conclusivi.
 2 * Cambia angolo, inizia a muoversi parallelamente ad un lato e a sparare.
  
Le routine di fuoco sono tre, tutte spudoratamente copiate:

 A * Mentre si allontana dagli angoli usa la routine di DIABOLIK.R
     (GreatSayian, edizione integrale)
 B * Quando ritorna verso gli angoli si appropria del codice di COLOSSUS.R
     (Sayian, leggermente modificato)
 C * Quando decelera spara senza correzione (KameAmeA)

Goku e' un po' misantropo.
Se infatti si accorge di condividere il suo bell' angoletto con un altro
crobottino cambia posizione.

Movimento
---------
La routine e' unica per tutte le posizioni dello schermo e per due dei tre
attacchi finali.
Calcola la distanza (al quadrato, evitando cosi' una radice) rispetto ad un
punto dato [(20,20)(980,20) (980,980)(20,980)], trova l' angolo necessario per
raggiungerlo e infine inizia a muoversi in quella direzione. Quando arriva a
destinazione si ferma.
Sceglie una direzione parallela ad uno dei lati e si avvia, camminando fino a
quando non si trova alla massima distanza stabilita dal punto.
Inverte quindi il movimento e riinizia dal principio.
Dopo un certo numero di cicli il movimento diventa prima una L e infine
perpendicolare a quello iniziale.
Parte quindi la routine di attacco finale.

Fase Finale
-----------
Dopo circa 100000 cicli Goku conta gli avversari:

 1 * Se c' e' piu' di un superstite continua il movimento cambiando di angolo
     ogni 12 oscillazioni:
        - Fino a che i danni sono inferiori al 20% il moto rimane parallelo
          ad un lato dell' arena.
        - Dopo di che oscilla perpendicolarmente alla bisettrice dell' angolo.
 2 * Se i crobot sono invece rimasti in due Son-Goku sceglie una di queste tre
     strategie:

   A * Se i danni sono maggiori dell' 80% si sposta di angolo libero in angolo
       libero cercando di colpire il crobot superstite, oscillando
       perpendicolarmente alla bisettrice del quadrante.
   B * Si muove lungo una diagonale (come Drago6.r) con cambio di diagonale ogni
       volta che l' angolo base e' occupato (raro).
       Tale schema viene ripetuto dodici volte, per poi passare al punto C.
   C * Adotta un movimento a rombo con vertici nei punti medi dei lati della
       arena (come Diabolik.r), alternato con movimento a girandola con
       vertici negli stessi punti (sempre se il movimento precedente era a 45
       gradi).
       Questo schema puo' essere scelto direttamente o come appendice al punto
       B.
 
CONSIDERAZIONI
==============
Il Crobot gia' si comporta male con gli avversari di quest' anno, figuriamoci
con quelli del prossimo torneo.
La routine di movimento e' molto generica e si puo' adattare a quasi ogni
schema di gioco. 

Purtroppo il suo maggior pregio e' anche il suo limite principale.
Dalla sua ha infatti la compattezza del codice, che consente di dedicare molto
spazio alla parte offensiva del gioco.
Per contro pero', tale compattezza e' ottenuta a prezzo di una maggior lentezza:
il controllo della distanza dai bordi infatti richiede almeno 16 istruzioni,
contro le tre necessarie normalmente.
Questo rende il povero Goku molto piu' vulnerabile degli altri al fuoco nemico.
In una partita media di 100000 cicli si perde l' 11% del tempo per il controllo
della posizione, contro il 2% altrimenti necessario.
         
Inoltre, poiche' Goku non ha (ovviamente) modo di sapere quanto e' forte
l' ultimo superstite, e poiche' renderlo in grado di riconoscere il tipo di
movimento del nemico avrebbe richiesto routine troppo ingombranti, il
mix delle varie tattiche disponibili e' stato stabilito empiricamente.
Dopo numerosi tentativi l' efficienza del frugoletto e' passata dal 17.8% al
43.7% in un mini-torneo a 8 giocatori. Non e' pero' detto che risultato
ottenuto sia il migliore possibile. Anzi, nella peggiore delle ipotesi il
crobot potrebbe prendere in ogni occasione la decisione meno adatta.


Il programma e' abbastanza commentato, nel caso improbabile qualcuno si prendesse
il disturbo di leggerlo.
Per la spiegazione delle routine di fuoco rimando ai crobot citati, o ai loro
eventuali ispiratori. Io le ho prese come parti pre-fabbricate.... funzionano
e tanto mi basta.

RINGRAZIAMENTI
==============

Un sentito grazie a Tom Poindexter (per averci donato Crobots) a Maurizio
'JOSHUA' Camagni (per le sue indispensabili utilities) e a tutti coloro che,
con i loro robots, hanno reso possibile l' esistenza di Goku (...in qualche
caso, piu' che di semplice ispirazione, si e'trattato di un vero e proprio
furto).

Un enorme ringraziamento ad AKIRA TORIYAMA per aver creato DragonBall e
DragonBall Z.

*/

int timmax, max, min, ang, ang2, dx, dy, qsiete, dsiete;
int ncmplt, dan, xx, yy, park, ango, oang, range, orange;
int flag4, flag2, flag1, flag;

main()
{

/*Inizializzazione variabili*/

min=10000;                                /*Distanza minima dalla destinazione*/
max=90000;                                /*Ampiezza del movimento*/
                                          
ang2=(Trova((dy=980-(loc_x()>500)*960),   /*Cerca le posizioni sullo schermo*/
     (1000-(dx=(loc_y()>500)*960+20)))    /*e trova l' angolo di oscillazione*/
     /90*90);                             

/*Trova un angolo libero e lo raggiunge*/

Go();
timmax=55+1400*(ncmplt=(dan<5));          /*Numero di cicli prima del movimento finale*/

/*Restiamo fermi*/

while (ncmplt)        
     {
       if (((--timmax)<28)|(dan<damage()-6))
         {
           if ((timmax=timmax/27)>1)
             Go();
           ncmplt=0;
         }  
         else Sayian(0);
      }

flag4=timmax;                             /*Sceglie il tipo di movimento finale*/

/*Ciclo principale*/

while (1)                                         
   {

/*Movimento oscillatorio*/

     while (--timmax)
       {
         drive (ang=(ang2+flag)%360,100);              
         while (Dista(dx,dy)<max)
            {
              if ((flag==225)|(flag==315))
                 GreatSayian();
              else Sayian(1);       
            }   

            KameAmeA(49);

            if (scan(ang+=180,10))
              Go();
            else
                 {
                  drive (ang,100);                 
                  while (Dista(dx,dy)>min)
                       GreatSayian();
                  }                    
         if (((++flag1)%38>18)&&(flag!=225))
            flag=630-flag;

  KameAmeA(49);
        }

/*Movimento finale*/

timmax=12;

if ((!Reeft())&&(damage()<80))
  {          
      if (flag4<5)                                 /*Attacco diagonale*/
         {
          min=15000;
          max=1350000;
          flag4=flag=315;                          /*Nuovo angolo di oscillazione*/
         }
         else                                      /*Attacco romboidale*/
        {
         while (1)
           {
            NuvolaSpeedy(500,50);
            NuvolaSpeedy(950-(flag2=450-flag2),500+flag2);
            NuvolaSpeedy(500+flag2,950-flag2);
            NuvolaSpeedy(50,500);            
           }
         }
      }   
   else 
     {
        if ((flag4<220)&&(damage()>20))              /*Movimento a 45 gradi contro i bordi*/
          {
           dy+=16500000/sin(ang2);
           dx+=16500000/cos(ang2);
           flag4=flag=225;
           max=25600;
          }
      Go();
     }
   }     
}

/*Operazioni di servizio*/

/*Routine di spostamento verso coordinate date*/

NuvolaSpeedy(tx,ty)
int tx, ty;
   {
    drive(ang=Trova(tx,ty),100);
    while ((Dista(tx,ty)>5000)&&(speed()))
         GreatSayian();
    KameAmeA(49);
   }

/*Individua l' angolazione necessaria per raggiungere un punto dato*/

Trova(mx,my)
int mx, my;
  {
    return (180+((mx-=(loc_x()))>0)*180+atan(((my-loc_y())*100000)/mx));
  }

/*Calcola la distanza rispetto ad un punto dato*/

Dista(nx,ny)
int nx, ny;
  {
    return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

/*Valuta se un angolo e' libero*/

Go()
  {                                            
    OooHoo();
    while (scan(Trova(dx,dy),10)>400)
         OooHoo();
    NuvolaSpeedy(dx,dy);
    dan=damage();
  }

/*Sceglie un nuovo angolo*/

OooHoo()                 
  {
     park=dy;
     dy=dx;
     dx=1000-park;
     ang2+=90;
  }                       

/*Conta i superstiti*/

Reeft()             
  {
    dsiete=ang2+225;
    qsiete=-1;                
    while (dsiete<(ang2+360))
         qsiete+=(scan(dsiete+=21,10)!=0);
    return (qsiete);
  }

/*Procedure di fuoco (spudoratamente copiate)*/

GreatSayian()
{
  if((orange=scan(ango,10))&&(orange<770))
  {
   if (range=scan(ango+353,4)) cannon(ango+=350,3*range-2*orange);
   else if (range=scan(ango,4)) cannon(ango,3*range-2*orange);
   else if (range=scan(ango+7,4)) cannon(ango+=10,3*range-2*orange); 
   }                                  
  else
    if((range=scan(ango-21,10))&&(range<800))
      cannon(ango-=21,range);
    else
      if((range=scan(ango+21,10))&&(range<800))
        cannon(ango+=21,range);
      else
        if((range=scan(ango-42,10))&&(range<900))
          cannon(ango-=42,range);
        else
          if((range=scan(ango+42,10))&&(range<900))
            cannon(ango+=42,range);
          else
            ango+=105;
}                            

KameAmeA(vel)
int vel;
{
  drive (ang,0);
  while (speed()>vel)   
       if ((range=scan(ango,10))&&(range<770)) cannon (ango,range);
       else ango+=20;
}
 
Sayian(muovi)
int muovi;
{                                   
     if (!scan(ango,5))
        if (!scan(ango-=11,5))
           if (!scan(ango+=22,5))
              if (!scan(ango-=33,5))
                 if (!scan(ango+=44,5)) { ango+=40; return; }
           
     if (scan(ango,5)>770)
     {
      ango+=40;
      return;
     }

       ObaBa();
       if (orange=scan((oang=ango),5))
         {
           ObaBa();
           if (range=scan(ango,10))
             cannon((ango+(ango-oang)*((1200+range)>>9)-(sin(ango-ang)>>14)*muovi),(range*160/(160+orange-range-(cos(ango-ang)>>12)*muovi)));
         }
}                                         

ObaBa()
{
       if(scan(ango-5,1)) ango-=5;
       if(scan(ango+5,1)) ango+=5;
       if(scan(ango-3,1)) ango-=3;
       if(scan(ango+3,1)) ango+=3;
       if(scan(ango-1,1)) ango-=1;
       if(scan(ango+1,1)) ango+=1;
}

