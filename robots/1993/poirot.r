/*  Poirot CRobot   Roma 05/09/93  */

/*  Scorre l' arena secondo la cornice
    in senso orario.
    La routine di fuoco e' ottimizzata sia rispetto
    alla gittata che rispetto all'angolo.

    Cristiano De Mei
*/

int ang,rp;
main()
{                   /* Inizializzazione posizione */
  ang=0;
  while (loc_y()>60) { drive(270,100);fuoco1(); }
  drive(90,0);
  while (speed()>49) fuocoright();
  while (loc_x()<940) { drive(0,100);fuocoright(); }
  drive(90,49);
  while (speed()>49) fuocoright();
  drive(90,100);

  while(1)
  {
     while (loc_y()<940) fuocoup();        /* va in alto */
     drive(180,49);
     while (speed()>49) fuocoup();

     drive(180,100);                       /* va a sinistra */
     while (loc_x()>60) fuocolefth();
     drive(270,49);
     while (speed()>49) fuocolefth();

     drive(270,100);
     while (loc_y()>60) fuocodown();      /* va in basso */
     drive(0,49);
     while (speed()>49) fuocodown();

     drive(0,100);
     while (loc_x()<940) fuocoright();    /* va a destra */
     drive(90,49);
     while (speed()>49) fuocoright();

     drive(90,100);
  }
}

fuoco1()
{
  int ra;           /* rountine di fuoco a 360 gradi */

  if (ra=scan(ang,8))
  {
    if (ra>rp) cannon(ang,8*ra/7);
          else cannon(ang,7*ra/8);
    rp=ra;
    if (ra>600)
      ang+=18;
  }
  else
  {
    ang+=18;
    if (ang>359) ang=0;
  }
}

fuocoright()
{
  int range,ra;      /* routine di fuoco da 0 a 180 gradi */

  if (range=scan(ang,8))
  {
    if (ra=scan(ang,3))
    {
      if (ra>rp) cannon(ang,8*ra/7);
            else cannon(ang,7*ra/8);
      rp=ra;
    }
    else
    if (ra=scan(ang+4,4))
    {
      if (ra>rp) cannon(ang+4,8*ra/7);
            else cannon(ang+4,7*ra/8);
      rp=ra;
      ang+=4;
    }
    else
    if (ra=scan(ang-4,4))
    {
      if (ra>rp) cannon(ang-4,8*ra/7);
            else cannon(ang-4,7*ra/8);
      rp=ra;
      ang-=8;
    }
  }
  else
  {
    ang+=12;
    if (ang>180) ang=0;
  }
}

fuocoup()
{
  int range,ra;      /* routine di fuoco da 90 a 270 gradi */

  if (range=scan(ang,8))
  {
    if (ra=scan(ang,3))
    {
      if (ra>rp) cannon(ang,8*ra/7);
            else cannon(ang,7*ra/8);
      rp=ra;
    }
    else
    if (ra=scan(ang+5,4))
    {
      if (ra>rp) cannon(ang+5,8*ra/7);
            else cannon(ang+5,7*ra/8);
      rp=ra;
      ang+=6;
    }
    else
    if (ra=scan(ang-5,4))
    {
      if (ra>rp) cannon(ang-5,8*ra/7);
            else cannon(ang-5,7*ra/8);
      rp=ra;
      ang-=10;
    }
  }
  else
  {
    ang+=12;
    if (ang>270) ang=90;
  }
}

fuocolefth()
{
  int range,ra;          /* routine di fuoco da 180 a 360 gradi */

  if (range=scan(ang,8))
  {
    if (ra=scan(ang,3))
    {
      if (ra>rp) cannon(ang,8*ra/7);
            else cannon(ang,7*ra/8);
      rp=ra;
    }
    else
    if (ra=scan(ang+5,4))
    {
      if (ra>rp) cannon(ang+5,8*ra/7);
            else cannon(ang+5,7*ra/8);
      rp=ra;
      ang+=6;
    }
    else
    if (ra=scan(ang-5,4))
    {
      if (ra>rp) cannon(ang-5,8*ra/7);
            else cannon(ang-5,7*ra/8);
      rp=ra;
      ang-=10;
    }
  }
  else
  {
    ang+=12;
    if (ang>360) ang=180;
  }
}

fuocodown()
{
  int ra;             /* routine di fuoco da 270 a 90 gradi */

  if (ra=scan(ang,6))
  {
      if (ra>rp) cannon(ang,8*ra/7);
            else cannon(ang,7*ra/8);
      rp=ra;
  }
  else
  {
    ang+=10;
    if (ang==90) ang=270;
    if (ang==360) ang=0;
  }
}