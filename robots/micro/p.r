/******************************************************************************
  CRobot DEFENDER.R

  Creato nel Novembre 1999 per il Torneo del Millennio

  *********Potendo partecipare un solo Robot preferisco questo **********

        DEFENDER - Manowar

        Orson Wells

        "WHEN YOU ARE OLD ENAUGH"
        "TO READ THIS WORDS"
        "THEIR MEANINGS WILL UNFOLD"

        "THIS WORDS ARE ALL THAT LEFT"
        "AND THOUGH WE'VE NEVER MET, MY ONLY SON"
        "I HOPE YOU KNOW"


  Massimo Paradisi


  Il Robot si posiziona nell'angolo pi— vicino e si muove rapidamente in
  oscillazione orizzontale.
  Ogni 1500 cicli circa, fa uno scan per vedere quanti nemici sono rimasti.
  Se ne Š rimasto solo uno, attacca disegnando un quadrilatero casuale (routine
  di kill!) in base alla posizione che ha al momento dirigendosi per 45ø, 135ø, 225ø 315ø,
  sparando con la routine di goblin in movimento.
*****************************************************************************/
int deg,odeg,deg2     ;      /* gradi dove fa lo scan*/
int range2,range,orange       ;  /* distanza del target */
int dir;           /* direzione su cui si muove il robot*/
int corr;
main()
{
deg=0;
deg2=175;
    /*
    "THAT I WOULD HAVE BEEN THERE"
    "TO WATCH YOU GROW           "
    "BUT MY CALLS WAS HEARD      "
    "AND I DID GO                "
    "NOW YOUR MISSION            "
    "LIES AHEAD OF YOU           "
    "AS IT DID MINE              "
    "SO LONG AGO                 "
    "TO HELP THE HELPLESS ONES   "
    "WHO ALL LOOK UP TO YOU      "
    "AND TO DEFEND THEM          "
    "SO THE END                  "
    */

    /*
    il robot si muove oscillando eseguendo in continuazione la routine
    di fuoco
    Se Š rimasto un solo nemico, lancia la fase ONLYONE
    */

    if(loc_x()>500) {while(loc_x()<900){dir=0;shoot();} corr=799;}
    else            while(loc_x()>100){dir=180;shoot();}
    drive(0,0);

    if(loc_y()>500) while(loc_y()<900) {dir=90;shoot();}
    else            while(loc_y()>100) {dir=270;shoot();}

    drive(0,0);

    deg=1;
    while (1)
    {

        /* vai verso sinistra e spara*/
        dir = 180;
        while (loc_x() > 100+corr) shoot();
        drive(dir,0);

        /* vai verso destra e spara*/
        dir = 0;
        while (loc_x() < 101+corr) shoot();
        drive(dir,0);

    }
}


/* scanna per due giri l'arena per verificare quanti nemici ci sono
   ritorna 1, se c'e' un solo nemico */

shoot()
{
    /*
    DEFENDER
    RIDE LIKE THE WING
    FIGHT PROUD MY SON
    YOU'RE THE DEFENDER
    GOD HAS SENT
    */

    drive(dir,100);
    if ((range=scan(deg,10)))
        {
        if(range>800) range=800;
        cannon(deg,range);
        }
        else deg+=10;
    if ((range2=scan(deg2,10)))
        {
        if(range2>800) range2=800;
        cannon(deg2,range2);
        }
        else deg2+=10;
}

