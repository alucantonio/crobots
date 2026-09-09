/*
Nome            : Raistlin
Versione        : 7.1
Autore		: Simone Ascheri

Preludio
========

Nel mondo di Krynn esiste una gerarchia divina molto dettagiata e complessa,
che parte dal Caos, il Padre del Tutto e del Nulla (un tipino veramente a modo,
che quando lo invitate a casa vi erutta lingue di fuoco sul divano buono) per
arrivare agli dei minori, quali Miskal, che vede contemporaneamente tuti gli
infiniti piani dell'esistenza, e quando giudica una situazione o d… un parere
e' in grado di valutare tutte le possibili alternative presentate dal problema
(proprio per questo, in effetti una soluzione non la da mai, perche' appena
inizia si ferma, dato che si accorge di qualche variabile di cui non ha tenuto
conto e riparte con l'analisi).
Padre Caos genero' i suoi tre figli principali, Paladine, Gilean e Takisis
(dolce donzella che al confronto Lucrezia Borgia era Madre Teresa di Calcutta),
che a loro volta ebbero tre figli, Solinari, Dio della magia bianca, Lunitari,
protettore della magia neutra e Nuitari, ispiratore della magia diabolica.
I tre, all'insaputa del Padre, decisero, in tempi lontanissimi, di creare la
Terra di Krynn, per poter dare ordine al Caos. Inoltre, desiderosi di avere
fedeli che li adorassero, ciascuno di loro creo' alcune delle razze che oggi
popolano il pianeta (umani, gnomi, minotauri, orchi, draghi, elfi, kender....).
Sol, Lun e Nui, valutate positivamente le attitudini magiche degli abitanti
della zona rimasero a vegliarli, sotto forma di lune, benedicendo quanti
decidevano di onorarli praticando la loro arte. Da notare che Nuitari e'
invisibile dal cielo di Krynn e solo i suoi adepti, le vesti nere, sono in
grado di scorgerla la notte).
Il mondo ando' avanti, sul filo di un precario equilibrio tra il bene (Paladine)
e il male (Takisis), con Gilean (e il suo altre-ego, Astinus, il bibliotecario di
Palanthas che annota pazientemente lo svolgersi di TUTTI eventi sul Krynn) alla
finestra ad osservare con fare abbastanza neutrale.
Purtroppo la Dea nera tramava nell'ombra e, aprofittando di un momento di
debolezza delle forze del bene scateno' le leggendarie 'Guerre dei draghi'
per cercare di uscire dall'Abisso (l'al di a' di Krynn) e giungere nel mondo.

Fortunatamente cio' accadde nell'era degli eroi: Tanis Mezz'elfo, Flint Fireforge
(nano), Strum BrightBlade (cavaliere di Solamnia, ordine fondato secoli prima da
Vinas Solamnus e che annovero' tra le sue fila uomini di indiscusso valore, quale
Yuma, erode della 'Guerra delle lance'), Caramon Majere (umano) e soprattutto
TassleHoff BurrFoot (kender) che, sfidando le preponderanti forze del male, si
ersero a baluardo del bene in un mondo che precipitava rapidemente verso l'auto
distruzione.
Ma nessuno di loro, per quanto forte e coraggioso (o incosciente come un
kender), avrebbe potuto portare le razze di Krynn alla vittoria senza l'aiuto
determinante di una veste nera, il signore del Presente e del Passato, il
custode della Torre dell'Alta Stregoneria di Palanthas, fratello gemello di
Caramon...... l'arcimago Raistlin Majere(*).

Commento
========

Dal momento che detesto partire da un foglio bianco (vabbŠ, blu nel caso dell'edit)
ho, come al solito, rispolverato un mio vecchio robot (Caccola.r) e ho cercato
di aggiornarlo per metterlo nelle condizioni di difendersi dai cattivi soggetti
che incontrer… al torneo.

Strategia
=========

La strategia non e' particolarmente complicata, anzi, Š persino pi— ridotta
di quella del suo predecessore da 300 VB:
All'inizio del match cerca un angolo libero e lo raggiunge.
Inizia quindi ad oscillare in orizzontale in verticale o diagonale:

1- se ha un nemico nell'angolo seguente lo attacca, muovendosi di circa 250
unit… nella sua direzione, altrimenti....
2- se ha un nemico nell'angolo precedente lo attacca con lo stesso sistema visto
prima.
3- ogni oscillazione parallela agli assi Š seguita da una lungo bisettrice del
quadrante. In questa situazione l'ampiezza del percorso di riduce a circa 100
unit….

Il ciclo continua fino a quando:

A- Subisce pi— dell'8% di danni................ si guarda, a questo punto,
intorno e cerca di cambiare angolo;
B- Ogni 11 (19 la prima volta) oscillazioni conta i nemici: se ne Š rimasto solo
uno parte con l' attacco finale. La routine non Š particolarmente brillante nŠ
innovativa (Š pari pari quella di Caccola toxicizzata) ma pare che, contro una
particolare categoria di nemici (fino al 1999) faccia un ottimo lavoro.

Note Tecniche
=============

Tecnicamente Raistlin e', credo, la cosa pi— incasinata che mente umana abbia
potuto concepire.
Dal momento che 500 istruzioni sono comunque poche, per farci entrare un crobot
che Š pi— o meno la fotocopia di Son-Gohan (eccezion fatta per il rendimento, che
Š notevolmente cresciuto) mi sono dovuto lanciare in voli pindarici non indifferenti.
Prova ne sia il fatto che, nonostante l'abbia scritto, a distanza di 7 mesi dal suo
comletamento non capisco piu' molto bene come funzioni.

Tra le novit… (o per lo meno presunte tali) introdotte segnalo:
===============================================================
        - il conto degli avversari che impiega una sola variabile per aggiornare
l'angolo di scansione e per annotare il numero dei superstiti (e non vi dico
quanto ci ho dovuto picchiare sopra per farle fare i conti correttamente);

        - la toxica, molto rivisitata che ingloba le funzioni di una routine di
puntamento precisa, quelle di un puntamento approssimato e quelle di routine
veloce per i rallentamenti;

        - sempre a proposito di routine di fuoco, nuovo Š il blocco di sei scan
che affinano il puntamento: non solo ora non ha pi— bisogno di una previa
riduzione dell'angolo da 10 a 5 gradi, ma restituisce in uscita la distanza
del nemico, permettendo un puntamento pi— preciso e una riduzione dell'ingombro
del codice;

        - il sistema per il calcolo della direzione in cui oscillare: Š la routine
pi— corta che sono riuscito a trovare, e mi pare che svolga egregiamente il suo
lavoro;

        - Il metodo di ricerca di un angolo libero: deriva da quello utilizzato
in Caccola.r, ma Š stato ulteriormente affinato per ridurre ai minimi termini
l'occupazione di codice.

-----------------------------------------------------------------------------
(*)Tutti i nomi di luoghi e personaggi qui riportati, nonchŠ ogni riferimento
al ciclo di DragonLance(TM) appartengono ai loro proprietari.
-----------------------------------------------------------------------------
*/

