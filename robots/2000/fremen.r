/*

Crobots  : Fremen
Version  : 2.0
Author   : Maurizio Camangi
Begin    : 16/01/2000
Revision : 27/09/2000

Fremen utilizza una strategia relativamente semplice.
Poiche' i robot avversari si nascondono negli angoli Fremen oscilla con un
movimento a "J" (come Jedi'97) su ciascun angolo: in questo modo e` in grado
di colpire il suo avversario per poi cambiare subito direzione, rendendo
piu` difficile l'attacco da parte del robot nemico.
Questo movimento viene eseguito se i danni sono minori di una certa soglia
oppure se un robot nemico e` a tiro; in caso contrario rimane fermo.
Il movimento oscillatorio viene portato avanti finche' non rimane un solo
avversario. A questo punto se non e` troppo danneggiato Fremen lo attacca
con la routine finale, identica al robot Jaja.r del '96.

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
    drange,
    spd,	/* 1 se in movimento, 0 altrimenti			*/
    dam,	/* Variabile temporanea salva danni subiti		*/
    dir,        /* Direzione del cammino                        	*/
    posx,
    posy,       /* Variabili temporanee ad un bit salva posizione	*/
    deg,enemy,dist,deg,alfa,corr,anco,verso,
    timer;	/* Massimo numero di cicli virtuali			*/

