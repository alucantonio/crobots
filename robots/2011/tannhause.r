/*

Crobots 	: Tannhauser
Type			: Micro
Version 	: 1.00
Author		: Maurizio Camangi
Begin			: 04-nov-2010
Revision	: 25-dic-2010

Questo microbot è Tobey del 2006 con un'altra architettura.

Il micro esegue una rotazione in senso orario vicino all'angolo,
a forma di quadrato, di lato lungo quasi 500 unità per tutto il tempo.
In pratica non ha nessuna routine di attacco finale.
*/

int
posx,
posy,
ang,
oang,
range,
orange,
x1, x2, y1, y2;

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

wall(l,m) 
{
  int c1;
 	if (m<5) c1=loc_x(); else c1=loc_y();
  if (m%2) return (c1>l); else return (c1<l);	
}	

fire(dir,l,m)
{
  int asin,acos;
  while(wall(l,m))
  {
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
  while(speed(drive(dir,0))>59) ;
}

main()
{
	y1=400 + 450*(posy=loc_y(posx=loc_x()>499)>499);
	y2=150 + 450*posy;
	x1=150 + 450*posx;
	x2=400 + 450*posx;
	while(1)
  {
		fire(180,x1,3);
		fire(90,y1,8);
		fire(0,x2,2);
		fire(270,y2,7);
	}
}
