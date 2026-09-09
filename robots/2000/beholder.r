/*------------------------------- BEHOLDER ---------------------------
                                                di Marco e Luca Pranzo

------------------------------------------------------STORIA DEL ROBOT

*frush*
Marco: Ehm, c'è nessuno?
Luca : Ma dove mi hai portato?
M: Nella tenda di Alkazoor l'evocatore, lo sai che dobbiamo fare il 
   robot anche quest'anno.
L: Si, ma cosa c'entra un mago con i crobots?
M: Primo non è un mago qualsiasi ma un famoso evocatore, secondo 
   vedrai che idea ho in mente.
L: Ancora non capisco.
M: Lo so che non capisci...
*spostando un pesante tendaggio*
M: Ehm c'è qualcuno nella tenda?
L: Ma qui dentro è buio.
Alkazoor: Chi disturba il mio sacro riposo?
L: *sussurro* Ma quale riposo, questo stava facendo una pennichella!
M: Siamo due comuni mortali che hanno sentito della tua fama, oh 
   onnipotente Alkazoor!
A: Ah! Capisco, e di quali servigi avete bisogno?
M: Vorremmo evocare un potente mostro che possa combattere nell'Arena 
   per noi!
A: Avete qualche idea, sul mostro che volete evocare?
L: Certo! Voglio un DRAGO!!
A: Bene, ottima scelta, il Drago è il mostro più potente! Vi costerà 
   50000 Monete d'oro.
L: Gasp!
M: Emm, potente Alkazoor, non disponiamo di tale cifra...
A: Quanto siete disposti a spendere?
M: Io ho 450 Monete d'oro.
L: Io... mmmh dove le avevo messe... ah eccole! 50 monete d'oro.
A: Per questa cifra vi posso offrire Tuorok il Campione dei Goblin!
M: Goblin? Mmm ottimo combattente, ma un po' datato!
A: Oppure vi posso evocare Zsa'tum l'elementale dell'aria.
L: Aria, qualcosa di più concreto?
A: Basta! Che ne dite di un Beholder?
L: Un Bechè?
M: Un Beholder, il potente mostro fluttuante con un grande occhio 
   centrale con tanti occhietti sopra.
L: Ahhh! Ricordo! Figus, ma perchè non ha un nome?
A: Non è proprio un beholder di prima categoria ma è pur sempre un 
   beholder!
M: OK! Ci hai convinti!
L: *sussurrando* Questo affare non mi convince...
M: Ecco le 500 monete d'oro.
A: Perfetto! Lo evocherò immediatamente...

.................ATTENSAO' BIOLDERIUS METE KLAMA!.....................
.............VEGNI KWI AFFAFFESSI STI'DU POLLLLIIII'!!!!!.............

*pufff*

A: Arrivederci ragazzi, e buona fortuna, ho altri clienti nel retro!
Beholder: Eccheme qui! Chi me vole?
M: Ahhh! Che bello un beholder tutto nostro!
L: Ma un beholder non era più grosso? Non ti sembra gracilino? 
M: Ma no, Luca tranquillo è tutto normale!
L: Normale? E cosa sono quegli occhiali!!!
M: Mmmh, hai ragione, ecco perchè costava così poco!
L: Costava poco, quello c'ha fregati! L'avevo detto io!
B: Mbeh! Mo che è sta storia, i miei padroni me sfottono pure loro!
M: Oramai è tardi, è già scappato via, accontentiamoci. Chissa se non 
   riusciamo ad ottenere qualcosa di buono da questo beholder. 
   Mmmmh un paio di scatole di lenti a contatto, un mese di body 
   building, un corso full-immersion di karatè...
L: Ma se non ha le braccia e le gambe!
M: Ah, è vero! Niente karate.
B: Mo questi che se sò messi in testa? Me vojono fà sudà! A'nfamoni!
L: Vabbè hai ragione, mettiamoci a lavorare.

--------------------------------------------------------SCHEDA TECNICA

Beholder è una lieve evoluzione di Panic (Torneo1999). La strategia 
del robot è la seguente:
# All'inizio del match esegue un conta dei nemici per stabilire se 
  entrare in modalita face2face o scontro a quattro. 
# Si reca in un angolo comportandosi come Panic e li vi riamne fino a
  che il conta non restituisce un solo avversario.
# A differenza di Panic cambia angolo solamente se il numero dei 
  nemici è inferiore a tre, la struttura dello sparo è leggermente 
  modificata rispetto alla toxica standard e spara anche in frenata.
# Nella strategia finale il robot esegue dei giri molto stretti al 
  centro dello schermo.

Tuttosommato Beholder non presenta nessuna grande innovazione ma è 
stato programmato solamente in un paio di giorni. =)

--------------------------------------------------------------------*/
int 
 menouno,meno150,meno800,inizio,angolo,centro,
 rng,orng,odeg,vel,panic,pos,d,
 omin,oqq,odir,overt,posiz,
 deg,dir,a,numero,b,vert,min,qq,sys_nen,sys_est,sys_nord,
 angolo_dir,danni,old_danni,finale,apos,aneg,maxscan;


