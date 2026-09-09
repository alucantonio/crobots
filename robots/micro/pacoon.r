/*
Nome del robot	: Pacoon.r
Autore		: Gianni Ino

All' inizio del match si porta nell' angolo (0,0) dove si ferma, sparando, fino a che i danni sono inferiori al 20%.
Dopo di che parte con l' attacco finale, scorazzando lungo la diagonale.
La routine di fuoco e' la ben nota Toxica.
*/

int z,mx,my,ang,ango, oang, dist, odist,dir;
main()
{
while (loc_y()>100) drive (270,100);
while (speed(drive (270,0)));
while (loc_x()>100) drive(dir=180,100);

while (1)
{
	if ((loc_x()%800)<200)
	{
		dir=45+180*(loc_x()>500);
		drive (dir,0);
	}
	if (z=(damage()>20)) drive(dir,100);
	if ((odist=scan(ango,10))&&(odist<730))
	{
		if (scan(ango-=5,5));else ango+=10;
		scan_();
		if (odist=scan(oang=ango,5))
		{
			scan_();
			if (dist=scan(ango,10))
			cannon((ango+(ango-oang)*((1200+dist)>>9)-(z)*(sin(ango-dir)>>14)),(dist*160/(160+odist-dist-(z)*(cos(ango-dir)>>12))));
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

