/******************************************************************************

    CROBOT:    AERIS - 28/11/1999

    AUTORE:    Marco Giovannini

*******************************************************************************

  E' dura la vita per una matricola: con un solo mese di tempo a disposizione
  e' difficile imparare ad usare CRobots e creare un robot competitivo. Quindi
  e' molto, ma molto meglio copiare quelli gia' fatti e vedere cosa succede.
  AERIS e' un robot standard, ma se volete proprio vedere come funziona eccovi
  la sua scheda tecnica:

  SCHEDA TECNICA:
      Come tutti, AERIS cerca di sopravvivere alle prime concitate fasi della
      battaglia nascondendosi nell'angolo piu' vicino. Qui compie un movimento
      triangolare sparando a tutto cio' che vede nel raggio del cannone con
      due routines di fuoco: una e' quella classica di tox.r, l'altra invece
      e' quella classica dei bambini (!) che viene richiamata durante la fase
      di rallentamento del robot.
      Chiaramente non si puo' continuare cosi' per sempre: il loop viene
      interrotto se viene superata una soglia critica di danni (nel qual caso
      si cambia quadrante) oppure non si colpisce nessuno per 16 volte
      consecutive.
      In quest'ultimo caso, se e' rimasto un solo altro robot in campo, viene
      attivata la routine di attacco finale kamikaze() attinta a piene mani da
      goblin.r, in cui si corre sulle diagonali sparando a vista. Questa
      routine viene richiamata anche nel caso in cui passati circa 150000
      cicli virtuali di clock non c'e' ancora stato un vincitore.

  La cosa bella di questo robot e' che, viste le efficienze degli altri
  partecipanti al torneo, non avra' speranza di passare almeno il primo
  girone: visto che si comporta come goblin.r, gli farete un mazzo tanto...
  Che dire allora? Uno ci prova!!
*/

int xx, yy;                                          /* variabili temporanee */

int time;                         /* contatore per i cicli virtuali di clock */
int quad;                              /* quadrante in cui si trova il robot */
int max_dam;               /* massimo danno sopportabile prima di andare via */
int counter;                  /* da quanto tempo e' che non si vede nessuno? */

int t_alfa;                                          /* variabile temporanea */
int m_alfa;                                           /* angolo di movimento */
int x_alfa, y_alfa, h_alfa;              /* orrizzontale, verticale, obliquo */

int c_alfa, c_rng;                            /* angolo del cannone e raggio */
int o_alfa, o_rng;                    /* old angolo del cannone e old raggio */


main()
{
    /* rileva in quale quadrante si trova: 0 se in basso a sinistra, 1 in
    basso a destra, 2 in alto a destra, 3 in alto a sinistra */
    quad = (xx = (loc_x() > 500)) + (yy = (loc_y() > 500)) + ((!xx && yy) * 2);

    wait();

    kamikaze();
}


init_loop()
{
    /* spostati nell'angolo del quadrante corrente */
    if (quad == 0 || quad == 3) { x_alfa = 0; while (loc_x() > 100) go(180); }
        else { x_alfa = 180; while (loc_x() < 900) go(0); }
    stop();
    if (quad >= 2) { y_alfa = 90; while (loc_y() < 900) go(90); }
        else { y_alfa = 270; while (loc_y() > 100) go(270); }
    stop();

    h_alfa = 495 - 90*quad;
    max_dam = damage() + 20;
}


