/*****************************/
/*           CORNER          */
/*          --------         */
/*      by Fabio Luciano     */
/*                           */
/*   4 Settembre 1994 (v.4)  */
/*                           */
/*****************************/
                                

int dir;

main()
{

  VaiInAngolo();

  RobotFisso();

  RobotMovimento();

  RobotFisso();
}


/*----------------------------------------------------------------------------*/
RobotFisso()
{
int direz, dist , dist1, delta, tempo;

  while (tempo < 500)
  {
    ++ tempo;

    if ((dist1 = scan(direz, 10)) < 1)
    {                                       /* Scansione Obiettivi */
      direz += 20;
			if (direz > 90) direz = 0;
    }

    else
    {                                       /* Bombardamento Obiettivi */

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

        tempo = 0;
      }

                                            /* Correzione angolo di ricerca */
      if (scan(direz - 13, 10))
        direz -= 13;
      else
        direz += 13;
      if (direz > 90 || direz < 0) direz = 0;
    }
  }

}


/*----------------------------------------------------------------------------*/
RobotMovimento()
{
  while (damage() < 85)
                                            /*----- Movimento a Triangolo     */
  {
    while (loc_y() < 700)
    {
      drive(90, 100);
      spara1();
    }

    while (loc_y() > 120)
    {
      drive(315, 100);
      spara1();
    }

    while (loc_x() > 120)
    {
      drive(180, 100);
      spara1();
    }
  
  }
} 


/*----------------------------------------------------------------------------*/
VaiInAngolo()                     /*----- Spostamento angolo Basso SX  (0,0) */
{
  while (loc_y() > 120)
	{
		drive(270, 100);
    spara();
	}
  while (loc_y() > 1)
	{
    drive(270, 10);
    spara();
  }
  drive(0,0);

  while (loc_x() > 120)
  {
		drive(180, 100);
    spara ();
  }
  while (loc_x() > 1)
  {
    drive(180, 10);
    spara ();
  }
  drive(0,0);
}


/*----------------------------------------------------------------------------*/
spara()                                  /*----- Spara mentre Š in movimento */
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
    if (dir > 350) dir = 0;
	}
}


/*--------------------------------------------------------------------------*/

spara1()
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
