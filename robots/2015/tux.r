/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2015)                                                */
/*                                                                          */
/*  CROBOT: tux.r                                                           */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Tux va al centro dell'arena e si muove alternativamente verso i due lati destro e sinistro oscillando finchè non viene colpito.
  Durante il movimento cerca di puntare il bersaglio piu' vicino e spara senza toxiche con correzioni differrenti a seconda della distanza.
  Mi sarebbe piaciuto poter dedicarci piu' tempo...  
  f2f pietoso ...
  
*/

int deg, odeg, rng, orng, dir, y, prox, lastrng, dam;

main()
{

	if (loc_y()<500) y=480; else y=520;
	lastrng=1000;
	
	while(loc_y()<y) fire(90);
	while(loc_y()>y) fire(270);

	while(1) {
		while (loc_x()<750) fire(0); 
		dam=damage();
		while (damage()<=dam+3) {
			while (loc_x()>750) fire(180);
			while (loc_x()<750) fire(0);
		}
		while (loc_x()>250) fire(180);
		dam=damage();
		while (damage()<=dam+3) {
			while (loc_x()<250) fire(0);
			while (loc_x()>250) fire(180);
		}
	}
}

fire(dir)
{
    drive(dir,100);
	
	if (rng=scan(odeg=deg,10)) {
		if ((lastrng=rng)<600) {
			if (scan(deg-8,5))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
			if (scan(deg+8,5))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
			if (scan(deg,10))   { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		} else {
			if (scan(deg-5,5)) deg-=5; else deg+=5;
			if (scan(deg+3,3)) deg+=3; else deg-=3;
			if (scan(deg-1,1)) deg-=1; else deg+=1;
			cannon(deg,2*scan(deg,10)-rng);
			
			if (rng=scan(prox+=20,10)) { if (rng<lastrng) deg=prox; } else { if (rng=scan(prox+=20,10)) {if (rng<lastrng) deg=prox; } }
		}
	}
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else deg+=77;

} 
