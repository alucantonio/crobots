/* hunter  realizzato da Summa Giovanni */
/* Segue una rotta casuale scansionando a 360ø, se trova */
/* un nemico, gli spara e lo segue, continuando a scansionare */
int	drx, dry, guida, ok, k, ct, cambio;
main()
{
	cambio = 0;
	drx = rand(780) + 100;          /* X casuale del punto da raggiungere */
	dry = rand(780) + 100;          /* Y casuale del punto da raggiungere */
	guida = angolo(drx, dry);      /* calcolo angolo di guida */
	k = 100;                      /* settaggio velocita standard */
	while (1) {
		if (cambio == 1)          /* il robot si ‚ fermato, cambio direzione */ {                         /* ricalcolo il punto di arrivo e il resto */
			drx = rand(780) + 100;
			dry = rand(780) + 100;
			guida = angolo(drx, dry);
			k = 100;
			cambio = 0;
		}
		drive(guida, k);           /* il robot si muove */
		/* fino a che il robot non si ferma o   */
		/* raggiunge i limiti impostati dalla   */
		/* funzione Dist(), esegue la procedura */
		/* SEEK() di cerca-spara-segui */
		while (speed() != 0 && (dist() != 1))
			seek();
		if (speed() == 0)
			cambio = 1;               /* se il robot e fermo preparo solo il cambio */
		else /* direzione */
			drive(guida, 80);        /* altrimenti rallento */
	}
}


angolo(x, y)                   /* calcola l'angolo di guida */
int	x, y;
{
	int	cx, cy, dx, dy, res;
	cx = loc_x();
	cy = loc_y();
	dx = cx - x;
	dy = cy - y;
	if (dx == 0) {
		if (y > cy)
			res = 90;
		else
			res = 270;
	} else
	 {
		if (y < cy) {
			if (x > cx)
				res = 360 + atan((100000 * dy) / dx);
			else
				res = 180 + atan((100000 * dy) / dx);
		} else
		 {
			if (x > cx)
				res = atan((100000 * dy) / dx);
			else
				res = 180 + atan((100000 * dy) / dx);
		};
	};
	return (res);
}


dist()       /* controlla che il robot non si sia avvicinato troppo */
{            /* al muro e in caso affermativo prepara il cambio direzione */
	int	diret;
	if ((loc_x() <= 120) || (loc_x() >= 880) || (loc_y() <= 120) || (loc_y() >= 880))
		cambio = 1;
	return (cambio);
}


seek()     /* procedura di scansione e fuoco */
{
	int	t_ang;
	t_ang = 0;
	ok = 0;
	while ((ok = scan(t_ang, 10)) == 0 && t_ang < 360)  /* scansiona a 360ø */
		t_ang += 20;
	if (ok) {
		if (ok < 50)                               /* aggiusta la gittata se */
			ok = 50;                                  /* troppo corta */
		cannon(t_ang, ok);                          /* spara sul nemico */
		drive(t_ang, 95);                           /* lo segue */
	}
}


