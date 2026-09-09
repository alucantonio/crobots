/*-------------------------------- PANIC -----------------------------
                                                di Luca e Marco Pranzo

-----------------------------------------------INTERVISTA CON IL ROBOT
Giornalista : Finalmente siamo riusciti ad avere un'intervista 
              esclusiva con Panic, l'ultimo C-Robot sfornato dai 
              Fratelli Pranzo! 
              Salve Panic.
Panic : Salve.
G. : Come si sente prima del Torneo? Emozionato?
P. : Si certo, emozionato come sempre, ma l'emozione sparirà appena 
     scenderò nell'arena e sicuramente farò del mio meglio!
G. : Sembra agguerrito, quale comportamento adotta in Arena?
P. : Aggurrito? Sempre nei limiti del lecito! Preferisco adottare una 
     strategia difensiva nell'angolo e colpire in contropiede con la 
     strategia finale appena mi capita l'occasione giusta.
G. : Quindi "Primo non prenderle".
P. : Certo, meglio pareggiare ed accontentarsi piuttosto che rischiare 
     in uno scontro impari due contro uno!
G. : Sa che molti non condividono questo atteggiamento?
P. : Certo, ma tutti sono liberi di agire come meglio credono.
G. : Dica qualcosa, per i nostri lettori, sulla sua vita.
P. : La mia nascita è stata molto travagliata, nei primi tempi non 
     riuscivo nemmeno a muovermi correttamente, inciampavo e sbattevo 
     al muro di frequente, altre volte mi bloccavo quasi senza motivo.
G. : Quindi una infanzia difficile.
P. : Si, ma poi le cose sono migliorate. Anche se ho un solo rammarico.
G. : Quale?
P. : Quello di non aver avuto molto tempo per allenarmi e raffinare il 
     mio comportamento. Ma farò del mio meglio.
G. : Purtroppo il tempo è tiranno, e gira voce che i suoi allenatori 
     non abbiano avuto di completarla.
P. : Si è vero. Mi avevano promesso altri comportamenti e altre 
     tattiche finali, ma si sono rimangiati le loro promesse. E non mi 
     hanno nemmeno allenato tanto! Mi chiedo come farò quando mi 
     troverò davanti dei robot "palestrati" da mesi!
G. : Ci vuole spiegare il significato del suo nome?
P. : I Fratelli mi hanno detto che è dovuto al fatto che appena si 
     avvicina un avversario comincio a tremare come una foglia. Ma io 
     non ci credo.
G. : Sa che hanno definito i suoi autori "geniali", lei cosa ne pensa?
P. : Secondo me rimangono due deficenti...
G. : Bene, con questo commento concludiamo l'intervista. Seguirà una 
     scheda tecnica del robot e il codice.
-------------------------------------------------------------STRATEGIA
Panic si posiziona nell'angolo più vicino, e vi rimane fermo a contare
 gli avversari. Quando un avversario entra a portata di sparo comincia 
    a pendolare (preferibilmente verso un angolo vuoto) per cercare di
           schivare i colpi. Quando l'avversario si allontana Panic si 
                                           riposiziona nel suo angolo.
 Se viene colpito e l'angolo nella direzione in cui si sta dirigendo è 
                                           vuoto allora cambia angolo.
  Appena si accorge di essere rimasto con un solo avversario parte per 
    la strategia finale attraversando orizzontalmente l'arena lungo la 
                                                              mediana.
---------------------------------------------------------------TATTICA
                    La routine di fuoco è praticamente quella  di Tox.
      Durante le frenate, per sfruttare al meglio i tempi morti, Panic
                                  esegue varie operazioni decisionali.
  Durante il pendolamento Panic calcola una correzione sulla direzione
   per accostarsi maggiormente alla parete in modo da diminuire la sua
                                      esposizione ai colpi dei nemici.
----------------------------------------------------------ARCHITETTURA
 L'architettura di Panic è estremamente lineare ed è riassumibile con:  
"Fino a che non sei arrivato a destinazione spara; quando sei arrivato  
                              decidi la nuova destinazione e riparti."
               Questa struttura permette la realizzazione di un codice 
      intrinsecamente senza procedure ed indipendente dalla posizione.

--------------------------------------------------------------------*/
int 
 menouno,meno150,meno800,inizio,angolo,centro,
 rng,orng,odeg,vel,panic,pos,d,
 omin,oqq,odir,overt,posiz,
 deg,dir,a,numero,b,vert,min,qq,sys_nen,sys_est,sys_nord,
 angolo_dir,danni,old_danni;


main() /*----------------------------------------------------------*/
{ 
  menouno-=(inizio=1);
  meno150-=150;
  if (sys_est=loc_x()>500) {qq=850; min=1;}
		      else {qq=meno150;  min=menouno; dir=180;}
  
/*----------------------------------------------- ciclo principale */
  while(1) 
  { 
/*------------------------------------- situazione pendolo (panic) */
    while(speed()>vel) ;
    drive(dir,100);
    if (vert) pos=loc_y();
	 else pos=loc_x();
    while ((min*pos)<qq)
    {
      /* spara */
	     if (orng=scan(deg,10))
	     {
		if (!scan(deg+=355,5)) deg+=10;
		if (orng>700) 
		{
		 cannon(deg,orng);
		 deg+=40;
		 panic-=1;  
		}
		else
		{
		  if(scan(deg+355,1)) deg+=355;
		  if(scan(deg+5,1))   deg+=5;
		  if(scan(deg+357,1)) deg+=357;
		  if(scan(deg+3,1))   deg+=3;
		  if(scan(deg+359,1)) deg+=359;
		  if(scan(deg+1,1))   deg+=1;       
		  
		  if (orng=scan(odeg=deg,5))
		  {
		      if(scan(deg+355,1)) deg+=355;
		      if(scan(deg+5,1))   deg+=5;
		      if(scan(deg+357,1)) deg+=357;
		      if(scan(deg+3,1))   deg+=3;
		      if(scan(deg+359,1)) deg+=359;
		      if(scan(deg+1,1))   deg+=1;       

		      if (rng=scan(deg,10))
		      {
			  cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
				 rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
			  panic=50; 
                      }
		  }
		}
	     }
	     else
	     {
		if (scan(deg+=339,10));
		else if (scan(deg+=42,10));
		else deg+=42;
		panic-=1;
	     }
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

	      if ( sys_nord ) { min=menouno; qq=-550; }
	      else { min=1; qq=450; }
	      panic=(dir=90+sys_nord*180);
	    }
	  }
	  else sys_nen=0;
	  
	  numero=0; b=9; a=angolo_dir-23;
	  while(b-=1)
	  {
	     if (rng=scan(a+=15,7))
	     {
		if (rng < 750) {deg=a; panic=30; b=1;}
		else numero+=1;
	     }
	  }
	} /*while panic<=0*/
      } /*if panic<=0*/
    }
/*--------------------------------------------------------- centro*/        
    else if (centro) 
    { 
       angolo=1;
       /* condizione di fuga */
       if ( ( (danni=damage()) >old_danni ) && (!scan(dir+10,10)) && (!scan(dir+350,10)))
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
       angolo=(centro=(vert=1));
       inizio=0;
       panic=10;
       meno800-=800;
    }
/*--------------------------------------------------------- finale */        
    else 
    {
       vert=0;
       if ( dir=180*(loc_x()>500) ) { min=menouno; qq=meno150; }
       else { min=1; qq=850; }    
    }
  } /*while(1)*/
} /*main*/

