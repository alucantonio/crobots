/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2004)                                 */
/*                                                                          */
/*  CROBOT: !Caos.r                                                         */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Il robot e' vergognosamente semplice: forzatamente per utilizzare le nuove routine 
  di fuoco che ovviamente perdono molto di efficacia per le semplificazioni!

  Il robot si muove a destra e a sinistra  cercando di fare subito fuori 
  l'avversario che si trova di fianco.
  Quindi continua ad oscillare e aspetta quasi fino alla fine del match e parte 
  all'attacco con il triangolone (vedi scheda !Alien)
  
  Strategicamente e' talmente semplice che aspettarsi qualche risultato e' un 
  azzardo, tuttavia i microbi non hanno molto codice a disposizione e a forza
  bruta e' messo benino; miracolosamente rende bene anche nell'ultimo torneo
  dei big e rompe le scatole ai fratelli maggiori a tal punto che sono stato 
  fortemente tentato a non inviarlo.
  La scommessa e' pero' sui microbi e su particolari situazioni strategiche che
  potrebbero verificarsi anche nei tornei maggiori.
  Mah ?!
  
*/


/*********************/
/* Variabili globali */
/*********************/

int rng,deg,odeg,orng,t,k;

main()
{

  if (loc_y()<499) { 
    while (loc_y()>250) Fire(270);
  } else {  
    while (loc_y()<750) Fire(90);
  }
  drive(180,0);  
 
/*******************************/
/* FASE 1: Attacco dall'angolo */
/*******************************/

  t=40;
  while (--t) {
    
    while (loc_x()>150) Fire(180);  
    Start();     
    
    while (loc_x()<850) Fire();  
    Start(180);  
  }

/****************************************/
/* FASE 2: Attacco finale               */
/****************************************/

  while (loc_y()<850) Fire(90); Start(245);
  
  while (1) {
    while (loc_y()>150) Fire(245); Start(110); 
    while (loc_y()<850) Fire(110); Start(0);
    while (loc_x()<850) Fire(0); Start(245);    
  }

}

/*******************************/
/* Routine di fuoco            */
/*******************************/

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
	