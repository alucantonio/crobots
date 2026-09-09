/*

Torneo 2025
Nome: 	thor_25.r	(1632 istruzioni - macro)
Autore: Franco Cartieri

Ho preso spunto dal movimento iniziale di Coppi e dall'attacco finale di Hulk.
All'inizio dell'incontro, se non è un f2f, si muove lungo i bordi; dopo 7 giri o se viene colpito, passa all'attacco finale.

 */

int dir, deg, rng, odeg, orng, t, e, dmin, dmax;

main()
{
  while (deg < 360)
  {
    if (rng = scan(deg += 21, 10))
    {
      cannon(deg, rng);
      if ((++e) > 1)
      {
        if (loc_x(t = 7) < 500)
        {
          if (loc_y() < 500)
          {
            dmax = ((dmin = -15) + 80);
            while ((damage() < 40) && (--t))
              RadarF2f(Dn(Sx(Up(Dx()))));
          }
          else
          {
            dmax = ((dmin = 255) + 80);
            while ((damage() < 40) && (--t))
              RadarF2f(Sx(Up(Dx(Dn()))));
          }
        }
        else
        {
          if (loc_y() < 500)
          {
            dmax = ((dmin = 75) + 80);
            while ((damage() < 40) && (--t))
              RadarF2f(Dx(Dn(Sx(Up()))));
          }
          else
          {
            dmax = ((dmin = 165) + 80);
            while ((damage() < 40) && (--t))
              RadarF2f(Up(Dx(Dn(Sx()))));
          }
        }
        F2f();
      }
    }
  }
  F2f();
}

F2f()
{
  int b, x, y;
  if (loc_y(x = (loc_x() > 500)) > 500)
  {
    if (x)
      Fulmine(dir = deg = 210);
    else
      Fulmine(dir = deg = 300);
  }
  else
  {
    if (x)
      Fulmine(dir = deg = 120);
    else
      Fulmine(dir = deg = 30);
  }
  Martello();
  while (1)
  {
    if (orng > 425)
    {
      Fulmine(dir = 180);
      while (Vai(loc_x() > 300))
        ;
      if (!orng || (orng > 425))
      {
        Fulmine(dir = 270);
        while (Vai(loc_y() > 300))
          ;
        if (!orng || (orng > 425))
        {
          Fulmine(dir = 0);
          while (Vai(loc_x() < 700))
            ;
          if ((!orng || orng > 425))
          {
            Fulmine(dir = 90);
            while (Vai(loc_y() < 700))
              ;
          }
        }
      }
    }
    else
    {
      if ((x = loc_x(y = loc_y())) > 850)
        dir = 150 + 60 * (y > 500);
      else if (x < 150)
        dir = 330 + 60 * (y < 500);
      else if (y > 850)
        dir = 240 + 60 * (x < 500);
      else if (y < 150)
        dir = 60 + 60 * (x > 500);
      else
        dir = deg + 75 + (b ^= 1) * 210;
      Fulmine();
      Fulmine();
    }
  }
}

Up()
{
  while (loc_y() < 925)
    Fuoco(90);
  Saetta(90);
}

Dn()
{
  while (loc_y() > 75)
    Fuoco(270);
  Saetta(270);
}

Dx()
{
  while (loc_x() < 925)
    Fuoco(0);
  Saetta(0);
}

Sx()
{
  while (loc_x() > 75)
    Fuoco(180);
  Saetta(180);
}

Radar()
{
  if (rng = scan(deg += 20, 10))
    ;
  else if (rng = scan(deg -= 40, 10))
    ;
  else if (rng = scan(deg += 60, 10))
    ;
  else
    return deg += 40;
  cannon(deg, rng);
  return cannon(deg, 2 * scan(deg, 10) - rng);
}

RadarF2f()
{
  int ang, en;
  ang = dmin;
  while (ang <= dmax)
    en += (scan(ang += 20, 10) > 0);
  if (en < 2)
    F2f();
}

Saetta(d)
{
  drive(d, 0);
  if ((rng = scan(odeg = deg, 10)) && (rng < 825))
  {
    if (!scan(deg -= 5, 5))
      deg += 11;
    if (!scan(deg -= 3, 2))
      deg += 5;
    return cannon(deg + deg - odeg, 2 * scan(deg, 10) - rng);
  }
  else
    Radar();
}

