/* BELLERINO MARIO                                                           */


/* In riferimento al concorso inerente il torneo di CROBOTS, io sottoscritto */
/* Bellerino Mario invio il programma nell' allegato  dischetto e di seguito */
/* trascrivo le strategie del T1000 e il listato del programma stesso.       */
/* Fiducioso in un vostro riscontro attendo notizie.                         */
/*                                 Con osservanza Bellerino Mario            */

/* Il robot quando trova un nemico ad una  distanza inferiore a 620 gli spa- */
/* ra, altrimenti gli si avvicina per colpirlo.  Quando il robot  viene col- */
/* pito si sposta nella parte opposta dello schermo controllando la  presen- */
/* za di un possibile nemico ed eventualmente sparando.                      */




/*                     T1000                     */
/*                Bellerino Mario                */

main()
int	degree, range, d, r;
{
	degree = 0;
	while (1) {
		r = damage();
		if (r > d) 
			scappa();
		d = damage();
		while ((range = scan(degree, 3)) > 600)
			drive(degree, 100);
		drive(degree, 0);
		if ((range = scan(degree, 3)) > 0 & range < 620)
			cannon(degree, range);
		else 
			degree += 6;

	}
}


scappa()
{
	int	y;
	y = loc_y();
	if (y < 500) {
		while (loc_y() < 700) {
			drive(90, 100);
			if ((range = scan(90, 10)) > 0) 
				cannon(90, range);
		}
		drive(0, 0);
	} else
	 {
		while (loc_y() > 300) {
			drive(270, 100);
			if ((range = scan(270, 10)) > 0) 
				cannon(270, range);
		}
		drive(0, 0);
	}
}