int timmax, ang, dx, dy;
int dan, park, a, oang, r, or;
int h, mi, mx, my, nx, ny, ampiezza, flag, flag1;
int max, clock;

main()                             
{

  dy=980-(loc_x(dx=(loc_y()>500)*960+20)>500)*960;

  while (Stop())
      {

         if (dan<=damage())
           while ((scan(10+(ang=(loc_x(park=dx)>(dx=1000-dy))*180+atan((((dy=park)-loc_y())*100000)/(dx-loc_x()))),10)+scan(350+ang,10))>400);

         drive (ang,100);
         while ((Dista(dx,dy)>4500)&&(speed()))
              if (h>6500) PallaDiFuoco(h<25000);

         if (dan=(flag1<387))
           {
             if ((timmax+=Stop(dan=damage()+(flag1=8)))%19);
             else
               {
                 while ((flag1+=20)<383) flag1-=(scan(flag1,10)>0);
               }

             ang=180*(dy>500)+90*(dx!=dy);
             if (clock=46000-clock)
               ang+=45;
             else
               if (scan(ang,10));else ang+=90;
      
             while ((Dista(dx,dy)<57000-clock))
                  PallaDiFuoco();
           }

      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Stop()
{
         PallaDiFuoco(PallaDiFuoco(drive(ang+=180,0)));
}

PallaDiFuoco(meglio)
int meglio;
{
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<850)
        {
          if (r=Rivela())                
             return cannon((oang+(a-oang)*3-(sin(a-ang)/19500)),(r*200/(200+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<850));
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang,10))) a=ang;
        else
          return (a+=40);
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
