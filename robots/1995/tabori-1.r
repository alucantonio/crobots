/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******\


                    ____       __   ___  ___  _      ___
                   (_  _) /^\ | .) /   \| _ \| |      H
                     ||  | ^ || * \| O ||   /| |      H
                     ||  |_|_||__ /\___/|_|_\|_|     _H_



                                  TABORI 1
                        un CRobot di Luca Ceresoli
                              MC-link: MC9729
                        Internet: mc9729@mclink.it

Tabori e' ispirato all'omonimo personaggio de "La variante di
Luneburg", un romanzo di P. Maurensig. Come lui, il robot *dovrebbe*
essere crudele e spietato, colpendo gli avversari poche volte ma
bene; che questo poi non succeda e' un fatto secondario. :-)

Tabori 1 resta fermo finche' non viene colpito; a questo punto si
sposta in modo tale da raggiungere il punto piu' vicino tra i quattro
spigoli ed i punti medi dei lati (vedi figura). Nel momento in cui si
accorge di aver subito altri danni, oppure quando e' passato troppo
tempo, si sposta nel punto piu' vicino, purche' sul tragitto non veda
nessun nemico; ma se vede un nemico da entrambi i lati si dirige
la' dove il nemico e' piu' lontano.
+-----------------+
| *      *      * |
|                 |
|                 |
| *             * |
|                 |
|                 |
| *      *      * |
+-----------------+
La tecnica di attacco applicata durante il movimento e' molto
semplice: guarda ad un angolo casuale, se vedi qualcuno spara.
Piu' complessa e' invece la routine di sparo da fermo kill(). Essa
cerca un nemico in un raggio di 90 (se in un angolo) o 180 gradi (se
sul punto medio di un lato). Quando lo ha trovato ne memorizza
l'angolo e la distanza nelle variabili a1 e r1. Poi lo cerca di nuovo
memorizzando le nuove coordinate in a2 e r2. Infine gli spara,
aggiustando il range in modo da calcolare lo spostamento del nemico
durante l'esecuzione dei calcoli e facendo lo stesso con l'angolo.
Il range subisce un ulteriore aggiustamento, per aumentarlo
ulteriormente se r2>r1, e diminuirlo in caso contrario. Infine il
robot copia le variabili a2 ed r2 in a1 ed r1, in modo tale da poter
individuare nuovamente il  nemico alla successiva esecuzione di
kill().
\******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/


/* Variabili globali (brutte e poco eleganti ma veloci ed efficienti!) */
int pos, posx, posy, posn1x, posn1y, posn1dir, posn2x, posn2y, posn2dir;
int a1, r1, a2, r2, a3, r3, scandir, deltar;
int time,       /* Quanto tempo il robot e' restato nella stessa posizione */
    maxtime;    /* Quanto tempo il robot deve restare nella stessa
                   posizione */
int dam,    /* Danni attuali */
    maxdam; /* Danni dopo i quali si cambia posizione */


main()
{
int dir;    /* Direzione di movimento */
/*int realx, realy;*/   /* Posizione effettiva */
int i1, i2;

/* Inizializzazione costanti */
maxdam=0;
maxtime=100;

/* Inizializzazione variabili */
r1=2000;
scandir=720;

while(damage()==0)      /* Pre-ciclo */
    kill();

pos=((angleto(500,500)+202)%360)/45; setpos();

while(1) {      /* ===== Ciclo principale ===== */
/*    posx=900; posy=500;*/
    dir=angleto(posx, posy);
    while(pita(loc_x(), loc_y(), posx, posy)>100) { /* =dist. frenata */
        drive(dir, 100);
        kill_moving();
        }
    drive(dir,0);
    while(speed()>0) {
        kill_moving();
        }

    time=0;
    dam=damage()+maxdam;
    while((dam>=damage()) && (time<maxtime)) {
        kill();
        ++time;
        }

    i1=scan(posn1dir,10);
    i2=scan(posn2dir,10);
    if( (i2>0) && ((i1==0)||(i1>i2)) )
        setpos(++pos);
    else
        setpos(--pos);
    }
}

