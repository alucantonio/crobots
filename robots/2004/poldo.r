
/* POLDO 
Torneo 2004 - Categoria Micro

Il mio semplice microbo se ne va a zonzo per l'arena, correndo
a tutta birra e sparando come un matto con la pistola di aladino!

Alvaro De Amicis

*/

int a;
int dir;
int a,or,oa,r;

main()
{
	dir = 0;
	a = 0;

	drive(dir,100);
	while(loc_x() < 800) spara();
	dir=90;
	while (1) {
		drive(dir,100);
		spara();		
		if (loc_x() < 200 && loc_y() < 200) dir = 0; else
		if (loc_x() > 800 && loc_y() > 800) dir = 180; else
		if (loc_y() < 200 && loc_x() > 800) dir = 90; else
		if (loc_y() > 800 && loc_x() < 200) dir = 270;
	}
}

spara()
{
	if (scan(a,10));
	else if (scan(a+=20,10));
	else if (scan(a-=40,10));
	else {
		if (scan(a+=60,10)) return;
		else if (scan(a-=80,10)) return;
		else if (scan(a+=100,10)) return;
		else if (scan(a-=120,10)) return;
		else if (scan(a+=140,10)) return;
		else if (scan(a-=160,10)) return;
		return a+=260;
	}
	if (scan(a-10,8)) a-=8;
	if (scan(a+10,8)) a+=8;
	if (scan(a+13,10)) a+=5; if (scan(a-13,10)) a-=5;
	if (scan(a+12,10)) a+=3; if (scan(a-12,10)) a-=3;
	if (scan(a+10,10)) a+=1; if (scan(a-10,10)) a-=1;
	if (or=scan(oa=a,10)) {
		if (scan(a+13,10)) a+=5; if (scan(a-13,10)) a-=5;
		if (scan(a+12,10)) a+=3; if (scan(a-12,10)) a-=3;
		if (scan(a+10,10)) a+=1; if (scan(a-10,10)) a-=1;
		if (r=scan(a,10))
			return cannon(a+(a-oa)*((1200+r)>>9)-(sin(a-dir)>>14),
			r*190/(190+or-r-(cos(a-dir)>>12)));
	}
} 
