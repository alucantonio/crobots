/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2001)                                 */
/*                                                                          */
/*  CROBOT: Vampire.r                                                       */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*
  Il microbo è poco furbo: il suo unico movimento consiste in un'oscillazione
  orizzontale sulla x da 100 a 900 in prossimita di y a 500.
  Spara con una toxica modificata per le oscillazioni degli avversari.
*/

int deg,rng,dir,odeg,orng,t;

main()
{
  t=90+180*(loc_y()>500);
  dir=90;
  
  while (loc_y()<=500) {
    Fire(drive(90,100));
  }
  Turn(270);
  
  while (loc_y()>500) {     
    Fire(drive(270,100));
  }
  Turn(0);

  deg=t;

  while (1) {
    while (loc_x()<=900) {
      Fire(drive(0,100));
    }
    Turn(180);
    
    while (loc_x()>100) {      
      Fire(drive(180,100));
    }
    Turn(0);
  }


}



Turn(d)
{
  while (speed()>65) drive(d,0);
  dir=d;
}


Fire()
{
    if (orng=scan(deg,10))
    {
        if (orng<420)  
        {
          if (orng<100) return cannon(deg,orng);
          if (scan(deg-10,6)) deg-=10;
          else if (scan(deg+10,6)) deg+=10;
          cannon(deg,(scan(deg,10)<<1)-orng);
          return;   
        } else if (orng>740) { deg+=40; return; }
        if (!scan(deg-=6,6)) deg+=12; 

        Find();

        if (orng=scan(odeg=deg,5))
        {
            Find();
            cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9)-(sin(deg-dir)>>14),
                   rng*250/(250+orng-rng-(cos(deg-dir)>>12)));                    
        } 
     }
     else
     {
        if (scan(deg-=20,10)) return Fire();
        if (scan(deg+=40,10)) return Fire();
        deg+=40; 
     }
}

Find()
{
  if(scan(deg-7,3)) deg-=7;
  if(scan(deg+7,3)) deg+=7;
  if(scan(deg-4,2)) deg-=4;
  if(scan(deg+4,2)) deg+=4;
  if(scan(deg-2,1)) deg-=2;
  if(scan(deg+2,1)) deg+=2;
}