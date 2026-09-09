/******************************************************************************
  CRobot DEFENDER.R

  Creato nel Ottobre 2001 per il Torneo di 2K1


--- Squadra vincente non si cambia ----

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
int deg,odeg;      /* gradi dove fa lo scan*/
int range,orange;  /* distanza del target */
int dir;           /* direzione su cui si muove il robot*/
int quad;          /* n. di quadrante in cui sta oscillando */
int cc;            /* contatore di cicli */
int od;            /* memorizza l'ultimo valore di damage()*/
int corr;          /* correttivo usato per l'oscillazione nella parte W o E */
int x,y;           /* memorizzano il valore di loc_x e loc_y */

main()
{
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

    /* 1  cc = circa 120 cicli
       10 cc = circa 1200 cicli
       17 cc = circa 2000 cicli*/

    quad=0;
    pos_ini();
    vai();
    deg=1;
    while (1)
    {
        cc+=1;

        /* vai verso sinistra e spara*/
        dir = 180;
        while (loc_x() > (100+corr)) shoot();
        if(cc==15 && (quad==1 || quad==3))
            {
            /* rallenta prima di eseguire radar() senno cozza con le pareti*/
            drive(dir,0);
            /* se c'e solo un nemico comincia a girare */
            if(radar()) onlyone();
            cc=1;
            }

        /* vai verso destra e spara*/
        dir = 0;
        while (loc_x() < (101+corr)) shoot();

        if(cc==15 && (quad==2 || quad==4) )
            {
            /* rallenta prima di eseguire radar() senno cozza con le pareti*/
            drive(dir,0);
            /* se c'e solo un nemico comincia a girare */
            if(radar()) onlyone();
            cc=1;
            }
    }
}

/* Decide il quadrante pi— vicino in cui posizionarsi*/
pos_ini()
{
x=loc_x();
y=loc_y();
if(y>500 && x>500) quad=1;
else if(y>500 && x<501) quad=2;
else if(y<501 && x<501) quad=3;
else quad=4;
corr=799*(quad==1 || quad==4);
}

/* Posiziona il robot nel quadrante indicato da QUAD */
vai()
    {
    /* la direzione Š calcolata in base al quadrante dove si trova*/
    dir = 90+180*(quad==3 || quad==4);
    if(dir==90)
        while(loc_y() <930) shoot();
    else
        {
        while(loc_y() >070) shoot();
        }
    while(speed()>49) drive(dir,49);
    }

/* scanna per due giri l'arena per verificare quanti nemici ci sono
   ritorna 1, se c'e' un solo nemico */

radar()
{
    int dd,t;
    dd=-10; t=0;
    while((dd+=20)!=710) if (scan(dd,10)) ++t;
    if (t<3) return 1;
    t=0;
    return 0;
}

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
  if( (range=scan(deg,10)) && (range<700) )
    {
          if (scan(deg+353,3)) cannon(deg+=353,(scan(deg,10)<<1)-range);
     else if (scan(deg+7,  3)) cannon(deg+=7,  (scan(deg,10)<<1)-range);
     else if (scan(deg,   10)) cannon(deg,     (scan(deg,10)<<1)-range);
     else shoot2();
    }
   else shoot2();
}
shoot2()
{

   if (range=scan(deg+340,10)) cannon(deg+=340,(scan(deg,10)<<1)-range);
   else if (range=scan(deg+20, 10)) cannon(deg+=20 ,(scan(deg,10)<<1)-range);
   else if (range=scan(deg+320,10)) cannon(deg+=320,(scan(deg,10)<<1)-range);
   else if (range=scan(deg+40, 10)) cannon(deg+=40 ,(scan(deg,10)<<1)-range);
   else if (range=scan(deg+300,10)) cannon(deg+=300,range);
   else if (range=scan(deg+60, 10)) cannon(deg+=60 ,range);
   else deg+=140;
}

onlyone()
{
    /*
    FATHER, FATHER, I LOOK UP TO YOU
    AND HEED THY CALL
    THIS LETTER ENDS MY SEARCH
    I'LL LIVE YOUR DREAM NOW PASSED TO ME
    AND NOW I WAIT TO SHAKE THE HEAD OF FATE
    LIKE THE DAWN AWAITING DUSK

    so wizards cast your spell
    with no heart to do it well
    so it's written it shall be

    DEFENDER
    RIDE LIKE THE WING
    FIGHT PROUD MY SON
    YOU'RE THE DEFENDER
    GOD HAS SENT
    */

   while(1)
   {
       while(loc_y()<850 && quad<=1)
       {
          dir=135;
          fire();
       }
       while(loc_x()>150 && quad<=2)
       {
          dir=225;
          fire();
       }
       while(loc_y()>150 && quad<=3)
       {
          dir=315;
          fire();
       }
       while(loc_x()<850 && quad<=4)
       {
          dir=45;
          fire();
       }
       quad=0;
   }
}

fire()
{
    drive(dir,100);
    if (orange=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (orange>700)
        {
            if (!scan(deg-=3,3)) deg+=6;
            cannon(deg,orange); deg+=40; return;
        }

        if(scan(deg-5,1)) deg-=5;
        if(scan(deg+5,1)) deg+=5;
        if(scan(deg-3,1)) deg-=3;
        if(scan(deg+3,1)) deg+=3;
        if(scan(deg-1,1)) deg-=1;
        if(scan(deg+1,1)) deg+=1;

        if (orange=scan(odeg=deg,5))
        {
            if(scan(deg-5,1)) deg-=5;
            if(scan(deg+5,1)) deg+=5;
            if(scan(deg-3,1)) deg-=3;
            if(scan(deg+3,1)) deg+=3;
            if(scan(deg-1,1)) deg-=1;
            if(scan(deg+1,1)) deg+=1;

            if (range=scan(deg,10))
                cannon(deg+(deg-odeg)*((1200+range)>>9)-(sin(deg-dir)>>14),
                       range*160/(160+orange-range-(cos(deg-dir)>>12)));
        }
     }
     else
     {
        if (scan(deg-=20,10)) return;
        if (scan(deg+=40,10)) return;
        deg+=40; return;
     }
}
