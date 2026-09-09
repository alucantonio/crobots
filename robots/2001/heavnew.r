/****************************************************************************/
/*                                                                          */
/*  CROBOT: HEAVNEW.R                                                       */
/*                                                                          */
/*  AUTORE: Massimo Paradisi                                                */
/*                                                                          */
/****************************************************************************/
/*
                          SCHEDA TECNICA:

1^ fase
    Questa fase serve  per tentare di sporavvivere un po' agli altri tre robot.

    Il Robot va subito al centro del lato sinistro del campo di gioco, e si
    muove rapidamente a destra ed a sinistra per essere un bersaglio difficile.
    Nel frattempo cerca il nemico in maniera approssimata e lo spara.

    Qualora i danni superino il 50% allora lancia la routine che modifichera'
    la strategia del robottino come descritto nella fase successiva.

2^ fase
   Il Robot gira intorno al campo di gioco muovendosi con un andamento
   non rettilineo ma camminando sempre come se disegnasse un'onda triangolare

   Per sparare, cosa che praticamente fa ad ogni ciclo, utilizza una ricerca
   all'angolo precedente, poi al +20, al -40 e quindi al +60 per cercare di
   circoscrivere la zona di presenza dell'avversario.
   Spara prima di fare lo scan e dopo aver ottenuto uno scan positivo.
*/

int direzione,       /*  Direzione di movimento          */
    oangolo,         /*  Angolo di scansione precedente  */
    angolo,          /*  Angolo di scansione attuale     */
    rng,             /*  Range di scansione              */
    distanza,        /*  Distanza del nemico             */
    ndistanza,       /*  Distanza calcolata immediatamente prima dello sparo */
    oldx,            /*  Memorizza l'ascissa del robot per il movimento da dx a sx */
    velocita;        /*  Velocit… del robottino          */

main()
{


    
/*  Inizio della 1^ Fase
    Il robot dirige verso il centro del lato ovest del campo di gioco */

    while (loc_x()<100)
    {
        drive(0,49);
        scanna();
    }
    drive(0,0);
    
    while (loc_x()>190)
    {
        drive(180,100);
        scanna();
    }
    while (speed()>49) drive(180,0);

    while (loc_y()<400)
    {
        drive(90,100);
        scanna();
    }
    while (loc_y()>600)
    {
        drive(270,100);
        scanna();
    }
    while (speed()>49) drive(180,0);

    while (loc_y()<480)
    {
        drive(90,20);
        scanna();
    }
    while (loc_y()>520)
    {
        drive(270,20);
        scanna();
    }
    while (speed()>0) drive(180,0);
    
    oldx=loc_x();       /* memorizzi la posizione attuale delle ascisse */

    while (1)

    /*  Vai a sinistra e a destra sparando */
    
    {
        drive(0,100);                       /* Va a sinistra...      */
        while (loc_x()<oldx+10) scanna();   /* dopo 10 pixel fermati */
        drive(0,0);                         /* Fermati               */
        scanna();                           /* Cerca il nemico       */
        while (speed()>49);                 /* aspetta il momento buono
                                               per il cambio di rotta */

        drive(180,100);                     /* Va a destra...         */
        while (loc_x()>oldx-10) scanna();   /* dopo 10 pixel si ferma */
        drive(180,0);                       /* Fermati                */
        scanna();                           /* Cerca il nemico        */
        while (speed()>49);                 /* aspetta il momento buono
                                               per il cambio di rotta */

        if (damage()>60) altro_tipo();      /* se sei stato danneggiato oltre
                                               1il 50% cambia modalit… di azione
                                               con l'altro tipo di robot
                                               quindi passa alla 2^ fase */
    }
}

    
/* Ricerca il nemico per la prima modalit… di gioco */
scanna()
{
    /* il robot cerca intorno all'angolo precedente
       se trova qualcosa chima la routine di sparo */

    if (distanza=scan(angolo,10)) spara();               /* Ricerca avanti      */
    else
        if (distanza=scan(angolo-=20,10)) spara();       /* Ricerca a destra    */
        else
            if (distanza=scan(angolo+=40,10)) spara();   /* Ricerca a sinistra  */
            else
                angolo+=40;                              /* se non trovi proprio
                                                            niente cambia settore*/
}

