/*

Crobots 	: Tobey
Type			: Micro
Version 	: 1.00
Author		: Maurizio Camangi
Begin			: 16-ago-2006
Revision	: 16-ago-2006

Questo micro robot è la dimostrazione di come il connubio fra pigrizia, mancanza di tempo e
mancanza di fantasia possa essere imbarazzante.
Ovviamente la routine di fuoco è tratta dal vincitore dell'ultimo torneo.

Il micro esegue una rotazione in senso orario vicino all'angolo,
a forma di quadrato, di lato lungo quasi 500 unità per tutto il tempo.
In pratica non ha nessuna routine di attacco finale.

Nei test mi sono accorto che l'efficienza aumentava linearmente con l'ampiezza dell'oscillazione.
*/

int
dir,
posx,
posy,
ang,
oang,
range,
orange,
timer,
step, x1, x2, y1, y2;

stop(dir)
{
  while(speed(drive(dir,0))>59) ;
  drive(dir,100);
}

fire(dir)
{
  int asin,acos;
  
  if (speed()<100) drive(dir,100); else { if (scan(dir,10)) ang=dir; if (range>850) { ang+=120; } }
      
  if (scan(ang,10)) {  
    asin=(sin(ang-dir)/14384); 
    acos=(cos(ang-dir)/3796)-230;

    find();
    if (orange=scan(oang=ang,3)) {
      find();
      cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin,
             range*230/(orange-range-acos)); 
    }  else search(); 
  } else search();  
}

find()
{
  if(scan(ang-13,10)) ang-=5;
  else if(scan(ang+13,10)) ang+=5;
  if(scan(ang+12,10)) ang+=4;
  else if(scan(ang-12,10)) ang-=4;
  if(scan(ang-11,10)) ang-=2;
  if(scan(ang+11,10)) ang+=2;
}

search()
{
  if (range=scan(ang+=350,10)) return cannon(ang,range);
  if (range=scan(ang+=20,10))  return cannon(ang,range);
  if (range=scan(ang+=320,10)) return cannon(ang,range);
  if (range=scan(ang+=60,10))  return cannon(ang,range);
  if (range=scan(ang+=280,10)) return cannon(ang,range);

  search(ang-=220);
}

main() {
int deg;

	y1=400 + 450*(posy=loc_y(posx=loc_x(dir=180)>500)>500);
	y2=150 + 450*posy;
	x1=150 + 450*posx;
	x2=400 + 450*posx;
	while(1) {
		if(step==0) while(loc_x() > x1) fire(180);
		else if(step==1) while(loc_y() < y1) fire(90);
		else if(step==2) while(loc_x() < x2) fire(0);
		else while(loc_y() > y2) fire(270);
		++step%=4;
		stop(dir+=270);
	}
}
