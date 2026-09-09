/*

IL programma realizzato da Dinardo Saverio
	effettua principalmente un'operazione di scan sfruttando come 
	tecnica di mira una tecnica di restringimento del cono di
	scan attraverso successive approssimazioni;
	si muove solo nel caso in cui venga colpito e va ad occupare
	in sequenza quattro punti precisi nei pressi dei bordi del campo di
	gioco , ciascuno su di un lato del campo stesso;
	le routine di fuoco sono due e differenziate a seconda
	che il robot SAXY si trovi in una fase di attesa ( fermo FIND())
	o in fase di fuga ( FUOCO()) ;
	LA procedura di fuga Š SCAPPA() e sfrutta le funzioni calcola_ang() e
	vai() per raggiunge i punti prestabiliti dalla SCAPPA() stessa;



*/


int d1,
    f,
    flag,
    dir,       
    x,y,x1,y1,
    ang,
    d,
    range;



main()
{ang=540;
f=0;
x=950;y=500;
dir=calcola_ang(x,y);
vai(x,y,dir);
d=damage();
while(1)
    {
     d=damage();
     while ( !(range = scan(ang,4)))
		   ang+=9;
     if(!find(ang))
		ang+=30;
     if(d!=damage())
		scappa();
   }
}

fuoco()
{int sfas,i,oldr;
 oldr=range;
 if (!(range = scan (ang, 3))) 
      {
      if(range = scan(ang -= 6, 3)) 
	  sfas = -4;
	  else 
	  if(range = scan(ang -= 7, 4)) 
		   sfas = -7;
		   else 
		   if(range = scan(ang -= 12, 8)) 
			     sfas = -10;
			     else 
			     if(range = scan(ang += 31, 3)) 
				    sfas = 4;
				    else 
				    if(range = scan(ang += 7, 4)) 
					 sfas  = 7;
					 else 
					 if(range = scan(ang += 12, 8)) 
						       sfas = 10;
       }
       else 
       sfas=0;

if((range)&&(range<710)) 
		{
		if(oldr) 
			cannon(ang+sfas,range+(range - oldr)/3);
			else 
			cannon(ang,range);
		}
		else 
		if(range>850) 
		{
		ang+=40;
		oldr=0;
		}        
}

find(ang)
int ang;
{int r;
 range=scan(ang,4);
 if (range)
	{
	if(scan(ang-2,2))
		ang-=2;
		else
		ang+=2;
	if(scan(ang-1,1))
		ang-=1;
		else
		ang+=1;
	if(scan(ang-1,0))
		ang--;
		else
		if(scan(ang+1,0))
			ang++;
	cannon(ang,range);
	return(1);
	}
 if((range=scan(ang,4))&&(range<700)) 
		{cannon(ang,range);return(1);}
		else
		{
		if(scan(ang+9,4)) 
			{ang +=9;return(1);}
			else
			if(scan(ang-9,4)) 
				{ang -= 9;return(1);}
				 else
				 return(0);
		}

}

scappa()
{int xs,ys;
f = (f + 1 + 4) % 4;
if(f==0)
       {xs=50;ys=500;dir=225;
       }
       else
       {
       if(f==1)
	      {xs=500;ys=950;dir=45;}
	      else
	      {
	      if(f==2)
		   {xs=950;ys=500;dir=315;}
		   else
		   {xs=500;ys=950;dir=135;}
	      }
       }
vai(xs,ys,dir);
}

calcola_ang(xx,yy)
int xx, yy;
{
  int d1;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */
  curx = loc_x();  /* get current location */
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  /* atan only returns -90 to +90, so figure out how to use */
  /* the atan() value */

  if (x == 0) {      /* x is zero, we either move due north or south */
    if (yy > cury)
      d1 = 90;        /* north */
    else
      d1 = 270;       /* south */
  } else {
    if (yy < cury) {
      if (xx > curx)
	d1 = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
      else
	d1 = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
    } else {
      if (xx > curx)
	d1 = atan((scale * y) / x);        /* north-east, quadrant 1 */
      else
	d1 = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
    }
  }
  return (d1);
}


vai(x,y,dir)
int x;int y;int dir;
{
    drive(dir,100);
    while (distanza(loc_x(),loc_y(),x,y) > 150 && speed() > 0)
						fuoco();
    drive(dir,20);
    while (distanza(loc_x(),loc_y(),x,y) > 20 && speed() > 0)
						;
    drive(dir,0);
}

distanza(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y, d1;
  x = x1 - x2;
  y = y1 - y2;
  d1 = sqrt((x*x) + (y*y));
  return(d1);
}

