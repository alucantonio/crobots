/*                          */
/*          CORNER          */
/*         --------         */
/*     by Fabio Luciano     */
/*                          */
/*  30 Luglio 1993  (v.1d)  */
/*                          */

int dir;

main()
{
int direz, dist , dist1, delta;

     	                          /*----- Spostamento angolo Basso SX  (0,0)    */
	while (loc_y()>0)
	{
		drive(270, 100);
		while (speed() > 0) spara();
	}
	
	while (loc_x()>0)
	{
		drive(180, 100);
		while (speed() > 0) spara ();
	}

	direz = 0;

	while (1)                 /*----- Scansione e Bombardamento Obiettivi   */
	{
		while ((dist1 = scan(direz, 10)) < 1)
		{
			direz += 20;
			if (direz > 90) direz = 0;
		}
			
		
		if (scan(direz + 8, 2))
			direz += 8;
		else
		{
			if (scan(direz - 8, 2)) 
				direz -= 8;
			else
			{
				if (scan(direz + 4, 2)) 
					direz += 4;
				else
					if (scan(direz - 4, 2)) direz -= 4;
			}
		}
		
		while ((dist = scan(direz, 3)) > 0 && dist < 800)
		{
			delta = (dist * 7 / 50 + 20) * (dist - dist1) / 21;

			cannon(direz, dist + delta);
				
			dist1 = dist;
		}
		
		                  /*----- Correzione angolo di ricerca          */
		if (scan(direz - 13, 10))
			direz -= 13;
		else
			direz += 13;
		if (direz > 90 || direz < 0) direz = 0;
	}

}

/*--------------------------------------------------------------------------*/

spara()
{
int dist, dist1, delta;

	if (dist1 = scan(dir,10))
	{
		
		if (scan(dir + 8, 2))
			dir += 8;
		else
		{
			if (scan(dir - 8, 2)) 
				dir -= 8;
			else
			{
				if (scan(dir + 4, 2)) 
					dir += 4;
				else
					if (scan(dir - 4, 2)) dir -= 4;
			}
		}
		
		dist = scan(dir, 5);
		
		delta = (dist * 7 / 50 + 20) * (dist - dist1) / 21;

		cannon(dir, dist + delta);
	}
	
	else
	{
		dir += 20;
		if (dir > 360) dir = 0;
	}
}
