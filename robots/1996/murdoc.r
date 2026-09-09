/*
                Murdoc.r
                30/9/1996
                Partecipante al sesto torneo di MCmicrocomputer
                un Crobot di Luca Ceresoli
                MC-link: MC9729

Doverosa premessa: il nome murdoc *non* si riferisce al famoso personaggio
dell'A-team, bensi' all'assassino co-protagonista di alcune delle piu' belle
puntate di MacGyver. :-)

Murdoc si muove orizzontalmente nell'angolo superiore destro dell'arena.
La funzione di attacco kill(), una volta trovato un nemico, richiama find()
per individuarlo con maggiore precisione, dopodiche' spara con alcune
correzioni all'angolo ed al range.
*/




int ang, rng;
int oang, orng;
int found;

main()
{
/* Fase iniziale */

drive (90, 100);
ang=0;
while(loc_y()<910) kill();

drive (0,49);
while (speed()>49) kill();
drive (0,100);
while (loc_x()<910) kill();

drive (0,49);
while(speed()>49) {kill(); drive(0,49);}

while(1) {      /* Ciclo principale */
        drive(0,100);
        while((loc_x()<860)&&(speed()>40)) kill();
        drive(0,40);
        while(speed()>49) kill();

        drive(180,100);
        while((loc_x()>760)&&(speed()>40)) kill();
        drive(180,40);
        while(speed()>49) kill();
        }
}

/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/

kill()
{
if ((rng=scan(ang,10))&&(rng<700)) find();      /* Cerca un nemico */
else {ang=(ang+50)%360; return;}

oang=ang; orng=rng;
find();
ang+=ang-oang;
rng+=rng-orng;
if(rng>0) cannon(ang,rng);      /* Spara */
if(rng>700) ang=(ang+40)%360;   /* Se e' troppo lontano, ne cerca un altro */
}

/******* **** *** ** * *  *   *      *      *   *  * * * ** *** **** *******/

find()  /* INdividua il nemico con una precisione di 6 gradi */
{
if (scan(ang-5,5)) ang-=5;
if (scan(ang+5,5)) ang+=5;
if (rng=scan(ang+3,3)) ang+=3;
if (rng=scan(ang-3,3)) ang-=3;
return;
}

