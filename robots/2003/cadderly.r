/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2003)                                 */
/*                                                                          */
/*  CROBOT: Cadderly.r                                                      */
/*                                                                          */
/*  CATEGORIA: 1000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:
  
  La maggior differenza rispetto ai Big e la mancanza strategica del cambio 
  dell'angolo; cambiano anche il f2f e le procedure decisionali del passaggio
  tra le fasi. E' interessante notare che manca completamente una routine di
  conteggio degli avversari, ma il robot si accorge comunque della presenza di 
  un unico avversario!
  Inizialmente il robot calcola alcuni parametri e si reca velocemente nell'angolo 
  piu' vicino (FASE 0).
  
  Quindi esegue in sequenza 3 strategie di gioco distinte (se il combattimento e' 
  un f2f passa direttamente all'ultima fase di gioco).
  

FASE 1:  
  
  La FASE 1 di gioco prevede un comportamento estremamente cauto e difensivo. 
  
  Il movimento nell'angolo ricorda quello di Drizzt e si basa su oscillazioni 
  brevi verso i due angoli adiacenti rimanendo in prossimita' dei bordi 
  dell'arena. 
  Ci sono tuttavia notevoli differenze rispetto ai robottini dello scorso anno:
  
    1) Le oscillazioni non sono alternate verso i due angoli adiacenti, ma sono 
       determinate in ogni oscillazione da una scelta ben precisa: la direzione
       e' quella dell'avversario piu' distante. L'idea e' quella di far variare
       il piu' possibile l'angolo di scansione dell'avversario piu' vicino e di 
       allontanarsi risultando un bersaglio difficile da trovare.  
    2) Nell'avvicinamento verso l'avversario piu' distante il robot non si ferma
       sempre in prossimita' dell'angolo iniziale: se l'avversario piu' distante
       e' molto lontano il robot si avvicina fino a una "distanza di sicurezza"
       da cui decide se sparare contro l'altro robot che era piu' vicino e da cui 
       si e' allontanato oppure se creare un fuoco di sbarramento verso il robot
       verso cui si e' avvicinato nel caso in cui risulti l'avversario piu' vicino.    
    3) In questa fase non si perde piu' tempo a contare gli avversari, ma si
       utilizzano criteri differenti per decidere se passare alla fase successiva.
    
  Controlli per decidere se passare alla fase successiva:
  
    1) Dopo 240 oscillazioni si passa comunque alla fase 2;
    2) Se prima delle 00 oscillazioni subisce un certo danno (00%) allora cambia
       subito tattica, perche' probabilmente la difesa non paga;
    3) Da 50 oscillazioni in poi, se non vede avversari nell'angolo opposto allora
       passa alla seconda fase poiche' immagina che sicuramente c'e' un avversario
       in meno e almeno un secondo e' in difficolta';
    4) Se in uno degli angoli adiacenti non trova un avversario controlla nell'altro
       angolo adiacente e se non c'e' un avversario neanche li o se sono passate 200
       oscillazioni allora passa alla fase 2.
       
  La routine di fuoco utilizzata in questa fase di gioco non esegue correzioni sulla 
  distanza poiche' si adatta al movimento del robot che tende ad allontanarsi o a 
  mantenere una distanza di sicurezza dagli avversari. Le correzioni sull'angolo 
  sono determinate invece da scansioni con risoluzione limitata in quanto gli 
  avversari probabilmente sono ben distanti e quindi l'angolo non deve variare molto.
        
FASE 2:  
  
  La FASE 2 di gioco prevede un comportamento estremamente offensivo dall'angolo. 
  
  Il robot controlla i due angoli adiacenti: se trova un avversario lo attacca finche'
  non subisce danni quindi passa al successivo. Quando il robot non trova piu' avversari
  negli angoli adiacenti allora si ferma e quindi passa alla fase 3 (e' il trucchhetto 
  che mi ha fatto risparmiare un bel po' di codice: non serve una funzione radar).
  
  L'attacco dall'angolo e' effettuato tramite un triangolo (dopo i quadrati di Fizban e
  i rettangoli di Zorn non potevano mancare i triangoli) molto allungato in direzione
  dell'avversario e schiacciato lungo il bordo dell'arena. L'idea e' quella di
  allontanarsi eventualmente da un secondo avversario, provare ad avvicinarsi il piu'
  possibile verso il bersaglio, eludere le routine di fuoco cambiando una volta la
  direzione in avvicinamento e riallontanarsi a massima velocita'. 
  
  Durante l'attacco a triangolo il robot fissa la direzione di fuoco sull'avversario e
  la routine di fuoco non perde mai il bersaglio.
  
  La routine di attacco a triangolo si e' dimostrata molto efficace soprattutto con
  i robot piu' recenti, ma soffre i robot che attendono molto nell'angolo e che utilizzano
  le toxiche (spero che quest'anno siano veramente pochi!); in particolare volevo fare i 
  complimenti ad Andrea Creola che con il suo Pippo2a vera bestia nera nei test dello scorso
  anno insieme a Stanlio: senza questi due nei test Elminster ottiene il 76,5% e Druzil il
  79%! Di sicuro almeno pippo3 quest'anno sara' molto ostico per i miei robottini, quindi
  nonostante i report ottimi da 2k1 in avanti, di punti deboli ce ne sono e la competizione
  sara' durissima come sempre.
  

FASE 3:
  
  La routine offensiva della fase 3 e' molto semplice: esegue un quadrato ampio:
  l'oscillazione e' quindi decisamente lunga. 
     
  Soffre le toxiche ovviamente!

ROUTINE DI FUOCO:

  La routine di fuoco e' derivata da un mix di quelle dello scorso anno con quelle 
  di Zorn e Rudolf di Alessandro Carlin.
  
    1) La temporizzazione non è ottimale come lo scorso anno, ma in compenso la 
       precisione è migliorata grazie al puntamento primario delle routine di Ale
       che ho modificato lievemente per renderle piu' veloci nell'esecuzione e 
       piu' precise nella prima correzione dell'angolo (ho aumentato a 10 la 
       risoluzione del primo scan).
    2) Il puntamento secondario rimane ampio (10) anche nelle correzioni dell'angolo 
       seguendo in maniera efficiente anche i nemici vicini.
    3) Non viene mai perso il nemico puntato.

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

int deg,rng,odeg,xs,ys,timer,dam,xd,yd,tx,dd,dd2,zd,x1,x2,y1,y2;

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

  zd=(yd=90+180*ys)-45+90*(xs^ys);

  x1=330-120*xs; x2=30+120*xs;
  y1=120+120*ys; y2=60+240*ys;

  timer=10000*((Look(xd=180*xs))+(Look(yd))+(Look(zd))>1);
  
/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

  while (++timer<240)	{
    if (tx) {
     
      if (xs) {
        Run(180); while (loc_x()>950) LookXY(xd,yd); Stop(180);
        Run(0);   while (loc_x()<955) ; Stop(0);
      } else {
        Run(0);   while (loc_x()<50) LookXY(xd,yd); Stop(0);
        Run(180); while (loc_x()>45)  ; Stop(180);
      }
      
    } else {
      
      if (ys) {
        Run(270); while (loc_y()>950) LookXY(yd,xd); Stop(270);
        Run(90);  while (loc_y()<955) ; Stop(90);
      } else {
        Run(90);  while (loc_y()<50) LookXY(yd,xd); Stop(90);
        Run(270); while (loc_y()>45) ;  Stop(270);
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

 while(1) {
      while (loc_x()<700) Fire(0,100); 
      Fire(90,0);  
      while (loc_y()<700) Fire(90,100);
      Fire(180,0); 
      while (loc_x()>300) Fire(180,100);
      Fire(270,0);     
      while (loc_y()>300) Fire(270,100);
      Fire(0,0);  
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
    if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
  } else {
      deg+=315; 
      while (!(rng=scan(deg+=20,10))) ; 
      cannon(deg,rng); 
  }
}

/*********************************/
/* Routines utilizzate in FASE 2 */
/*********************************/

