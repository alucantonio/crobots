/******************************************************************************
  CRobot DEF2.R

  Creato nel Ottobre 2000 per il Torneo di IOPROGRAMMO

  Massimo Paradisi


  Il Robot si posiziona nell'angolo pi— vicino e si muove rapidamente in
  oscillazione orizzontale e verticale (a L).
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
int corrx,corry;   /* correttivo usato per l'oscillazione nella parte W o E */
int x,y;           /* memorizzano il valore di loc_x e loc_y */

main()
{

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

        if(quad==1)
        {
            while(1)
            {
            cc+=1;
            runalto();
            runsinistra();
            if(cc>15) radar();
            rundestra();
            runbasso();
            }
        }
        else if(quad==2)
        {
            while(1)
            {
            cc+=1;
            runalto();
            rundestra();
            if(cc>15) radar();
            runsinistra();
            runbasso();
            }
        }
        else if(quad==3)
        {
            while(1)
            {
            cc+=1;
            runbasso();
            rundestra();
            runsinistra();
            if(cc>15) radar();
            runalto();
            }
        }
        else if(quad==4)
        {
            while(1)
            {
            cc+=1;
            runbasso();
            runsinistra();
            rundestra();
            if(cc>15) radar();
            runalto();
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
corrx=799*(quad==1 || quad==4);
corry=799*(quad==1 || quad==2);
}

/* Posiziona il robot nel quadrante indicato da QUAD */
vai()
    {
    /* la direzione Š calcolata in base al quadrante dove si trova*/
    return;
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
    drive(dir,0);
    dd=-10; t=0;
    while((dd+=20)!=710) if (scan(dd,10)) ++t;
    if(t<3)
        onlyone();
        cc=1;
    return 1;
}

shoot()
{
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


runsinistra()
{
    /* vai verso sinistra e spara*/
    dir = 180;
    while (loc_x() > (101+corrx)) shoot();
}
runalto()
{
    /* vai verso altro e spara*/
    dir = 90;
    while (loc_y() < (101+corry)) shoot();
}
runbasso()
{
    /* vai verso altro e spara*/
    dir = 270;
    while (loc_y() > (101+corry)) shoot();
}
rundestra()
{
    /* vai verso altro e spara*/
    dir = 0;
    while (loc_x() < (101+corrx)) shoot();
}

onlyone()
{

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
