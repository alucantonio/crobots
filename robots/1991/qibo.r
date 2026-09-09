/*
Qibo, 13/5/91   -   23/5/91
Beppi Menozzi   ("Wheeling Pitch")
v. Bertora 8/9 Genova
*/

/* Un misto di Papillon5 (poco di piu' del 4) e di Ylen */
/* tanti saluti */
/* Non e' un robot imbattibile, ma e' "intelligente", ed e' in grado di
   adattarsi all'algoritmo avversario utilizzando due diversi algoritmi
   a seconda se il nemico tende a seguire o a girare sui bordi. E' piu'
   efficiente contro i robot che seguono. Particolarita' e' che spara
   "mirando" e non a mitraglia come molti altri... */

int	Dir, DirR, Range, oldRange, oldDir, DoIt, Gira;

Ylen()        /* un po' modificato */
{
	int	RealRange, olddir;

	while (damage() < 82) {
		if ( DirDeviaz (Dir, DirR) > 12 ) {
			drive (DirR = Dir, 50);
			while (speed() > 50) 
				;
			drive (DirR, 100);
		} else if (!speed()) {
			drive (DirR = plot_course (500, 500), 50);
			while (speed() < 50) 
				;
			drive (DirR, 100);
		};

		if (!(Range = scan  (Dir, 4))) {
			Dir -= 23;
			while ((!(Range = scan (Dir, 10))))
				if (speed())
					Dir += 20;
				else
				 {
					drive (DirR = plot_course (500, 500), 50);
					while (speed() < 50) 
						;
					drive (DirR, 100);
				};
		} else
		 {
			Dir -= 4;
			if (!(scan(Dir, 4))) 
				Dir += 8;
			Dir -= 2;
			if (!(scan(Dir, 2))) 
				Dir += 4;
		};

		if (Range > 70)
			Range = 7 * Range / 6;
		else
			Range = 70;
		cannon (Dir, Range);
	};
}


main()
/* Papillon4 un po' modificato */
{
	drive (DirR = plot_course(800, 800), 50);
	while (speed() > 50) 
		;
	drive (DirR, 100);
	while ((abs(loc_x() - 800) > 150 || abs(loc_y() - 800) > 150) && speed())
		Attacca();
	Gira = 0;
	drive (DirR = plot_course (0, 0), 50);
	while (speed() > 50) 
		;

	while (1) {
		drive (DirR, 100);        /*  /  */
		while (loc_x() > 160 && loc_y() > 160 && speed() )
			Attacca();
		DirAndCheck (90);

		drive (DirR, 100);        /*  |  */
		while (loc_y() < 830 && speed() )
			Attacca();
		PlotAndCheck (999, 0);

		drive (DirR, 100);        /*  \  */
		while (loc_x() < 840 && loc_y() > 160 && speed() )
			Attacca();
		DirAndCheck (90);

		drive (DirR, 100);        /*  |  */
		while (loc_y() < 830 && speed() )
			Attacca();
		PlotAndCheck (0, 0);

		drive (DirR, 100);        /*  /  */
		while (loc_x() > 160 && loc_y() > 160 && speed() )
			Attacca();
		DirAndCheck (90);

		drive (DirR, 100);        /*  |  */
		while (loc_y() < 830 && speed() )
			Attacca();
		DirAndCheck (0);

		drive (DirR, 100);        /*  --  */
		while (loc_x() < 830 && speed() )
			Attacca();
		PlotAndCheck (0, 0);
	};
}


DirAndCheck (d)
int	d;
{
	drive (d, 50);
	Check();
	while (speed() > 50) 
		;
	DirR = d;
}


PlotAndCheck (x, y)
int	x, y;
{
	int	d;

	d = plot_course (x, y);
	drive (d, 50);
	Check();
	while (speed() > 50) 
		;
	DirR = d;
}


Check ()        /* cerca di capire se l'altro robot segue o gira */
{
	if (Range > 550)
		++Gira;
	else if (Range < 80)
		Gira = 0;
	else if (DirDeviaz (Dir, DirR + 180) > 23)    /* deviazione (se c'e' non segue) */
		++Gira;
	else
		Gira = 0;
	if (Gira >= 4)
		Ylen ();    /* e' il momento di cambiare algoritmo! */
}


Attacca()
{
	int	RealRange, RRange;

	oldRange = Range;
	oldDir = Dir;
	--Dir;
	if (!(Range = scan (Dir, 6))) {
		DoIt = 0;
		Dir -= 33;
		while (!(Range = scan(Dir, 8))) 
			Dir += 16;
	} else
		DoIt = 1;
	if (Range > 750) 
		return;

	RealRange = Range;
	Dir -= 4;
	if (!(Range = scan(Dir, 4))) 
		Dir += 8;
	Dir -= 2;
	if (!(Range = scan(Dir, 2))) 
		Dir += 4;

	if (!Range) 
		Range = RealRange;

	RRange = (800000 + cos(Dir - DirR)) * (2 * Range - oldRange) / 800000;
	if (RRange < 60) 
		RRange = 60;

	if (DoIt)
		cannon (Dir + 2 * (Dir - oldDir) / 3, RRange);
	else
		cannon (Dir, Range);
}


plot_course(xx, yy)
int	xx, yy;
{
	int	d;
	int	x, y;
	int	curx, cury;


	curx = loc_x();
	cury = loc_y();
	x = curx - xx;
	y = cury - yy;

	if (x == 0) {
		if (yy > cury)
			d = 90;
		else
			d = 270;
	} else {
		if (yy < cury) {
			if (xx > curx)
				d = 360 + atan((100000 * y) / x);
			else
				d = 180 + atan((100000 * y) / x);
		} else {
			if (xx > curx)
				d = atan((100000 * y) / x);
			else
				d = 180 + atan((100000 * y) / x);
		}
	}
	return (d);
}


abs(n)
int	n;
{
	if (n < 0) 
		return (-n); 
	else 
		return (n);
}


mod360 (n)
int	n;
{
	while (n < 0) 
		n += 360;
	n %= 360;
	return (n);
}


min (a, b)
int	a, b;
{
	if (a < b) 
		return (a); 
	else 
		return (b);
}


DirDeviaz (d1, d2)        /* trova la differenza tra due angoli */
int	d1, d2;
{
	return (min (mod360 (d2 - d1), mod360 (d1 - d2)));
}


