int distance;
int gunRange;
int speed;
int safeMarg;
int aimCorrection;

main ()
{
speed = 100;
safeMarg = 150;
gunRange = 700;
aimCorrection = 5;
while (1)
  {
  while (loc_y() > safeMarg)
    { 
    drive(270,speed); 
    check(0);
    }
    stop();
  while (loc_x() < (1000 - safeMarg))
    {
    drive(0,speed);
    check(90);
    }
    stop();
  while (loc_y() < (1000 - safeMarg))
    {
    drive(90,speed);
    check(180);
    }
    stop();
  while (loc_x() > safeMarg)
    {
    drive(180,speed);
    check(270);
    }
    stop();
  }
}

check(angle)
{
distance = scan(angle,1);
if ((gunRange > distance) && (distance != 0))
  {
  if (distance > 350)
    {
    cannon(angle + aimCorrection,distance);
    }
  else
    {
    cannon(angle,distance);
    }
  }
}

stop()
{
drive(0,0);
}
