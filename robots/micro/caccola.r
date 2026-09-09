/*
Nome		: Caccola
Autore		: Simone Ascheri

Caccola deve questo suo meraviglioso nome ai primi scambi epistolari che ho
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

Tecnicamente Caccola e' un bordello indicibile.
Per riuscire a concentrare in 300 VB tutte le cose che avevo in mente ho
dovuto fare delle porcherie assurde.
Il listato e' quindi incomprensibile.

La strategia non e' particolarmente complicata:
Cerca un angolo libero e lo raggiunge. inizia quindi ad oscillare in
orizzontale, fino a quando:

1 - subisce il 15% di danni................ cambia cosi' angolo
2 - subisce piu' dell' 85% di danni........ sta fermo, cambiando angolo
    ogni volta che subisce danni superiori al 5%
3 - si accorge di avere un unico nemico.... parte con l' attacco finale.

La routine finale non e' un gran che, e quella di fuoco e' assai imprecisa.

*/

int timmax,ang, dx, dy;
int dan, park, ango, oang, range, orange;
int mi, mx, my, nx, ny, ampiezza, flag, flag1;

main()                             
{
/*Calcola le coordinate degli angoli*/

  dan-=(dy=980-(loc_x(dx=(loc_y(mi=15)>500)*960+20)>500)*960);

  while (ang+=180)
      {

/*Ogni 25 oscillazioni conta i superstiti*/

         if (++timmax>25)
              {
               timmax=flag=flag1=10;
               while (flag<370) flag1-=(scan(flag+=20,10)>0);
              }

/*Questa e' la parte peggiore: in una sola riga calcola l' angolo per
  raggiungere le coordinate date, controlla se la zona e' libera, e imposta
  altro paio di valori*/

         if ((dan<damage(drive(ang,0))-mi)||(flag1>8))
            while ((park=dx)&&((scan(10+(ang=(360+((mx=(dx=1000-dy)-loc_x())<0)*180+atan((((dy=park)-loc_y(dan=damage()))*100000)/mx))),10)+scan(350+ang,10))>400));

/*Arriva alla minima distanza di sicurezza da un punto dato... serve
  anche per la parte di ritorno dell' oscillazione e per l' attacco finale*/

         while (((nx=dx-loc_x())*nx+(ny=dy-loc_y())*ny)>7200)
              {
                drive(ang,100);
                Assimilate();
              }

/*Si allontana dal suo angoletto.... solo se i danni subiti sono inferiori
  all' 85%. Altrimenti sta fermo, e cambia di angolo ogni volta che subisce
  un 5% di danni*/

         if (damage(ampiezza=6)<85)
           while (--ampiezza)
                {
                  drive(ang=(dx>500)*180,100);
                  Assimilate();
                }
         else Assimilate(mi=5);
      }
}

Assimilate()
{
  if((range=scan(ango,10))&&(range<770));
  else
    if((range=scan(ango+=339,10)));
    else
      if((range=scan(ango+=42,10)));
      else
        return (ango+=40);
    cannon (ango+=5+350*(scan(ango+355,5)>0),2*scan(ango,10)-range);
}

