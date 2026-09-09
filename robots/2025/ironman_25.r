/*

Torneo 2025
Nome: 	ironman_25.r	(1993 istruzioni - macro)
Autore: Franco Cartieri

All'inizio dell'incontro si posiziona nell'angolo più vicino e si muove lungo due triangoli disegnati sui lati dell'angolo.
Se uno dei due angoli adiacenti è libero, il movimento diventa asimmetrico verso quest'angolo.
Se i due angoli adiacenti sono entrambi occupati o se sono stati effettuati più di 10 cicli, il movimento diventa simmetrico.
Oltre i 25 cicli, parte comunque per l'attacco finale di Hulk.
Ad ogni ciclo controlla il numero di avversari; se ne è rimasto uno solo, inizia l'attacco finale.

*/

int dir, deg, rng, odeg, orng, t, nc, xs, ys, xd, yd, xmd, ymd, dmin, dmax, xdr, ydr, e;

main()
{
  while (deg < 360)
  {
    if (rng = scan(deg += 21, 10))
    {
      cannon(deg, rng);
      if ((++e) > 1)
      {
        if (xs = loc_x() > 499)
          Xmin(850, 0, 0);
        else
          Xmax(150, 180, 0);
        if (ys = loc_y(xd = 180 * xs) > 499)
          Ymin(850, 90, 0);
        else
          Ymax(150, 270, 0);
        Radar(dmax = (dmin = (yd = 90 + 180 * ys) + 90 * (xs ^ ys) - 105) + 80);
        xdr = xd - 180;
        ydr = yd - 180;
        if (xs)
        {
          xmd = (150 + (ys * 60));
          ymd = (120 + (ys * 120));
        }
        else
        {
          xmd = (30 + (ys * 300));
          ymd = (60 + (ys * 240));
        }
        while (1)
        {
          if ((nc += 1) < 10)
          {
            if (t % 2)
            {
              if (!Look(xd))
                t += 1;
            }
            else
            {
              if (!Look(yd))
                t += 1;
            }
          }
          else
          {
            t += 1;
            if ((nc > 25) || (damage() > 75))
              F2f();
          }
          if (t % 2)
          {
            if (ys)
              Ymax(325, ymd, 0);
            else
              Ymin(675, ymd, 0);
            if (xs)
              Xmin(825, xdr, 0);
            else
              Xmax(175, xdr, 0);
            if (ys)
              Ymin(825, ydr, 1);
            else
              Ymax(175, ydr, 1);
          }
          else
          {
            if (xs)
              Xmax(325, xmd, 0);
            else
              Xmin(675, xmd, 0);
            if (ys)
              Ymin(825, ydr, 0);
            else
              Ymax(175, ydr, 0);
            if (xs)
              Xmin(825, xdr, 1);
            else
              Xmax(175, xdr, 1);
          }
        }
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
      Raggio(dir = deg = 210);
    else
      Raggio(dir = deg = 300);
  }
  else
  {
    if (x)
      Raggio(dir = deg = 120);
    else
      Raggio(dir = deg = 30);
  }
  Missile();
  while (1)
  {
    if (orng > 425)
    {
      Raggio(dir = 180);
      while (Vai(loc_x() > 300))
        ;
      if (!orng || (orng > 425))
      {
        Raggio(dir = 270);
        while (Vai(loc_y() > 300))
          ;
        if (!orng || (orng > 425))
        {
          Raggio(dir = 0);
          while (Vai(loc_x() < 700))
            ;
          if ((!orng || orng > 425))
          {
            Raggio(dir = 90);
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
      Raggio();
      Raggio();
    }
  }
}

Stop(dir, testf2f)
{
  drive(dir, 0);
  if (testf2f)
    Radar();
  else
    while (speed() > 59)
      ;
}

Ymin(dis, dir, testf2f)
{
  while (loc_y() < dis)
    Spara(dir);
  Stop(dir, testf2f);
}

Ymax(dis, dir, testf2f)
{
  while (loc_y() > dis)
    Spara(dir);
  Stop(dir, testf2f);
}

Xmin(dis, dir, testf2f)
{
  while (loc_x() < dis)
    Spara(dir);
  Stop(dir, testf2f);
}

Xmax(dis, dir, testf2f)
{
  while (loc_x() > dis)
    Spara(dir);
  Stop(dir, testf2f);
}

Look(d) { return (scan(d - 10, 10) + scan(d + 10, 10)); }

Radar()
{
  int ang, en;
  ang = dmin;
  while (ang <= dmax)
    en += (scan(ang += 20, 10) > 0);
  if (en < 2)
    F2f();
}

Vai(c)
{
  if (c && ((!orng || orng > 425)))
  {
    Missile();
    return 1;
  }
  else
    return 0;
}

Missile()
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

Raggio()
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
  return 1;
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

Spara(dir)
{
  int asin, acos;
  drive(dir, 100);
  if (scan(dir, 10))
    deg = dir;
  else if (rng > 700)
    deg += 180;
  if (scan(deg, 10))
  {
    asin = (sin(deg - dir) / 14384);
    acos = (cos(deg - dir) / 3796) - 230;
    deg -= 18 * (scan(deg - 18, 10) > 0);
    deg += 18 * (scan(deg + 18, 10) > 0);
    if (scan(deg - 16, 10))
      deg -= 8;
    else if (scan(deg + 16, 10))
      deg += 8;
    if (scan(deg - 12, 10))
      deg -= 4;
    else if (scan(deg + 12, 10))
      deg += 4;
    if (scan(deg - 11, 10))
      deg -= 2;
    if (scan(deg + 11, 10))
      deg += 2;
    if (orng = scan(odeg = deg, 3))
    {
      if (scan(deg - 13, 10))
        deg -= 5;
      else if (scan(deg + 13, 10))
        deg += 5;
      if (scan(deg + 12, 10))
        deg += 4;
      else if (scan(deg - 12, 10))
        deg -= 4;
      if (scan(deg - 11, 10))
        deg -= 2;
      if (scan(deg + 11, 10))
        deg += 2;
      cannon(deg + (deg - odeg) * ((880 + (rng = scan(deg, 10))) / 482) - asin, rng * 230 / (orng - rng - acos));
    }
    else
      Cerca();
  }
  else
    Cerca();
}

Cerca()
{
  if (scan(deg -= 350, 10))
    return Raffica();
  if (scan(deg -= 20, 10))
    return Raffica();
  if (scan(deg -= 320, 10))
    return Raffica();
  if (scan(deg -= 60, 10))
    return Raffica();
  if (scan(deg -= 280, 10))
    return Raffica();
  if (scan(deg -= 100, 10))
    return Raffica();
  if (scan(deg -= 240, 10))
    return Raffica();
}

Raffica()
{
  if (rng = scan(odeg = deg, 10))
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
    }
    return cannon(deg + (deg - odeg), 2 * scan(deg, 10) - rng);
  }
  else
    return Cerca();
}
