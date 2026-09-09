/*

Crobots  : Jedi
Version  : 4.0
Author   : Maurizio Camangi
Begin    : 31-lug-2001
Revision : 26-ago-2001

Jedi4 utilizza una strategia relativamente semplice derivata da Fremen
(torneo2000). Jedi4 oscilla con un movimento a "J" su ciascun angolo:
in questo modo e` in grado di colpire il suo avversario per poi cambiare
subito direzione, rendendo piu` difficile l'attacco da parte del robot nemico.
Questo movimento viene eseguito se i danni sono minori di una certa soglia
oppure se un robot nemico e` a tiro; in caso contrario rimane fermo.
Il movimento oscillatorio viene portato avanti finche' non rimane un solo
avversario. A questo punto se non e` troppo danneggiato Jedi4 lo attacca
con la routine finale del robot Boom.r (torneo 2000).

                                ATTENZIONE

QUESTO C-ROBOT E' FATTO DI BIT AL 100%
NEL CASO IMPROBABILE CHE VENGA A CONTATTO CON ANTI-BIT DI QUALUNQUE TIPO
NE RISULTERA' UN'ESPLOSIONE.

                                AVVERTENZA

UN GIORNO, L'INTERO UNIVERSO (COMPRESO QUESTO C-ROBOT) POTREBBE COLLASSARE
IN UN PUNTO INFINITAMENTE PICCOLO. SE UN ALTRO UNIVERSO DOVESSE IN SEGUITO
EMERGERNE, L'ESISTENZA (ED IL FUNZIONAMENTO) DI QUESTO C-ROBOT IN
QUELL'UNIVERSO NON PUO' ESSERE GARANTITO.

*/

int ang,        /* Angolo di scanning                                   */
    oang,       /* Angolo di scanning precedente                        */
    range,      /* Gittata corrente                                     */
    orange,     /* Gittata precedente                                   */
    drange,
    spd,        /* 1 se in movimento, 0 altrimenti                      */
    dam,        /* Variabile temporanea salva danni subiti              */
    dir,        /* Direzione del cammino                                */
    posx,
    posy,       /* Variabili temporanee ad un bit salva posizione       */
    deg,enemy,dist,deg,alfa,corr,anco,verso,
    timer;      /* Massimo numero di cicli virtuali                     */

va(x,d) { /* Si sposta nella direzione x, con distanza d dal punto di arrivo*/
 drive(dir=d,100);
 if (dir==90) while((dist=(x - loc_y()))>75) fire();
 else if (dir == 270) while((dist=(loc_y() - x))>75) fire();
 else if (dir == 180) while((dist=(loc_x()-x))>75) fire();
 else while((dist=(x-loc_x()))>75) fire();
 stop();
}

scan_() {

        if(scan(ang+352,4)) ang+=352;
        if(scan(ang+8,4)) ang+=8;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+359,1)) ang+=359;
        if(scan(ang+1,1)) ang+=1;
}

/* Funzioni di gestione del fuoco */

fire()
{
   --timer;
   if (dist > 160)
     if (orange=scan(ang,10)) {
        if (orange>700) return fire2();
        else {
           scan_();
           if (orange=scan(oang=ang,5))
             {
                scan_();
                if (range=scan(ang,10))
                  {
                     return cannon(ang+(ang-oang)*((1200+range)>>9)-((spd=speed()>0)*sin(ang-dir)>>14),
                                   range*172/(172+orange-range-(spd*cos(ang-dir)>>12)));
                  }
             } else return fire2();
        }
     } else return search();
   else return fire2();
}

fire2() /* Thanks to Simone */
{
     if((orange=scan(ang,10))&&(orange<770))
     {
           if (range=scan(ang+353,4))
               cannon(ang+=353,range);
           else if (range=scan(ang,3))
                    cannon(ang,range);
           else if (range=scan(ang+7,4))
                    cannon(ang+=7,range);
     }
     else
         if((range=scan(ang+=339,10)))
             cannon(ang,range);
       else
           if((range=scan(ang+=42,10)))
               cannon(ang,range);
         else
                 return (ang+=40);
}

