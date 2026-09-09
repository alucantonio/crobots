/*UKA Studs
Milano, Rob
 mirobot.r */

int rminx,rminy,rmaxx,rmaxy;

int
GoodState()
{
  int rc;

  if (damage()>50) return 0;
  else return 1;
}


int
dist(x,y)
int x, y;
{
  int a,b;

  a= loc_x()-x;
  b= loc_y()-y;
  return sqrt((a*a)+(b*b));
}


int nearborder()
{
  if ((loc_x()>980) || (loc_x()<20) || (loc_y()>980) || (loc_y()<20)) return 1;
  else
     return 0;
}



int
MoveIntoRectangle()
{
  int direction= 0;

  if (loc_x()<500)
  {
     if (loc_y()<500)
       direction= atan((500-loc_y())/(500-loc_x())*100000);
     else
     if (loc_y()>500)
       direction= 360+atan((500-loc_y())/(500-loc_x())*100000);
  }
  else
  if (loc_x()>500)
  {
    if (loc_y()<500)
       direction= 180+atan((500-loc_y())/(500-loc_x())*100000);
    else
    if (loc_y()>500)
       direction= 180+atan((500-loc_y())/(500-loc_x())*100000);
  }


  if (direction!=0)
     while(dist(500,500)>282)
          drive(direction, 100);


  drive(direction,0);
}



int
MoveRandomly()
{
  int i, j, maxdegree,
      direction,range;

  direction= rand(359);
  drive(direction,100);

  i= 0;
  while(i<359) /* search whole field */
  {
    if (nearborder()) i=360;
    else
    if (range= scan(i,3))
    {
      cannon(i, range);
      drive(direction,80);
      j= i-10;
      if (j<0) j+=360;
      maxdegree= (j+20) % 360;
      cannon(i, range+2);
      while(j<maxdegree)
      {
        if (scan(j, 0))
           cannon(j, range);
        j+=2;
        if (j==360) j=0;
      }
      i= 360;
    }
    i+= 5;
  }
  drive(0,0);
}


main()
{
  rminx= 300; rminy=300;
  rmaxx= 700; rmaxy=700;


  while(1)
  {
    MoveIntoRectangle();
    MoveRandomly();
  }
}

