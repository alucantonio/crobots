/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2003)                                 */
/*                                                                          */
/*  CROBOT: Danica.r                                                        */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:
  
  A differenza di Big e midi Danica non ha una fase intermedia, inoltre ha una 
  caratteristica nella fase 1 che non e' presente nei fratelli maggiori e che 
  e' molto interessante: purtroppo non ho fatto in tempo a innestarla sugli altri 
  robot! Avevo fatto un tentativo sul midi che arrivava in questo modo al 70%
  in 2k2, ma non ho mandato quella versione perche' perdeva molto negli altri 
  tornei (era da riparametrizzare e aggiustare un po'); magari per l'anno prossimo.
   
  Sia il f2f e che le procedure decisionali del passaggio tra le fasi sono semplificate
  e la routine di fuoco principale deriva da quella di Regis.
  
  Inizialmente il robot calcola alcuni parametri e si reca velocemente nell'angolo 
  piu' vicino (FASE 0).
  
  Quindi esegue in sequenza 3 strategie di gioco distinte (se il combattimento e' 
  un f2f passa direttamente all'ultima fase di gioco).
  

FASE 1:  
  
  La FASE 1 di gioco prevede un comportamento estremamente cauto e difensivo. 
  
  Il movimento nell'angolo ricorda quello di Drizzt e si basa su oscillazioni 
  brevi verso i due angoli adiacenti rimanendo in prossimita' dei bordi 
  dell'arena. 
  Differenze e caratteristiche:
  
    1) Le oscillazioni sono alternate verso i due angoli adiacenti;
    2) Nell'avvicinamento verso l'avversario piu' distante il robot non si ferma
       sempre in prossimita' dell'angolo iniziale: se l'avversario piu' distante
       e' molto lontano il robot si avvicina fino a una "distanza di sicurezza"
       da cui decide se sparare contro l'altro robot che era piu' vicino e da cui 
       si e' allontanato oppure se creare un fuoco di sbarramento verso il robot
       verso cui si e' avvicinato nel caso in cui risulti l'avversario piu' vicino.    
    3) In questa fase si contano gli avversari con una funzione piu' precisa rispetto 
       a quella di Regis.
    4) Il robot torna immediatamente verso l'angolo senza neanche raggiungere la 
       coordinata prefissata minima e senza avere il tempo di ricaricare 
       il cannone se l'avversario e' a una distanza inferiore a quella prefissata
       di sicurezza. Questa modifica rende il robot particolarmente difensivo in 
       questa fase.
    
  Controlli per decidere se passare alla fase successiva:
  
    1) Dopo (440 oscillazioni + danno subito) si passa comunque alla fase 2;
    2) Se rimane un solo avversario si passa alla fase 2;
       
  La routine di fuoco utilizzata in questa fase di gioco esegue correzioni sulla 
  distanza. Le correzioni sull'angolo sono determinate invece da scansioni con risoluzione
  limitata in quanto gli avversari probabilmente sono ben distanti e quindi l'angolo non 
  deve variare molto.
         

FASE 2:
  
  La routine offensiva della fase 2 e' la stessa di Regis con una piccola aggiunta: 
  esegue un quadrato minimo al centro dell'arena e se l'avversario si avvicina molto il 
  quadrato si allarga.
  
  Questa routine al contrario di quelle dei fratelli maggiori non soffre le toxiche! 
     

ROUTINE DI FUOCO:

  La routine di fuoco e' derivata da quella di Regis. 

RINGRAZIAMENTI:

Un ringraziamento a tutti i "veterani" che continuano ad alimentare con i loro
robot, le loro utilities e soprattutto con la loro passione questo gioco meraviglioso: 
in particolare a Simone Ascheri, Michelangelo Messina, Alessandro Carlin, Maurizio 
Camangi e Andrea Creola che sono anche sempre presenti nella ML e che costituiscono di 
fatto lo "sponsor umano" di Crobots.
Un grazie anche alle nuove "matricole", che quest'anno hanno contribuito a stabilire un 
nuovo record di affluenza al torneo, e che spero continuino a partecipare ai prossimi
tornei e soprattutto si divertano.

In bocca al lupo a tutti e buon torneo 2k3!

*/

/*********************/
/* Variabili globali */
/*********************/

int deg,rng,odeg,xs,ys,en,rd,ren,timer,sc1,sc2,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd;

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
  sc1=sc2=1;  

  dmax=(dmin=(zd=(yd=90+180*ys)-45+90*(xs^ys))-60)+100;

/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

  while(en>1) {
    Run(xd,xp,2-xs);	
    Run(yd,yp,6-ys);	
  }

/****************************************/
/* FASE 2: Attacco al centro dell'arena */
/****************************************/

  sc1=5; sc2=3;  ++ff;  
 
  while(1) {
      while (loc_x()<500+xmax) Fire(0,100);
      Fire(90,0);  
      while (loc_y()<500) Fire(90,100);
      Fire(180,0); 
      while (loc_x()>499) Fire(180,100);
      Fire(270,0);     
      while (loc_y()>499) Fire(270,100);
      Fire(0,0*(xmax=350*(rng<250))); 
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
    if (scan(deg+350,10)) deg-=sc1; else deg+=sc1;
    if (scan(deg+10,10)) deg+=sc2; else deg-=sc2; 
    cannon(deg+(deg-odeg)*ff,(scan(deg,10)<<1)-rng);
  } else {
      if (rng=scan(deg+=340,10)) return cannon(deg,rng); 
      if (rng=scan(deg+=40,10))  return cannon(deg,rng);  
      while (!(rng=scan(deg+=20,10))) ; 
      cannon(deg,rng);
  }
}

/*********************************/
/* Routines utilizzate in FASE 1 */
/*********************************/

Run(d,l,m) { 
  int r;
  if (timer%12==2) {
    en=0;
    while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    dmin=zd-60; 
  }
  
  while(r<2) {
  drive(d,100);
  
  ++r;
  if (++timer>440+damage()) en=1; 
  
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
