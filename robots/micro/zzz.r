/****************************************************************************/
/*                                                                          */
/*  Torneo di Microbots (2000)                                              */
/*                                                                          */
/*  CROBOT: ZZZ.R                                                           */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

int deg,rng,dir,orng,odeg,dir,i,d1,d2,y1;

main()
{
  while(loc_x()>=150) Move(180);
  y1=850; d1=270; d2=90; i=120;
  while(1) {
    while(loc_y()>=y1) Move(d1);
    while(loc_y()<=850) Move(d2);
    if (--i<0) { y1=150; d2=135; d1=315; }
  }
}

Move(d) { drive(dir=d,100); Fire(); }

Fire()
{
    if (orng=scan(deg,5))
    {

        Find();

        if (orng=scan(odeg=deg,5))
        {
            Find();

            if (rng=scan(deg,10))
            {
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
            }
        }
     }
     else
     {
        if (!scan(deg-=10,5)) 
          if (!scan(deg+=20,5)) deg+=20; 
     }
}

Find()
{
  if(scan(deg-5,1)) deg-=5;
  if(scan(deg+5,1)) deg+=5;
  if(scan(deg-3,1)) deg-=3;
  if(scan(deg+3,1)) deg+=3;
  if(scan(deg-1,1)) deg-=1;
  if(scan(deg+1,1)) deg+=1;  
}
