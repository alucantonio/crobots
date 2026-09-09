/****************************************************************************/
/*                                                                          */
/*  VI Torneo di CRobots di MCmicrocomputer                                 */
/*                                                                          */
/*  CROBOT: NEWB52.R                                                        */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere questo robot (NEWB52.R).     */

/*               
                          SCHEDA TECNICA:

    Il robot gira intorno all'arena di combattimento descrivendo una 
    traiettoria a zig zag. La forza del robot Š legata al tipo di movimento
    che si basa sullo stesso principio di quello del suo predecessore (vedi
    B52.r).
    La maggiore dinamicit… del robot lo rende ancora pi— competitivo ed anche
    pi— agguerrito: non digerisce molto bene i pareggi e cerca di finire
    gli incontri al pi— presto possibile,infatti non si ferma un istante !!!
    La semplicissima routine di fuoco Š la stessa di B52.r: difficilmente
    rimpiazzabile.
*/

int dir,          /*  Direzione di movimento          */
    odeg,         /*  Angolo di scansione precedente  */
    deg,          /*  Angolo di scansione attuale     */ 
    rng,          /*  Range di scansione              */
    r;            /*  Ultimo range di scansione       */


main()
{
/* Stabilisce il quadrante iniziale per recarsi subito ai bordi dell'arena: */

    if (loc_x()<500)
       if (loc_y()<500) dir=0;
       else dir=270;
    else
       if (loc_y()<500) dir=90;
       else dir =180;

/* Comincia la sua marcia intorno al recinto: */
    while (1)
    {
        Go(dir);
        dir=(dir+90)%360;
    }
}

Go(d)
{
    if (d==0)
    {
        while(loc_x()<900)
        {
            if (loc_y()<130)
            {
                drive(60,100);
                while(loc_y()<130) fuoco();
                drive(60,0);
                fuoco();
                while (speed()>49);
            }
            else
            {
                drive(300,100);
                while(loc_y()>120) fuoco();
                drive(300,0);
                fuoco();
                while (speed()>49);
            }

        }
    }
    else if (d==90)
    {
        while(loc_y()<900)
        {
            if (loc_x()>870)
            {
                drive(150,100);
                while(loc_x()>870) fuoco();
                drive(150,0);
                fuoco();
                while (speed()>49);
            }
            else
            {
                drive(30,100);
                while(loc_x()<880) fuoco();
                drive(30,0);
                fuoco();
                while (speed()>49);
            }

        }
    }
    else if (d==180)
    {
        while(loc_x()>100)
        {
            if (loc_y()>870)
            {
                drive(240,100);
                while(loc_y()>870) fuoco();
                drive(240,0);
                fuoco();
                while (speed()>49);
            }
            else
            {
                drive(120,100);
                while(loc_y()<880) fuoco();
                drive(120,0);
                fuoco();
                while (speed()>49);
            }

        }
    }
    else
    {
        while(loc_y()>100)
        {
            if (loc_x()<130)
            {
                drive(330,100);
                while(loc_x()<130) fuoco();
                drive(330,0);
                fuoco();
                while (speed()>49);
            }
            else
            {
                drive(210,100);
                while(loc_x()>120) fuoco();
                drive(210,0);
                fuoco();
                while (speed()>49);
            }

        }
    }
}

fuoco()
{
    if (rng=scan(deg,10)) spara();            /* Guarda avanti      */
    else if (rng=scan(deg-=20,10)) spara();   /* Guarda a destra    */
    else if (rng=scan(deg+=40,10)) spara();   /* Guarda a sinistra  */
                                              /* ... e spara ...    */
    else deg+=40;      /* ... altrimenti cambia angolo di scansione */     
}

spara()
{
/*  Approssima l'angolo di fuoco */    

    if (scan(deg+5,5)) deg+=5; else deg-=5;
    if (scan(deg+3,3)) deg+=3; else deg-=3;

/*  Se il bersaglio Š sotto tiro spara e aggiorna l'angolo precedente */
    if (r=scan(deg,10)) { cannon(deg+(deg-odeg),r+(r-rng)); odeg=deg; }

    if (rng>700) deg+=40;  /* Se il bersaglio Š lontano cambia angolo */

}

