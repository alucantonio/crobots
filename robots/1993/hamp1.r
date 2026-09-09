/****************************************************************************                                 
|                                                                           |
|                                  HAMP1.R                                  |
|                                                                           |
*****************************************************************************

Autore:

Spazian Massimo

*****************************************************************************

Commento al funzionamento del robot:

E' un robot molto semplice. 
1. Quando parte si sposta verso il lato destro dell'arena. 
2. Qui effettua un'iterazione per 5 volte e si sposta in basso e poi in alto 
   lungo il bordo.
3. Finita questa iterazione si sposta sul lato in alto ripetendo l'iterazione
   muovendosi pero' a destra e a sinistra su quel lato.
4. Finita anche questa iterazione si sposter… sul lato sinistro e successiva-
   mente su quello in basso ripetendo sempre le stesse iterazioni.
5. A questo punto si ritorna al punto di partenza e si riparte (dal punto 2).

Restando sempre sullo stesso lato si rischia di impattare molto spesso, per 
cui lo spostamento da un lato a quello adiacente mi Š sembrata un' ottima idea
per poter arrivare a colpire su tutta l'arena.

La funzione di sparo Š molto semplice e simile a quelle di tanti altri robot, 
i suoi pregi sono di mirare velocemente su un avversario e di tener conto 
dello spostamento dell'avversario.
La scomposizione nei 4 sottoprogrammi up, dn, dx e sx; di cui uno spara verso 
l'alto, un'altro verso il basso, poi verso destra e verso sinistra Š per 
ottenere una maggiore efficienza: meno istruzioni ci sono e pi— velocemente Š 
eseguito il programma.

***************************************************************************
|  varibili globali                                                       |
**************************************************************************/

int ang;         /* angolo su cui mirare e sparare */
int an1;         /* angolo su cui mirare e sparare: usato da dx() */
int range1;      /* var. utilizzata per il nuovo range */
int range2;      /* tiene nota del vecchio range: confrontato con il nuovo si
                    pu• capire da che parte sta andando il nemico */
int cicli;       /* semplice variabile contatore */

/**************************************************************************
|  main                                                                   |
**************************************************************************/

main() {

  cicli=0;

  drive( 0, 100 );                 /* va a destra fino al bordo              */
  while( loc_x()<900 ) dn();
  drive( 0, 20 );
  while(( speed()>49 )||( loc_x()<995 ));

  while( 1 ) {
    
    while( cicli<5 ) {             /* itera per 5 volte */
      drive( 90, 100 );            /* va su e gi— sul lato destro            */
      while( loc_y()<900 ) sx();
      drive( 90, 40 );
      while( speed()>49 ) sx();
      drive( 270, 100 );
      while( loc_y()>100 ) sx();
      drive( 270, 40 );
      while( speed()>49 ) sx();
      cicli=cicli+1;
    }
    
    cicli=0;

    drive( 90, 100 );
    while( loc_y()<900 ) sx();
    drive( 90, 20 );
    while(( speed()>49 )||( loc_y()<995 ));    
    
    while( cicli<5 ) {           /* itera per 5 volte */
      drive( 180, 100 );         /* va a sinistra e a destra sul lato in alto  */
      while( loc_x()>100 ) dn();
      drive( 180, 40 );
      while( speed()>49 ) dn();
      drive( 0, 100 );
      while( loc_x()<900 ) dn();
      drive( 0, 40 );
      while( speed()>49 ) dn();
      cicli=cicli+1;
    }

    drive( 180, 100 );
    while( loc_x()>100 ) dn();
    drive( 180, 20 );
    while(( speed()>49 )||( loc_x()>5 ))dn();
  
    cicli=0;
 
    while( cicli<5 ) {                /* itera per 5 volte */
      drive( 270, 100 );              /* va su e gi— sul lato sinistro       */
      while( loc_y()>100 ) dx();
      drive( 270, 40 );
      while( speed()>49 ) dx();
      drive( 90, 100 );
      while( loc_y()<900 ) dx();
      drive( 90, 40 );
      while( speed()>49 ) dx();
      cicli=cicli+1;
    }
    
    cicli=0;

    drive( 270, 100 );
    while( loc_y()>100 ) dx();
    drive( 270, 20 );
    while(( speed()>49 )||( loc_y()>5 ));    

    while( cicli<5 ) {         /* itera per 5 volte */
      drive( 0, 100 );         /* va a sinistra e a destra sul lato in basso */
      while( loc_x()<900 ) up();
      drive( 0, 40 );
      while( speed()>49 ) up();
      drive( 180, 100 );
      while( loc_x()>100 ) up();
      drive( 180, 40 );
      while( speed()>49 ) up();
      cicli=cicli+1;
    }
    
    cicli=0;

    drive( 0, 100 );
    while( loc_x()<900 ) up();
    drive( 0, 20 );
    while(( speed()>49 )||( loc_x()<995 ));    

  }
}

/***************************************************************************
|  Procedura sx                                                            |
|  Spara verso sinistra a 180ø quando il robot staziona sulla parte destra |
***************************************************************************/

sx() {
  if( range1=scan( ang, 10 )) {
    if( range2<range1 ) cannon( ang, 8*range1/7 );
    else cannon( ang, 7*range1/8 );
    range2=range1;
  } else {
    ang-=20;
    if( ang<70 ) ang=270; 
  }
}

/***************************************************************************
|  Procedura dx                                                            |
|  Spara verso destra a 180ø quando il robot staziona sulla parte sinistra |
***************************************************************************/

dx() {
  if( range1=scan( ang, 10 )) {
    if( range2<range1 ) cannon( ang, 8*range1/7 );
    else cannon( ang, 7*range1/8 );
    range2=range1;
  } else {
    ang+=20;
    if( ang>360 ) ang=270; 
  }
  
  if( range1=scan( an1, 10 )) {
    if( range2<range1 ) cannon( an1, 8*range1/7 );
    else cannon( an1, 7*range1/8 );
    range2=range1;
  } else {
    an1-=20;
    if( an1 < 0 ) an1=90; 
  }
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
