/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2003)                                 */
/*                                                                          */
/*  CROBOT: Elminster.r                                                     */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:
  
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
  
    1) Dopo 220 oscillazioni si passa comunque alla fase 2;
    2) Se prima delle 140 oscillazioni subisce un certo danno (70%) allora cambia
       subito tattica, perche' probabilmente la difesa non paga;
    3) Da 140 oscillazioni in poi, se non vede avversari nell'angolo opposto allora
       passa alla seconda fase poiche' immagina che sicuramente c'e' un avversario
       in meno e almeno un secondo e' in difficolta';
    4) Se in uno degli angoli adiacenti non trova un avversario controlla nell'altro
       angolo adiacente e se non c'e' un avversario neanche li o se si e' allontanato
       dall'angolo per recarsi in quello opposto allora passa alla fase 2.
       
  La routine di fuoco utilizzata in questa fase di gioco non esegue correzioni sulla 
  distanza poiche' si adatta al movimento del robot che tende ad allontanarsi o a 
  mantenere una distanza di sicurezza dagli avversari. Le correzioni sull'angolo 
  sono determinate invece da scansioni con risoluzione limitata in quanto gli 
  avversari probabilmente sono ben distanti e quindi l'angolo non deve variare molto.
        
FASE 2:  
  
  La FASE 2 di gioco prevede un comportamento estremamente offensivo dall'angolo e 
  contemporaneamente dinamico in quanto prevede cambi di angolo. 
  
  Il robot controlla i due angoli adiacenti: se trova un avversario lo attacca finche'
  non subisce danni altrimenti prova a cambiare angolo.
  L'attacco dall'angolo e' effettuato tramite un triangolo (dopo i quadrati di Fizban e
  i rettangoli di Zorn non potevano mancare i triangoli) molto allungato in direzione
  dell'avversario e schiacciato lungo il bordo dell'arena. L'idea e' quella di
  allontanarsi eventualmente da un secondo avversario, provare ad avvicinarsi il piu'
  possibile verso il bersaglio, eludere le routine di fuoco cambiando una volta la
  direzione in avvicinamento e riallontanarsi a massima velocita'. Vengono registrati
  inoltre i danni subiti durante l'attacco preferendo la direzione in cui si subiscono
  meno danni. 
  Il cambio di angolo viene effettuato solo dopo alcuni controlli ridondanti e piu'
  accurati verso il quadrante di destinazione.
  Dopo il cambio dell'angolo il robot aspetta un certo numero di iterazioni (che variano
  in base al tempo gia' trascorso e ai danni subiti) prima di riproporre l'attacco a 
  triangolo. Durante i cambi di angolo si controlla anche che non sia rimasto un unico 
  avversario; in tal caso, a meno di non aver subito danni notevoli (90%), si passa alla
  fase 3.    
  
  Durante l'attacco a triangolo il robot fissa la direzione di fuoco sull'avversario e
  la routine di fuoco non perde mai il bersaglio, invece durante i cambi d'angolo la
  routine di fuoco cambia bersaglio quando quello puntato diventa troppo distante.
  
  La routine di attacco a triangolo si e' dimostrata molto efficace soprattutto con
  i robot piu' recenti, ma soffre i robot che attendono molto nell'angolo e che utilizzano
  le toxiche (spero che quest'anno siano veramente pochi!); in particolare volevo fare i 
  complimenti ad Andrea Creola che con il suo Pippo2a vera bestia nera nei test dello scorso
  anno insieme a Stanlio: senza questi due nei test Elminster ottiene il 76,5% e Druzil il
  79%! Di sicuro almeno pippo3 quest'anno sara' molto ostico per i miei robottini, quindi
  nonostante i report ottimi da 2k1 in avanti, di punti deboli ce ne sono e la competizione
  sara' durissima come sempre.
  

FASE 3:
  
  La routine offensiva della fase 3 e' praticamente identica al f2f di Wulfgar; cambia
  principalmente la routine di fuoco e le oscillazioni lunghe sono un po' piu'
  lunghe:
    
    1) Il robot si porta al centro dell'arena;
    2) Finche non subisce un danno maggiore del 10% esegue un'oscillazione
       media in direzione del nemico puntato dalla routine di fuoco prima con uno
       sfasamento di +45 gradi e poi di -45 gradi;
    3) Fino alla fine del match viene descritto un quadrato al centro dell'arena:
       il quadrato e' minimo se il robot avversario si trova a una distanza 
       maggiore di 390, altrimenti si allarga di circa 300 unità. Questa scelta
       serve a rendere difficile il puntamento ai robot vicini.


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
    3) In un'unica chiamata (Fire) vengono scansionati 160 gradi e non piu' 180, per creare
       una piccola intersezione dell'area di scansione tra 2 chiamate successive.
    4) Nel f2f non viene mai perso il nemico puntato, nel 4vs4 invece la scelta del cambio
       del bersaglio in caso di distanza eccessiva e' determinata dalla variabile chdeg.


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

