/***************************************************************************
|                                                                          |
|                                  HAMP2.R                                 |
|                                                                          |
****************************************************************************

Autore:

Spazian Massimo

****************************************************************************

Commento al funzionamento del robot:

E' un robot molto semplice. 
Quando parte decide in modo random se andare verso l' alto oppure verso il 
basso. Una volta raggiunto un bordo dell'arena si muove a destra e a sinistra
lungo il bordo per 15 volte, finita l'iterazione si sposta in diagonale verso
il bordo opposto (verso l'alto se in partenza era andato verso il basso e 
viceversa).

L'idea di stazionare su di un lato e dopo un po' cambiare e andare su quello 
opposto Š nata dall'aver notato che meno spostamenti si fanno meglio Š: non si 
pu• stare fermi ma Š dannoso perdere tempo a frenare e cambiare continuamente 
direzione. D'altronde restando sempre sullo stesso lato si rischia di impattare
molto spesso, per cui un'iterazione di 15 volte mi Š sembrata la soluzione
migliore, infatti gli spostamenti da un lato all'altro sono limitatissimi e
si ha la possibilit… di sparare su tutta l'arena.

La funzione di sparo Š molto semplice (la scomposizione in due sottoprogrammi,
up e dn di cui il primo spara verso l'alto e il secondo verso il basso, Š per
ottenere una maggiore efficienza: meno istruzioni ci sono e pi— velocemente Š
eseguito il programma) e simile a quelle di tanti altri robot, i suoi pregi
sono di mirare velocemente su un avversario e di tener conto dello spostamento
dell'avversario.

****************************************************************************
|   variabili globali                                                      |
***************************************************************************/

int ang;         /* angolo su cui mirare e sparare */
int range1;      /* var. utilizzata per il nuovo range */
int range2;      /* tiene nota del vecchio range: confrontato con il nuovo si
                    pu• capire da che parte sta andando il nemico */
int cicli;       /* semplice variabile contatore */

/***************************************************************************
|   main                                                                   |
***************************************************************************/

main() {

  cicli=0;
    
  if( rand(2)-1 ) {                  /* va verso l'alto o il basso in random */

    drive( 90, 100 );                /* va verso il basso                    */
    while( loc_y()<900 ) spara();
    drive( 90, 20 );
    while(( speed()>49 )||( loc_y()<995 ));
    
    while( cicli<15 ) {              /* cicla per 15 volte                   */
      drive( 0, 100 );               /* va a destra fino al bordo            */
      while( loc_x()<900 ) dn();
      drive( 0, 40 );
      while( speed()>49 ) dn();
      drive( 180, 100 );             /* va a sinistra fino al bordo          */
      while( loc_x()>100 ) dn();
      drive( 180, 40 );
      while( speed()>49 ) dn();
      cicli=cicli+1;
    }
    
    diag2();                         /* si sposta sul lato in basso          */
    cicli=0;
    
  } else {
    drive( 270, 100 );               /* va verso l'alto                      */
    while( loc_y()>100 ) spara();
    drive( 270, 20 );
    while(( speed()>49 )||( loc_y()>5 ));
  }

  while( 1 ) {
  
    while( cicli<15 ) {              /* cicla per 15 volte                   */
      drive( 0, 100 );               /* va a destra fino al bordo            */
      while( loc_x()<900 ) up();
      drive( 0, 40 );
      while( speed()>49 ) up();
      drive( 180, 100 );             /* va a sinistra fino al bordo          */ 
      while( loc_x()>100 ) up();
      drive( 180, 40 );
      while( speed()>49 ) up();
      cicli=cicli+1;
    }
  
    cicli=0;
    diag1();                         /* si sposta sul lato in alto           */
    
    while( cicli<15 ) {              /* cicla per 15 volte                   */
      drive( 0, 100 );               /* va a destra fino al bordo            */
      while( loc_x()<900 ) dn();
      drive( 0, 40 );
      while( speed()>49 ) dn();
      drive( 180, 100 );             /* va a sinistra fino al bordo          */
      while( loc_x()>100 ) dn();
      drive( 180, 40 );                
      while( speed()>49 ) dn();
      cicli=cicli+1;
    }
    
    diag2();                         /* si sposta sul lato in basso          */
    cicli=0;
    
  }
}

/***************************************************************************
|  Procedura Diag1                                                         |
|  Muove il robot dalla parte bassa alla parte alta dello schermo          |
***************************************************************************/

diag1() {
  drive( 65, 100 );
  while( loc_y()<900 ) spara();
  drive( 65, 20 );
  while(( speed()>0 )&&(loc_y()<995));
  drive( 0, 49 );
}

/***************************************************************************
|  Procedura Diag2                                                         |
|  Muove il robot dalla parte alta alla parte bassa dello schermo          |
***************************************************************************/

diag2() {
  drive( 300, 100 );
  while( loc_y()>100 ) spara();
  drive( 300, 20 );
  while(( speed()>0 )&&( loc_y()>5 ));
  drive( 180, 49 );
}

/***************************************************************************
|  Procedura spara                                                         |
|  Spara mentre il robot si sposta mediante diag1 o diag2                  |
***************************************************************************/

spara() {
  dn();
  up();
}

/***************************************************************************
|  Procedura dn                                                            |
|  Spara verso il basso a 180ø quando il robot staziona sulla parte alta   |
***************************************************************************/

dn() {
  if( range1=scan( ang, 10 )) {
    if( range2<range1 ) cannon( ang, 8*range1/7 );
    else cannon( ang, 7*range1/8 );
    range2=range1;
  } else {
    ang-=20;
    if( ang<=159 ) ang=359; 
  }
}

/***************************************************************************
|  Procedura up                                                            |
|  Spara verso l'alto a 180ø quando il robot staziona sulla parte bassa    |
***************************************************************************/

up() {
  if( range1=scan( ang, 10 )) {
    if( range2<range1 ) cannon( ang, 8*range1/7 );
    else cannon( ang, 7*range1/8 );
    range2=range1;
  } else {
    ang+=20;
    if( ang>=200 ) ang=0; 
  }
}

/***************************************************************************/