/* una volta trovato il nemico con scanna lo spara */
spara()
{
    /*  Cerca un nemico nello stretto intorno */

    if (scan(angolo+5,5)) angolo+=5;
    else
        angolo-=5;
    if (scan(angolo+3,3)) angolo+=3;
    else
         angolo-=3;

    /*  Se il bersaglio Š stato trovato spara */

    if (ndistanza=scan(angolo,10))
    {
        cannon(angolo+(angolo-oangolo),ndistanza+(ndistanza-distanza));
        oangolo=angolo;
    }
    if (distanza>700) angolo+=40;  /* Se il bersaglio Š lontano cambia angolo */

}

/* robot per la 2^ fase */
altro_tipo()
{
    /* routine di piazzamento del robot in un'"orbita" antioraria intorno al
       campo di gioco */
    direzione = 270;
    velocita = 100;
    while(loc_y() > 150) scanna_e_spara();
    direzione = 90;
    scanna_e_spara();
    scanna_e_spara();
    direzione = 180;
    while(loc_x() > 600) scanna_e_spara();
    velocita = 50;
    scanna_e_spara();
    scanna_e_spara();
    direzione = 0;
    while(loc_x() < 750) scanna_e_spara();
    angolo = 90;
    /* appena ha raggiunto la posizione idonea per cominciare a ciclare
       parte un ciclo senza uscita che durera' fino alla fine del match */

            while(1)
            {
            /* In questo ciclo il robottino orbita in senso
               antiorario intorno al campo di gioco con un movimento non
               rettilineo ma /\/\/\/\ .
               La velocit… e direzione viene impostata prima dell'inizio
               di ogni segmento di movimento, e inviata alla macchina
               ogni volta che lancia la routine scanna_e_spara */

            velocita = 100;
            direzione = 45;
            while (loc_x() < 900) scanna_e_spara();
            direzione = 225;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 135;
            while (loc_x() > 750) scanna_e_spara();
            direzione = 315;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 45;
            while (loc_x() < 900) scanna_e_spara();
            direzione = 225;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 135;
            while (loc_y() < 900) scanna_e_spara();
            direzione = 315;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 225;
            while (loc_y() > 750) scanna_e_spara();
            direzione = 45;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 135;
            while (loc_y() < 900) scanna_e_spara();
            direzione = 315;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 225;
            while (loc_x() > 100) scanna_e_spara();
            direzione = 45;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 315;
            while (loc_x() < 250) scanna_e_spara();
            direzione = 135;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 225;
            while (loc_x() > 100) scanna_e_spara();
            direzione = 45;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 315;
            while (loc_y() > 100) scanna_e_spara();
            direzione = 135;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 45;
            while (loc_y() < 250) scanna_e_spara();
            direzione = 225;
            scanna_e_spara();
            scanna_e_spara();
            velocita = 100;
            direzione = 315;
            while (loc_y() > 100) scanna_e_spara();
            direzione = 135;
            scanna_e_spara();
            scanna_e_spara();
            }
}

/* routine di ricerca e spara per la seconda fase */
scanna_e_spara()
{
    /* da la direzione al robot */
    drive(direzione, velocita);

    if (distanza = scan(angolo,10))
    {
        if (distanza > 40) cannon(angolo, distanza);
    }
    else
        {
        angolo += 20;
        if ((distanza = scan(angolo,10)) == 0)
           {
           angolo -= 40;
           if ((distanza = scan(angolo,10)) == 0)
           {
                angolo += 60;
                while ((distanza = scan(angolo,10)) == 0) angolo += 20;
           }
           }
           if (distanza > 40) cannon(angolo, distanza);
        }

}