wait()
{
    init_loop();
    while (counter < 16) {
        while (damage() < max_dam && counter < 16) {
            /* movimento in orrizzontale */
            while (loc_x() < 150 || loc_x() > 850) go(x_alfa); stop();
            /* in obliquo */
            while (loc_x() > 100 && loc_x() < 900) go(h_alfa); stop();
            /* in verticale */
            while (loc_y() > 100 && loc_y() < 900) go(y_alfa); stop();

            if (++time > 80)            /* se ti sei stufato di aspettare... */
                if (damage() < 80) kamikaze(); else time = 0;
        }

        if (counter >= 16) {                   /* se non hai trovato nessuno */
            int t;                    /* controlla che non siate solo in due */
            c_alfa = -10;
            while (c_alfa < 710) if (scan(c_alfa += 20, 10)) ++t;
            if (t > 2) counter = 0;          /* senno' continua ad aspettare */
        } else {                              /* altrimenti cambia quadrante */
            t_alfa = quad*90;      /* controlla che non ci sia gia' qualcuno */
            if (scan(t_alfa + 350, 10) || scan(t_alfa + 10, 10)) {
                if (!(scan(t_alfa + 80, 10) || scan(t_alfa + 100, 10)))
                    { quad = (quad + 3) % 4; init_loop(); }  /* quello prima */
            } else { quad = (quad + 1) % 4; init_loop(); }    /* quello dopo */
        }
    }
}


kamikaze()
{
    m_alfa = 45 + quad*90;                      /* direzione della diagonale */
    while (1) {
        while (loc_x() < 450 || loc_x() > 550) go(m_alfa); stop(); /* centro */
        drive(m_alfa += 180, 100);

        if (scan(m_alfa + 350, 10) || scan(m_alfa + 10, 10)) {
            if (scan(m_alfa + 80, 10) || scan(m_alfa + 100, 10)) m_alfa += 270;
                else m_alfa += 90;
            stop();
        }

        while (loc_x() < 850 && loc_x() > 150 &&
               loc_y() < 850 && loc_y() > 150) go(m_alfa); stop();
        m_alfa += 180;
    }
}


go(dir)
{
    drive(m_alfa = dir, 100);
    if (o_rng = scan(c_alfa, 10)) {
        if (o_rng > 700) { c_alfa += 40; ++counter; return; }  /* e' lontano */

        if (scan(c_alfa + 355, 1)) c_alfa += 355;
        if (scan(c_alfa + 5,   1)) c_alfa += 5;
        if (scan(c_alfa + 357, 1)) c_alfa += 357;
        if (scan(c_alfa + 3,   1)) c_alfa += 3;
        if (scan(c_alfa + 359, 1)) c_alfa += 359;
        if (scan(c_alfa + 1,   1)) c_alfa += 1;

        if (o_rng = scan(o_alfa = c_alfa, 10)) {
            if (scan(c_alfa + 355, 1)) c_alfa += 355;
            if (scan(c_alfa + 5,   1)) c_alfa += 5;
            if (scan(c_alfa + 357, 1)) c_alfa += 357;
            if (scan(c_alfa + 3,   1)) c_alfa += 3;
            if (scan(c_alfa + 359, 1)) c_alfa += 359;
            if (scan(c_alfa + 1,   1)) c_alfa += 1;

            if (c_rng = scan(c_alfa, 10)) {
  cannon( c_alfa+(c_alfa-o_alfa)*((1200+c_rng)>>9)-(sin(c_alfa-m_alfa)>>14),
          (c_rng*160)/(160+o_rng-c_rng-(cos(c_alfa-m_alfa)>>12)) );
                counter = 0;
                return;
            }
        }
    }
    hunt();                           /* non c'e' nessuno? cerca li' intorno */
}


stop()
{
    drive(m_alfa, 0);
    while (speed() > 40) {
        if (c_rng = scan(c_alfa, 10)) {
            if (c_rng > 700) { c_alfa += 40; ++counter; }
            else {
                if (o_rng = scan(c_alfa += 5, 5)) cannon(c_alfa, o_rng);
                    else cannon(c_alfa += 350, c_rng);
                counter = 0;
            }
        } else hunt();
    }
}


hunt()
{
    if (scan(c_alfa += 340, 10)) return;                  /* guarda a destra */
    if (scan(c_alfa += 40, 10)) return;                 /* guarda a sinistra */
    c_alfa += 40;
}

