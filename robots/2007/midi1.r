/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots 2007                                                  */
/*                                                                          */
/*  CROBOT: midi1.r                                                         */
/*                                                                          */
/*  CATEGORIA: 1000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

Identico a !zeus con lievi ritocchi nei parametri.
  
*/

/*********************/
/* Variabili globali */
/*********************/

int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd,zd,xmd,ymd,ez;
int timer,dmin,dmax,ex;

/****************************************/
/* Routines di movimento e di scansione */
/****************************************/

Ymin(d1,d2,d3) {while(loc_y()<d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Ymax(d1,d2,d3) {while(loc_y()>d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmin(d1,d2,d3) {while(loc_x()<d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmax(d1,d2,d3) {while(loc_x()>d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/****************************************************/
/* FASE 0: Calcolo parametri e ritirata nell'angolo */
/****************************************************/

  if (xs=loc_x()>499) Xmin(850,0,0); else Xmax(150,180,180); 
  if (ys=loc_y()>499) Ymin(850,90,90); else Ymax(150,270,270);
  
  Params();
  
  Radar();
  
/******************************/
/* FASE 1: Attacco dall'angolo */
/******************************/

  while (en>1) {

   while (Look(deg=xd)) {
      if (xs) Xmax(720,xmd,yd-180); else Xmin(280,xmd,yd-180);
      if (ys) Ymin(850,yd-180,xd-180); else Ymax(150,yd-180,xd-180);
      if (xs) Xmin(850,xd-180,xmd); else Xmax(150,xd-180,xmd);
    } 

    while (!Look(xd) && Look(deg=yd)) {
      if (xs) Xmax(720,zd,yd-180); else Xmin(280,zd,yd-180);
      if (ys) Ymin(850,yd-180,xd-180); else Ymax(150,yd-180,xd-180);
      if (xs) Xmin(850,xd-180,zd); else Xmax(150,xd-180,zd);
    } 

    drive(xd-180,0);
    Radar();
  }
    

/****************************************/
/* FASE 2: Attacco finale               */
/****************************************/
  while (1) {
    Xmin(850,0,270);    
    Ymax(150,270,180);    
    Xmax(150,180,90);    
    Ymin(850,90,0);    
  }
/*
  Xmin(850,0,90);    
  Ymin(850,90,245);    

  while (1) {
    Ymax(150,245,110);    
    Ymin(850,110,0);    
    Xmin(850,0,245);    
  }
*/
}

/**********************************/
/* Routine di conteggio avversari */
/**********************************/

Radar()
{
  en=0;
  while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
  dmin=zd-60; 
}

/*********************************************/
/* Routine per calcolo parametri dell'angolo */
/*********************************************/

Params()
{
  xd=180*xs; 
  dmax=(dmin=(zd=(yd=90+180*ys)-45+90*(xs^ys))-60)+100;
  if (xs) { 
    if (ys) { xmd=218; ymd=232; } else { xmd=142; ymd=128; }
  } else {
    if (ys) { xmd=322; ymd=308; } else { xmd=38; ymd=52; }
  }
}

/*******************************/
/* Routine di fuoco principale */
/*******************************/

FireX(dir)
{
  int asin,acos;
  
  if (speed()<100) drive(dir,100); 
      
  if (scan(deg,10))
  {  
      asin=(sin(deg-dir)/14384);
      acos=(cos(deg-dir)/3796)-230;

      deg-=18*(scan(deg-18,10)>0); 
      deg+=18*(scan(deg+18,10)>0); 

      if(scan(deg-16,10)) deg-=8;
      else if(scan(deg+16,10)) deg+=8;
      if(scan(deg-12,10)) deg-=4;
      else if(scan(deg+12,10)) deg+=4;
      if(scan(deg-11,10)) deg-=2;
      if(scan(deg+11,10)) deg+=2;

      if (orng=scan(odeg=deg,4))
        {
            if(scan(deg-13,10)) deg-=5;
            else if(scan(deg+13,10)) deg+=5;
            if(scan(deg+12,10)) deg+=4;
            else if(scan(deg-12,10)) deg-=4;
            if(scan(deg-11,10)) deg-=2;
            if(scan(deg+11,10)) deg+=2;

            cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,
                   rng*230/(orng-rng-acos)); 
        }  else Search(); 
  } else Search();  
}

Search()
{
  if (rng=scan(deg+=350,10)) return cannon(deg,2*scan(deg,10)-rng);
  if (rng=scan(deg+=20,10))  return cannon(deg,2*scan(deg,10)-rng);
  if (rng=scan(deg+=320,10)) return cannon(deg,rng);
  if (rng=scan(deg+=60,10))  return cannon(deg,rng);
  if (rng=scan(deg+=280,10)) return cannon(deg,rng);

  deg-=220;
  Search();
}

QFire(dir)
{
  drive(dir,0);  
  while(speed()>59) ;
  drive(dir,100);
}
