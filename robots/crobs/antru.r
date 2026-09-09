int xflag, yflag;

main()
{
  int dir, x, y, range, dirFlag, lastx, lasty;
  dir=rand(360);

  calcDir(dir);

  dirFlag=0;
  
  x=loc_x();
  y=loc_y();
  
  while (1)
  {		
    x=loc_x();
    y=loc_y();
    if (lastx==x && lasty==y)
    {
      dir = dir+90;
      calcDir(dir);
      drive(dir, 100);
    }

    drive(dir, 100);
    if (dirFlag)
    {
      if (range=scan(0, 10)) cannon(0, range);
      else if (range=scan(20,10)) cannon(20, range);
      else if (range=scan(40,10)) cannon(40, range);
      else if (range=scan(60,10)) cannon(60, range);
      else if (range=scan(80,10)) cannon(80, range);
      else if (range=scan(100,10)) cannon(100, range);
      else if (range=scan(120,10)) cannon(120, range);
      else if (range=scan(140,10)) cannon(140, range);
      else if (range=scan(160,10)) cannon(140, range);
      else if (range=scan(180,10)) cannon(180, range);
      else if (range=scan(200,10)) cannon(200, range);
      else if (range=scan(220,10)) cannon(220, range);
      else if (range=scan(240,10)) cannon(240, range);
      else if (range=scan(260,10)) cannon(260, range);
    }
    else
    {
      if (range=scan(340, 10)) cannon(340, range);
      else if (range=scan(320,10)) cannon(320, range);
      else if (range=scan(300,10)) cannon(300, range);
      else if (range=scan(280,10)) cannon(280, range);
      else if (range=scan(260,10)) cannon(260, range);
      else if (range=scan(240,10)) cannon(240, range);
      else if (range=scan(220,10)) cannon(220, range);
      else if (range=scan(200,10)) cannon(200, range);
      else if (range=scan(180,10)) cannon(180, range);
      else if (range=scan(160,10)) cannon(160, range); 
      else if (range=scan(140,10)) cannon(140, range);
      else if (range=scan(120,10)) cannon(120, range);
      else if (range=scan(100,10)) cannon(100, range);
      else if (range=scan(80,10)) cannon(80, range);
    }
    
    dirFlag = !dirFlag;

    x=loc_x();
    y=loc_y();
    lastx = x;
    lasty = y;
    if (!xflag && x<200 || xflag && x>800) 
    {
      drive(dir, 50);
      dir = clipDir(180-dir);
      xflag = !xflag;
    }
    if (!yflag && y<200 || yflag && y>800)
    {
      drive(dir, 50);
      dir = clipDir(-dir);
      yflag=!yflag;
    }
  }
}

calcDir(dir)
int dir;
{
  if (dir<90)
  {
    xflag=1;
    yflag=1;
  }
  else if (dir<180)
  {
    xflag=0;
    yflag=1;
  }
  else if (dir<270)
  {
    xflag=0;
    yflag=0;
  }
  else 
  {
    xflag=1;
    yflag=0;
  }
}

clipDir(dir)
int dir;
{
  while (dir<0) dir+=360;
  while (dir>360) dir-=360;

  return dir;
}