Triangle(d) 
{
    dam=damage();
    while (!Look(deg=d) && (damage()<=dam)) {
      dam=damage();
      if (d==xd) {
        if (ys) { Ymax(845,x1); Ymin(945,x2); } else { Ymin(155,x2); Ymax(55,x1); }
        if (xs) { 
          Xmin(900,0);
        } else {
          Xmax(100,180);
        }
      } else {   
        if (xs) { Xmax(845,y1); Xmin(945,y2); } else { Xmin(155,y2); Xmax(55,y1); } 
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
  if (timer>50) { if (Look(zd)) timer=10000; }  else if (damage()>50) timer=10000; 
  deg=p2;
  if (dd=scan(p1,10)) {
    if ((dd<(dd2=scan(p2,10))) || (!dd2)) { deg=p1; tx=!tx; }
  } else if (Look(p1)) if ((timer>200) || (Look(p2))) timer=10000;
}

Run(d)
{
  drive(d,100);
  while(speed()<70) ;	
}

Stop(d)
{
  if (d==deg) while (scan(d,10)>840) ;
  drive(d,0);

  if (rng=scan(deg,10)) { 
    deg+=2-4*(scan(deg+350,10)>0);
    
    cannon(deg-=1-2*(scan(deg+10,10)>0),rng); 
  }	
  while(speed()>59) ; 	
}