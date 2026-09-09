/****************************************************************************/
/*                                                                          */
/*  CROBOT: B52.R                                                           */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere questo robot (B52.R).        */

/*               
                          SCHEDA TECNICA:

    Il robot inizialmente raggiunge il centro del lato ovest dell'arena di
    combattimento e si muove a destra e a sinistra rispetto a una coordinata
    x prossima a 150: il movimento ? molto corto e quindi il robot ? 
    sottoposto ad accelerazioni e decelerazioni frequenti; inoltre le 
    continue inversioni di direzione di movimento eludono gli algoritmi
    di fuoco che si basano sulla previsione di un terzo punto per il tiro.
    L'inconveniente di questo tipo di movimento ? l'impossibilit? di creare
    routines di fuoco di una certa complesssit?, poiche il tempo a 
    disposizione tra due inversioni ? veramente esiguo e c'? il rischio di
    andarsi a suicidare contro il bordo dell'arena.
    Passati circa 140000 cicli virtuali di CPU il robot controlla i danni
    subiti e, se ? in buono stato, passa all'attacco.
    La routine di attacco consiste nell'avvicinarsi al robot avversario
    (sperando che ne sia rimasto solo uno) seguendo una traiettoria a zig
    zag; il principio che sta alla base di tale strategia ? analogo a quello
    utilizzato nella prima fase di combattimento: spostandocisi a destra ed a
    sinistra rispetto alla direzione in cui si trova il robot avversario
    si creano maggiori difficolt? a fare individuare l'angolo di scansione 
    corretto per il tiro (il range ? comunque molto pi? semplice da trovare).
    Infine durante la fase di attacco si controlla la vicinanza al bordo e,
    se necessario, si va verso il centro.
    L'efficienza del robot ? dunque legata alla strategia di movimento e non
    dipende quindi dalla precisione delle routine di fuoco, che sono molto
    semplici; vengono fatte approssimazioni abbastanza grossolane che,
    tuttavia, danno risultati soddisfacenti (spero!!!).

*/

int x,            /*  Coordinata x                    */
    y,            /*  Coordinata y                    */
    t,            /*  Timer                           */
    dam,          /*  Danno subito                    */
    dir,          /*  Direzione di movimento          */
    odeg,         /*  Angolo di scansione precedente  */
    deg,          /*  Angolo di scansione attuale     */ 
    rng,          /*  Range di scansione              */
    dd,           /*  Correzione angolo               */
    r,            /*  Ultimo range di scansione       */
    p,            /*  Flag di direzione               */
    a;            /*  Flag stato robot                */


main()
{
    
/*  Raggiungi il centro del lato ovest dell'arena     */    

    while (loc_x()<100) { drive(0,49); fuoco(); }
    drive(0,0);
    
    while (loc_x()>190) { drive(180,100); fuoco(); }
    while (speed()>49) drive(180,0);

    while (loc_y()<400) { drive(90,100); fuoco(); }
    while (loc_y()>600) { drive(270,100); fuoco(); }
    while (speed()>49) drive(180,0);

    while (loc_y()<480) { drive(90,20); fuoco(); }
    while (loc_y()>520) { drive(270,20); fuoco(); }
    while (speed()>0) drive(180,0);

    
    
    t=200;           /* Inizializzazione timer: circa 140000 cicli */
    x=loc_x();       /* Coordinata x attuale */
    a=1;             /* Inizialmente supponiamo che i danni siano forti */
    
    while (a)        /* Finch? i danni sono consistenti... */
    {
    while (t)        /* Finch? non passano circa 140000 cicli di CPU... */

/*  Vai a sinistra e a destra sparando */    
    
    {
        drive(0,100);                  /* Vai a sinistra...      */
        while (loc_x()<x+10) fuoco();  /* ... non troppo e spara */
        drive(0,0);                    /* Rallenta               */
        fuoco();                       /* Spara                  */
        while (speed()>49) ;           /* Controlla la velocit?  */

        drive(180,100);                /* Vai a destra...        */
        while (loc_x()>x-10) fuoco();  /* ... non troppo e spara */
        drive(180,0);                  /* Rallenta               */
        fuoco();                       /* Spara                  */
        while (speed()>49) ;           /* Controlla la velocit?  */

        --t;                           /* Decrementa il Timer    */
    }
    
    if (damage()<87) a=0;       /* Verifica i danni subiti */
    
    }
    
    dir=45; dd=-4;       /* Inizializzazione direzione di movimento e */
                         /* angolo di sfasamento                      */
    
    while (1)            /* Fino alla fine...  */

/* ... attacca!!!  */

    {
        while (speed()<80) drive(dir,100);    /* Accelera                 */
        fuoco3();                             /* Spara                    */
        drive(dir,0);                         /* Rallenta                 */
        ++t;                                  /* Perdi tempo!             */
        if (p) dir=deg-15; else dir=deg+135;  /* Correggi direzione e...  */
        p=!p;  dd=-dd;                        /* ... angolo di sfasamento */
        if (! Sicuro()) Centro();     /* Se sei troppo vicino ai bordi... */
                                      /* ... vai in centro                */
        while (speed()>49) ;                  /* Controlla la velocit?    */
    }
  
}

