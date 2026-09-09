/******************************************************************************
*  CRobot MAXHEAV.R
*  Creato nel Settembre 1998 per il Torneo di MC
*
*  Massimo Paradisi
*
*
*  Il Robot si posiziona nell'angolo in basso a destra e, muovendosi orizzon-
*  talmente da sinistra a destra nello spazio di 100 unit…, esegue una ricerca
*  verso eventuali avversari, sparando se si trovano a distanza utile.
*  Se il danno subito e' oltre il 50%, si sposta in un angolo in cui
*  non c'e' nessun nemico, continuando ad eseguire sempre un movimento
*  rapido nello spazio di 100 unita'.
******************************************************************************/

int deg;                /* gradi dove fa lo scan*/
int range;              /* distanza del target */
int dir;                /* direzione su cui si muove il robot*/

main()

{
    /* inizializza l'angolo sul quale effettuera' lo scan */
    deg=0;

    /* si muove verso il basso fino al bordo, quindi verso l'angolo destro
       per iniziare la FASE 1 di combattimento*/
    dir = 270;
    while(loc_y() > 150) shoot();
    dir = 0;
    while(loc_x() < 900) shoot();

    /*************** FASE 1 ************
     il robot si muove tra 750 ed 850 unita'
     eseguendo ad ogni ciclo la routine di fuoco.
     Quando il danno subito supera il 50% inizia la FASE2
     lanciando la routine fase2()             */

    while (1)
    {
    /* vai verso sinistra e spara*/
    dir = 180;
    while (loc_x() > 750) shoot();
    if( damage()>50) fase2();
    /* vai verso destra e spara*/
    dir = 0;
    while (loc_x() < 850) shoot();
    if( damage()>50) fase2();
    }
}
fase2()
/**************FASE 2***********
 in questa fase cerca un angolo del campo di gioco dove non vede nessun avversario,
 vi si dirige e prosegue con la stessa strategia di tiro che utilizzava
 prima*/

{
if(scan(180,10)==0)   /*se non trova il nemico in basso a sinistra ci va'*/
    {
    dir=180;
    while(loc_x()>150) shoot();
    while(1)
        {
        dir = 90;
        while (loc_y() < 250) shoot();
        dir = 270;
        while (loc_y() > 150) shoot();
        }
    }
else
    {
    if(scan(135,10)==0) /*se non trova il nemico in alto a sinistra ci va'*/
        {
        dir=135;
        while((loc_x()>150) && (loc_y()<850)) shoot();
        while(1)
            {
            dir = 180;
            while (loc_x() > 150) shoot();
            dir = 0;
            while (loc_x() < 250) shoot();
            }
        }
    else
            /*se ha trovato i precedenti angoli occupati va comunque in alto a destra*/
            {
            dir=90;
            while((loc_y()<850)) shoot();
            while(1)
                {
                dir = 180;
                while (loc_x() > 750) shoot();
                dir = 0;
                while (loc_x() < 850) shoot();
                }
            }
    }
}

shoot()
{
/* il comando di direzione viene impartito ad ogni ciclo di sparo*/
drive(dir, 100);

/* cerca il nemico nell'angolo memorizzato in 'deg'
   se lo trova tenta di affinare il tiro cercandolo nei dintorni (+-7),
   quindi spara.*/

if ( (range=scan(deg,10)) && (range<770) )
    {
    if (range=scan(deg+353,3))
        cannon(deg+=353,range);
    else
        if (range=scan(deg,3))
            cannon(deg,range);
        else
            if (range=scan(deg+7,3))
                cannon(deg+=7,range);
    }
else
/* cerca il nemico in un angolo di 42 gradi piu' elevato di quell'altro*/
    {
    if ((range=scan(deg+21,10))&&(range<700))
        {
        deg+=21;
        cannon(deg,range);
        }
    else
        {
        if ((range=scan(deg+42,10))&&(range<700))
            deg+=42;
        else
            deg+=63;
        }
    }
}                         