main() /*----------------------------------------------------------*/
{ 

/*------------------------------------------------- conta iniziale */
  while ( (numero<=1)&&(b<=18) )
  {
    b+=1;
    if (scan(a+=21,10)) numero+=1;
  }
  if (numero<=1) {finale=1;maxscan=5000;}
  else {numero=3;maxscan=700;}

  menouno-=(inizio=1);
  meno150-=150;

  if (sys_est=loc_x()>500) {qq=850; min=1;}
		      else {qq=meno150;  min=menouno; dir=180;}
  
/*----------------------------------------------- ciclo principale */
  while(1) 
  { 
/*------------------------------------- situazione pendolo (panic) */
    /* spara in frenata */
    while (speed()>vel) 
    {
      if (orng=scan(deg,10)) 
      {
        if (rng=scan((deg=(6*(scan((deg+=(10*(scan((odeg=deg)+10,10)>0)-5))+10,10)>0)-3)+deg),10))
          cannon(deg+(deg-odeg),rng+(rng-orng)*2);
      }
    }

    drive(dir,100);
    if (vert) pos=loc_y();
	 else pos=loc_x();
    while ((min*pos)<qq)
    {
      /* spara */
      if ( (rng=scan(deg,10)) && (rng<maxscan) )
      {
	if (!scan(deg-=5,5)) deg+=10;

      if(scan(deg-6,1)) deg-=6;
      if(scan(deg+6,1)) deg+=6;
	if(scan(deg-4,1)) deg-=4;
	if(scan(deg+4,1)) deg+=4;
	if(scan(deg-2,1)) deg-=2;
	if(scan(deg+2,1)) deg+=2;		  			            
	
	if (orng=scan(odeg=deg,5))
	{
         if(scan(deg-6,1)) deg-=6;
         if(scan(deg+6,1)) deg+=6;
	   if(scan(deg-4,1)) deg-=4;
	   if(scan(deg+4,1)) deg+=4;
	   if(scan(deg-2,1)) deg-=2;
	   if(scan(deg+2,1)) deg+=2;		  			            

         if (rng=scan(deg,10)) 
	   {
             cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*190/(190+orng-rng-(cos(deg-dir)>>12)));
             panic=50; 
           }
        }  			 
      }
      else if ( (rng=scan(deg-=21,10)) && (rng<maxscan) ) ; 
      else if ( (rng=scan(deg+=42,10)) && (rng<maxscan) ) ;
      else if ( (rng=scan(deg+=21,10)) && (rng<maxscan) ) ;
      else if ( (rng=scan(deg+=21,10)) && (rng<maxscan) ) ;
      else if ( (rng=scan(deg+=21,10)) && (rng<maxscan) ) ;
      else panic -=1;

      /* condizione di uscita */
      if (vert) pos=loc_y();
	   else pos=loc_x();
    }
    drive(dir+180,0); 
    vel=49;
/*------------------------------------- situazione angolo (panic) */            
    if (angolo)
    {
      if (panic<=0) { omin=min; oqq=qq+140; odir=dir; overt=vert; }
      
      if (scan(dir=angolo_dir,10)) dir+=90;
      vert=((dir%180)>(angolo=0));
      if (vert*sys_nord+(!vert)*sys_est) {qq=meno800; min=menouno;}
				    else {qq=200; min=1;}
/*--------------------------------------- situazione fermo (no-panic) */        
      if (panic<=0)
      {             
	drive(odir,45); 
	if (overt) while(omin*loc_y()<oqq);
	     else while(omin*loc_x()<oqq);    
	drive(odir+180,(numero=0));  

	while (panic<=0)
	{
	  if (numero==1) 
	  {
	    if((sys_nen += 1)==5)  
	    {
	      centro=0; 
	      vert=1;
              maxscan=5000;

	      if ( sys_nord ) { min=menouno; qq=-550; }
	      else { min=1; qq=450; }
	      panic=(dir=90+sys_nord*180);
	    }
	  }
	  else sys_nen=0;

        numero=0;	  
        if (rng=scan(a=angolo_dir,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}
        if (rng=scan(a+=15,7)) {numero+=1;if (rng < 750) {deg=a; panic=30;}}

	} /*while panic<=0*/
      } /*if panic<=0*/
    }
/*--------------------------------------------------------- centro*/        
    else if (centro) 
    { 
       angolo=1;
       /* condizione di fuga */
       if ( ( (danni=damage()) > old_danni ) && (!scan(dir,10)) && (numero<=3) )
       { 
	  drive(dir,vel=100); 
	  qq+=650;
	  angolo_dir+=180*(dir==angolo_dir)-90;
	  if (vert) sys_nord^=1; 
	       else sys_est^=1;
       }
       else
       { 
	  posiz=vert*loc_x()+(!vert)*loc_y();
	  if ( (posiz>20) && (posiz<980) ) dir+=10*(angolo_dir==dir)-5;

	  dir+=180; 
	  qq=50-qq;
	  min*=menouno;
       } 
       old_danni=danni;       
    } 
/*--------------------------------------------------------- inizio */        
    else if (inizio) 
    {

       if (sys_nord=loc_y()>500) { dir=90;  qq=850; min=1;  }
			    else { dir=270; qq=meno150; min=menouno; }
       if (sys_est) if (sys_nord) angolo_dir=540;
		    else angolo_dir=450;
       else if (sys_nord) angolo_dir=630;
	    else angolo_dir=720;

       inizio=0;
       panic=10;
       meno800-=800;
       vert=1;
       centro=angolo=(!finale);
       aneg=-450;
       apos=550; 
    }
/*--------------------------------------------------------- finale */ 
    else 
    {
      sys_nord=(loc_x()>500);
      sys_est=(loc_y()>500);

      if ( sys_nord && sys_est ) {dir=180;vert=0;qq=aneg;min=menouno;}
      else if ( sys_nord ) {dir=90;vert=1;qq=apos;min=1;}
      else if ( sys_est ) {dir=270;vert=1;qq=aneg;min=menouno;}
      else {dir=0;vert=0;qq=apos;min=1;}
    }
  } /*while(1)*/
} /*main*/

/*-------------------------------------------------------------*/
/* Beholder, di Marco e Luca Pranzo, CRobot per il Torneo2000. */
/*-------------------------------------------------------------*/