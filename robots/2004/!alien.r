/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2004)                                 */
/*                                                                          */
/*  CROBOT: !Alien.r                                                        */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:
  
  ROUTINE DI FUOCO
  
  La novità maggiore di questo robot come anche degli altri di quest'anno e'
  costituita dalle routine di fuoco.
  
  In breve l'idea e' quella di evolvere le toxiche, ma di utilizzarle solo quando
  sono efficaci alternandole con routine non toxiche.
  
  Per migliorare le toxiche mi sono basato su questo obiettivo: utilizzare un tempo 
  di calcolo minore tra l'ultima serie di scan e la chiamata della cannon.
  Per ottenere cio' ho anticipato il calcolo delle correzioni trigonometriche prima 
  delle due serie di scan e ho inserito nello stesso punto il correttivo sul numeratore
  della formula del range. A questo punto e' stato necessario inserire 2 controlli per
  non perdere il bersaglio subito dopo il calcolo dei correttivi trigonometrici.
  
  Quindi ho modificato serie di scansioni con degli else che non vengono eseguiti sempre
  al fine di ridurre la durata media globale delle routine di fuoco che tuttavia e' ancora
  un po' alta (circa 25-30 cicli piu' del necessario) e per ridurre il tempo della seconda 
  serie di scan che determina la precisione per le variazioni di range e angolo.
  
  La seconda idea e' data dalla scelta di non utilizzare le toxiche nei casi in cui
  l'avversario e' molto vicino e soprattutto quando l'angolo varia molto e quindi i dati 
  della prima serie di scan non sono affidabili. 
  
  La parte non toxica delle routine varia nei 4 robot che ho presentato (nel micro e nel midi 
  ovviamente per risparmiare un po' di codice) e non presenta novita' particolari.
  
  Tenendo conto della 'lentezza' della routine e dei risultati che ottiene nei test credo
  che la precisione sia notevolmente migliorata.
  
  STRATEGIA
  
  La strategia del robot in generale e' molto simile a quella dei miei robot dello scorso
  anno. C'e' una prima fase difensiva identica a quella dello scorso anno (movimento a L) 
  con piccole differenze nella routine di fuoco semplificata e con la scelta differente 
  dei criteri per passare alla fase successiva (in particolare cambia subito se subisce 
  danni anche lievi e controlla meglio gli avversari negli angoli adiacenti).
  La seconda fase di attacco dall'angolo ora utilizza i triangoli di Simone dello scorso
  torneo e spero che resistano almeno un altro anno ;-) 
  L'ultima fase e' costituita dall'attacco a tutto campo in cui si utilizza un semplice
  e ampio triangolo circa isoscele con la base nella parte superiore dell'arena.
     
  CONSIDERAZIONI
  
  Il f2f soffre ovviamente di piu' i robot che utilizzano toxiche e oscillazioni brevi, 
  in particolar modo se in direzione perpendicolare poiche' in tal caso l'angolo non 
  varia molto e' si utilizza erroneamente la parte toxica della routine di fuoco. 

*/


/*********************/
/* Variabili globali */
/*********************/

int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd,zd,xmd,ymd,ez;
int timer,dmin,dmax,tx,timer,dd,dd2;

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
/* FASE 1: Difesa nell'angolo */
/******************************/

  if (en>1) { 
    while ((++timer<230) && (damage()<70))	{
      if (tx) {
        if (xs) {
          Run(180); while (loc_x()>950) LookX(); Stop(180);
          Run(0);   while (loc_x()<955) ; Stop(0);
        } else {
          Run(0);   while (loc_x()<50) LookX(); Stop(0);
          Run(180); while (loc_x()>45)  ; Stop(180);
        }
      
      } else {
        if (ys) {
          Run(270); while (loc_y()>950) LookY(); Stop(270);
          Run(90);  while (loc_y()<955) ; Stop(90);
        } else {
          Run(90);  while (loc_y()<50) LookY(); Stop(90);
          Run(270); while (loc_y()>45) ;  Stop(270);
        }
      
      }
      
    }
    
    if (en>1) Radar(timer=0);


  
/*******************************/
/* FASE 2: Attacco dall'angolo */
/*******************************/

    while (en>1) {

      while (Look(deg=xd)) {
        if (xs) Xmax(720,xmd,yd-180); else Xmin(280,xmd,yd-180);
        if (ys) Ymin(850,yd-180,xd-180); else Ymax(150,yd-180,xd-180);
        if (xs) Xmin(850,xd-180,xmd); else Xmax(150,xd-180,xmd);
      } 
    
      while (!Look(xd) && Look(deg=yd) && (++timer<100)) {
        if (xs) Xmax(720,zd,yd-180); else Xmin(280,zd,yd-180);
        if (!rng) deg=yd;
        if (ys) Ymin(850,yd-180,xd-180); else Ymax(150,yd-180,xd-180);
        if (!rng) deg=yd;
        if (xs) Xmin(850,xd-180,zd); else Xmax(150,xd-180,zd);
      }

      drive(xd-180,0);
      Radar();
      if (timer>=100) { if (damage()<30) en=1; else timer=0; } 

    }

    while (damage()<20) {
      Xmin(530,0,90);    
      Ymin(530,90,180);    
      Xmax(470,180,270);    
      Ymax(470,270,0);    
    }

  }

