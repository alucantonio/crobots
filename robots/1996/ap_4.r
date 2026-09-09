/*
**
**           ap_4.r             
**             di               
**       Antonio Pennino        
**     (MC4366@mclink.it)       
**          30/09/95            
**
*/

/*------------------------------------------------------------------**
**               PRINCIPALI COSTANTI DEL PROGRAMMA                  **
**------------------------------------------------------------------*/
int  STOP;          /*  motore fermo                                */
int  MAXVEL;        /*  motore al massimo                           */
int  MAXVELCD;      /*  max. velocita' per poter cambiare direzione */
int  DIM_XY;        /*  numero di caselle orizzontali/verticali     */
int  MARGMURO;      /*  margine di sicurezza per il muro            */
int  MAXTIRO;       /*  massima lunghezza di tiro del cannone       */
int  MINTIRO;       /*  minima  lunghezza di tiro del cannone       */
int  AMPSCAN;       /*  ampiezza dell' angolo di scansione          */
int  INCRSCAN;      /*  incremento nell' angolo di scansione        */
int  RIPSCAN;       /*  numero scansioni consecutive                */

/*------------------------------------------------------------------**
**                      VARIABILI GLOBALI                           **
**------------------------------------------------------------------*/
int  AngScan;       /*  ultimo angolo di scansione del radar        */
int  DirMarcia;     /*  direzione (angolo) attuale di marcia        */
int  AutoPilota;    /*  autopilota in funzione (tranquilli...)      */
int  Tranquillo;    /*  flag per verificare se sono al sicuro       */

