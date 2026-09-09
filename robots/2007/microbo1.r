/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots 2007                                                  */
/*                                                                          */
/*  CROBOT: microbo1.r                                                      */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

Pochissimo tempo per le schede e per completare gli altri robot. :-(
Microbo1 è l'unico robot differente dagli anni precedenti: gli altri 3 sono versioni 
leggermente modificate dei miei robot dello scorso torneo.

Il robot attende nell'angolo contando gli avversari, puntando sempre il più vicino
(l'idea su cui avrei voluto sviluppare meglio i robot di quest'anno, ma purtroppo 
non ho avuto tempo sufficiente) e con un moto a triangolo molto prossimo all'angolo.
Alla fine del match o quando rimane un solo avversario attacca usando un moto a quadrato
al centro dell'arena.
  
*/

int deg,rng,dir,odeg,orng,t;
int xs,ys,en,xd,yd,zd,ez;
int dmin,dmax,tx;
int enrng;

Up(d) { Start(90); while(loc_y()<d) Fire(); }
Dw(d) { Start(270); while(loc_y()>d) Fire(); }
Dx(d) { Start(0); while(loc_x()<d) Fire();  }
Sx(d) { Start(180); while(loc_x()>d) Fire();  }

main()
{

  if (xs=loc_x()>499) Dx(900); else Sx(100); 
  if (ys=loc_y()>499) Up(900); else Dw(100);
  
  drive(45,0);
  xd=180*xs; 
  dmax=(dmin=(zd=(en=yd=90+180*ys)-45+90*(xs^ys))-60)+100;

    while (en>1) {
      Start(zd);
      en=0; enrng=1500;
      while ((dmin<=dmax)) 
        if (rng=scan(dmin+=20,10)) { 
          ++en; 
          if (rng<enrng) { 
            deg=dmin; 
            enrng=rng; 
          } 
        }
      dmin=zd-60; 
      if (++t>220) if (damage()<80) en=1;
      Fire();

      if (xs) Dx(920); else Sx(80);
      if (ys) Up(920); else Dw(80);
      
    }

  while (1) {
    Dx(500);    
    Dw(500);    
    Sx(500);    
    Up(500);    
  }

}

Fire()
{
 if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg+=355; else deg+=5;
    if (scan(deg+10,10)) deg+=3; else deg+=357; 
     cannon((deg<<1)-odeg,(scan(deg,10)<<1)-rng); 
  } else {
        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        if (rng=scan(deg+=80,10))  return cannon(deg,rng);
        while (!(rng=scan(deg+=20,10))) ; 
        Fire();
  }
}

Start(d)
{
  drive(d,0); 
  while(speed()>59) ;
  drive(d,100); 
}