int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd,zd,xmd,ymd,ez;
int timer,dmin,dmax,xdam,ydam,xyl,xyh,xyel,xyeh,chdeg,dd,dd2,tx;

/****************************************/
/* Routines di movimento e di scansione */
/****************************************/

Up(d) { while(loc_y()<d) Fire(drive(90,100));  drive(90,0);  }
Dw(d) { while(loc_y()>d) Fire(drive(270,100)); drive(270,0); }
Dx(d) { while(loc_x()<d) Fire(drive(0,100));   drive(0,0);   }
Sx(d) { while(loc_x()>d) Fire(drive(180,100)); drive(180,0); }

Ymin(d1,d2) {while(loc_y()<d1) Fire(drive(d2,100)); drive(d2,0); }
Ymax(d1,d2) {while(loc_y()>d1) Fire(drive(d2,100)); drive(d2,0); }
Xmin(d1,d2) {while(loc_x()<d1) Fire(drive(d2,100)); drive(d2,0); }
Xmax(d1,d2) {while(loc_x()>d1) Fire(drive(d2,100)); drive(d2,0); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/****************************************************/
/* FASE 0: Calcolo parametri e ritirata nell'angolo */
/****************************************************/

  chdeg=1;	

  if (xs=loc_x()>499) Dx(900); else Sx(100); 
  if (ys=loc_y()>499) Up(880); else Dw(120);
  
  Params();
  
  xyl=95; xyh=905; xyel=55; xyeh=945; chdeg=0; t=40;
  Radar();
  
/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

  if (en>1) { 
    while (++timer<220)	{
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
    if (damage()<40) t=25; 
    if (timer<300) t-=20;
  }
    
  if (en>1) Radar();
    
/***********************************************/
/* FASE 2: Attacco dall'angolo e cambio angolo */
/***********************************************/

  while(en>1) {
    while (scan(xd,10) && (xdam<3)) {
      deg=xd;
      dam=damage();
      if (xs) { 
        if (ys) { Ymax(845,210); Ymin(945,150); } else { Ymin(155,150); Ymax(55,210); } 
        Dx(900);
      } else {
        if (ys) { Ymax(845,330); Ymin(945,30); } else { Ymin(155,30); Ymax(55,330); } 
        Sx(100);
      } 
      xdam=damage()-dam;
    } 
    if ((ydam-=3)<0) ydam=0;
    if (!Look(xd)) {
      chdeg=1;	
      if (xs=!xs) { Dx(300); if (!Look(xmd)) Dx(900); else { deg=xmd; Sx(100); xs=!xs; chdeg=0; } } else { Sx(700); if (!Look(xmd)) Sx(100);  else { deg=xmd; Dx(900); xs=!xs;  chdeg=0; } } 
      --t;
      if (chdeg) {
        Params();
        if (!Look(yd)) Radar();
        chdeg=0; 
        if ((t>1)) ydam=5;
      }	
      xdam=0; 
    }

   
    while (scan(yd,10) && (ydam<3)) {
      deg=yd;
      dam=damage();
      if (ys) { 
        if (xs) { Xmax(845,240); Xmin(945,300); } else { Xmin(155,300); Xmax(55,240); }
        Up(900); 
      } else {
        if (xs) { Xmax(845,120); Xmin(945,60); } else { Xmin(155,60); Xmax(55,120); }
        Dw(100);  
      } 
      ydam=damage()-dam;
    } 
    if ((xdam-=3)<0) xdam=0;
    if (!Look(yd)) {
      chdeg=1;	
      if (ys=!ys) { Up(300); if (!Look(ymd)) Up(900);  else { deg=ymd; Dw(100); ys=!ys; chdeg=0; } } else { Dw(700); if (!Look(ymd)) Dw(100);  else { deg=ymd; Up(900); ys=!ys; chdeg=0; } }
      --t;
      if (chdeg) {
        Params(); 
        if (!Look(xd)) Radar();
        chdeg=0;	
        if ((t>1)) xdam=5; 
      }
      ydam=0; 
    }
     
  }
  

/****************************************/
/* FASE 3: Attacco al centro dell'arena */
/****************************************/

  chdeg=0;	
  if (Look(xd)) if (ys) Dw(100); else Up(900);
  
  Up(509);  Sx(509); Dw(492); Dx(492); 
 
 if ((dam=damage())<10) {  
  
  while(damage()<dam+10) {
    dir=deg+45; t=14;
    dam=damage(); 
    while (--t) Fire(drive(dir,100));
    dir+=180;	t=14;    
    while (--t) Fire(drive(dir,100));
    dir=deg+315; t=14;
    while (--t) Fire(drive(dir,100));
    dir+=180;	t=14;
    while (--t) Fire(drive(dir,100));
  }  
  }

   while(1) {
    if (rng>390) { 
      Dx(500); Up(500); Sx(499); Dw(499); 
    } else {	
      Dx(650); Up(650); Sx(350); Dw(350); 
    }
  } 

}

/*******************************/
/* Routine di fuoco principale */
/*******************************/

Fire()
{
  if (chdeg) if (rng>880) { rng=700; return deg+=120; } 
  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    
  } else {
    
    if (rng=scan(deg+=340,10)) return cannon(deg,rng);
    if (rng=scan(deg+=40,10))  return cannon(deg,rng);
    if (rng=scan(deg+=300,10)) return cannon(deg,rng);
    if (rng=scan(deg+=80,10))  return cannon(deg,rng);
    if (rng=scan(deg+=260,10)) return cannon(deg,rng);
    if (rng=scan(deg+=120,10)) return cannon(deg,rng);
    if (rng=scan(deg+=220,10)) return cannon(deg,rng);
    
    deg+=230; 
    
  }
}

