/*


        Torneo macro 2010


        Buffy robot ver.1.4 del 06-ott-2008
        Assemblato da Marco Borsari (con l'aiuto di Willow),
        in caso di malfunzionamenti siete nelle vostre sole mani.


Caratteristiche:
        Buffy e` una evoluzione della struttura base di Hal9000'99
        (v.6.07) scritto in C, il cui sviluppo e` stato portato avanti
        parallelamente in ambiente Pascal. A causa di questo tortuoso
        passaggio il risultato finale e` un po' instabile, questo
        simulacro e` infatti convinto che sentenziare battute sceme
        tipo "Tanto va la gatta all'aglio che ci lascia il vampiro"
        serva a disorientare i suoi avversari. Le modifiche rispetto
        all'originale sono:
        - durante la fase iniziale e di medio gioco se attaccato si
        muove comunque dal proprio angolo sfruttando se necessario le
        diagonali del campo di battaglia;
        - la routine di attacco finale usa come modello quella de
        ilBestio, cercando di variare molto angolo e distanza;
        - la funzione di fuoco e` la Toxic, con l'aggiunta dei
        controlli per i bersagli efficaci e, nel rilevamento, una
        maggiore rapidita` unita a una esecuzione costante usata
        durante il movimento.


*/


int ang,       /* Angolo di scanning                   */
    orange,    /* Gittata precedente                   */
    spd,       /* 1 se in movimento, 0 altrimenti      */
    flag,      /* Attendi negli angoli se uguale a 0   */
    dir,       /* Direzione del cammino                */
    pos,       /* Variabile temporanea salva posizione */
    maxcount;  /* Massimo numero di cicli virtuali     */


main() /* Inizializza alcune variabili ed innesca la routine principale */
{
        ang=0;
        spd=flag=1;
        maxcount=650;
        defence();
}


run(x) /* Si sposta nella direzione x, parallela ai lati dell'arena */
int x;
{
        drive(dir=x,100);
        if (dir==90) while(loc_y() < 850) fire();
        else if (dir == 270) while(loc_y() > 150) fire();
        else if (dir == 180) while(loc_x() > 150) fire();
        else while(loc_x() < 850) fire();
        stop();
}


pole()
{
        if (pos < 2) {
                drive(dir=45+90*pos,100);
                while (loc_y() < 450) fire();
        } else {
                drive(dir=495-90*pos,100);
                while (loc_y() > 550) fire();
        }
}


escape()
{
        pole();
        flag=1;
        if (!radar(dir+=90)) stop(); /* Controlla a sinistra     */
        else if (!radar(dir+=180)) stop(); /* Controlla a destra */
        else dir+=90; /* Avanti senza paura                      */
        drive(dir,100);
        while (((loc_x() % 850) > 150) && ((loc_y() % 850) > 150))
                fire();
        flag=0;
        stop();
}


stop() /* Fermati! */
{
int dam,  /* Variabile temporanea salva danni subiti */
zrange;   /* Gittata di allontanamento               */

        if (speed()) { /* Se non ha colliso */
                drive(dir,40*flag);
                while (speed() >= 50) fire();
        }
        pos = (loc_x() > 500) + 2*(loc_y() > 500);
        if (!flag) { /* Se 0 rimane immobile */
                dam = damage();
                zrange = spd = 0;
                while ((!orange || orange > 400 || orange >= zrange) &&
                  damage() < dam + 10 && --maxcount) {
                        zrange = orange;
                        fire();
                }
                spd = 1;
        } 
}


radar(x) /* Restituisce 0 se la direzione x e` libera da nemici */
int x;
{
        return(scan(x+350,10) || scan(x+10,10));
}


look(x,y) /* Guarda dove spostarsi */
int x,y;
{
        if (!radar(x))
                run(x);
        else if (!radar(y))
                run(y);
        else
                escape();
}


defence() /* Routine base di difesa, attiva per circa 150mila cicli/CPU */
{
        if (loc_x() > 500) run(0);
        else run(180);
        flag=0;
        if (loc_y() > 500) run(90);
        else run(270);
        while (1)
        {
                if (!maxcount) /* Controllo cicli/CPU trascorsi */
                {
                        if (damage() > 80) {
                                spd=0;
                                fire();
                        } else {
                                flag=1;
                                attack();
                        }
                } else if (pos == 0) /* (0,0) */
                        look(90,0);
                else if (pos == 1) /* (999,0) */
                        look(180,90);
                else if (pos == 2) /* (0,999) */
                        look(0,270);
                else /* if (pos == 3)  (999,999) */
                        look(270,180);
        }
}


/* Routine di attacco finale, movimento calcolato rispetto al nemico */


wall()
{
  dir %= 360;
  if ((loc_x() < 300 && dir > 90 && dir < 270) ||
    (loc_x() > 700 && (dir < 90 || dir > 270)) ||
    (loc_y() < 300 && dir > 180 && dir < 360) ||
    (loc_y() > 700 && dir > 0 && dir < 180)) return 1;
  else return 0;
}


attack()
{
int twist,  /* Conta il tempo per il cambio di direzione      */
crunch,     /* Se 1 rimbalza rispetto al muro                 */
bang,       /* Controlla la variazione dell'angolo di attacco */
clock;      /* Alterna 0 e 1, per variare l'angolo            */

  pole();
  clock = 0;
  while (1) {
    twist = 3;
    while (--twist) {
      bang = ang;
      fire();
      if (twist == 1  || (crunch = wall()) || ang == bang) {
        stop();
        if (crunch) dir += 165;
        else dir = ang + 135 + 90 * (clock ^= 1);
        twist = 1;
      }
    }
    drive(dir,100);
  }
}


/* Funzione di fuoco, con interpolazione del bersaglio */


track()
{
  if(scan(ang+355,2)) ang+=355;
  if(scan(ang+5,2)) ang+=5;
  if(scan(ang+357,1)) ang+=357;
  if(scan(ang+3,1)) ang+=3;
  if(scan(ang+359,0)) ang+=359;
  if(scan(ang+1,0)) ang+=1;
}


find(x)
int x;
{
  ang+=x;
  if (scan(ang,10));
  else if (scan(ang+=340,10));
  else if (scan(ang+=40,10));
  else if (spd) ang+=40;
  else while(!scan(ang+=15,10));
}


fire()
{
int oang,  /* Angolo di scanning precedente */
range;     /* Gittata corrente              */

  if((orange=scan(ang,10)) && orange<800)
    {
      if(orange<150)
        return cannon(ang,orange);
      if(scan(ang+=355,5));
      else ang+=10;
      track();
      if(orange=scan(ang,5))
        {
          oang=ang;
          track();
          if(range=scan(ang,10))
            while(!cannon(ang+(ang-oang)*((1200+range)>>9)-spd*(sin(ang-dir)>>14),
              range*(165-spd*5)/(165-spd*5+orange-range-spd*(cos(ang-dir)>>12))));
          else find(0);
        }
      else find(0);
    }
  else find(orange/20);
}
