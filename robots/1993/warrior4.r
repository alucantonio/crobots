/* Warrior IV v2.0
   Programmato da Carmine Della Sala

   Il robot si muove su quattro diverse diagonali ed utilizza  una routine di 
   fuoco che modifica sia l' angolo che la gittata in base allo spostamento 
   del nemico. Il robot avversario viene cercato entro un range di 700 metri.
*/

int     ang,ang2,dif,oldrange,newrange,dam,dir;       

main()
{
	ang=ang2=dif= 0;
	oldrange = 500;
	start();
	diag1();
	diag2();
	diag3();
	diag4();
}
 xydir (x,y)
 int x,y;
 {
    int d, locx, locy;

    locx = loc_x();
    locy = loc_y();

    if (locx == x)
    {
       if (y > locy)
	  d = 90;
       else
	  d = 270;
    }
    else
    {
       if (y < locy)
       {
	  if (x > locx)
	     d = 360 + atan ((100000 * (locy - y)) / (locx - x) );
	  else
	     d = 180 + atan ((100000 * (locy - y)) / (locx - x) );
       }
       else
	  if (x > locx)
	     d = atan ((100000 * (locy - y)) / (locx - x) );
	  else
	     d = 180 + atan ((100000 * (locy - y)) / (locx - x) );
    };
    return (d);
 }

spara ()
{
	int     i, range2;

	if (!((newrange = scan (ang, 5))&&(newrange<700))) {
		if ((newrange = scan(ang -= 10, 5))&&(newrange<700)) dif = -6;
		else if ((newrange = scan(ang -= 15, 10))&&(newrange<700)) dif = -10;
		else if ((newrange = scan(ang += 35, 5))&&(newrange<700)) dif = 6;
		else if ((newrange = scan(ang += 15, 10))&&(newrange<700)) dif = 10;
		else {
			i = 10;
			while (!(newrange = scan(ang += 20, 10))&&(newrange<700) && (--i))
				;
			dif = 0;
			oldrange = newrange;
			return;
		}
	}
	if (newrange>oldrange)
		cannon(ang + dif, (newrange * 15) / 13);
	else
		cannon(ang + dif, (newrange * 15) / 17);
	range2 = scan (ang2 -= 20, 10);
	if ((range2 > 0) && (range2 < (newrange - 50))) {
		ang = ang2;
		oldrange = range2;
	} else 
		oldrange = newrange;
}
start()
{
	 dir=xydir(500,910);
	drive (dir,100);
	while((loc_x()<450)||(loc_x()>550)&&(loc_y()<910))
	 spara();
	drive (0, 0);
	spara();
 }
danni()
{
 return(damage()-dam);
}
diag1()
{
	while (damage() < 25) {
		drive (45, 70);
		dam = damage();
		while (loc_y() < 870 && (danni() < 9))
			spara();
		drive (45, 0);
		spara();

		drive (225, 70);
		dam = damage();
		while (loc_x() > 130 && (danni()< 9))
			spara();
		drive (225, 0);
		spara();
	}
}
diag2()        
{
		drive (135, 100);
		while ((loc_x() > 230) && (loc_y() < 770))
		spara();
		while (damage() < 50) {
		drive (135, 50);
		dam = damage();
		while ((loc_x() > 130) && (loc_y() < 870) && (danni() < 9))
			spara();
		drive (135, 0);
		spara();

		drive (315, 50);
		dam = damage();
		while ((loc_y() > 130) && (loc_x() < 870) && (danni()< 9))
			spara();
		drive (315, 0);
		spara();
	}
}
diag3()
{
	drive(225,100);
	while((loc_y()>230)&&(loc_x()>230))
	spara();
	while (damage() < 75) {
		drive (225, 30);
		dam = damage();
		while ((loc_y() > 130) && (loc_x() > 130) && (danni()< 9))
			spara();
		drive (225, 0);
		spara();

		drive (45, 30);
		dam = damage();
		while ((loc_x() < 870) && (loc_y() < 870) && (danni()< 9))
			spara();
		drive (45, 0);
		spara();
	}
}
diag4()        
{
	drive(135,100);
	while((loc_y()<770)&&(loc_x()>230))
	spara();
	while (1) {
		drive (135, 20);
		dam = damage();
		while ((loc_y() < 870) && (loc_x() > 130) && (danni()< 9))
			spara();
		drive (135, 0);
		spara();

		drive (315, 20);
		dam = damage();
		while ((loc_x() < 870) && (loc_y() > 130) && (danni()< 9))
			spara();
		drive (315, 0);
		spara();
	}
}
, Via Vasto 8,83100 Avellino. 
				