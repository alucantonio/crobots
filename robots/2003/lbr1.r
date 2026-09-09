/****************************************************************************/
/*                                                                          */
/*  CROBOT: LBR1.R  359 istruzioni (OTTOBRE 2003)                           */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Leonardo Baldini                                                */
/*                                                                          */
/****************************************************************************/


/*

SCHEDA TECNICA:
  
  Questo robot è praticamente l'attacco finale dell'altro mio robot LSR,
  il fratello maggiore.
  Il robot inizia un movimento oscillatorio a triangolo centrato sul centro dell'arena.

OSCILLAZIONI:

  Il movimento a triangolo è ottenuto spostandosi da un vertice all'altro calcolando
  che la distanza attuale dal vertice sia inferiore alla precedente, in questo modo
  in realtà sorpassa il vertice prima di cambiare direzione, ne consegue un movimento
  a triangolo imperfetto.
   
ROUTINE DI FUOCO:
  La routine di fuoco è quella di mazinga.

ROUTINE FINALE:
  
  Non ha una routine finale.
    
*/
int nx;
int ny;
int dr;
int cx;
int cy;
int a;
int angle;
int cangle;
int dang; 
int dampos; 
int dist;
int pdist;
int dspeed;
int nangle;
   
main()
{
  dampos=damage();
  dr= 270;
  /* posizione centrale */
  cx= 500;
  cy= 500;
  getcangle();
  a= 0;
  while(1) {
    nx= cx;
    ny= cy;
    if (a==1)
      if (cangle<180)
        ny+= dr;
      else
        ny-= dr;
    if (a==2)
      if (cangle==0 || cangle==270)
        nx+= dr;
      else
        nx-= dr;
 /* calcola angolo di direzione */
    getangle();
 /* calcola distanza dal punto di arrivo */
    getdistance();
    pdist= dist;
 /* rallenta per cambiare direzione */
    while(speed()>49) drive(angle,0);
 /* si dirige verso il punto di arrivo */
    while (pdist>=dist) { 
      drive(angle,dspeed);
      fire();
      fire();
      pdist= dist;
 /* calcola distanza dal punto di arrivo */
      getdistance();
    } 
    if (++a>2) {
        a=0;
    }
  }
} 
    
/* calcolo angolo per spostamento */    
getangle() 
{ 
 angle= (180+180*(nx>loc_x())+atan(100000*(loc_y()-ny)/(loc_x()-nx)))%360; 
} 
 
/* calcolo angolo per controllo avversari */ 
getcangle()
{
  cangle= 90*(cx>500)+90*(cy>500)+180*(cy>500 && cx<500);
  nangle= cangle-180;
} 
/* calcolo distanza dal punto di arrivo */
getdistance()
{
  int x, y;
  x = loc_x() - nx;
  y = loc_y() - ny;
  dist= (x*x) + (y*y);
  if (dist>2000)
    dspeed= 100;
  else
    dspeed= 20;
}
/* routine di fuoco */
fire()
{
    int oldr,range;
    if ((oldr=scan(nangle,10))&&(oldr<850)) {
        if (!scan(nangle+=355,5)) nangle+=10;
        if (!scan(nangle+=357,3)) nangle+=6;
        cannon(nangle,2*scan(nangle,10)-oldr);        

    } 
    else {
        if (oldr=scan(nangle+=340,10)) return cannon(nangle,oldr);
        if (oldr=scan(nangle+=40,10)) return cannon(nangle,oldr);
        nangle+=40;
    }
}
/* end of LBR1.R */