/****************************************/
/* FASE 3: Attacco finale               */
/****************************************/


  Xmin(850,0,90);    
  Ymin(850,90,245);    

  while (1) {
    Ymax(150,245,110);    
    Ymin(850,110,0);    
    Xmin(850,0,245);    
  }

}

/**********************************/
/* Routine di conteggio avversari */
/**********************************/

Radar()
{
  en=0;
  while ((dmin<=dmax) && (en<2)) en+=(scan(dmin+=20,10)>0);
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
      
  if (scan(deg,10)>150)
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
  if (scan(deg-=350,10)) return FireXX();
  if (scan(deg-=20,10))  return FireXX();
  if (scan(deg-=320,10)) return FireXX();
  if (scan(deg-=60,10))  return FireXX();
  if (scan(deg-=280,10)) return FireXX();
  if (scan(deg-=100,10)) return FireXX();
  if (scan(deg-=240,10)) return FireXX();
  if (scan(deg-=140,10)) return FireXX();
  if (scan(deg-=200,10)) return FireXX();
  if (scan(deg-=180,10)) return FireXX();
  if (scan(deg-=160,10)) return FireXX();
  if (scan(deg-=220,10)) return FireXX();
  if (scan(deg-=120,10)) return FireXX();
  if (scan(deg-=260,10)) return FireXX();
  if (scan(deg-=80,10))  return FireXX();
  if (scan(deg-=300,10)) return FireXX();
  if (scan(deg-=40,10))  return FireXX();
  if (scan(deg-=340,10)) return FireXX();
}

FireXX()
{
  if (rng=scan(odeg=deg,10)) {    
    if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
  }  else Search();
}

QFire(dir)
{
  drive(dir,0);  
  while(speed()>59) ;
  drive(dir,100);
}


LookX()
{
  LookZ(deg=yd);
  if (dd=scan(xd,10)) {
    if ((dd<(dd2=(scan(yd,10)+scan(ymd,10)))) || (!dd2)) { deg=xd; tx=!tx; }
  } else LookAgain(xd,xmd,yd);
}

LookY()
{
  LookZ(deg=xd);
  if (dd=scan(yd,10)) {
    if ((dd<(dd2=(scan(xd,10)+scan(xmd,10)))) || (!dd2)) { deg=yd; tx=!tx; }  
  } else LookAgain(yd,ymd,xd);
}

LookZ()
{ 
  if (timer>180) { if (!Look(zd)) timer=10000; if (damage()<30) timer=10000; }  else if (damage()>25) timer=10000;  
}

LookAgain(d1,d2,d3) { if (!Look(d1) && ((!scan(d2,10)) || (!scan(d3,10)))) timer=10000; }

Run(d)
{
  drive(d,100);
  while(speed()<70) drive(d,100);	
}

Stop(d)
{
  if (deg==d) while(scan(d,10)>840) ; 
  drive(d,0);

  if (!((rng=scan(odeg=deg,10)) && rng<880)) 
    if (!(rng=scan(odeg=(deg+=340),10))) 
      if (!(rng=scan(odeg=(deg+=40),10))) { while(speed()>59) drive(d,0); return; }
    
  if (scan(deg+10,10)) deg+=3; else deg+=357; 
  if (scan(deg+350,10)) deg+=358; else deg+=2; 
  if (scan(deg+10,10)) deg+=1; else deg+=359; 
    
  cannon(2*deg-odeg,rng); 
  	
  while(speed()>59) drive(d,0); 	
}
