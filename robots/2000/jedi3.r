/*
                =====   ========   =====         =====
                =====   ========   ======        =====
                 ===     ===        ===  ==       ===
                 ===     ===        ===   ==      ===
                 ===     ======     ===    ==     ===
                 ===     ===        ===     ==    ===
             ==  ====   ========   ===========   =====
             ========   ========   ===========   =====

        JEDI ver.3.06c del 26-mag-2000

        (C) Copyright 2000 Maurizio Camangi

Jedi3 oscilla vicino a ciascun angolo tentando di schivare i colpi degli
avversari presenti negli angoli adiacenti, modificando la direzione di
oscillazione.
Quando rimane un solo avversario Jedi3 lo attacca portandosi al centro del
campo di battaglia ed oscillando trasversalmente, a 135 gradi di sfasatura,
rispetto al nemico.

				ATTENZIONE

QUESTO C-ROBOT E' FATTO DI BIT AL 100%
NEL CASO IMPROBABILE CHE VENGA A CONTATTO CON ANTI-BIT DI QUALUNQUE TIPO
NE RISULTERA' UN'ESPLOSIONE

				AVVERTENZA

UN GIORNO, L'INTERO UNIVERSO (COMPRESO QUESTO C-ROBOT) POTREBBE COLLASSARE
IN UN PUNTO INFINITAMENTE PICCOLO. SE UN ALTRO UNIVERSO DOVESSE IN SEGUITO
EMERGERNE, L'ESISTENZA (ED IL FUNZIONAMENTO) DI QUESTO C-ROBOT IN
QUELL'UNIVERSO NON PUO' ESSERE GARANTITO

*/

int ang,        /* Angolo di scanning                           	*/
    oang,	/* Angolo di scanning precedente			*/
    range,	/* Gittata corrente					*/
    orange,	/* Gittata precedente					*/
    spd,	/* 1 se in movimento, 0 altrimenti			*/
    dam,dam2,	/* Variabile temporanea salva danni subiti		*/
    dir,        /* Direzione del cammino                        	*/
    posx,
    posy,
    orz,        /* Variabili temporanee ad un bit salva posizione	*/
    deg,
    deg1,
    deg2,
    enemy,dist, /* Variabili temporanee per usi disparati               */
    timer;	/* Massimo numero di cicli virtuali			*/

va(x,d) { /* Funzione compatta di spostamento */
 drive(dir=d,100);
 if (dir==90) while((dist=(x - loc_y()))>75) fire();
 else if (dir == 270) while((dist=(loc_y() - x))>75) fire();
 else if (dir == 180) while((dist=(loc_x()-x))>75) fire();
 else while((dist=(x-loc_x()))>75) fire();
 stop();
}

scan_()	/* Versione presente in Coppi	*/
{
        if(scan(ang+354,1)) ang+=354;
        if(scan(ang+6,  1)) ang+=6;
        if(scan(ang+356,1)) ang+=356;
        if(scan(ang+4,  1)) ang+=4;
        if(scan(ang+358,1)) ang+=358;
        if(scan(ang+2,  1)) ang+=2;
}

fire()	/* Funzioni di gestione del fuoco - Thanks Simone	*/
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
		     spd=speed()>0;
		     return cannon(ang+(ang-oang)*((1200+range)>>9)-(spd*sin(ang-dir)>>14),
				   range*172/(172+orange-range-(spd*cos(ang-dir)>>12)));
		  }
	     } else return fire2();
	}
     } else return search();
   else return fire2();
}

fire2()
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

radar(x) /* Restituisce 1 se la direzione x e` libera da nemici		*/
{
	return( !(scan(x+351,10) || scan(x+9,10)));
}

dista(x,y)
int x,y;
{
	return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()		/*  Fermati!						*/
{
	drive(dir,0);
        while (speed() > 49)
	 if ((range=scan(ang,10))&&(range<770))
	   cannon(ang,range);
	 else search();
}

main() /* Inizializza alcune variabili ed innesca la routine principale	*/
{
 ang=timer=1;
 posx=loc_x()>500;
 posy=loc_y()>500;
 va(1000*posy,270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 while(1) {
   if (radar(dir=deg1=posx*180)) ;
   else deg2=dir=90+180*posy;
   dam=damage();
   while((!orange || orange > 400) && (dam<damage()+15) && (timer>0)) {
    dam2=damage()+4;
    if (orz=!(dir%180)) {
     va(350+300*posx,dir);
     va(1000*posx,180 + 180*posx);
    } else {
     va(350+300*posy,dir);
     va(1000*posy,270 - 180*posy);
    }
    if (dam2<damage())
     if(orz) dir=deg2;
     else dir=deg1;
    else dir=(dir+180)%360;
   }
   if (timer<=0) { /* Controllo cicli/CPU trascorsi	*/
	  deg=9; enemy=0;
	  while((deg+=20)<379) enemy+=(scan(deg,10)>0);
	    if (enemy<2)
		if (damage() < 80) {
		 while(dist=1000) {
  		   drive(dir=(360+((posx=500-loc_x())<0)*180+atan(((500-loc_y())*100000)/posx)),100);
		   while(dista(500,500)>15000) fire();
		   stop();
		   drive(dir=ang+135,100);
		   while(dista(500,500)<50000) fire();
		   stop();
		 }
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
