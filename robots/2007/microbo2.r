/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots 2007                                                  */
/*                                                                          */
/*  CROBOT: microbo2.r                                                      */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

Identico a !caos con attacco finale diverso (quadrato grande!).
  
*/

int rng,deg,odeg,orng,t,k;

main()
{

  if (loc_y()<499) { 
    while (loc_y()>250) Fire(270);
  } else {  
    while (loc_y()<750) Fire(90);
  }
  drive(180,0);  
 
  t=40;
  while (--t) {
    
    while (loc_x()>150) Fire(180);  
    Start();     
    
    while (loc_x()<850) Fire();  
    Start(180);  
  }

  while (1) {
    while (loc_x()>150) Fire(180); Start(270); 
    while (loc_y()>150) Fire(270); Start(0); 
    while (loc_x()<850) Fire(0); Start(90);    
    while (loc_y()<850) Fire(90); Start(180);
  } 

}

Fire(dir)
{
  int asin,acos;
  
  if (speed()<100) drive(dir,100); else { if (scan(dir,10)) deg=dir; if (rng>850) { deg+=120; } }
      
  if (scan(deg,10)) {  
    asin=(sin(deg-dir)/14384); 
    acos=(cos(deg-dir)/3796)-230;

    Find();
    if (orng=scan(odeg=deg,3)) {
      Find();
      cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,
             rng*230/(orng-rng-acos)); 
    }  else Search(); 
  } else Search();  
}

Find()
{
  if(scan(deg-13,10)) deg-=5;
  else if(scan(deg+13,10)) deg+=5;
  if(scan(deg+12,10)) deg+=4;
  else if(scan(deg-12,10)) deg-=4;
  if(scan(deg-11,10)) deg-=2;
  if(scan(deg+11,10)) deg+=2;
}

Search()
{
  if (rng=scan(deg+=350,10)) return cannon(deg,rng);
  if (rng=scan(deg+=20,10))  return cannon(deg,rng);
  if (rng=scan(deg+=320,10)) return cannon(deg,rng);
  if (rng=scan(deg+=60,10))  return cannon(deg,rng);
  if (rng=scan(deg+=280,10)) return cannon(deg,rng);

  deg-=220;
  Search();
}

Start(dir)
{
  drive(dir,0); 
  while(speed()>59) ;
  drive(dir,100); 
}
	