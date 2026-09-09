/*


        HalMan ver.1.0 del 10-giu-2002


        (C) Copyright Marco Borsari


Caratteristiche:
        HalMan e` un'evoluzione di Hal9000'99 (v.6.07) generata dal
        Monolito su Giove interfacciando gli schemi di Dave Bowman 
e
        di Hal in una simulazione semi-indipendente, data la 
fondamentale
        incompatibilita` di tutti questi elementi il risultato finale e`
        piuttosto scarso. Le modifiche rispetto all'originale sono:
        - durante la fase iniziale e di medio gioco se attaccato si 
muove
        comunque dal proprio angolo sfruttando se necessario le 
diagonali
        del campo di battaglia;
        - la routine di attacco finale consiste semplicemente 
nell'oscillare
        verticalmente lungo uno dei lati;
        - la funzione di fuoco e` stata riportata all'iniziale Tox-based
        con l'aggiunta di un controllo per i bersagli lontani e una
        correzione lungo la direzione di spostamento presa da Leader.


*/


int ang,        /* Angolo di scanning                                   */
    oang,       /* Angolo di scanning precedente                        */
    range,      /* Gittata corrente                                     */
    orange,     /* Gittata precedente                                   */
    spd,        /* 1 se in movimento, 0 altrimenti                      */
    flag,       /* Attendi negli angoli se uguale a 1                   */
    dam,        /* Variabile temporanea salva danni subiti              */
    dir,        /* Direzione del cammino                                */
    pos,        /* Variabile temporanea a due bit salva posizione       */
    maxcount;   /* Massimo numero di cicli virtuali                     */


main() /* Inizializza alcune variabili ed innesca la routine 
principale      */
{
        spd=1;
        ang=flag=0;
        maxcount=650;
        defence();
}


up() /* Direzione nord (90 gradi) */
{
        drive(dir=90,100);
        while(loc_y() < 750) fire();
        drive(dir,50); /* Si avvicina il piu` possibile ai bordi */
        while(loc_y() < 875) fire();
        stop();


}


down() /* Direzione sud (270 gradi) */
{
        drive(dir=270,100);
        while(loc_y() > 250) fire();
        drive(dir,50);
        while(loc_y() > 125) fire();
        stop();
}


left() /* Direzione ovest (180 gradi) */
{
        drive(dir=180,100);
        while(loc_x() > 250) fire();
        drive(dir,50);
        while(loc_x() > 125) fire();
        stop();
}


right() /* Direzione est (0 gradi) */
{
        drive(dir=0,100);
        while(loc_x() < 750) fire();
        drive(dir,50);
        while(loc_x() < 875) fire();
        stop();
}


escape()
{
        if (pos < 2) {
                drive(dir=45+(90*pos),100);
                while (loc_y() < 400) fire();
        } else {
                drive(dir=495-(90*pos),100);
                while (loc_y() > 600) fire();
        }
        flag=0;
        if (!radar(dir+=90)) stop(); /* controlla a sinistra       */
        else if (!radar(dir+=180)) stop(); /* controlla a destra   */
        else dir+=90; /* avanti senza paura                        */
        drive(dir,100);
        while (((loc_x() % 850) > 150) && ((loc_y() % 850) > 150))
                fire();
        flag=1;
        stop();
}


defence() /* Routine base di difesa, attiva per circa 150mila 
cicli/CPU       */
{
        if (loc_x() > 500) right();
        else left();
        flag=1;
        if (loc_y() > 500) up();
        else down();
        while (1)
        {
                if (!maxcount) { /* Controllo cicli/CPU trascorsi       */
                        flag=0;
                        if (damage() > 80) {
                                spd=0;
                                fire();
                        } else {
                                wave();
                        }
                } else if (pos == 0) /* (0,0) */
                {
                        if (!radar(90)) {
                                up();
                        } else if (!radar(0)) {
                                right();
                        } else {
                                escape();
                        }
                } else if (pos == 1) /* (1000,0) */
                {
                        if (!radar(180)) {
                                left();
                        } else if (!radar(90)) {
                                up();           
                        } else {
                                escape();
                        }
                } else if (pos == 2) /* (0,1000) */
                {
                        if (!radar(0)) {
                                right();
                        } else if (!radar(270)) {
                                down();
                        } else {
                                escape();
                        }
                }  else /* if (pos == 3)  (1000,1000) */
                {
                        if (!radar(270)) {
                                down();
                        } else if (!radar(180)) {
                                left();
                        } else {
                                escape();
                        }
                }
        }
}


/* Funzione finale, movimento oscillatorio                              */


wave()
{
        if (loc_y() < 500) up();
        else down();
}


track()
{
  if(scan(ang+355,1)) ang+=355;
  if(scan(ang+5,1)) ang+=5;
  if(scan(ang+357,1)) ang+=357;
  if(scan(ang+3,1)) ang+=3;
  if(scan(ang+359,1)) ang+=359;
  if(scan(ang+1,1)) ang+=1;
}    


find()
{
  if(scan(ang+=350,10));
  else if(scan(ang+=20,10));
       else while(!scan(ang+=15,10));
}


fire()
int ver;
{
  if((ver=radar(dir)) && (spd))
    {
      ang=dir+(360+10*ver);
      if(scan(ang+353,3)) ang+=353;
      if(scan(ang+7,3)) ang+=7;
      range=scan(ang,10);
      return cannon(ang,range+(range-orange)*range/275);
    }
  if((orange=scan(ang,5))<850)
    {
      track();
      if(orange=scan(ang,5))
        {
          oang=ang;
          if(orange<200) return cannon(oang,orange);
          track();
          if(range=scan(ang,10))
            while(!cannon(ang+(ang-oang)*((1200+range)>>9)-
spd*(sin(ang-dir)>>14),
              range*(165-spd*5)/(165-spd*5+orange-range-spd*(cos(ang-
dir)>>12))));
          else find();
        }
      else find();
    }
  else find(ang+=25);
}


radar(x) /* Restituisce 0 se la direzione x e` libera da nemici         */
int x;
{
        if(orange=scan(x+350,10)) return -1;
        else if(orange=scan(x+10,10)) return 1;
        else return orange;
}


stop()          /*  Fermati!                                            */
{
        drive(dir,0);
        while (speed() > 49) fire();
        pos = (loc_x() > 500) + 2*(loc_y() > 500) ;
        if (flag) { /* Se 1 rimane immobile                             */
                dam=damage();
                spd=0;
                while ((orange<150 || orange>450) && 
(damage()<dam+10) &&
                --maxcount)
                        fire();
                spd=1;
        } 
}