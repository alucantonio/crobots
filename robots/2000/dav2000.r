/*
+ --------------------------------------------------------------------------- +
+                                                                             +
+  Torneo di CRobots 2000                                                     +
+                                                                             +
+  CROBOT: DAV2000.R (Tanto per cambiare...)                                  +
+                                                                             +
+  AUTORE: Lorenzi Davide                                                     +
+                                                                             +
+ --------------------------------------------------------------------------- +

 SCHEDA TECNICA:

 La tattica di gioco di questo mostriciattolo deriva da quella del suo
 predecessore DAV46.r con particolari accorgimenti che ne aumentano
 l'aggressivita'.

 Inizialmente il crobot si reca nell'angolo piu' vicino, conta per due volte
 il numero di avversari ed in caso attacca subito.
 Se ne trova piu' di uno comincia ad oscillare rispetto alla bisettrice
 dell'angolo ed ogni 4*i oscillazioni complete ricontrolla quanti robottini
 ci sono nell'arena (i=numero degli avversari contati la volta prima).
 In questo modo si espone meno poiche' i momenti in cui si ferma per contare
 diminuiscono. Se per due volte ne trova uno solo allora attacca.

 Il robot utilizza 2 modalita' di sparo:
 1- Sparo veloce che utilizza durante le oscillazioni
 2- Sparo preciso che utilizza durante gli spostamenti e nella routine finale

 Ogni 4 oscillazioni complete si muove lungo entrambi i lati adiacenti, 
 colpisce e ritorna sul suo angolo.
 Se subisce danni superiori al 15% in uno stesso angolo si sposta se ne trova
 di liberi altrimenti ricomincia.

 Nella routine finale il crobot si muove casualmente nell'arena ed il piu'
 possibile utilizzando un'altra routine di sparo.

 I miei piu' sentiti ringraziamenti agli organizzatori, agli amici della
 mailing list ed ai creatori dei crobots da cui ho preso parti di codice.

 Buon combattimento a tutti!
-------------------------------------------------------------------------------
*/

int eDist, eGradi;     /* Distanza e Gradi          */
int oeDist, oeGradi;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */

int danni, i, c2, x, y;
int timeuntil;

main()
{
    vai (x=100+800*(loc_x()>500),y=85+830*(loc_y()>500));
    if (numEnemy()<2)
        if (numEnemy()<2)
            attacco();

    ne=3; c2=2; timeuntil=1;
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
    /* setta i gradi di oscillazione */
    if (loc_y()<500) { 
        if (loc_x()<500) dir=45;
        else dir=135;
    }
    else { 
        if (loc_x()<500) dir=315;
        else dir=225;
    }

    danni=damage()+15;
    while (damage()<danni) {
        oscilla (5);
        
        if (--timeuntil<1) {
            if (!oeDist || oeDist>600) {
                timeuntil=numEnemy();
                if (ne<2) if (!--c2) attacco ();
            }
        }

        if (oeDist && oeDist<120) return;

        if (ne>1) {
            if (!oeDist || oeDist>600)
                lat();
        }
    }
}