/* Routine di fuoco utilizzata nella prima fase di gioco */

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

/*  Se il bersaglio ? sotto tiro spara e aggiorna l'angolo precedente */
    if (r=scan(deg,10)) { cannon(deg+(deg-odeg),r+(r-rng)); odeg=deg; }

    if (rng>700) deg+=40;  /* Se il bersaglio ? lontano cambia angolo */

}

/* Routine di fuoco utilizzata nella fase di attacco */

fuoco3()
{
    while ( !(rng=scan(deg+=19,10)) ) ;  /* Trova il bersaglio... */
    spara3();                            /* ... e spara!!!        */ 
}

spara3()
{
/*  Approssima l'angolo di tiro */    
    if (scan(deg+5,5)) deg+=5; else deg-=5;
    if (scan(deg+3,3)) deg+=3; else deg-=3;

/*  Se il bersaglio ? sotto tiro spara utilizzando lo sfasamento */
    if (r=scan(deg,10)) cannon(deg+dd,r+(r-rng));

/*  Aggiorna l'angolo di scansione */
    if (rng<700) deg-=60; else deg+=20;
}

/* Routine che verifica l'avvicinamento ai bordi dell'arena */

Sicuro()         /* 34 Cicli di CPU */
{
    x=loc_x();
    y=loc_y();
    if ((x<150) || (x>850) || (y<150) || (y>850)) return 0;
    return 1;
}

/* Routine di riposizionamento al centro dell'arena */

Centro()
{
    while (loc_x()<400) { drive(0,100); fuoco2(); } 
    while (loc_x()>600) { drive(180,100); fuoco2(); } 
    while (speed()>49) drive(dir,0);
    while (loc_y()<400) { drive(90,100); fuoco2(); } 
    while (loc_y()>600) { drive(270,100); fuoco2(); } 
    while (speed()>49) drive(dir,0);
}

/* Routine di fuoco utilizzata per recarsi al centro dell'arena */

fuoco2()
{
    while ( !(rng=scan(deg+=19,10)) ) ;  /* Trova il bersaglio... */
    spara2();                            /* ... e spara!!!        */
}

spara2()
{
/*  Approssima l'angolo di tiro */    
    if (scan(deg+5,5)) deg+=5; else deg-=5;
    if (scan(deg+3,3)) deg+=3; else deg-=3;

/*  Se il bersaglio ? sotto tiro spara */
    if (r=scan(deg,10)) cannon(deg,r+(r-rng));

/*  Aggiorna l'angolo di scansione */    
    if (rng<700) deg-=30; else deg+=20;
}