/**********************************/
/* Routine di conteggio avversari */
/**********************************/

Radar()
{
  if (damage()>90) return (en=3); 
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
    if (ys) { xmd=210; ymd=240; } else { xmd=150; ymd=120; }
  } else {
    if (ys) { xmd=330; ymd=300; } else { xmd=30; ymd=60; }
  }
}

/*********************************/
/* Routines utilizzate in FASE 1 */
/*********************************/

LookX()
{
  LookZ(deg=yd);
  if (dd=scan(xd,10)) {
    if ((dd<(dd2=scan(yd,10))) || (!dd2)) { deg=xd; tx=!tx; }
  } else LookAgain(xd,xmd);
}

LookY()
{
  LookZ(deg=xd);
  if (dd=scan(yd,10)) {
    if ((dd<(dd2=scan(xd,10))) || (!dd2)) { deg=yd; tx=!tx; }  
  } else LookAgain(yd,ymd);
}

LookZ()
{ 
  if (timer>140) { if (!Look(zd)) timer=10000; } else if (damage()>70) timer=10000;   
}

LookAgain(d1,d2) { if (!Look(d1) && !scan(d2,10)) timer=10000; }

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
    if (!(rng=scan(deg+=340,10))) 
      if (!(rng=scan(deg+=40,10))) { while(speed()>59) drive(d,0); return; }
    
  if (scan(deg+10,10)) deg+=3; else deg+=357; 
  if (scan(deg+350,10)) deg+=358; else deg+=2; 
  if (scan(deg+10,10)) deg+=1; else deg+=359; 
    
  cannon(deg,rng); 
  	
  while(speed()>59) drive(d,0); 	
}

