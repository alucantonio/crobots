/*

 ######  ######  ####      ##
   ##    ##      ##  ##    ##
   ##    ##      ##    ##  ##
   ##    ####    ##    ##  ##
   ##    ##      ##    ##  ##
  ##     ##      ##    ##  ##
###      ######  ########  ##

Crobots 	: Jedi
Type		: Macro
Version 	: 6.0
Author		: Maurizio Camangi
Begin		: 30-ott-2002
Revision	: 22-ott-2003

Jedi6 è una lieve evoluzione di Jedi5 del 2002.
Di Jedi5 mantiene il movimento a forma di "J". Jedi6 interrompe il movimento
se non è troppo danneggiato e se i nemici sono troppo lontani.
La differenza con Jedi5 consiste nell'utilizzo di una diversa
routine f2f: nel caso in cui sia rimasto un solo sopravvissuto adotta un movimento al centro dell'arena
di forma quadrata, ruotata di circa 10 gradi in senso antiorario, che varia in base alla
distanza del nemico.

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
    dam,        /* Variabile temporanea salva danni subiti              */
    dir,        /* Direzione del cammino                                */
    posx,
    posy,       /* Variabili temporanee ad un bit salva posizione       */
    deg,enemy,dist,
    dist1,dist2,
    timer;      /* Massimo numero di cicli virtuali                     */

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

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


/* Routine finale */

fire4()
{
  drive(dir,100);
  if (range=scan(oang=ang,10))
  {    

    if (scan(ang+350,10)) ang+=355; else ang+=5;
    if (scan(ang+350,10)) ang+=357; else ang+=3; 
    
    cannon(ang+ang-oang,(scan(ang,10)<<1)-range); 

  } else {
        if (range=scan(ang+=340,10)) return cannon(ang,range);
        if (range=scan(ang+=40,10))  return cannon(ang,range);
        if (range=scan(ang+=300,10)) return cannon(ang,range);
        if (range=scan(ang+=80,10))  return cannon(ang,range);
        if (range=scan(ang+=260,10)) return cannon(ang,range);
        if (range=scan(ang+=120,10)) return cannon(ang,range);
        if (range=scan(ang+=220,10)) return cannon(ang,range);
        if (range=scan(ang+=160,10)) return cannon(ang,range);
        if (range=scan(ang+=180,10)) return cannon(ang,range);
        ang+=270; 
  }
}

last() {
	while (1) {
		while (loc_x() < dist1) { fire4(); }
		dir=100;
		while (loc_y() < dist1) { fire4(); }
		dir=190;
		while (loc_x() > dist2) { fire4(); }
		dir=280;
		while (loc_y() > dist2) { fire4(); }
		dir=10;
		dist2=1000-(dist1=(750 - 200*(range>300)));
	}
}


main() /* Inizializza alcune variabili ed innesca la routine principale */
{


 ang=timer=1;


 va(1000*(posy=loc_y(posx=loc_x()>500)>500),270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 dist2=1000-(dist1=850);
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
		   degree(750,500);
                   stop();
                   last();
                }
                else timer=9999;
            else timer=50;
 }
}

/* May the Force be with you */
/* Dedicated to RDX */