/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2001)                                 */
/*                                                                          */
/*  CROBOT: MicroDNA.r                                                      */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*
  Il microbo è poco piu' furbo dell'amico vampire.r: 
  il suo unico movimento consiste in un quadrato inizialmente nell'angolo più
  vicino e alla fine (f2f) al centro dell'arena.
  orizzontale sulla x da 100 a 900 in prossimita di y a 500.
  Spara con una toxica modificata per le oscillazioni degli avversari.
*/

int deg,rng,dir,odeg,orng,n,xm,ym,t;

main()
{
  xm=880-760*(loc_x(n=4)<500);
  ym=880-760*(loc_y()<500);
  
  while (++t) {
    if (n>1)
      if ((t%5)==1) {
        odeg=n=0;
        while((odeg+=20)<=360) if (scan(odeg,10)) ++n;	
        if ((n<=1)||(t>140)) xm=ym=500;
      }
    
    while (loc_x()<=xm) {
      Fire(drive(0,100));
    }
    Turn(90);

    while (loc_y()<=ym) {
      Fire(drive(90,100));
    }
    Turn(180);

    while (loc_x()>xm) {      
      Fire(drive(180,100));
    }
    Turn(270);

    while (loc_y()>ym) {     
      Fire(drive(270,100));
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
        if ((orng<420) || (n>1)) 
        {
          if (orng<100) return cannon(deg,orng);
          if (scan(deg-10,6)) deg-=10;
          else if (scan(deg+10,6)) deg+=10;
          cannon(deg,(scan(deg,10)<<1)-orng);
          if (n>1) 
            if (orng>770) deg+=40;           
          return;   
        }
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