/*
Torneo midi 2012

Camille.r del 08-agosto-2011,
assemblato da Marco Borsari.

Scheda tecnica:
Il robot prende come modello Cadderly del 2003 (alle cui note
esplicative si rimanda) e vi apporta alcune migliorie. Ho sostituito
nel sistema di frenata il fuoco rapido e la velocita' regolata oltre
il massimo, per maggiore compattezza e sicurezza. Dopo aver
considerato codici analoghi, ho modificato i coefficienti di sparo del
cannone nel cono centrale. Nel passaggio alla fase 2, ho abbassato il
limite di danno da 50 a 30, ancora in questa ho inserito un ammontare
di danno da superare per cambiare il lato di attacco.
La fase 3 (finale) di gioco passa dal tracciare un quadrato attorno
all'arena a un piu' irregolare poligono.
*/

/*********************/
/* Variabili globali */
/*********************/

int dir,deg,rng,odeg,xs,ys,radius,timer,dam,xd,yd,tx,dd,dd2,zd,x1,x2,y1,y2;

/****************************************/
/* Routines di movimento e di scansione */
/****************************************/

Ymin(d1,d2) { while(loc_y()<d1) Fire(d2,100); drive(d2,0); }
Ymax(d1,d2) { while(loc_y()>d1) Fire(d2,100); drive(d2,0); }
Xmin(d1,d2) { while(loc_x()<d1) Fire(d2,100); drive(d2,0); }
Xmax(d1,d2) { while(loc_x()>d1) Fire(d2,100); drive(d2,0); }

Look(d) { return (!(scan(d-10,10)+scan(d+10,10))); }

/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/****************************************************/
/* FASE 0: Calcolo parametri e ritirata nell'angolo */
/****************************************************/

  if (xs=loc_x()>499) Xmin(900,0);  else Xmax(100,180);
  if (ys=loc_y()>499) Ymin(880,90); else Ymax(120,270);

  tx=0;
  zd=(yd=90+180*ys)-45+90*(xs^ys);

  x1=330-120*xs; x2=30+120*xs;
  y1=120+120*ys; y2=60+240*ys;

  timer=10000*((Look(xd=180*xs))+(Look(yd))+(Look(zd))>1);

/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

  while (++timer<240) {
    if (tx) {

      if (xs) {
        drive(180,100); while (loc_x()>950) LookXY(xd,yd); Stop(180);
        drive(0,100);   while (loc_x()<955) ; Stop(0);
      } else {
        drive(0,100);   while (loc_x()<50)  LookXY(xd,yd); Stop(0);
        drive(180,100); while (loc_x()>45)  ; Stop(180);
      }

    } else {

      if (ys) {
        drive(270,100); while (loc_y()>950) LookXY(yd,xd); Stop(270);
        drive(90,100);  while (loc_y()<955) ; Stop(90);
      } else {
        drive(90,100);  while (loc_y()<50)  LookXY(yd,xd); Stop(90);
        drive(270,100); while (loc_y()>45)  ; Stop(270);
      }

    }
  }

/********************************/
/* FASE 2: Attacco dall'angolo  */
/********************************/

  while(speed()) {
    Triangle(xd);
    Triangle(yd);
  }

/****************************************/
/* FASE 3: Attacco al centro dell'arena */
/****************************************/

  radius=(Ver(500,500)+180)%360;
  while(1) {
    dir=Ver(xs=500+/*400*/cos(radius)/250,
    ys=500+/*400*/sin(radius)/250);
    while (Dist(xs,ys)>100) Fire(dir,100);
    Fire(dir,49);
    radius=(radius+280)%360;
  }

}

/*******************************/
/* Routine di fuoco principale */
/*******************************/

Fire(dir,v)
{
  drive(dir,v);
  if (rng=scan(odeg=deg,10))
  {
    if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg,5))      { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg,3*scan(deg,10)-2*rng)); }
  } else {
      deg+=315;
      while (!(rng=scan(deg+=20,10))) ;
      cannon(deg,rng);
  }
}

/*********************************/
/* Routines utilizzate in FASE 3 */
/*********************************/

Ver(x,y)
{
  y-=loc_y();
  if ((x-=loc_x())==0)
    if (y<0) return 90;
    else return 270;
  else return 180*((x>0)+1)+atan(100000*y/x);
}


Dist(x,y)
{
  return sqrt((x-=loc_x())*x+(y-=loc_y())*y);
}

/*********************************/
/* Routines utilizzate in FASE 2 */
/*********************************/

Triangle(d)
{
    dam=damage()+6;
    while (!Look(deg=d) && (damage()<=dam)) {
      if (d==xd) {
        if (ys) {
          Ymax(845,x1); Ymin(945,x2);
        } else {
          Ymin(155,x2); Ymax(55,x1);
        }
        if (xs) {
          Xmin(900,0);
        } else {
          Xmax(100,180);
        }
      } else {
        if (xs) {
          Xmax(845,y1); Xmin(945,y2);
        } else {
          Xmin(155,y2); Xmax(55,y1);
        }
        if (ys) {
          Ymin(900,90);
        } else {
          Ymax(100,270);
        }
      }
    }
}

/*********************************/
/* Routines utilizzate in FASE 1 */
/*********************************/

LookXY(p1,p2)
{
  if (timer>50) { if (Look(zd)) timer=10000; } else if (damage()>30) timer=10000;
  deg=p2;
  if (dd=scan(p1,10)) {
    if ((dd<(dd2=scan(p2,10))) || (!dd2)) { deg=p1; tx=!tx; }
  } else if (Look(p1)) if ((timer>190) || (Look(p2))) timer=10000;
}

Stop(d)
{
  if (d==deg) while (scan(d,10)>840) ;
  Fire(d,40);
  while(speed()>49) ;
}
