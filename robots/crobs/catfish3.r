/* Actually from Cameron (Go figure) */

int enemy;
int direction;
int left;
int right;
int safeMarg;

main()
{
  left = 10;
  right = 20;
  direction = left;
  safeMarg = 150;
  sink();

  while(1)
  {
    if (direction == left)
    {
      while (loc_x() > safeMarg)
      {
        if (loc_x() > safeMarg) drive(180,100);
        look();
      }
      direction = right;
    }

    if (direction == right)
    {
      while (loc_x() < 1000 - safeMarg)
      {
        if (loc_x() < 1000 - safeMarg) drive(0,100);
        look();
      }
      direction = left;
    }
  }
}

sink()
{
  while (loc_y() > 20)
    drive(270,loc_y());
}

stop()
{
  drive(0,0);
}

look()
int deg;
{
  deg = 30;
  while (deg <= 150)
  {
    enemy = scan(deg,10);
    if (enemy != 0) cannon(deg,enemy);
    deg = deg + 30;
  }
}

