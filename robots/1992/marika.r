/*
 *    CASASOFT Marika  1.00
 *    (c) 1992 Roberto Ceccarelli
 *
 *    dedicato a Marika e Paola
 *
 */

int	x1, y1, a1;   /*  coordinate dei vertici */
int	x2, y2, a2;   /*  e direzione della diagonale */
int	x3, y3, a3;
int	x4, y4, a4;
int	dlimit;       /*  limite di danni prima dello spostamento */

main()
{
	int	dir;

	setup();
	dlimit = 11;

	/* raggiunge l'angolo superiore sinistro */
	go2angle(x2, y2);

	/* ciclo operativo principale */
	while (1)
		if (rand(2) > 0)
			cw();
		else 
			ccw();
}


/* rotazione sul piano in senso antiorario */
ccw()
{
	spara(a2);
	fuga(0, 180);
	spara(a4);
	fuga(270, 180);
	spara(a3);
	fuga(180, 90);
	spara(a1);
	fuga(90, 0);
}


/* rotazione sul piano in senso orario */
cw()
{
	spara(a2);
	fuga(270, 0);
	spara(a1);
	fuga(0, 90);
	spara(a3);
	fuga(90, 180);
	spara(a4);
	fuga(180, 270);
}


/* raggiunge con movimento rettilineo un altro angolo
   e spara in direzione ortogonale allo spostamento */
fuga(dir, sdir)
int	dir, sdir;
{
	drive(dir, 100);
	if (dir == 0) 
		while (loc_x() < 980) 
			shield(dir, sdir);
	if (dir == 90) 
		while (loc_y() < 980) 
			shield(dir, sdir);
	if (dir == 180) 
		while (loc_x() > 20) 
			shield(dir, sdir);
	if (dir == 270) 
		while (loc_y() > 20) 
			shield(dir, sdir);
	drive(0, 0);
}


/* fuoco di copertura durante uno spostamento */
shield(dir, sdir)
int	dir, sdir;
{
	int	offs, limit;

	limit = 81;
	offs = -80;
	while (offs < limit) {
		fuoco(sdir + offs);
		offs += 20;
		drive(dir, 100);
	}
}


/* raggiunge l'angolo */
go2angle(x, y)
int	x, y;
{
	int	dir;

	dir = plot_course(x, y);
	while (loc_x() > 25  ||  loc_y() < 975) {
		fuoco(dir);          /* scaccia eventuali intrusi */
		fuoco(0);            /* protezione limitata, */
		fuoco(90);           /* ma talvolta utile */
		fuoco(180);
		fuoco(270);
		drive(dir, 100);
	}
	drive(0, 0);
}


/* spara nel quadrante; se subisce danni esce
   e si attiva la routine di spostamento */
spara(dir)
int	dir;
{
	int	danni, offs, limit;

	danni = damage() + dlimit;
	limit = 41;
	while (danni > damage() ) {
		offs = -40;
		while ((offs < limit) && (danni > damage())) {
			fuoco(dir + offs);
			offs += 20;
		}
	}  /*  si sposta per cercare di limitare i danni */
}


/*  inizializza le varibili di riferimento  */
setup()
{
	x1 = 20;   
	y1 = 20;   
	a1 = 45;
	x2 = 20;   
	y2 = 980;  
	a2 = 315;
	x3 = 980;  
	y3 = 20;   
	a3 = 135;
	x4 = 980;  
	y4 = 980;  
	a4 = 225;
}


/*  controlla bersaglio e spara */
fuoco(a)
int	a;
{
	int	range, offs, dir, danni;

	danni = damage() + dlimit;
	if (range = scan(a, 10)) {
		offs = -9;
		cannon(a, range);  /* spara un colpo sperando nella fortuna */

		/* ricerca la posizione precisa */
		while ((offs < 10) && (danni > damage())) {
			dir = (a + offs) % 360;
			range = scan(dir, 2);
			if ((range > 0) && (range < 700)) {
				cannon(dir, range);
				offs = -9;         /* ripete lo scaning locale */
			} else 
				offs += 3;
		}   /* fine loop while */
	}
}


/* plot course function, return degree heading to */
/* reach destination x, y; uses atan() trig function */

/*  tratta da sniper.r  */
plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	scale;
	int	curx, cury;

	scale = 100000;  /* scale for trig functions */
	curx = loc_x();  /* get current location */
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	/* atan only returns -90 to +90, so figure out how to use */
	/* the atan() value */

	if (x == 0) {      /* x is zero, we either move due north or south */
		if (yy > cury)
			d = 90;        /* north */
		else
			d = 270;       /* south */
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((scale * y) / x);  /* south-east, quadrant 4 */
			else
				d = 180 + atan((scale * y) / x);  /* south-west, quadrant 3 */
		} else {
			if (xx > curx)
				d = atan((scale * y) / x);        /* north-east, quadrant 1 */
			else
				d = 180 + atan((scale * y) / x);  /* north-west, quadrant 2 */
		}
	}
	return (d);
}


