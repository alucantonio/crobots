/*
**
**           ap_2.r                Antonio Pennino
**
*/

/*------------------------------------------------------------------**
**               PRINCIPALI COSTANTI DEL PROGRAMMA                  **
**------------------------------------------------------------------*/
int  STOP;          /*  motore fermo                                */
int  MAXVEL;        /*  motore al massimo                           */
int  MAXCDIR;       /*  max. velocita' per poter cambiare direzione */
int  DIM_X;         /*  numero di caselle orizzontali (sinistra=0)  */
int  DIM_Y;         /*  numero di caselle verticali   (basso=0)     */
int  MARGMURO;      /*  margine di sicurezza per il muro            */
int  MAXTIRO;       /*  massima lunghezza di tiro del cannone       */
int  MINTIRO;       /*  margine di sicurezza per il cannone         */
int  AMPSCAN;       /*  ampiezza dell' angolo di scansione          */
int  INCRSCAN;      /*  incremento nell' angolo di scansione        */
int  RIPSCAN;       /*  numero di scansioni per coprire 360 gradi   */
int  LOOPSCAN;      /*  numero di scansioni consecutive             */

/*------------------------------------------------------------------**
**                      VARIABILI GLOBALI                           **
**------------------------------------------------------------------*/
int  AngScan;       /*  ultimo angolo di scansione del radar        */
int  Distanza;      /*  distanza del bersaglio trovato              */
int  DirMarcia;     /*  direzione (angolo) attuale di marcia        */
int  xb,yb;         /*  vecchie coordinate del bersaglio            */
int  dxb,dyb;       /*  differenza di coordinate del bersaglio      */

/*------------------------------------------------------------------**
**          INIZIALIZZA LE COSTANTI E LE VARIABILI GLOBALI          **
**------------------------------------------------------------------*/
inizializza()
{
  STOP=0;      MAXVEL=100;   MAXCDIR=49;
  DIM_X=1000;  DIM_Y=1000;   MARGMURO=225;
  MAXTIRO=700; MINTIRO=45;  
  AMPSCAN=7;   INCRSCAN=AMPSCAN*2;
  LOOPSCAN=7;  RIPSCAN=360/INCRSCAN;      
  AngScan=0;   Distanza=0;
}

/*------------------------------------------------------------------**
**         RESTITUISCO IL VALORE ASSOLUTO (>0) DI UN INTERO         **
**------------------------------------------------------------------*/
abs(num)
int num;
{
  if (num>=0) return(num); else return(num*-1);
}

/*------------------------------------------------------------------**
**        CALCOLO LA DIREZIONE PER ANDARE IN UN CERTO PUNTO         **
**   L' angolo e' restituito normalizzato ( 0 <= angolo < 360 )     **
**------------------------------------------------------------------*/
direzione(old_x,old_y,new_x,new_y)
int old_x,old_y,new_x,new_y;
{
  int dx,dy,angolo;                 /* dichiaro le variabili locali */       
  dx=new_x-old_x; dy=new_y-old_y;   /* calcolo le differenze in X,Y */
  if (dx==0)                        /* valuto se direzione verticale*/
    if(dy>=0) return(90);           /* ... new_y e' a +90 gradi     */
	 else return(270);          /* ... new_y e' a -90 gradi     */
  angolo=atan((100000*dy)/abs(dx)); /* calcolo l' angolo(1,4 quadr.)*/
  if ( dx < 0 ) angolo=180-angolo;  /* corr. x secondo e terzo quad.*/
  angolo=(angolo+720)%360;          /* normalizzo l' angolo (0-359) */
  return(angolo);                   /* restituisco l' angolo        */
}

/*------------------------------------------------------------------**
**              SI SPOSTA NELLA LOCAZIONE SPECIFICATA               **
**                ( x , y , velocita ; DirMarcia )                  **
**------------------------------------------------------------------*/
go_to(x,y,vel)
int x,y,vel;
{
  go_dir( direzione(loc_x(),loc_y(),x,y) , vel );
}

/*------------------------------------------------------------------**
**   SI SPOSTA VERSO IL CENTRO SENZA USCIRE FINCHE' E' NEL MARGINE  **
**     Se la velocita' == 0  esce x far gestire il tutto al main    **
**                    ( velocita ; DirMarcia )                      **
**------------------------------------------------------------------*/
go_centro(vel)
int vel;
{
  go_to(DIM_X/2,DIM_Y/2,vel);
  while(testmarg(loc_x(),loc_y()) && speed()) ; 
}

