/************************************/
/*                                  */
/*  Torneo di CRobots (2012)        */
/*                                  */
/*  CROBOT: yeti.r                  */
/*                                  */
/*  CATEGORIA: 1000 istruzioni      */
/*                                  */
/*  AUTORE: Daniele Nuzzo           */
/*                                  */
/************************************/

/*

SCHEDA TECNICA:

  Praticamente lycan con innestato il movimento di pippo11a + qualche piccolo ritocco.
  Vediamo come se la cava...  

*/

/*********************/
/* Variabili globali */
/*********************/

int orng,x,y,dir,deg,rng,odeg,xs,ys,en,rd,timer,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd;

/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/****************************************************/
/* FASE 0: Calcolo parametri e ritirata nell'angolo */
/****************************************************/

	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
	drive(xd=180*xs,100); 
	dmax=(dmin=zd=((yd=90+180*ys)-105+90*(xs^ys)))+100;
  
/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

	while(en>1) {
		Run(xd,xp,2-xs);	
		Run(yd,yp,6-ys);	
	}

/*******************/
/* FASE 2: Attacco */
/*******************/

	f2f();
		
}

f2f()
{

	int b=0;
	ff=1;
	
	while(damage()<80) {
			
        if ((x=loc_x(y=loc_y()))>880) dir=160+40*(y>500);
        else if (x<120) dir=340+40*(y<500);
        else if ((y)>880) dir=250+40*(x<500);
        else if (y<120) dir=70+40*(x>500);                        

		else if (orng>600) dir=deg+25+(b^=1)*235;
		else if (orng<150) dir=deg+170+(b^=1)*25;
		else dir=deg+180*(b^=1);
					
		Fire(dir,100);
		Fire(dir,100);
		Fire(dir,100);
			
		drive(dir,49);
                       
    }
	
	theEnd();
            
}

theEnd()
{
	/*ff=1;*/
	while(1) {
		while (loc_x()<900) Fire2(0,100);
		Fire2(90,0);
		while (loc_y()<900) Fire2(90,100);
		Fire2(180,0);
		while (loc_x()>100) Fire2(180,100);
		Fire2(270,0);
		while (loc_y()>100) Fire2(270,100);
		Fire2(0,0);
	}
}


/********************/
/* Routine di fuoco */
/********************/

Fire(dir,v)
{
	drive(dir,v);
	
	if ((orng=scan(odeg=deg,10))) {
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
		return(cannon(deg+ff*(deg-odeg),2*scan(deg,10)-orng));
	} else {
		if (orng=scan(deg+=340,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		if (orng=scan(deg+=40,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		if (orng=scan(deg+=300,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		if (orng=scan(deg+=80,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		if (orng=scan(deg+=260,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		if (orng=scan(deg+=120,10)) return cannon(deg,3*scan(deg,10)-2*orng);
		deg+=80;
	} 
}

Fire2(dir,v)
{
	drive(dir,v);
	if (rng=scan(odeg=deg,10)) {
		if (scan(deg-8,5))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg+8,5))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg,10))   { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
	}
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else if(scan(dir,10)) deg=dir;
	else while(!scan(deg,10))deg+=19;
}

/*********************************/
/* Routines utilizzate in FASE 1 */
/*********************************/

Run(d,l,m) { 
  int r;
  if (timer%12==2) {
    en=0;
    while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    dmin=zd; 
  }
  
  while(r<2) {
  drive(d,100);
  
  ++r;
  if (++timer>550) theEnd(); 
  if (damage()>20) if (en==2) theEnd();
  
  if (scan(d,10)) { deg=d; while (scan(d,10)>840) ; } else while(Check(l,m)) ;
    
   
  Fire(d,0);  
  while(speed()>59) ;
  ++m;  
  d+=180;
  } 
}

Check(l,m) {
  int c1;
  if (m<5) c1=loc_x(); else c1=loc_y();
  if (m%2) return (c1>l); else return (c1<l);	
}	
