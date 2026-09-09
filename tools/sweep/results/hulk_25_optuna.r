/*

Torneo 2025
Nome:	hulk_25.r		(999 istruzioni - midi)
Autore:	Franco Cartieri

Descrizione robot:
Hulk_25 è un crobot molto offensivo.
È ottimizzato per lo scontro a 2, ma si comporta bene anche nel 3vs3.
Cerca di adattarsi all'avversario: se l'avversario è distante, si muove lungo un quadrato al centro dell'arena e attacca con una routine di fuoco lenta ma precisa;
se l'avversario è vicino, si muove con oscillazioni e usa una routine di fuoco più veloce.
È un miglioramento, o forse peggioramento, di Hulk_20.

*/

int dir, deg, rng, odeg, orng, x, y, b;

main()
{
  if (loc_y(x = (loc_x() > 500)) > 500)
  {
    if (x)
      Spacca(dir = deg = 210);
    else
      Spacca(dir = deg = 300);
  }
  else
  {
    if (x)
      Spacca(dir = deg = 120);
    else
      Spacca(dir = deg = 30);
  }
  Rompi();
  while (1)
  {
    if (orng > 427)
    {
      Spacca(dir = 180);
      while (Vai(loc_x() > 300))
        ;
      if (!orng || (orng > 427))
      {
        Spacca(dir = 270);
        while (Vai(loc_y() > 300))
          ;
        if (!orng || (orng > 427))
        {
          Spacca(dir = 0);
          while (Vai(loc_x() < 700))
            ;
          if ((!orng || orng > 427))
          {
            Spacca(dir = 90);
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
      Spacca();
      Spacca();
    }
  }
}

Vai(c)
{
  if (c && ((!orng || orng > 427)))
  {
    Rompi();
    return 1;
  }
  else
    return 0;
}

Rompi()
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
      return cannon(deg + (deg - odeg) * ((1273 + rng) >> 9) - (sin(deg - dir) >> 14), rng * 201 / (201 + orng - rng - (cos(deg - dir) >> 12)));
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
  return 1;
}

Spacca()
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
    cannon(deg, rng * 135 / (135 + orng - rng));
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