/*------------------------------------------------------------------**
**               SI SPOSTA NELLA DIREZIONE SPECIFICATA              **
**                ( direzione , velocita ; DirMarcia )              **
**------------------------------------------------------------------*/
go_dir(direzione,vel)
int direzione;
int vel;
{
  if ( DirMarcia==direzione ) { drive (DirMarcia,vel); return; }
  DirMarcia=direzione;
  drive( DirMarcia , STOP   );
  while (speed() > MAXCDIR) ;
  drive( DirMarcia , vel    );
  while (speed() == STOP) drive(DirMarcia,vel);
}

/*------------------------------------------------------------------**
**                 INVERTE LA DIREZIONE DI MARCIA                   **
**------------------------------------------------------------------*/
retromarcia()
{
  DirMarcia=(DirMarcia+180+360)%360;
  go_dir(DirMarcia,MAXVEL);
}

/*------------------------------------------------------------------**
**     VERIFICO SE LA COORDINATA SPECIFICATA SI TROVA AI MARGINI    **
**              ( 0=falso, 1=su un lato, 2=in un angolo )           **
**------------------------------------------------------------------*/
testmarg(x,y)
int x,y;
{ 
  int ritorno;
  ritorno=0;
  if ( (x+MARGMURO) >= DIM_X ) ++ritorno;
  if ( (y+MARGMURO) >= DIM_Y ) ++ritorno;
  if (x<MARGMURO)              ++ritorno;
  if (y<MARGMURO)              ++ritorno;
  return(ritorno);
}

/*------------------------------------------------------------------**
**    VERIFICO SE LA COORDINATA SPECIFICATA E' FUORI DAL QUADRATO   **
**                        ( ; vero | falso )                        **
**------------------------------------------------------------------*/
testfuori(x,y)
int x,y;
{     
  if (x<0)                     return(1);
  if (y<0)                     return(1);
  if (x>=DIM_X)                return(1);
  if (y>=DIM_Y)                return(1);
  return(0);
}

/*------------------------------------------------------------------**
**                 CALCOLA LA DISTANZA TRA DUE PUNTI                **
**                    ( x1,y1,x2,y2 ; distanza )                    **
**------------------------------------------------------------------*/
distanza(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  int dx,dy;
  dx=x1-x2; dy=y1-y2;
  return( sqrt(dx*dx+dy*dy) );
}

/*------------------------------------------------------------------**
**                 I N I Z I O   P R O G R A M M A                  **
**------------------------------------------------------------------*/
main()
{
  inizializza();

  go_dir(90,MAXVEL);  while (speed()) spara();
  go_dir( 0,MAXVEL);  while (speed()) spara();

  go_dir(270,MAXVEL); while (speed()) spara();

  while(1)
    { 
     go_dir(180,MAXVEL); 
     while(testmarg(loc_x(),loc_y()) == 2)            spara();
     while(testmarg(loc_x(),loc_y()) < 2 && speed())  spara();
     
     go_dir(90,MAXVEL);    
     while(testmarg(loc_x(),loc_y()) == 2)            spara();
     while(testmarg(loc_x(),loc_y()) < 2 && speed())  spara();
     
     go_dir(315,MAXVEL);
     while(testmarg(loc_x(),loc_y()) == 2)            spara();
     while(testmarg(loc_x(),loc_y()) < 2 && speed())  spara();
    }
}

/*------------------------------------------------------------------**
**                    CERCO IL BERSAGLIO E SPARO                    **
**------------------------------------------------------------------*/
spara()
{
  int i;
  
  AngScan=(AngScan+720)%360;              /* normalizzo AngScan     */

  if      (Distanza=scan(AngScan,AMPSCAN))
    { cannon(AngScan,Distanza);           return; }
  else if (Distanza=scan(AngScan-INCRSCAN,AMPSCAN))
    { cannon(AngScan-=INCRSCAN,Distanza); return; }
  else if (Distanza=scan(AngScan+INCRSCAN,AMPSCAN))
    { cannon(AngScan+=INCRSCAN,Distanza); return; }

  if (speed() == STOP)  return;           /* se sono fermo esco     */

  i=LOOPSCAN+1; Distanza=0;               /* inizializzo il loop    */
  AngScan+=INCRSCAN;                      /* inizializzo l' angolo  */
  while(--i && !Distanza)                 /* se trovo SPARO         */
    if (Distanza=scan(AngScan+=INCRSCAN,AMPSCAN))
      cannon(AngScan,Distanza);
}

