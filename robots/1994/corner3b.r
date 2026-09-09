/******************************/
/*                            */
/*           CORNER           */
/*          --------          */
/*      by Fabio Luciano      */
/*                            */
/*  15 Settembre 1994 (v.3b)  */
/*                            */
/******************************/


int dir;

main()
{
														/*------- Si sposta in angolo Basso SX (0,0)  */
	while (loc_y() > 100)
	{
		drive(270, 100);
		spara();
	}
	
	while (loc_x() > 100)
	{
		drive(180, 100);
		spara(); 
	}

	drive(0, 0);
	


	while (1)                 /*----- Movimento a Triangolo                 */

	{
    while (loc_y() < 700)
    {
      drive(90, 100);
      spara();
    }

    while (loc_y() > 120)
    {
      drive(315, 100);
      spara();
    }

    while (loc_x() > 120)
    {
      drive(180, 100);
      spara();
    }
	
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
		
		dist = scan(dir, 3);
		
		delta = (dist * 7 / 50 + 20) * (dist - dist1) / 21;

    cannon(dir, dist + delta);
	}
	
	else
	{
		dir += 20;
    if (dir > 350) dir = 0;
	}
}
