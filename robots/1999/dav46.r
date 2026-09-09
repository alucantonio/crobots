/*
+ --------------------------------------------------------------------------- +
+                                                                             +
+  Torneo di CRobots 1999  (The Y2K Tournament)                               +
+                                                                             +
+  CROBOT: DAV46.R                                                            +
+                                                                             +
+  AUTORE: Lorenzi Davide                                                     +
+                                                                             +
+ --------------------------------------------------------------------------- +

              SCHEDA TECNICA (uguale a quella di CANCER.R):

 Questo robot si distingue da CANCER.R perche' esegue i controlli di stato
 ogni 4 oscillazioni complete e non ogni oscillazione. E' migliore
 nell'F2F ma peggiore nel 4vs4.


 Inizialmente il crobot si reca nell'angolo piu' vicino e comincia ad oscillare
 rispetto alla bisettrice di questo.
 Ogni 4 oscillazioni complete controlla in numero di avversari rimasti e se per
 due volte ne trova uno solo allora attacca.

 Il robot utilizza 2 modalita' di sparo:
 1- Sparo veloce che utilizza durante le oscillazioni
 2- Sparo preciso che utilizza durante gli spostamenti e nella routine finale

 DAV46 resta nell'angolo iniziale finche' non viene colpito con una certa
 frequenza o finche' qualcuno si avvicina piu' di 80 m. Se gli angoli adiacenti
 non sono liberi allora resta li' e riprende ad oscillare.
 Si sposta preferibilmente in verticale.

 La routine finale e' molto semplice:
 Il robot si sposta in un punto preciso dell'arena ed oscilla parallelamente
 alla diagonale che va da sx in basso a dx in alto.

 DAV46 utilizza anche una variabile q che indica il numero del quadrante
 corrente. I quadranti sono cosi' disposti:

                         ---------
                        | 3  |  2 |
                        | ------- |
                        | 0  |  1 |
                         ---------


 Un ringraziamento va agli autori di Goblin.r, Tox.r, Tornado.r, Son-Goku.r da
 cui ho ripreso e modificato parti di codice.
 Grazie anche ai responsabili della mailing list ed a tutti gli amici che vi
 hanno partecipato.

 DIFETTI: La routine di movimento e' molto lenta per il carico di istruzioni
          da eseguire. La routine finale non e' il massimo.
          Quando il robot si sposta ed un altro lo continua a colpire lui va
          avanti lo stesso e spesso subisce notevoli danni. Le prove che
          ho fatto per ovviare a questo inconveniente non hanno dato i
          risultati sperati :( .

   PREGI: Far molto male agli altri crobots? Speriamo!  :))
-------------------------------------------------------------------------------
*/

int eDist, eGradi;     /* Distanza e Gradi          */
int oeDist, oeGradi;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int q;                 /* Quadrante                 */
int ne;                /* Numero avversari          */

int danni;
int i;
int c2;
int x,y;
/*****************************************************************
quadranti:
 ---------
| 3  |  2 |
| ------- |
| 0  |  1 |
 ---------
*****************************************************************/

main()
{
    if (loc_x ()<500) x=100; else x=900;
    if (loc_y ()<500) y=85; else y=915;
    vai (x,y);

    ne=3; c2=2;
    while (1) {
        angle ();
        move ();
    }        
}

vai (x,y)
{
    dir=ang (x,y);
    drive (dir,100);
    while (dist(x,y)>22500) {drive (dir,100); fuoco(0);}
    while (dist(x,y)>1600) {drive (dir,100);}
    drive (dir,0);
}

/* Angolo per andare in una certa direzione */
ang(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }

angle()
{
    leggiQuad ();
    
    danni=damage()+20;
    while (damage()<danni) {
        oscilla (5);

        numEnemy ();
        if (ne<=1) if (!--c2) attacco ();
        if (oeDist && oeDist<80) return;
    }
}


move ()
{
    i=0;
    if (loc_y()<500)
        if (libero(90)) {y=915;i=1;}
        else sxdx ();
    else
        if (libero(270)) {y=85;i=1;}
        else sxdx ();

    if (i) vai (x,y);
}

sxdx () 
{ 
    if (loc_x()<500) {
        if (libero(0)) {x=900;i=1;}
    }
    else { 
        if (libero(180)) {x=100;i=1;}
    }
}


oscilla (n)
{
    while (--n) {
        drive (dir,100); fuoco(1);
        while (loc_y()<=y) {drive (dir,100); fuoco(1);}
        dir+=180;
        drive (dir,100); fuoco(1);
        while (loc_y()>y) {drive (dir,100); fuoco(1);}
        dir-=180;
    }
    drive (dir,0);
}


/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!scan(gradi+350,10) && !scan(gradi+10,10));
}


/* rende il numero di avversari presenti */
/* all'interno della variabile ne */
numEnemy ()
{
    i=-10; ne=0;
    while (i<360) {
        if (scan (i+=20, 10)) ++ne;
    }
}


/* ritorna il numero del quadrante in cui si trova il robot */
leggiQuad()
{
    if (loc_y()<500) { 
        if (loc_x()<500) {q=0; dir=45;}
        else {q=1; dir=135;}
    }
    else { 
        if (loc_x()<500) {q=3; dir=135;}
        else {q=2; dir=45;}
    }
}



attacco ()
{
    vai (500,200);
    while (1) {
        dir=35; 
        drive(dir,100); fuoco(0);
        while (loc_x()<800) {drive(dir,100); fuoco(0);}
        dir+=180;
        drive(dir,100); fuoco(0);
        while (loc_y()>200) {drive(dir,100); fuoco(0);}
    }
}


fuoco(flag)
{
    if (oeDist=scan(eGradi,10)) {
        if (!scan(eGradi+=355,5)) eGradi+=10;
        if ((oeDist>800)&&(ne>1)) {eGradi+=40; return;}
        if (flag) {
            if (!scan(eGradi+=357,3)) eGradi+=6;
            cannon(eGradi,2*scan(eGradi,5)-oeDist); return;
        }        

        if(scan(eGradi+355,1)) eGradi+=355;
        if(scan(eGradi+5,1)) eGradi+=5;
        if(scan(eGradi+357,1)) eGradi+=357;
        if(scan(eGradi+3,1)) eGradi+=3;
        if(scan(eGradi+359,1)) eGradi+=359;
        if(scan(eGradi+1,1)) eGradi+=1;

        if (oeDist=scan(oeGradi=eGradi,5)) {

            if(scan(eGradi+355,1)) eGradi+=355;
            if(scan(eGradi+5,1)) eGradi+=5;
            if(scan(eGradi+357,1)) eGradi+=357;
            if(scan(eGradi+3,1)) eGradi+=3;
            if(scan(eGradi+359,1)) eGradi+=359;
            if(scan(eGradi+1,1)) eGradi+=1;

            if (eDist=scan(eGradi,10)) {
                cannon(eGradi+(eGradi-oeGradi)*((1200+eDist)>>9)-(sin(eGradi-dir)>>14),
                       eDist*160/(160+oeDist-eDist-(cos(eGradi-dir)>>12)));
            }
        }
    } 
    else {
        if (scan(eGradi+=340,10)) return;
        if (scan(eGradi+=40,10)) return;
        eGradi+=40;
    }
}
