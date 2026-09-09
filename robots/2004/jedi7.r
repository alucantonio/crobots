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
Version 	: 7.26
Author		: Maurizio Camangi
Begin		: 18-dic-2003
Revision	: 19-ago-2004


Questa è una versione più complessa ed elaborata di Rat-Man. Ovvero fa più o meno le stesse cose, ma peggio...
La funzione d'attacco f2f è la stessa dello scorso anno, cambia solo l'angolo di rotazione.

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
    dif,dist;

degree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

dista(x,y) /* Distanza al quadrato (evita una sqrt())   */
int x,y;
{
        return (((x-=loc_x())*x+(y-=loc_y())*y));
}

va(x,f,s) {
int x,f,s;

 drive(dir,100);
 if (f==0) while((dist=(x - loc_y()))>75) fire3(s); /* Nord */
 else if (f==1) while((dist=(loc_y() - x))>75) fire3(s); /* Sud */
 else if (f==2) while((dist=(loc_x()-x))>75) fire3(s); /* Ovest */
 else while((dist=(x-loc_x()))>75) fire3(s); /* Est */
 stop();
}


/* Funzioni di gestione del fuoco */
search()
{
             if (range=scan(ang+=340,10));
             else if (range=scan(ang+=40,10));
             else if (range=scan(dir,10)) ang=dir;
             else return (ang+=40);
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
           if (range=scan(ang+353,4))    cannon(ang+=353,range);
           else if (range=scan(ang,3))   cannon(ang,range);
           else if (range=scan(ang+7,4)) cannon(ang+=7,range);
     }
     else if((range=scan(ang+=339,10))) cannon(ang,range);
     else if((range=scan(ang+=42,10)))  cannon(ang,range);
     else return (ang+=40);
}


/* Funzione di fuoco in movimento */


fire3(safe)
int safe;
{
  if (safe && (dist<=173));
  else if (scan(ang,10))
    {
      if ((orange=scan_(/*drive(dir,100)*/))<850)
        {
          if (range=scan_())                
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*220/(220+orange-range-(cos(ang-dir)/4167))));
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
          return (ang+=43);
  cannon (ang,2*scan(ang,10)-range);
}


stop()          /*  Fermati!      */
{
        fire3(fire3(drive(dir,0)));
}


/* Routine finale */

/* ovviamente il codice è scopiazzato da S. Ascheri, a cui invio un grosso grazie */

fire4()
{
    drive (dir,100);
    if (orange=scan(ang,10)) 
    {
           
           if (scan(ang,2)){if ((cannon(ang+0+0+0+0+0,3*scan(ang,10)-2*orange))) return;}
           else if (scan(ang-=7,5)){if ((cannon(ang-6+0+0,2*scan(ang,10)-orange))) return;}
           else if (scan(ang+=14,5)){if((cannon(ang+7,2*scan(ang,10)-orange))) return;}
           else if (scan(ang+=10,5)){if((cannon(ang+7,2*scan(ang,10)-orange))) return;}
	else ang+=15;
    } 
        else if (range=scan(ang+=340,10)) return (cannon(ang,range));
        else if (range=scan(ang+=40,10))  return (cannon(ang,range));
        else if (range=scan(ang+=300,10)) return (cannon(ang,range));
        else if (range=scan(ang+=80,10))  return (cannon(ang,range));
        else if (range=scan(ang+=260,10)) return (cannon(ang,range));
        else if (range=scan(ang+=120,10)) return (cannon(ang,range));
        else if (range=scan(ang+=220,10)) return (cannon(ang,range));
        else if (range=scan(ang+=160,10)) return (cannon(ang,range));
        else if (range=scan(ang+=180,10)) return (cannon(ang,range));
	else ang+=270;
	return fire4();
}

main() /* Inizializza alcune variabili ed innesca la routine principale */
{
int x,y,f,dist1,dist2,timer,enemy,deg,l;

 posy=loc_y(posx=loc_x(f=40)>500)>500;
 drive(degree(x=20+960*posx,y=20+960*posy),100);
 while((dist=dista(x,y)) > 8100) fire3(1);
 stop();
 dif=-30 + 60*(posx^posy);
 
 while (1)
 {
        while (--timer>0) {
         if ((damage()<70 /*60*/) || (orange && (orange<740))) {
           dir=360 - 180*posx - dif;
           va(350+300*posx,2+2*!posx,0);
           dir-=180;
           va(1000*posx,2+2*posx,1);
           dir=90 + 180*posy + dif;
           va(350+300*posy,posy,0);
           dir+=180;
           va(1000*posy,!posy,1);
         } else fire();
        }
          enemy=0; ; l=(deg=(90*((posy<<1)+(posx^posy))+320))+131;
          while((deg < l) && (enemy<2)) { enemy+=(scan(deg+=20,10)>0); }
          if (enemy<2) {
                
		   degree(750,500);
                   
		   while (1) {
			dist2=1000-(dist1=(600 - 100*(range>300)));
			while (loc_x() < dist1) { fire4(); }
			dir=105;
			while (loc_y() < dist1) { fire4(); }
			dir=195;
			while (loc_x() > dist2) { fire4(); }
			dir=285;
			while (loc_y() > dist2) { fire4(); }
			dir=15;
		   }
		
          } else timer=3+(f/=2);
 }
}

/* May the Force be with you */