search()
{
             if (range=scan(ang+=340,10));
             else if (range=scan(ang+=40,10));
             else if (range=scan(dir,10))
                 ang=dir;
             else
                  return (ang+=40);
             return cannon(ang,2*scan(ang,10)-range);
}

radar(x) /* Restituisce 1 se la direzione x e` libera da nemici         */
{
        return( !(scan(x+351,10) || scan(x+9,10)));
}

dista(x,y)
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()          /*  Fermati!      */
{
        drive(dir,0);
        while (speed() > 49)
         if ((range=scan(ang,10))&&(range<770))
           cannon(ang,range);
         else search();
}

/******** from Boom.r, Thanks to Mick Messina ***************/

spara()
{
        ++timer;
        if ((range=scan(ang, 10)) ) {

                if (scan(ang-8,4)) {
                        if (scan(ang-=8+3,2)) {
                                if(scan(ang+=3-2,1)) ang-=2;
                        }  else if (scan(ang-3,2)) ang-=3;
                } else if(scan(ang+8,4)) {
                        if (scan(ang+=8+3,2)) ang+=3;
                        else --ang;
                }  else if(scan(ang+3,2)) ang+=3;
                else --ang;

        }  else if ((range=scan(ang-=20,10))) {
                if (scan(ang-8,4)) {
                        if (scan(ang-=8-3,2)) ang-=3;
                        else ++ang;
                } else if(scan(ang+7,4)) ang+=7;
        }  else if ((range=scan(ang+=40,10))) {
                if (scan(ang+7,4)) ang+=7;
        }  else if (!(range=scan(ang+=20,10))) {
                if ((range=scan(ang+=21,10))) {
                        if (range>800) {
                                cannon(ang,700);
                                /*if(!att) ang+=57;*/
                                return;
                        }
                } else {
                        if (!(scan(ang+=21,10))) ang+=40;
                        return;
                }
        }
        if (orange=scan(ang,10)){
                cannon (ang, orange*165/(165+range-orange) );
                /*
                if(orange>720) if(!att) if(orange>range || orange>800) {
                                ang+=57;
                                range=0;
                        }
                */

        }  else if(scan(ang-20,10)) ang-=20;
        else if(!scan(ang+=21,10)) ang+=57;
}

boom()
{
int b=0;
            while(1) {
                if(timer%2) {
                        if ((posy=loc_x())>910 ) dir=180;
                        else if (posy<90 ) dir=360;
                        else if ((posy=loc_y())>910 ) dir=270;
                        else if (posy<90) dir=90;
                        else dir=ang+65+(b^=1)*205;/*65*/
                        spara(drive(dir,100));
                } else {
                        if(range>480) fire(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}


main() /* Inizializza alcune variabili ed innesca la routine principale */
{

 ang=timer=1;

 va(1000*(posy=loc_y(posx=loc_x()>500)>500),270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 while (1)
 {
        dam=damage()+15;
        while ((damage()<dam) && (timer>0)) {
         if ((damage()<70 /*60*/) || (orange && (orange<740))) {
           va(350+300*posx,360 - 180*posx);
           va(1000*posx,180+180*posx);
           va(350+300*posy,90 + 180*posy);
           va(1000*posy,270 - 180*posy);
         } else fire();
        }
        if (timer<=0) { /* Controllo cicli/CPU trascorsi        */
          deg=9; enemy=0;
          while((deg+=20)<379) enemy+=(scan(deg,10)>0);
            if (enemy<2)
                if (damage() < 80) {
                   drive(dir=(360+((posx=500-loc_x())<0)*180+atan(((500-loc_y())*100000)/posx)),100);
                   while(dista(500,500)>15000) fire();
                   stop();
                   boom();
                }
                else timer=9999;
            else timer=50;
        } else {
         if(radar(dir=90+180*posy)) va(1000*(dir==90),dir);
         else va(1000*((dir=360 - 180*posx)==180),dir);
        }
         posx=loc_x()>500;
         posy=loc_y()>500;
 }
}