/*


Crobots  : Jedi
Version  : 5.02
Author   : Maurizio Camangi
Begin    : 02-ott-2002
Revision : 31-ott-2002


Jedi5 utilizza una strategia relativamente semplice derivata da Jedi4
(torneo2001). Jedi5 oscilla con un movimento a "J" sull'angolo:
in questo modo e` in grado di colpire il suo avversario per poi cambiare
subito direzione, rendendo piu` difficile l'attacco da parte del robot nemico.
Questo movimento viene eseguito se i danni sono minori di una certa soglia
oppure se un robot nemico e` a tiro; in caso contrario rimane fermo.
Jedi5 non cambia mai angolo.
Il movimento oscillatorio viene portato avanti finche' non rimane un solo
avversario. A questo punto se non e` troppo danneggiato Jedi5 lo attacca
con la routine finale del robot Rudolf_6.r (torneo 2001).


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
    deg,enemy,dist,b,
    timer;      /* Massimo numero di cicli virtuali                     */


va(x,d) { /* Si sposta nella direzione x, con distanza d dal punto di arrivo*/
 drive(dir=d,100);
 if (dir==90) while((dist=(x - loc_y()))>75) fire3();
 else if (dir == 270) while((dist=(loc_y() - x))>75) fire3();
 else if (dir == 180) while((dist=(loc_x()-x))>75) fire3();
 else while((dist=(x-loc_x()))>75) fire3();
 stop();
}


/* Funzioni di gestione del fuoco */


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


scan_()   
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}


scan2_() {


        if(scan(ang+352,4)) ang+=352;
        if(scan(ang+8,4)) ang+=8;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+359,1)) ang+=359;
        if(scan(ang+1,1)) ang+=1;
}


/* Funzione di fuoco da fermo*/


fire()
{
   --timer;
     if (orange=scan(ang,10)) {
        if (orange>700) return fire2();
        else {
           scan_();
           if (orange=scan(oang=ang,5))
             {
                scan_();
                if (range=scan(ang,10))
                  {
                     return cannon(ang+(ang-oang)*((1200+range)>>9),
                                   range*172/(172+orange-range));
                  }
             } else return fire2();
        }
     } else return search();
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


/* Funzione di fuoco in movimento */


fire3()
{
  --timer;
  if (dist <= 160);
  else if (scan(ang,10))
    {
      if ((orange=scan_(/*drive(dir,100)*/))<850)
        {
          if (range=scan_())                
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*200/(200+orange-range-(cos(ang-dir)/4167))));
        }
    }      
  if((range=scan(ang,10))&&(range<850));
  else
    if((range=scan(ang+=339,10)));
    else
      if((range=scan(ang+=42,10)));
      else
        if((range=scan(dir,10))) ang=dir;
        else
          return (ang+=40);
  cannon (ang,2*scan(ang,10)-range);
}


stop()          /*  Fermati!      */
{
        fire3(fire3(drive(dir,0)));
}


/******** Thanks to Alex Carlin ***************/


Fuoco()
{
    if (orange=scan(oang=ang,10)) {
        if (!scan(ang+=355,5)) ang+=10;
        if (!scan(ang+=357,3)) ang+=6;
        cannon(ang+(ang-oang),2*scan(ang,10)-orange);        
    } 
    else {
        if (orange=scan(ang+=340,10)) return cannon(ang,orange);
        if (orange=scan(ang+=40,10)) return cannon(ang,orange);
        if (orange=scan(ang+=300,10)) return cannon(ang,orange);
        if (orange=scan(ang+=80,10)) return cannon(ang,orange);
        ang+=60;
    }
}


udo(){
while(loc_x()>500) {while(loc_y()>885) {drive(240,100);Fuoco();}
                    while(loc_y()<885) {drive(120,100);Fuoco();}
                    }
}


uso(){
while(loc_x()<500) {while(loc_y()>885) {drive(300,100);Fuoco();}
                    while(loc_y()<885) {drive(60,100);Fuoco();}
                    }
}


ddo(){
while(loc_x()>500) {while(loc_y()>115) {drive(240,100);Fuoco();}
                    while(loc_y()<115) {drive(120,100);Fuoco();}
                    }
}


dso(){
while(loc_x()<500) {while(loc_y()>115) {drive(300,100);Fuoco();}
                    while(loc_y()<115) {drive(60,100);Fuoco();}
                    }
}


fine()
{
if (b==0) dso();
else if (b==1) ddo();
else if (b==2) udo();
else uso();
while(1)
{
while(loc_y()>150) {while(loc_x()>500) {drive(190,100);Fuoco();}
                    while(loc_x()<500) {drive(350,100);Fuoco();}
                    }
while(loc_y()<850) {
                    while(loc_x()>500) {drive(170,100);Fuoco();}
                    while(loc_x()<500) {drive(10,100);Fuoco();}
                    }
}
}


/* ---- */


main() /* Inizializza alcune variabili ed innesca la routine principale */
{


 ang=timer=1;


 va(1000*(posy=loc_y(posx=loc_x()>500)>500),270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 b=posy*2+posx;
 while (1)
 {
        while (timer>0) {
         if ((damage()<70 /*60*/) || (orange && (orange<740))) {
           va(350+300*posx,360 - 180*posx);
           va(1000*posx,180+180*posx);
           va(350+300*posy,90 + 180*posy);
           va(1000*posy,270 - 180*posy);
         } else fire();
        }
          deg=9; enemy=0;
          while((deg+=20)<379) enemy+=(scan(deg,10)>0);
            if (enemy<2)
                if (damage() < 80) {
                   stop();
                   fine();
                }
                else timer=9999;
            else timer=50;
 }
}