/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
setpos()
{
pos=(pos+8)%8;
if(pos%2) {                     /* Posizz. 1,3,5,7 */
    if((pos%4)==3) {                /* 3,7 */
        if(pos==7) {                    /* 7 */
            posx=920; posy=80;
            posn1x=920; posn1y=80; posn1dir=90;
            posn2x=500; posn2y=80; posn2dir=180;
            }
        else {                          /* 3 */
            posx=80; posy=920;
            posn1x=80; posn1y=500; posn1dir=270;
            posn2x=500; posn2y=920; posn2dir=360;
            }
        }
    else {                          /* 1,5 */
        if(pos==5) {                    /* 5 */
            posx=80; posy=80;
            posn1x=500; posn1y=80; posn1dir=0;
            posn2x=80; posn2y=500; posn2dir=90;
            }
        else {                          /* 1 */
            posx=920; posy=920;
            posn1x=500; posn1y=920; posn1dir=180;
            posn2x=920; posn2y=500; posn2dir=270;
            }
        }
    /* posn2dir=(pos1dir+90)%360; */
    }
else {                          /* Posizz. 0,2,4,6 */
    if(!(pos%4)) {                  /* 0,4 */
        if(pos==4) {                    /* 4 */
            posx=80; posy=500;
            posn1x=80; posn1y=80; posn1dir=270;
            posn2x=80; posn2y=920; posn2dir=450;
            }
        else {                          /* 0 */
            posx=920; posy=500;
            posn1x=920; posn1y=920; posn1dir=90;
            posn2x=920; posn2y=80; posn2dir=270;
            }
        }
    else {                          /* 2,6 */
        if(pos==6) {                    /* 6 */
            posx=500; posy=80;
            posn1x=920; posn1y=80; posn1dir=0;
            posn2x=80; posn2y=80; posn2dir=180;
            }
        else {                          /* 2 */
            posx=500; posy=920;
            posn1x=80; posn1y=920; posn1dir=180;
            posn2x=920; posn2y=920; posn2dir=360;
            }
        }
    /* posn2dir=(pos1dir+180)%360; */
    }
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
kill()
{
if(r1==2000) {
    scandir+=10;
    getpos(scandir, 1);
    if(scandir>posn2dir) scandir=posn1dir-20;
    r2=2000;
    }

if((r1!=2000) && (r2==2000)) {
    getpos((a1+5), 2);
    if(r2==2000) getpos((a1-5), 2);
    if(r2==2000) r1=2000;
    }

if(r2!=2000) {
    if( ((a1-a2)<5) && ((a1-a2)>-5) && ((r1-r2)<10) && ((r1-r2)>-10) ) {
        r3=r2; a3=a2;
        }
    else {
        deltar=r2-r1;
        r3=r2+(50*deltar*mod(deltar)/r2);
        a3=(a2*4)-(a1*3)+((a1-a2)*deltar/20);
        }
    if(r3<=700) {
        cannon(a3, r3);
        r1=r2; a1=a2; r2=2000;
        }
    else r1=2000;
    }
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
kill_moving()
{
int range, ang;
ang=rand(360);
range=scan(ang,5);
if(range) cannon(ang,range);
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
getpos(eang, num)
{
int range;
if(range=scan(eang, 5)) {
    if (scan(eang+3, 2)) {
        if(scan(eang+4, 1)) {
            if(scan(eang+3, 0)) eang+=3;
            else                eang+=4;
            }
        else {
            if(scan(eang+2, 0)) eang+=2;
            else                eang+=1;
            }
        }
    else {
        if ( scan(eang-4, 2) ) {
            if(scan(eang-2, 1)) eang-=2;
            else                eang-=3;
            }
        else {
            if(scan(eang-1, 0)) eang-=1;
            else                eang-=0;
            }
        }
    if(num==1)  { a1=eang; r1=range; }
    else        { a2=eang; r2=range; }
    }
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
pita(x1, y1, x2, y2)
int x1, y1, x2, y2;
{
x2-=x1; y2-=y1;
x2*=x2; y2*=y2;
return (sqrt(x2+y2));
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
angleto(xdest, ydest)           /*  restituisce l'angolo per raggiungere il */
int xdest, ydest;               /*  punto (xdest, ydest) */
                                /*  Tratta da sniper.r, ringraziando il
                                    nostro benefattore Tom Poindexter */
{
    int dir;
    int x, y;
    int curx, cury;

    curx = loc_x();
    cury = loc_y();
    x = curx-xdest;
    y = cury-ydest;

    if ( !x ) {
        if ( ydest>cury )
            dir = 90;
        else
            dir = 270;
        }
    else {
        if (ydest < cury) {
            if (xdest > curx)
                dir = 360 + atan((100000 * y) / x);
            else
                dir = 180 + atan((100000 * y) / x);
            }
        else {
            if (xdest > curx)
                dir = atan((100000 * y) / x);
            else
                dir = 180 + atan((100000 * y) / x);
            }
    }
    return dir;
}
/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/
mod(n)
int n;
{
if(n<0) return(-n);
return n;
}
