/****************************************************************************/
/*                                                                          */
/*  CROBOT: LBR.R  485 istruzioni (OTTOBRE 2003)                            */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Leonardo Baldini                                                */
/*                                                                          */
/****************************************************************************/


/*

SCHEDA TECNICA:
  
  Il robot si reca nell'angolo più vicino e inizia un movimento oscillatorio
  a triangolo. Se accumula il 20% di danni si sposta su uno dei due angoli adiacenti
  preferibilmente dove non trova nessuno.

OSCILLAZIONI:

  Il movimento a triangolo è ottenuto spostandosi da un vertice all'altro calcolando
  che la distanza attuale dal vertice sia inferiore alla precedente, in questo modo
  in realtà sorpassa il vertice prima di cambiare direzione, ne consegue un movimento
  a triangolo imperfetto.
   
ROUTINE DI FUOCO:
  La routine di fuoco è quella di mazinga.

ROUTINE FINALE:
  
  Quando raggiunge il 70% di danni tenta il tutto per tutto e inizia a muoversi a triangolo
  centrato sul centro dell'arena sperando di essere rimasto contro solo un altro avversario.
    
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
  dr= 60;
  /* posizione nell'angolo più vicino */
  cx= 100+800*(loc_x()>500);
  cy= 100+800*(loc_y()>500);
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
      /* routine di  fuoco */
      fire();
      fire();
      pdist= dist;
  /* calcola distanza dal punto di arrivo */
      getdistance();
    } 
  /* controlla se ha accumulato il 20% di danni inquesto angolo */
    if (dampos+20<damage()) {
  /* se i danni sono < 70% cambia angolo */
      if (damage()<70) {
        dang= cangle;
        if (!scan(dang+90,10)) dang+=90;
        if (!scan(dang,10)) {
          if (dang==90 || dang==270)
            cy= 1000-cy;
          else
            cx= 1000-cx;
          getcangle();
          dampos=damage();
          a=0;
        }
  /* se i danni sono > 70% attacco finale al centro */
      } else {
        cx= 500; cy=500; dr=250; a=0;
        getcangle();
        dampos=damage();
      }
    } else if (++a>2) {
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
/* end of LBR.R */
