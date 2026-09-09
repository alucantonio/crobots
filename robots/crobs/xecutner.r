int dir, dis;
main ()
  {
    int dam, res, num;

    dam = damage ();
    first ();

    while (1)
      {
        if (dam + 5 < damage ())
          {
            dam = damage ();
            flee ();
            first ();
          }
        else if (dis == 0)
          {
            first ();
          }
        else
          {
            if (dis < 700 && dis > 0)
              {
                cannon (dir, dis);
              }
            if (dis > 700)
              {
                drive (dir, 75);
              }
            else if (dis > 100)
              {
                drive (dir, 30);
              }
            else if (dis > 20)
              {
                drive (dir, 10);
              }
            else
              {
                drive (dir, 0);
              }

            res = 5;
            while (res > 0)
              {
                dir -= res;
                dis = scan (dir, res);
                if (dis == 0)
                  {
                    dir += res * 2;
                  }
                res /= 2;
              }
          }
      }
  }

first () /*return the angle to the 'closest' robot*/
  {
    int resolution;

    resolution = 10;

    dis = scan (dir, resolution);
    while (dis == 0)
      {
        dir += resolution * 2;
        dis = scan (dir, resolution);
      }

    while (resolution > 1)
      {
        resolution /= 2;
        dir -= resolution;
        dis = scan (dir, resolution);
        if (dis == 0)
          {
            dir += resolution * 2;
          }
      }
  }

flee () /*move to a random location on the screen*/
  {
    int dir,x,y;

    x = rand (970) + 15;
    y = rand (970) + 15;

    dir = plot_course (x,y);
    drive (dir, 100);

    while (distance (loc_x(), loc_y(), x, y) > 150 && speed () > 0)
      ;
    drive (dir, 0);
  }

int
distance (x1, y1, x2, y2) /*the distance between the two points*/
  int x1,y1, x2, y2;
  {
    int x,y;

    x = x1-x2;
    y = y1-y2;
    return (sqrt ((x*x) + (y*y)));
  }

int
plot_course (xx,yy) /*the angle to get to the new point*/
  int xx,yy;
  {
    int d;
    int x,y;
    int scale;
    int curx,cury;

    scale = 100000;
    curx = loc_x ();
    cury = loc_y ();
    x = curx - xx;
    y = cury - yy;

    if (x==0)
      {
        if (yy > cury)
          {
            d = 90;
          }
        else
          {
            d = 270;
          }
      }
    else
      {
        if (yy < cury)
          {
            if (xx > curx)
              {
                d = 360 - atan ((scale * y) / x);
              }
            else
              {
                d = 180 + atan ((scale * y) / x);
              }
          }
        else
          {
            if (xx > curx)
              {
                d = atan ((scale * y) / x);
              }
            else
              {
                d = 180 + atan ((scale * y) / x);
              }
          }
      }
    return (d);
  }