/*------------------------------------------------------------------**
**          INIZIALIZZA LE COSTANTI E LE VARIABILI GLOBALI          **
**------------------------------------------------------------------*/
inizializza()
{
  STOP=0;      MAXVEL=100;         MAXVELCD=40;
  DIM_XY=1000; MARGMURO=240;
  MAXTIRO=700; MINTIRO=50;  
  AMPSCAN=9;   INCRSCAN=AMPSCAN*2; RIPSCAN=5;      
  
  AngScan=0;   AutoPilota=0;       Tranquillo=0;
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
**               SI SPOSTA NELLA DIREZIONE SPECIFICATA              **
**               con correzione per evitare il margine              **
**  -------------------------------------------------------------   **
**          ( direzione , velocita ; DirMarcia , AutoPilota )       **
**  _____________________________________________________________   **
**  AutoPilota ON significa che si e' ai bordi ma che l' angolo e'  **
**  stato preventivamente controllato (non rischio impatto bordi)   **   
**------------------------------------------------------------------*/
go_dir(direzione,vel)
int direzione;
int vel;
{
  int x,y,amin,amax,minc,maxc;      /* angoli e coordinate min/max  */
  
  drive (DirMarcia,MAXVELCD);     /* mi porto avanti con la manovra */

  x=loc_x(); y=loc_y(); minc=MARGMURO; maxc=DIM_XY-MARGMURO;
  amin=0; amax=360;                           /* default a. min/max */
  AutoPilota=0;                               /* default AutoPilota */
  
  if (x<minc && y<minc) { amin=0;   amax=90;  } /* basso a sinistra */
  if (x<minc && y<minc) { if (direzione>180) direzione-=360; }
  if (x>maxc && y<minc) { amin=90;  amax=180; } /* basso a destra   */
  if (x<minc && y>maxc) { amin=270; amax=360; } /* alto  a sinistra */
  if (x>maxc && y>maxc) { amin=180; amax=270; } /* alto  a destra   */

  if (!(direzione>=amin && direzione<=amax))    /* ____CORREGGO____ */
    if (abs(direzione-amin) < abs(direzione-amax))
         { direzione=amin; AutoPilota=1; }      /* _AutoPilota ON _ */
    else { direzione=amax; AutoPilota=1; }      /* _AutoPilota ON _ */
 
  drive (DirMarcia=direzione,vel);
  while (speed() == STOP)     drive(DirMarcia,vel) ;
  while (testmarg(-1,-1) > 1) ;
  return(DirMarcia);
}

/*------------------------------------------------------------------**
**              SI SPOSTA NELLA LOCAZIONE SPECIFICATA               **
**                ( x , y , velocita ; DirMarcia )                  **
**------------------------------------------------------------------*/
go_to(x,y,vel)
int x,y,vel;
{
  return( go_dir( DirMarcia=direzione(loc_x(),loc_y(),x,y) , vel ) );
}

/*------------------------------------------------------------------**
**     VERIFICO SE LA COORDINATA SPECIFICATA SI TROVA AI MARGINI    **
**     Se la coordinata e' -1,-1 allora uso la attuale coordinata   **
**              ( 0=falso, 1=su un lato, 2=in un angolo )           **
**------------------------------------------------------------------*/
testmarg(x,y)
int x,y;
{ 
  int ritorno, diffmuro;
  
  diffmuro=DIM_XY-MARGMURO; ritorno=0; 
  if (x==-1 && y==-1) { x=loc_x(); y=loc_y(); }

  if (x<MARGMURO)         ++ritorno;
  if (y<MARGMURO)         ++ritorno;
  if (x>diffmuro)         ++ritorno;
  if (y>diffmuro)         ++ritorno;

  return(ritorno);
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


/*********************************************************************
**                 I N I Z I O   P R O G R A M M A                  **
*********************************************************************/
main()
{
  inizializza();
  go_to(0,0,MAXVEL);
  while(1) loop();
}  

/*------------------------------------------------------------------**
**      LOOP, privilegiando il controllo dei bordi e solo in        **
**      seconda battuta le operazioni di sparo (se mi accorgo       **
**      che sono fermo od in un angolo, esco subito!)               **
**------------------------------------------------------------------*/
loop()
{
  if ( ver_tranq() )  spara(); else go_dir(DirMarcia,MAXVEL);
}

/*------------------------------------------------------------------**
**                        Routine di SPARO!!                        **
**       Anche qui' dentro esco alla svelta se sono nei guai!       **
**------------------------------------------------------------------*/
spara()
{
  int i,d;                                    /* i=loop, d=distanza */
  
  d=0;                          /* parto fiducioso... e' tutto Ok!? */
  while(Tranquillo)             /* tanto controllo piu' in la'...   */
    {                           /* d=0 --> non ho il bersaglio      */
     i=RIPSCAN+1; 
     while ( Tranquillo && (--i >= 0) )          /* verifica & LOOP */
       {
	AngScan=AngScan+INCRSCAN+180;    /* imposto il nuovo angolo */
	while ( ver_tranq() && (d=scan(AngScan,AMPSCAN)) ) 
	  {
	   int a1,a2;
	   if ( (d>MINTIRO) && (d<=MAXTIRO) ) cannon(AngScan,(d*8)/9);
	   a1=AngScan-INCRSCAN;
	   a2=AngScan+INCRSCAN;
	   if      (d=scan(a1,AMPSCAN)) AngScan=a1;
	   else if (d=scan(a2,AMPSCAN)) AngScan=a2;
	  }
       }
    }
}

/*------------------------------------------------------------------**
**          Posso stare tranquillo, oppure sto rischiando?          **
**     ----------------------------------------------------------   **
**     Se sono nei guai DISATTIVO l' autopilota e segnalo "guai",   **
**     cosi' come nel caso risulti non piu' necessario (in centro)  **
**     Altrimenti la posizione dell' autopilota rimane invariata    **
**     ----------------------------------------------------------   **
**          ( 0=falso (guai!), 1=vero (cioe' tranquillo) )          **
**------------------------------------------------------------------*/
ver_tranq()  
{ 
  int t;
  t=testmarg(-1,-1);
  if (speed()==0)           { Tranquillo=0; AutoPilota=0; return Tranquillo; }
  if (t==2)                 { Tranquillo=0; AutoPilota=0; return Tranquillo; }
  if (t==1 && AutoPilota==0){ Tranquillo=0;               return Tranquillo; }
  if (t==1 && AutoPilota==1){ Tranquillo=1;               return Tranquillo; }
  if (t==0)                 { Tranquillo=1; AutoPilota=0; return Tranquillo; }
  return(Tranquillo=1);                     
}