/* Si muove sui lati adiacenti e poi torna indietro */
lat ()
{
    if (damage()<90) {
        /* X */
        if (loc_x()<500) {
            if (!libero(0))
                while (loc_x()<280) {drive (0,100);fuoco(1);}
            while (loc_x()>100) {drive (180,100);fuoco(1);}
        }
        else {
            if (!libero(180))
                while (loc_x()>720) {drive (180,100);fuoco(1);}
           while (loc_x()<900) {drive (0,100);fuoco(1);}
        }
        drive (dir,0);

        /* Y */
        if (loc_y()<500) {
            if (!libero(90))
                while (loc_y()<280) {drive (90,100);fuoco(1);}
            while (loc_y()>100) {drive (270,100);fuoco(1);}
        }
        else {
            if (!libero(270))
                while (loc_y()>720) {drive (270,100);fuoco(1);}
            while (loc_y()<900) {drive (90,100);fuoco(1);}
        }
        drive (dir,0);

        /* si riposiziona correttamente */
        if (loc_x()<500)
            while (loc_x()<70) {drive (0,80);fuoco(1);}
        else
            while (loc_x()>930) {drive (180,80);fuoco(1);}
        drive(dir,0);
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
        if (loc_y()<500) while (loc_y()<=y) {drive (dir,100); fuoco(1);}
        else while (loc_y()>y) {drive (dir,100); fuoco(1);}
        dir+=180;
        drive (dir,100); fuoco(1);
        if (loc_y()<500) while (loc_y()>y) {drive (dir,100); fuoco(1);}
        else while (loc_y()<=y) {drive (dir,100); fuoco(1);}
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
    i=0; ne=0;
    while (i<360) {
        if (scan (i+=20, 10)) ++ne;
    }
    return ne;
}

/* Copyright 2000 by DAV */
attacco ()
{
    dir=ang(500,500);
    while(speed()<100) {drive(dir,100);focus();}

    while (1) {
        if (loc_x()<250) dir=0;
        else if (loc_x()>750) dir=180;
        else if (loc_y()<250) dir=90;
        else if (loc_y()>750) dir=270;
        else dir=rand(360);

        drive(dir,45);
        /* sparo rapido */
        while (speed()>45) {
            if (oeDist=scan(eGradi,10)) {
                if (!scan(eGradi+=355,5)) eGradi+=10;
                if (!scan(eGradi+=357,3)) eGradi+=6;
                cannon(eGradi,2*scan(eGradi,5)-oeDist);
            }
            else {
                if (scan(eGradi+=340,10));
                else if (scan(eGradi+=40,10));
                else eGradi+=40;
            }
        }

        drive(dir,100);
        while(speed()<100) focus ();
    }
}

/* Routine di fuoco presa da Dario.r e rivista */
focus()
{
    /* cerca un nemico */
    if (oeDist=scan(eGradi,10));
    else if (oeDist=scan(eGradi-=21,10));
    else if (oeDist=scan(eGradi+=42,10));
    else {eGradi+=42; return;}

    /* se e` vicino spara immediatamente */
    if (oeDist<150) {cannon(eGradi,oeDist); return;}

    if (scan(eGradi-=5,5)); else eGradi+=10;
    if (scan(eGradi+5,2)) eGradi+=5; if (scan(eGradi-5,2)) eGradi-=5;
    if (scan(eGradi+3,1)) eGradi+=3; if (scan(eGradi-3,1)) eGradi-=3;
    if (scan(eGradi+1,1)) eGradi+=1; if (scan(eGradi-1,1)) eGradi-=1;
    if (oeDist=scan(oeGradi=eGradi,5)) {
        if (scan(eGradi+5,2)) eGradi+=5; if (scan(eGradi-5,2)) eGradi-=5;
        if (scan(eGradi+3,1)) eGradi+=3; if (scan(eGradi-3,1)) eGradi-=3;
        if (scan(eGradi+1,1)) eGradi+=1; if (scan(eGradi-1,1)) eGradi-=1;

        if (eDist=scan(eGradi,10)) {
            cannon(eGradi+(eGradi-oeGradi)*((1200+eDist)>>9)-(sin(eGradi-dir)>>14),
                   eDist*172/(172+oeDist-eDist-(cos(eGradi-dir)>>12)));
            return;
        }
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

        if(scan(eGradi+355,1)) eGradi+=355; if(scan(eGradi+5,1)) eGradi+=5;
        if(scan(eGradi+357,1)) eGradi+=357; if(scan(eGradi+3,1)) eGradi+=3;
        if(scan(eGradi+359,1)) eGradi+=359; if(scan(eGradi+1,1)) eGradi+=1;
        if (oeDist=scan(oeGradi=eGradi,5)) {
            if(scan(eGradi+355,1)) eGradi+=355; if(scan(eGradi+5,1)) eGradi+=5;
            if(scan(eGradi+357,1)) eGradi+=357; if(scan(eGradi+3,1)) eGradi+=3;
            if(scan(eGradi+359,1)) eGradi+=359; if(scan(eGradi+1,1)) eGradi+=1;

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