Fuoco(d)
{
  drive(d, 100);
  if ((rng = scan(odeg = deg, 10)) && (rng < 825))
  {
    if (scan(deg - 8, 5))
    {
      if (scan(deg -= 5, 2))
        ;
      else
        deg -= 4;
    }
    else
    {
      if (scan(deg + 8, 5))
      {
        if (scan(deg += 5, 2))
          ;
        else
          deg += 4;
      }
      else
      {
        if (scan(deg, 1))
          return cannon((deg + deg - odeg), (2 * scan(deg, 10) - rng));
        else
        {
          if (scan(deg -= 3, 2))
            return cannon((deg + deg - odeg), (2 * scan(deg, 10) - rng));
          else
            return cannon(((deg += 6) + deg - odeg), (2 * scan(deg, 10) - rng));
        }
      }
    }
    return cannon((deg + deg - odeg), (2 * scan(deg, 10) - rng));
  }
  else
    Radar();
}

Vai(c)
{
  if (c && ((!orng || orng > 425)))
  {
    Martello();
    return 1;
  }
  else
    return 0;
}

Martello()
{
  drive(dir, 100);
  if (scan(deg, 10))
    ;
  else if (scan(deg -= 21, 10))
    ;
  else if (scan(deg += 42, 10))
    ;
  else if (scan(deg += 21, 10))
    ;
  else
    return Ritrova();
  if (scan(deg - 17, 10))
    deg -= 6;
  if (scan(deg + 17, 10))
    deg += 6;
  if ((orng = Affina()))
  {
    if ((rng = Affina(odeg = deg)))
      return cannon(deg + (deg - odeg) * ((1200 + rng) >> 9) - (sin(deg - dir) >> 14), rng * 192 / (192 + orng - rng - (cos(deg - dir) >> 12)));
    else if (rng = scan(deg -= 21, 10))
      return cannon(deg, rng);
    else if (rng = scan(deg += 42, 10))
      return cannon(deg, rng);
    else
      deg += 41;
  }
  else if (orng = scan(deg -= 21, 10))
    return cannon(deg, orng);
  else if (orng = scan(deg += 42, 10))
    return cannon(deg, orng);
  else
    deg += 41;
}

Fulmine()
{
  if (scan(deg - 15, 10))
    deg -= 5;
  if (scan(deg + 15, 10))
    deg += 5;
  drive(dir, 100);
  if ((orng = scan(deg, 10)))
  {
    if (scan(deg - 15, 10))
    {
      if (scan(deg -= 13, 4))
      {
        if (scan(deg - 8, 10))
          deg -= 5;
      }
      else if (scan(deg - 10, 10))
        deg -= 8;
      else
        deg += 6;
    }
    else if (scan(deg + 14, 10))
    {
      if (scan(deg += 13, 5))
        deg += 5;
    }
    else if (scan(deg + 9, 10))
      deg += 6;
    else
      deg -= 5;
  }
  else if ((orng = scan(deg -= 21, 10)))
  {
    if (scan(deg - 9, 10))
    {
      if (scan(deg -= 13, 5))
        deg -= 5;
    }
    else if (scan(deg + 9, 10))
      deg += 6;
  }
  else if (orng = scan(deg += 42, 10))
  {
    if (scan(deg + 9, 10))
      deg += 12;
  }
  else if ((orng = scan(deg += 21, 10)))
    ;
  else
    return Ritrova();
  if ((rng = scan(deg, 10)))
    cannon(deg, rng * 145 / (145 + orng - rng));
  else if (orng = scan(deg -= 21, 10))
    cannon(deg, orng);
  else if (orng = scan(deg += 42, 10))
    cannon(deg, orng);
  else
    deg += 41;
}

Affina()
{
  if (scan(deg + 13, 10))
    deg += 4;
  if (scan(deg - 13, 10))
    deg -= 4;
  if (scan(deg + 12, 10))
    deg += 2;
  if (scan(deg - 12, 10))
    deg -= 2;
  if (scan(deg + 10, 10))
    ++deg;
  if (scan(deg - 10, 10))
    --deg;
  return scan(deg, 10);
}

Ritrova()
{
  if ((orng = scan(deg -= 84, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg -= 21, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg += 126, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg += 21, 10)))
    return cannon(deg, orng);
  else if ((orng = scan(deg -= 168, 10)))
    return cannon(deg, orng);
  else
    return deg += 264;
}
