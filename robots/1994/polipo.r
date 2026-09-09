/*  Polipo CRobot   Roma 03/08/94  */

/*  Scorre l' arena secondo una traiettoria verticale sul lato
    sinistro ed effettua delle fermate agli angoli.
    La routine di fuoco e' ottimizzata sia rispetto
    alla gittata che rispetto all'angolo ed e' ricavata dal
    precedente robot Poirot.r.

    Cristiano De Mei
*/

int ang,rp,dprec,angini,angfin,ra,distanza,nonhosparato,continua,angp;
main()
{
  ang=0;angp=180;
  while (loc_x()>60) { drive(180,100);fuocolefth(); }
  drive(180,49);
  while (loc_x()>20) fuocolefth();
  while (loc_x()>10) { drive(180,19);fuocolefth(); }
  drive(0,0);
  if (loc_y()>900) drive(270,25);
              else drive(90,25);
  while (speed()>49) fuocolefth();
  drive(270,49);ang=270;

  while(1)
  {
     while (loc_y()>100) fuocolefth();  /* vai giu */
     drive(270,49);
     while (loc_y()>30) fuocolefth();
     drive(90,0);
     angini=0;angfin=91;
     angolo();

     drive(90,100);ang=90;              /* vai su */
     while (loc_y()<900) fuocolefth();
     drive(90,49);
     while (loc_y()<970) fuocolefth();
     drive(270,0);
     angini=270;angfin=361;
     angolo();

     drive(270,100);ang=270;
  }
}

angolo()    /* fermati e cerca gli avversari */
{

  dprec=damage();
  ang=angini;
  while (damage()<dprec+11)
  {
    if ((ra=scan(ang,10)) && (ra<775))
    {
      continua=1;
      while ((continua) && (damage()<dprec+11))
      {
        ang+=(scan(ang+13,2) != 0)*15;
        ang+=(scan(ang-13,2) != 0)*345;
        spara();
      }
      continua=1;
      while ((continua) && (damage()<dprec+11))
      {
        ang+=(scan(ang+8,2) != 0)*10;
        ang+=(scan(ang-8,2) != 0)*350;
        spara();
      }
      continua=1;
      while ((continua) && (damage()<dprec+11))
      {
        ang+=(scan(ang+3,2) != 0)*5;
        ang+=(scan(ang-3,2) != 0)*355;
        spara();
      }
    }
    else
    {
      ang+=10;
      if (ang>angfin) ang=angini;
    }
  }
}

spara()  /* routine di aggiustamento della mira */
{
      if (ra=scan(ang,3))
      {
        if ((rp-ra>160) || (ra-rp>160)) distanza=ra;
        else
          if (ra>rp+5) distanza=ra*8/7;
          else
            if (ra<rp-5) distanza=ra*7/8;
            else distanza=ra;
        nonhosparato=bomba();
        rp=ra;
        continua=(angp!=ang);
        angp=ang;
      }
      else continua=0;
}

bomba()   /* fuoco ! */
{
  return !(cannon(ang,distanza));
}


fuocolefth()   /* fuoco durante le manovre */
{
  int range,ra;

  if ((range=scan(ang,8)) && (range<780))
  {
    if (ra=scan(ang,2))
    {
      if (ra>rp+15) cannon(ang,8*ra/7);
      else
      if (ra<rp-15) cannon(ang,7*ra/8);
      else
      cannon(ang,ra);
      rp=ra;
    }
    else
    if (ra=scan(ang+4,3))
    {
      if (ra>rp+15) cannon(ang+5,8*ra/7);
      else
      if (ra<rp-15) cannon(ang+5,7*ra/8);
      else
      cannon(ang+5,ra);
      rp=ra;
    }
    else
    if (ra=scan(ang-4,3))
    {
      if (ra>rp+15) cannon(ang-5,8*ra/7);
      else
      if (ra<rp-15) cannon(ang-5,7*ra/8);
      else
      cannon(ang-5,ra);
      rp=ra;
      ang+=350;
    }
  }
  else
  {
    ang+=10;
    ang%=360;
    if (ang==90) ang=270;
  }
}
