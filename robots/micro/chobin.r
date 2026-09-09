/*
Nome del robot	: Chobin.r
Autore		: Gianni Ino

Il robot e' un affare che non si muove neanche se lo spingono.
All' inizio del match si porta nell' angolo piu' vicino, dove si ferma PER SEMPRE.
La routine di fuoco e' la ben nota Toxica.
Non c' e' nemmeno uno straccio di attacco finale.
*/

int ango, oang, dist, odist;
main()
{
	if (loc_x()>500)
	{
		while (loc_x()<950)
		drive(0,100);
	}
	else
	{
		while (loc_x()>50)
		drive(180,100);
	}
	while (speed(drive (0,0)));
	if (loc_y()>500)
	{
		while (loc_y()<950)
		drive(90,100);
	}
	else
	{
		while (loc_y()>50)
		drive(270,100);
	}
	while (speed(drive (0,0)));
while (1)
   {
    if (odist=scan(ango,10))
      {
        if (odist>730) cannon (ango,odist);
        else
        {
        if (scan(ango-=5,5));else ango+=10;
        scan_();
        if (odist=scan(oang=ango,5))
          {
            scan_();
            if (dist=scan(ango,10))
              cannon(ango+(ango-oang)*((1150+dist)>>9),(dist*160/(160+odist-dist)));
          }
        else
           while (!scan(ango+=11,10));
        }
      }
     else
           while (!scan(ango+=21,10));
}
}

scan_()
{
  if(scan(ango+354,1)) ango+=354;
  if(scan(ango+6,  1)) ango+=6;
  if(scan(ango+356,1)) ango+=356;
  if(scan(ango+4,  1)) ango+=4;
  if(scan(ango+358,1)) ango+=358;
  if(scan(ango+2,  1)) ango+=2;
}

