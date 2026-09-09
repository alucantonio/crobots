/*
Nome		: Pirla
Autore		: Simone Ascheri

Pirla deve questo suo meraviglioso nome ai primi scambi epistolari che ho
tenuto con il nostro Sommo Direttore del torneo, mega esperto di Linux,
gran lup. mannar., ing. Maurizio Camangi.
Il summenzionato soggetto si e' (piu' o meno) offerto di farmi da guida
nell' intricato mondo dei sistemi Unix.
Dal momento pero' che, dopo 5 giorni da che lo avevo installato, ancora non ero in
grado di modificare a manina le impostazioni di X-server vari, ricompilare
il Kernel o scrivere un driver per i WinModem, il nostro impareggiabile amico
non perdeva occasione di sottolineare come il suo genio andasse sprecato,
apostrofandomi di volta in volta con dei simpatici Caccola e Pirla.
Da qui la decisione di dedicargli questi due microbi.

Tecnicamente Pirla e' una versione evoluta di Caccola:
quindi il casino e' ulteriormente aumentato e il listato e' sempre piu'
incomprensibile.

La strategia non e' particolarmente complicata:
Cerca un angolo libero e lo raggiunge. inizia quindi ad oscillare in
orizzontale, fino a quando:

1 - subisce il 15% di danni................ cambia cosi' angolo
2 - si accorge di avere un unico nemico.... parte con l' attacco finale.

La routine finale non e' un gran che, e quella di fuoco e' assai imprecisa.
In effetti e' abbastanza improprio parlare di routine, perche' il crobot e'
praticamente composto da un unico ciclo, che si ripete fino alla fine della
partita.

Rispetto a Caccola, Pirla introduce due novita' che, pur sembrandomi carine,
non danno i risultati sperati (infatti Pirla e' molto meno efficiente del
fratello):

A- L' oscillazione e' governata da un unico ciclo di while
B- La conta degli avversari non viene effettuata ogni n oscillazioni, bensi'
   prima di ogni sparo: ogni volta ovviamente Pirla esamina solo una porzione
   dell' arena. Quando si accorge che il superstite e' uno solo attacca.
   Per evitare di perdere un avversario a causa dei buchi nella scansione
   dovuti al movimento del robot, l' arena e' scandagliata 2 volte.
*/

int clock, flag3, flag, flag1, flag2;
int dan, park, ango, oang, range, orange;
int mx, my, nx, ny, ang, dx, dy;

main()                             
{
/*Calcola le coordinate degli angoli*/

  dan-=(dy=980-(loc_x(dx=(loc_y()>500)*960+20)>500)*960);

/*Inizia il ciclo, calcolando ogni volta l' angolo di ocilazione e le
  coordinate del punto da raggiungere*/

  while (drive(ang=((dx+=(flag2=-flag2))<loc_x())*180,0))
      {

/*Questa e' la parte peggiore: in una sola riga calcola l' angolo per
  raggiungere le coordinate date, controlla se la zona e' libera, imposta
  altro paio di valori e decide se sta oscillando o attaccando*/

        if (((dan<damage()-15)||(flag3))&&(clock^=1))
             while ((park=dx)&&((scan(10+(ang=(360+((mx=(dx=1000-dy)-loc_x(flag2=200-400*(dx<500)))<0)*180+atan((((dy=park)-loc_y(dan=damage()))*100000)/mx))),10)+scan(350+ang,10))>400));

/*Arriva alla minima distanza di sicurezza da un punto dato, oscilla
  e all' occorrenza effettua l' attacco finale*/

           while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>8200)
                {
                  drive(ang,100);

/*Ogni volta effettua la scansione di 20 gradi dell' arena:
  dopo 360 richiami ha comletato tutto il percorso*/

                  if (flag>10) flag1-=(scan(flag-=20,10)>0);
                  else
                    if (flag1>727) flag3=1;        /*Attiva l' attacco finale*/
                       else flag=flag1=730;

/*Routine di ricerca bersaglio*/

                  if((range=scan(ango,10))&&(range<770)) fire();
                  else
                    if((range=scan(ango+=339,10))) fire();
                    else
                      if((range=scan(ango+=42,10))) fire();
                      else
                        ango+=40;
                }
      }
}


/*Routine di fuoco*/

fire()
{
     cannon (ango+=5+350*(scan(ango+355,5)>0),3*scan(ango,10)-2*range);
}
