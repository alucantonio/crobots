/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2015)                                                */
/*                                                                          */
/*  CROBOT: the_old.r                                                       */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Vecchia rivisitazione di !zeus.r, non finita per la verita' e non adatta per il torneo 2015, ma interessante per il koth globale combinato. 
  Ora l'attacco a triangolo toxico dall'angolo avviene in entrambe le direzioni ed e' stato aggiunto un f2f non toxico piu' moderno.
*/

/*********************/
/* Variabili globali */
/*********************/

int deg,rng,dir,odeg,orng,dam,t,r;
int x,y,xs,ys,en,xd,yd,zd,xmd,ymd,ez;
int timer,dmin,dmax,ex;

/****************************************/
/* Routines di movimento e di scansione */
/****************************************/

Ymin(d1,d2,d3) {while(loc_y()<d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Ymax(d1,d2,d3) {while(loc_y()>d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmin(d1,d2,d3) {while(loc_x()<d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmax(d1,d2,d3) {while(loc_x()>d1) FireX(d2); if (d3==d2) drive(d2,0); else QFire(d3); }

Ymin2(d1,d2,d3) {while(loc_y()<d1) fire(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Ymax2(d1,d2,d3) {while(loc_y()>d1) fire(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmin2(d1,d2,d3) {while(loc_x()<d1) fire(d2); if (d3==d2) drive(d2,0); else QFire(d3); }
Xmax2(d1,d2,d3) {while(loc_x()>d1) fire(d2); if (d3==d2) drive(d2,0); else QFire(d3); }

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
  

   dam=damage();

   while (Look(deg=xd) && damage()<=dam) {
      if (xs) Xmax(720,xmd,yd-180); else Xmin(280,xmd,yd-180);
      if (ys) Ymin(850,yd-180,xd-180); else Ymax(150,yd-180,xd-180);
      if (xs) Xmin(850,xd-180,xmd); else Xmax(150,xd-180,xmd);
    } 

    dam=damage();

	while (Look(deg=yd) && damage()<=dam) {
      if (ys) Ymax(720,ymd,xd-180); else Ymin(280,ymd,xd-180);
      if (xs) Xmin(850,xd-180,yd-180); else Xmax(150,xd-180,yd-180);
      if (ys) Ymin(850,yd-180,ymd); else Ymax(150,yd-180,ymd);
    } 
    drive(yd-180,0);

    if (damage()<=dam) {
		Radar();
	} else if (!(r=Look(zd))) {
		if (en==2) if (damage()>30) f2f();
	} else if (r<600) en=1;
  }
    

/****************************************/
/* FASE 2: Attacco finale               */
/****************************************/

  f2ft();

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

      if (orng=scan(odeg=deg,3))
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

f2f() {
	int b,dir;

	while(1) {
		if (((x=loc_x())%850)<150) dir=180*(x>500);
		else if (((y=loc_y())%850)<150) dir=90+180*(y>500);
		else if ((rng<150) || (damage()>75)) dir=deg+180;
		else if (rng>650) dir=deg;
		else dir=deg+180*(b^=1);
		
		fire(dir); fire(dir); fire(dir); 
	 
	}
}

f2ft() {
  if (xs) Xmax(550,180,180); else Xmin(450,0,0);    
  if (ys) Ymax(150,270,270);    

  while (1) {
    Xmin(850,45,135);    
    Ymin(850,135,225);    
    Xmax(150,225,315);    
    Ymax(150,315,45);    
  }
}

fire(dir)
{
	drive(dir,100);
	if (rng=scan(odeg=deg,10)) {
		if (scan(deg-8,5)) { 	
			if (scan(deg-=5,2)) ; 
			else deg-=4; 
		} else {
			if (scan(deg+8,5)) {
				if (scan(deg+=5,2)) ; 
				else deg+=4; 
			} else {
				if (scan(deg,1)) ;
				else if (scan(deg-=3,2)) ; else deg+=6;
			}
		}
		return(cannon(deg+deg-odeg,2*scan(deg,10)-rng));
	} else {
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else deg+=80;
	}
}