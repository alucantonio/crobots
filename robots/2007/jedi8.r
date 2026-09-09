/*

 ======  ======  ====      ==
   ==    ==      ==  ==    ==
   ==    ==      ==    ==  ==
   ==    ====    ==    ==  ==
   ==    ==      ==    ==  ==
  ==     ==      ==    ==  ==
===      ======  ========  ==

Crobots 	: Jedi
Type			: Macro
Version 	: 8.11
Author		: Maurizio Camangi
Begin			: 19-ago-2006
Revision	: 29-ago-2006

Jedi8 è stato sviluppato a partire dal micro Rat-Man. E' stato mantenuto il movimento
oscillatorio nell'angolo. Come la tradizione impone, la funzione di fuoco è vergognosamente
copiata dal robot del vincitore dell'ultima edizione del torneo totale
(quello con tutti i robot di sempre), nel nostro caso Daniele Nuzzo.

L'attacco finale è a forma di quadrato che cambia ampiezza se si subiscono danni superiori
all'11% durante una singola rotazione.

Test statistici sono stati utilizzati per calibrare al meglio alcune costanti del codice.
*/

int
	ang,
	oang,
	range,
	orange,
	dam,        /* Variabile temporanea salva danni subiti              */
	dir,        /* Direzione del cammino                                */
	posx,
	posy,
	x,y,       /* Variabili temporanee ad un bit salva posizione       */
	dif,
	dist,
	flag;

fire(dir)
{
  int asin,acos;
  /*if (safe) return;*/
  if (speed()<100) drive(dir,100); 
      
  if (scan(ang,10)>50)
  {  
      asin=(sin(ang-dir)/14384);
      acos=(cos(ang-dir)/3796)-230;

      ang-=18*(scan(ang-18,10)>0);  
      ang+=18*(scan(ang+18,10)>0); 

      if(scan(ang-16,10)) ang-=8;
      else if(scan(ang+16,10)) ang+=8;
      if(scan(ang-12,10)) ang-=4;
      else if(scan(ang+12,10)) ang+=4;
      if(scan(ang-11,10)) ang-=2;
      if(scan(ang+11,10)) ang+=2;

      if (orange=scan(oang=ang,3))
        {
            if(scan(ang-13,10)) ang-=5;
            else if(scan(ang+13,10)) ang+=5; 
            if(scan(ang+12,10)) ang+=4;
            else if(scan(ang-12,10)) ang-=4;
            if(scan(ang-11,10)) ang-=2;
            if(scan(ang+11,10)) ang+=2;

            cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin,
                   range*230/(orange-range-acos)); 
        }  else search(); 
  } else search();  
}

search()
{
  if (scan(ang-=350,10)) return fire2();
  if (scan(ang-=20,10))  return fire2();
  if (scan(ang-=320,10)) return fire2();
  if (scan(ang-=60,10))  return fire2();
  if (scan(ang-=280,10)) return fire2();
  if (scan(ang-=100,10)) return fire2();
  if (scan(ang-=240,10)) return fire2();
  if (scan(ang-=140,10)) return fire2();
  if (scan(ang-=200,10)) return fire2();
  if (scan(ang-=180,10)) return fire2();
  if (scan(ang-=160,10)) return fire2();
  if (scan(ang-=220,10)) return fire2();
  if (scan(ang-=120,10)) return fire2();
  if (scan(ang-=260,10)) return fire2();
  if (scan(ang-=80,10))  return fire2();
  if (scan(ang-=300,10)) return fire2();
  if (scan(ang-=40,10))  return fire2();
  if (scan(ang-=340,10)) return fire2();
}

fire2()
{

  if (range=scan(oang=ang,10)) {
    if (range>500) return cannon(ang,range);
    if (scan(ang+350,10)) ang+=355; else ang+=5;
    if (scan(ang+350,10)) ang+=357; else ang+=3; 
    cannon((ang<<1)-oang,(scan(ang,10)<<1)-range);
  } else search();   
}

stop(dir)
{
  drive(dir,0);  
  while(speed()>59) ;
  drive(dir,100);
}

_scan_()  
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}

int run_(safe)
int safe;
{
 drive(dir,100);
 if (safe);
 else if (scan(ang,10))
    {
      if ((orange=_scan_())<850)
        {
          if (range=_scan_())               
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*220/(220+orange-range-(cos(ang-dir)/4167))));
        }
    }     
  if ((range=scan(ang,10))&&(range<850));
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

degree(x,y) /* Direzione per x,y */
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}

dista(dx,dy) /* Distanza al quadrato (evita una sqrt())   */
int dx,dy;
{
        return (((dx-=loc_x())*dx+(dy-=loc_y())*dy));
}

corner() { /* Si avvicina al corner */
	degree(x=20+960*posx,y=20+960*posy);
	while((dist=dista(x,y)) > 8100) run_(dist<25600);
	drive(dir,0);
}

main() /* Inizializza alcune variabili ed innesca la routine principale */
{
int dist3,timer,deg,l,dif,d, up, low, clock;

/*
* Setup main variables
*/

 up=850;
 low=300;
 posy=loc_y(posx=loc_x(dist3=123450)>500)>500;
 dif=(60*(posx^posy))-30;
 
 corner(clock=0);

 while (1)
 {
    while (--timer>-1) {
    	dir=flag*(540*posx - dif) + (!flag)*(90 + 180*posy + dif);
			while(dista(x,y) < (dist3-4925*(damage()>d))) fire(dir); drive(dir,0);
			d=damage(corner(flag^=1))+4;
    }
    l=(deg=(90*((posy<<1)+(posx^posy))+320))+131;
    while((deg < l) && (timer<1)) { timer+=(scan(deg+=20,10)>0); }
    if (timer<1) {
			while(1) {
				d=damage();
				/*
				Senso Orario (in senso antiorario perde circa il 20%)
				*/
				while(loc_x() < up)  fire(0);   stop(270);
				while(loc_y() > low) fire(270); stop(180);
				while(loc_x() > low) fire(180); stop(90);
				while(loc_y() < up)  fire(90);  stop(0);
								
				if ((damage()-d)>11) { /* Cambia ampiezza */
					if (clock^=1) {
						up=600; low=150;
					} else {
						up=850; low=300;
					}
				}
			}
    }
 }
}

/* May the Force be with you! */
