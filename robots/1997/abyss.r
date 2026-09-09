/****************************************************************************/
/*                                                                          */
/*  VII Torneo di CRobots di MCmicrocomputer (1997)                         */
/*                                                                          */
/*  CROBOT: ABYSS.R                                                         */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere questo crobot (ABYSS.R).     */

/*               
                          SCHEDA TECNICA:

  Inizialmente il robot si reca nell'angolo in basso a destra dell'arena;
  quindi guarda in direzione dei due angoli adiacenti e si comporta nel
  seguente modo:
    - se in alto non c'ä nessuno, allora si dirige verso nord lungo il
      bordo dell'arena fino a raggiungere circa la metÖ del lato e quindi
      torna indietro;
    - altrimenti se a sinistra non c'ä nessuno, allora si dirige verso ovest
      lungo il bordo dell'arena fino a raggiungere circa la metÖ del lato
      e quindi torna indietro;
    - altrimenti sceglie come direzione quella in cui avvista il nemico
      pió vicino.
  Il robot controlla continuamente se ä rimasto un solo nemico, in tal caso
  lo attacca a meno che non sia molto danneggiato, atrimenti continua nel
  suo movimento oscillatorio descritto in precedenza.
  Le routine di attacco sono in realta due: il robot prova prima ad attaccare
  l'avversario utilizzando le grandi diagonali dell'arena; quindi se la
  scelta non si rivela felice utilizza la routine di attacco di B52.r.
  Vengono utilizzate tre routine di fuoco, entrambe in movimento (il robot
  non stÖ mai fermo!!!): una ä derivata da quella di tox.r; la seconda
  ä molto pió semplice, ma efficace contro i robot che utilizzano
  oscillazioni brevi, infine la terza ä quella specifica per il movimento
  oscillatorio di attacco.

  NOTE:  - il sorgente ä straottimizzato (e quindi anche abbastanza difficile
           da comprendere); ä un vero peccato che la limitazione della
           lunghezza del codice (1000 istruzioni macchina???) sia cosç
           restrittiva e vincolante. In tal modo la creativitÖ degli autori
           dei robot e la stragegia di gioco si riducono veramente all'osso!
           Credo che se non si farÖ nulla per ovviare a questo handicap, il
           gioco purtroppo sarÖ destinato a tramontare entro breve tempo.
           La sua longevitÖ ä stata una delle caratteristiche pió gradite,
           ma analizzando la qualitÖ dei crobot dei vari tornei, risulta
           evidente che anno dopo anno si sono creati robot sempre molto
           pió competitivi, ma anche con sorgenti pió lunghi!!!
           Un'altra cosa da correggere sarebbe il bug sulla scansione in
           direzione 0: falsa il risultato di molti combattimenti e rende
           inadeguate diverse strategie di gioco!

*/

int dir,deg,rng,p,orng,odeg,q,t;

main()
{
    Quattro();
    q=135;

    while(q)
    {
        if (scan(q,10)) { dir=q-45; fuggi(); q+=90; } 

        p=damage();
        if (loc_x()<500) while(loc_x()<850) ff2(q);
        else while(loc_x()>150) ff2(q);
        if (damage()>p+10) q=180;

        drive((q+=180)%=360,0);
    }

    while (1)
    {
        while (speed()<80) drive(dir,100);
        fuoco2();
        Rallenta();
        if (p=!p) dir=deg-15; else dir=deg+135;

        if (((rng=loc_x())<150) || (rng>850) || ((orng=loc_y())<150) || (orng>850))
        {
             while (loc_x()<400) ff2();
             while (loc_x()>600) ff2(180);
             while (loc_y()<400) ff2(90);
             while (loc_y()>600) ff2(270);
             Rallenta();
        }

        while (speed()>49) ;   
    } 
}

ff2(dd)
{
    drive(dd,100); fuoco();
}

Quattro()
{
    while(loc_x()<900) ff2();
    Rallenta();
    while(loc_y()>100) ff2(270);
    Rallenta();

    while(1)
    {
        if (scan(180,10)>=scan(90,10))
        {
            while(loc_y()<400) ff2(90);
            drive(270,0);
            while(loc_y()>100) ff2(270);
            drive(90,0);
        }
        else
        {
            while(loc_x()>600) ff2(180);
            Rallenta();
            while(loc_x()<900) ff2();
            drive(180,0);
        }

        if (t>15)
        {
           t=0;
           if (scan(95,10)) ++t;
           if (scan(115,10)) ++t;
           if (scan(135,10)) ++t;
           if (scan(155,10)) ++t;
           if (scan(175,10)) ++t;
           if (t<2) return;
        }
    }
}

fuggi()
{
    if (dir==180)      while(loc_x()>150) ff();
    else if (dir==90)  while(loc_y()<850) ff();
    else if (dir==270) while(loc_y()>150) ff();
    else               while(loc_x()<850) ff();

    Rallenta();
}

Rallenta()
{
    drive(dir,0);
}

ff()
{
   drive(dir,100); fuoco(1); 
}

fuoco2()
{
    while ( !(orng=scan(deg+=19,10)) ) ;
    if (scan(deg+5,5)) deg+=5; else deg-=5;
    if (scan(deg+3,3)) deg+=3; else deg-=3;
    if (rng=scan(deg,10)) cannon(deg,2*rng-orng);
    if (orng<700) deg-=60; else deg+=20;
}

fuoco(flag)
{
  if (!scan(deg,5))
     if (!scan(deg-=10,5))
        if (!scan(deg+=20,5))
           if (!scan(deg-=30,5))
              if (!scan(deg+=40,5)) { deg+=30; return; }

  if (flag)
  {
       if(scan(deg-5,1)) deg-=5;
       if(scan(deg+5,1)) deg+=5;
       if(scan(deg-3,1)) deg-=3;
       if(scan(deg+3,1)) deg+=3;
       if(scan(deg-1,1)) deg-=1;
       if(scan(deg+1,1)) deg+=1;
       if (orng=rng=scan(odeg=deg,5))
         {
           if(scan(deg-5,1)) deg-=5;
           if(scan(deg+5,1)) deg+=5;
           if(scan(deg-3,1)) deg-=3;
           if(scan(deg+3,1)) deg+=3;
           if(scan(deg-1,1)) deg-=1;
           if(scan(deg+1,1)) deg+=1;
             if (rng=scan(deg,10))
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
         }
  }
  else
  {
    if (!scan(deg+=3,3)) deg-=6;
/*    if (!scan(deg+=2,1)) deg-=4;   */

    if (orng=scan(deg,10)) cannon(deg,orng); else orng=999;
  }

  if (orng>720) { deg+=30; ++t; } else t=0; 
}
