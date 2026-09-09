/****************************************************************************/
/*                                                                          */
/*  Torneo di Microbots (2000)                                              */
/*                                                                          */
/*  CROBOT: UHM.R                                                           */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

int deg,rng,dir,orng,odeg,cx,cy;

main()
{
  while(1) { 
    if (Move(50,55))
      if (Move(50,945))
        if (Move(950,945))
          if (Move(950,55)) Fire();
  }
}

DirTo(x,y) int x,y; { return (360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)); }
From(x,y) int x,y; { return (((x-=loc_x())*x+(y-=loc_y())*y)); }

GoTo(x,y)
int x,y;
{
  while (From(x,y)>12000) { drive(dir,100); Fire(); }
  while(speed()>49) drive(dir,0);
  Fire();
}

Move(x,y)
int x,y;
{
  if ((x==cx) && (y==cy)) return 1;
  if (Look(dir=DirTo(x,y))) return 1;
  GoTo(cx=x,cy=y);
  return 0;
}

Look(d)
int d;
{
  return (scan(d+350,10)+scan(d+10,10));
}

Fire()
{
    if ((orng=scan(odeg=deg,10)) && (orng<800)) {
      if (!scan(deg+=5,5)) deg+=350;
      if (!scan(deg+=3,3)) deg+=354;
      if (rng=scan(deg,10)) cannon(deg+(deg-odeg),rng*160/(160+orng-rng));
    } else {
      if (scan(deg-=20,10)) return;
      if (scan(deg+=40,10)) return;
      deg+=40; return;
    }
}
