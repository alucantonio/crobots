/***************************************************/
/* HUNTER.R                  *  di Speranza Fabio  */
/* Ricerca altri Robots e    *     Aprile 1991     */
/* si sposta se colpito.     *                     */
/* Rielaborazione di Counter *                     */
/***************************************************/

/*************************/
/* Variabili Globali     */
/*************************/

int last_dir = 0;
int angle, res;

main()
{
  int range, dist, piu, spara,st ;
  int mag = 12;
  register int d;
  long i;

  res = 10;
  piu = 0;
  last_dir = 0;
  d = damage();
  angle = rand(360);
  while(1)
  {
    while ((range = scan(angle,res)) > 0)
    {
      st = 1;
      if (range > 700)   /* out of range, head toward it */
      {
        drive(angle,100);
        i = 1;
        while (++i < 50) /* use a counter to limit move time */
          ;
        drive (angle,0);
        if (d != damage())
        {
          d = damage();
          scappa(last_dir);
        }
      } else
      {
        range += piu ;
        cannon(angle,range);
        if (d != damage())
        {
          spara = 0 ;
          d = damage();
          scappa(last_dir);
        }
        piu = 0;
       if ((dist=scan(angle-10,10)) > 0)
         {  res = -1;
            angle -= 2;
            if (dist > range)
              piu = mag;
            else
              piu = -mag; }
       else {
          if ((dist=scan(angle+10,10)) > 0)
          {  res = 1;
             angle += 2;
            if (dist > range)
              piu = mag;
            else
              piu = -mag; }
            }
      }
    }
    if (d != damage()) {
      d = damage();
      scappa(last_dir);
    }
    st += 1;
    angle += res;
    angle %= 360;
    if (st = 360)
      res = 10;
  }
}

/*******************************************/
/* Scappare velocementeeeeee.............. */
/*******************************************/

scappa()
{
  int x, y;
  int i;

  x = loc_x();
  y = loc_y();
  i = 0;

  if (last_dir == 0) {
    if (y > 700) {
      last_dir = 1;
      drive(270,100);
      while ( ++i < (y-750))
        ;
      drive(270,0);
    } else {
      last_dir = 1;
      drive(90,100);
      while (750 > loc_y() && ++i < 750-y)
        ;
      drive(90,0);
    }
  } else {
    if (x > 700) {
      last_dir = 0;
      drive(180,100);
      while (++i < (x-750))
        ;
      drive(180,0);
    } else {
      last_dir = 0;
      drive(0,100);
      while (750 > loc_x() && ++i < 750-x)
        ;
      drive(0,0);
    }
  }
  res = 10;
}

/* Fine di HUNTER.R */