va(x,d) { /* Si sposta nella direzione x, con distanza d dal punto di arrivo*/
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

/* Funzioni di gestione del fuoco -- Thanks Simone!	*/

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
		     spd=speed()>0;
		     return cannon(ang+(ang-oang)*((1200+range)>>9)-(spd*sin(ang-dir)>>14),
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

radar(x) /* Restituisce 1 se la direzione x e` libera da nemici		*/
{
	return( !(scan(x+351,10) || scan(x+9,10)));
}

dista(x,y)
int x,y;
{
	return (((x-=loc_x())*x+(y-=loc_y())*y));
}

stop()		/*  Fermati!	  */
{
	drive(dir,0);
        while (speed() > 49)
	 if ((range=scan(ang,10))&&(range<770))
	   cannon(ang,range);
	 else search();
}

/* Jaja'96 di Luigi Rafaiani -- Thanks! */

jaja() {

while (1)
	{
	verso = 180;
	while (loc_x() > 250) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 90;
	while (loc_y() < 750) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 360;
	while (loc_x() < 750) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	verso = 270;
	while (loc_y() > 250) colpire();
	dam = damage();
	while (dam == damage()) fcolp();
	}
}

colpire()

{
fuoco();
dir = verso+50;
drive (dir,100);
fuoco();
dir = verso-50;
drive (dir,100);
}

fcolp()

{
fuoco();
dir = verso+90;
drive (dir,100);
fuoco();
dir = verso-90;
drive (dir,100);
}

find()

{

if ( orange = scan(ang,10) )  
 { if ( scan(ang+6,5) )
   {  if ( scan(ang+2,2) )
      {  if ( scan(ang+4,1) ) 
	 {  if ( scan(ang+3,0) ) 
	     ang+=3; 
	    else
	     ang+=4;
	 }
	 else
	    if ( scan(ang+2,0) )
	     ang+=2; 
	    else
	     ang+=1; 
      }
      else
      {  if ( scan(ang+8,1) ) 
	 {  if ( scan(ang+7,0) ) 
	     ang+=7; 
	    else
	     ang+=9;
	 }
      else
	 if ( scan(ang+6,0) )
	    ang+=6; 
	 else
	    ang+=5; 
      }
   }
   else
   {  if ( scan (ang-1,2) )
      {  if ( scan(ang-3,1) )
	 {  if ( scan(ang-2,0) ) 
	     ang-=2;
	    else
	     ang-=3;        
	 }
	 else
	   if ( scan(ang-1,0) )
	    ang-=1;
	   else
	    ang-=0;        
      }
      else
      {  if ( scan(ang-4,1) )
	 {  if ( scan(ang-5,0) ) 
	     ang-=5;
	    else
	     ang-=4;        
	 }
	 else
	   if ( scan(ang-6,1) )
	    ang-=6;
	   else
	    ang-=8;        
      }
   }
 return 1;
 }
else 
 { if ( orange = scan(ang+15,5) )
   {  if ( scan(ang+12,2) )
      {  if ( scan(ang+14,1) ) 
	 {  if ( scan(ang+13,0) ) 
	     ang+=13; 
	    else
	     ang+=14;
	 }
	 else
	    if ( scan(ang+12,0) )
	     ang+=12; 
	    else
	     ang+=11; 
      }
      else
      {  if ( scan(ang+18,1) ) 
	 {  if ( scan(ang+17,0) ) 
	     ang+=17; 
	    else
	     ang+=19;
	 }
      else
	 if ( scan(ang+16,0) )
	    ang+=16; 
	 else
	    ang+=15; 
      }
   }
   else
   {  if ( orange = scan (ang-13,2) )
      {  if ( scan(ang-11,1) )
	 {  if ( scan(ang-11,0) ) 
	     ang-=11;
	    else
	     ang-=12;        
	 }
	 else
	   if ( scan(ang-13,0) )
	    ang-=13;
	   else
	    ang-=14;        
      }
      else
      {  if ( orange = scan(ang-17,1) )
	 {  if ( scan(ang-16,0) ) 
	     ang-=16;
	    else
	     ang-=17;        
	 }
	 else
	   if ( scan(ang-18,1) )
	    ang-=18;
	   else
	    return 0;        
      }
   }
 return 1;
 }
}

fuoco()         
{
/* se individui un bersaglio spara                           */
if ( find() )
   {
   spara();
   }
else    
   {
   ang += 29;
   drive (dir,40); 
   while ( ! scan(ang,10) ) ang += 19;
   while (speed() > 40) ;
   }
}

spara()
 
{
 
drive (dir,100);

oang=ang;
 
if ( find() )
 {    
 drive (dir,40);
    
 alfa = (ang-dir) - ((ang-dir)/360)*360;
 
 corr = cos(alfa);
 anco = - sin(alfa);
    
 deg = ang + (ang-oang)*3 + anco/17000;
   
 if (range=scan(ang,10)) 
   {
   drange =  range*350/(350+orange-range-corr/3000); 
   while ( ! cannon ( deg, drange ) ) ;
   }
 else   
   {
   drange = orange;
   cannon ( deg, drange);
   }
 }
else
 {
 drive (dir,40);
 ang += 29;
 while ( ! scan (ang,10) ) ang += 19;
 while (speed() > 40);
 }

}

main() /* Inizializza alcune variabili ed innesca la routine principale	*/
{
 ang=timer=1;
 posx=loc_x()>500;
 posy=loc_y()>500;
 va(1000*posy,270 - 180*posy);
 va(1000*posx,180 + 180*posx);
 while (1)
 {
	dam=damage()+15;
	while ((damage()<dam) && (timer>0)) {
         if ((damage()<60 /*50*/) || (orange && (orange<740))) {
	   va(350+300*posx,360 - 180*posx);
	   va(1000*posx,180+180*posx);
	   va(350+300*posy,90 + 180*posy);
	   va(1000*posy,270 - 180*posy);
         } else fire();
	}
	if (timer<=0) { /* Controllo cicli/CPU trascorsi	*/
	  deg=9; enemy=0;
	  while((deg+=20)<379) enemy+=(scan(deg,10)>0);
	    if (enemy<2)
		if (damage() < 80) {
                   drive(dir=(360+((posx=500-loc_x())<0)*180+atan(((500-loc_y())*100000)/posx)),100);
                   while(dista(500,500)>15000) fire();
                   stop();
		   jaja();
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
