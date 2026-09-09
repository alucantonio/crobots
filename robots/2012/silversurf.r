/*
Crobots 	: SilverSurfer
Type			: Micro
Version 	: 1.00
Author		: Maurizio Camangi
Begin			: 04-mar-2011
Revision	: 13-gen-2012

Questo microbot è Tannhauser del 2011 con un'altra funzione di fuoco.

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
orange;

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
 	/*c1=(loc_x()*(m<5))+(loc_y()*(m>=5));*/
  if (m%2) return (c1>l); else return (c1<l);	
}	

fire(dir,l,m,z)
{
  int asin,acos;
  while(wall(l,m))
  {
    drive(dir,100); /*if (scan(dir,10)) ang=dir;*/
        
    if (scan(ang,10)) {
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
      if (orange=scan(oang=ang,3)) {
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
  drive(dir,0);
}

main()
{
	posy=loc_y(posx=loc_x()>499)>499;
	while(1)
	{
    fire(270,180 + 420*posy,7,fire(0,400 + 420*posx,2,fire(90,400 + 420*posy,8,fire(180,180 + 420*posx,3,1))));
  }
}
