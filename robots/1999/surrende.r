/******************************************************************************
*  CRobot SURRENDER.R
*  Creato nel Novembre 1999 per il Torneo del Millennio
*
*  Massimo Paradisi
*
*
*  Il Robot si posiziona in un angolo libero, e muovendosi orizzon-
*  talmente da sinistra a destra in un breve spazio, esegue una ricerca
*  verso eventuali avversari, sparando se si trovano a distanza utile.
*  Se il danno subito e' oltre il 50%, si sposta in un angolo in cui
*  non c'e' nessun nemico, continuando ad eseguire sempre un movimento
*  rapido in uno spazio ristretto.
******************************************************************************/

int deg;           /* gradi dove fa lo scan*/
int range;         /* distanza del target */
int dir;           /* direzione su cui si muove il robot*/
int quadrante;     /* quadrante senza nemici */
int dx;            /* indica il margine sx oltre il quale non deve oscillare*/
int sx;            /* indica il margine dx oltre il quale non deve oscillare*/
int flag;          /* un flag */
int quad;          /* quadrante in cui andare */
int x,y;           /* coordinate del robot */
main()

{

pos_ang();

    flag=1;
    while (1)
    {
        /* vai verso sinistra e spara*/
        dir = 180;
        while (loc_x() > 120) shoot();
        if( damage()>50 && flag) pos_ang();
        /* vai verso destra e spara*/
        dir = 0;
        while (loc_x() < 121) shoot();
        if( damage()>50 && flag) pos_ang();
    }
}



shoot()
{
/* il comando di direzione viene impartito ad ogni ciclo di sparo*/
drive(dir, 100);

/* cerca il nemico nell'angolo memorizzato in 'deg'
   se lo trova tenta di affinare il tiro cercandolo nei dintorni (+-7),
   quindi spara.*/
if (range=scan(deg,10))
    {
    cannon(deg,range);
    shoot2();
    }
else
{
if (range=scan(deg+10,10))
    {
    cannon(deg+=10,range);
    cannon(deg,range);
    shoot2();
    }
    else
    {
    if (range=scan(deg-20,10))
        {
        cannon(deg-=20,range);
        cannon(deg,range);
        shoot2();
        }
        else deg+=30;
    }
}

}

shoot2()
{
    if (range=scan(deg+355,5))
        {
        cannon(deg+=355,range);
        cannon(deg,range);
        }
    else
        if (range=scan(deg+5,5))
        {
            cannon(deg+=5,range);
            cannon(deg,range);
        }
}

pos_ang()
{
    flag=0;
    quad=cerca_angolo();
    vai();
}

/* controlla qual'e l'angolo senza nemici*/
cerca_angolo()
{
    x=loc_x();
    y=loc_y();

    if(quad!=2)
    {
    deg=180-atan((1000-y)/(x));
    if(range=scan(deg-5,10)) cannon(deg,range);
    else if(range=scan(deg+5,10)) cannon(deg,range);
    else return 2;
    }

    if(quad!=3)
    {
    deg=180+atan(y/x);
    if(range=scan(deg-5,10)) cannon(deg,range);
    else if(range=scan(deg+5,10)) cannon(deg,range);
    else return 3;
    }
    if(quad!=1)
    {
    deg=atan((1000-y)/(1000-x));
    if(range=scan(deg-5,10)) cannon(deg,range);
    else if(range=scan(deg+5,10)) cannon(deg,range);
    else return 1;
    }
    return 4;
}

/* Posiziona il robot nel quadrante indicato da QUAD */
vai()
    {
    /* la direzione Š calcolata in base al quadrante dove si trova*/
    dir = 90+180*(quad==3 || quad==4);
    if(dir==90)
        while(loc_y() <900) shoot();
    else
        {
        while(loc_y() >100) shoot();
        }
    }

