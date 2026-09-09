/********************************/
/*                              */
/*  Torneo di CRobots 2025      */
/*                              */
/*  CROBOT: extrasmall.r        */
/*                              */
/*  CATEGORIA:  500 istruzioni  */
/*                              */
/*  AUTORE: Daniele Nuzzo       */
/*                              */
/********************************/


/*

All'ultimo minuto, solo per partecipare.
Buon torneo e un saluto a tutti!

*/


int rng,deg,odeg,orng,k, odir;

main()
{
	
  while (odir=1) {
    
	if (scan(0,10)) UpDw();	else Dx(750);
	if (scan(90,10)) SxDx(); else Up(750);
	if (scan(180,10)) UpDw(); else Sx(250);
	if (scan(270,10)) SxDx(); else  Dw(250);
	
  }

}

Up(y) { while(loc_y()<y) Fire(90); }
Dw(y) { while(loc_y()>y) Fire(270); }
Dx(x) { while(loc_x()<x) Fire(); }
Sx(x) { while(loc_x()>x) Fire(180); }

UpDw() { if (loc_y()<500) Up(750); else Dw(250); }
SxDx() { if (loc_x()<500) Dx(750); else Sx(250); }


Fire(dir)
{
  int asin,acos;
  
  if (odir!=dir) {
	drive(dir,0); 
	while(speed()>49) ;
	drive(dir,100);
	odir=dir;
  } else { 
	if (scan(dir,10)) deg=dir; 
	if (rng>850) deg+=120;  
  }

  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg+=355; else deg+=5;
    if (scan(deg+350,10)) deg+=357; else deg+=3; 
    cannon((deg<<1)-odeg+1,(scan(deg,10)<<1)-rng); 
  } else {
        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        if (rng=scan(deg+=80,10))  return cannon(deg,rng);
        if (rng=scan(deg+=260,10)) return cannon(deg,rng);
        if (rng=scan(deg+=120,10)) return cannon(deg,rng);
        deg+=270; 
  }
  
}
