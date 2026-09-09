/*

Crobots  : Borg
Version  : 1.0
Author   : Maurizio Camangi
Begin    : 26-ago-2001
Revision : 30-set-2001

Borg esegue un movimento a forma di quadrato nel proprio angolo che non viene mai abbandonato.
Utilizza tecnologia "reciclata" da Fremen e come funzione di attacco finale quella di Boom.

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
    ang_1,
    ang_2,      /* Direzioni d'attacco statiche dei quattro lati        */
    posx,
    posy,       /* Variabili temporanee ad un bit salva posizione       */
    deg,enemy,dist,deg,alfa,corr,anco,verso,
    timer;      /* Massimo numero di cicli virtuali                     */

va(x,d) { /* Si sposta nella direzione x, con distanza d dal punto di arrivo*/
 int lim;
 if ((d == ang_1) || (d == ang_2)) lim=0;
 else lim=70;
 drive(dir=d,100);
 if (dir==90) while((x - loc_y()) > lim) fire3();
 else if (dir == 270) while((loc_y() - x) > lim) fire3();
 else if (dir == 180) while((loc_x()-x) > lim) fire3();
 else while((x-loc_x()) > lim) fire3();
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
  /* --timer;
   if (dist > 160) {*/
     if (orange=scan(ang,10)) {
        if (orange>740) return fire3();
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
                  else return cannon(oang,orange);
             } else return fire3();
        }
     } else return search();
   /*}
   fire3();*/
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

/* fuoco veloce */
fire3() {
  --timer;
  if (orange=scan(ang,10)) {
         if (range=scan(ang,1))   return cannon(ang,range);
    else if (range=scan(ang-5,4)) return cannon(ang-=3,range);
    else if (range=scan(ang+5,4)) return cannon(ang+=3,range);
  }
  else if (range=scan(ang-=20,10)) return cannon(ang,range);
  else if (range=scan(ang+=40,10)) return cannon(ang,range);
  else return ang+=40;
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

radar(x) /* Restituisce 1 se la direzione x e` occupata da nemici       */
{
        return(scan(x+351,10) || scan(x+9,10));
}

dista(x,y)
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()          /*  Fermati!      */
{
 drive(dir,0);
 while (speed() > 50) {
    if (orange=scan(ang,10)) {
      oang=ang;
      if (scan(ang+=5,5)); else ang-=10;
      if (scan(ang+=3,3)); else ang-=6;

      if (range=scan(ang,10))
        cannon(ang+(ang-oang),range+(range-orange)*2);
    }
    else search();
  }
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
 int x;

 ang=timer=1;
 posx=loc_x()>500;
 posy=loc_y()>500;

 ang_1 = 90 + 180*posy;
 ang_2 = 360 - 180*posx;

 va(1000*posy,270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 while (1)
 {
        /* dam=damage()+15; */
        while (timer>0) {
         /*if ((damage()<70) || (orange && (orange<740))) {*/
           if (radar(ang_2)) ang = ang_2;
           va(150+700*posx,ang_2);
           va(150+700*posy,ang_1);
           if (radar(ang_1)) ang = ang_1;
           va(1000*posx,180+180*posx);
           va(1000*posy,270 - 180*posy);
         /*} else fire();*/
        }
        if (timer<=0) { /* Controllo cicli/CPU trascorsi        */
          deg=9; enemy=0;
          while((deg+=20)<379) enemy+=(scan(deg,10)>0);
            if (enemy<2)
                if (damage() < 80) {
                   drive(dir=(360+((x=500-loc_x())<0)*180+atan(((500-loc_y())*100000)/x)),100);
                   while(dista(500,500)>15000) fire();
                   stop();
                   boom();
                }
                else timer=9999;
            else timer=70;
        }
         posx=loc_x()>500;
         posy=loc_y()>500;
 }
}