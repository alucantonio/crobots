/*                     Martina Hingis  [release 2]                   */	
/* Autore: Luca Leoncavallo*/

/* Hingis basa tutta la sua tattica sul grande dinamismo e su movimenti semplici che
   dovrebbero garantire una discreta efficienza ed impermeabilita` agli errori.
   La sua partita e` composta da due fasi: una piu` difensiva con la quale inizia il match
   ed una piu` offensiva con la quale cerca di chiudere in maniera vincente le partite (ossia
   cercando di pattare il minor numero di volte possibile).
   Nella prima fase la scelta e` quella di conquistarsi un lato (destro o sinistro) e percorrerlo
   su e giu` alla velocita` massima sparando verso il centro dell'arena. Questo dovrebbe
   consentire una buona copertura difensiva, perche` comunque si e` decentrati rispetto
   al centro dell'arena e la velocità è quella massima possibile, ma allo  stesso tempo una
   discreta propensione offensiva perche` ci si limita a scannare solo mezzo angolo giro.
   Per evitare inoltre sfortunati assembramenti proprio sullo stesso lato, Hingis si sposta
   sulla parte opposta se comincia ad essere colpito (controllo del "damage").
   Questa prima tattica non e` pero` efficiente contro tutti i tipi di avversari. Si potrebbe ad
   esempio correre il rischio di impattare contro robot "pigri" che rimangono dalla parte
   opposta dell'arena oppure c'è il rischio di soffrire particolarmente quei robot che prediligono
   angoli o lati (le posizioni piu` facili da conquistare!). Per questi motivi Hingis cambia strategia
   percorrendo una traiettoria piu` difficile da controllare, ma piuttosto interessante: un Rombo!
   I vertici del rombo dovrebbero essere i 4 punti a meta` dei lati dell'arena, ma ovviamente il
   controllo non puo` (e non vuole) essere cosi` preciso.
   Vantaggi? Io credo che sicuramente il fatto di essere piu` vicino al centro dell'arena dia
   ottime garanzie sul fronte offensivo: si possono centrare obbiettivi sia sul centro che sugli 
   angoli!  Inoltre cambiando tattica solo in un secondo tempo si presume che non ci siano piu`
   tutti e quattro i "gladiatori" per cui visto che ci si muove quasi sempre al massimo della velocita`
   potrebbe essere garantita anche una discreta difesa personale.
   
   IMPORTANTE: La routine di sparo e` leggermente adattata da quella di Goblin che mi ha molto
   impressionato. 
      
   N.B. E` la mia prima partecipazione per cui il mio unico termometro sulla qualita` del robot
   e` organizzare qualche "arena" e verificare sperimentalmente i risultati e questo cambio di
   tattica sembra pagare! :) */

int ang,oang,rng,orng;			/* Angolo di Scan e Range rilevato */
int danni;				/* Memorizza lo stato dei danni subiti dal robot */
int head;				/* Direzione che si sta percorrendo */

Shoot()
{
    if (orng=scan(ang,10))
    {
        if (!scan(ang-=5,5)) ang+=10;
        if (orng>700)
        {
            if (!scan(ang-=3,3)) ang+=6;
            cannon(ang,orng); ang+=40; return;
        }

        if(scan(ang-5,1)) ang-=5;
        if(scan(ang+5,1)) ang+=5;
        if(scan(ang-3,1)) ang-=3;
        if(scan(ang+3,1)) ang+=3;
        if(scan(ang-1,1)) ang-=1;
        if(scan(ang+1,1)) ang+=1;

        if (orng=scan(oang=ang,5))
        {
            if(scan(ang-5,1)) ang-=5;
            if(scan(ang+5,1)) ang+=5;
            if(scan(ang-3,1)) ang-=3;
            if(scan(ang+3,1)) ang+=3;
            if(scan(ang-1,1)) ang-=1;
            if(scan(ang+1,1)) ang+=1;

            if (rng=scan(ang,10))
            {
                cannon(ang+(ang-oang)*((1200+rng)>>9)-(sin(ang-head)>>14),
                       rng*160/(160+orng-rng-(cos(ang-head)>>12)));
            }
        }
     }
     else
     {
        if (scan(ang-=20,10)) return;
        if (scan(ang+=40,10)) return;
        ang+=40; return;
     }
}

main()
{
/* Sceglie fra i lati di destra e sinistra quello piu` vicino e ci si avvicina a velocita` massima e sparando.
   Quando e` sufficientemente vicino inizia la decelerazione, ma senza smettere di sparare*/
  if (loc_x()>500)
  {  
      drive(head=0,100);
      while (loc_x()<850) Shoot();
	  drive(0,0);
	  while (speed()>48) Shoot();
  }
  else
  {   drive(head=180,100);
      while (loc_x()>150) Shoot();
	  drive(180,0);
	  while (speed()>48) Shoot();
  }

/* Gioca la prima meta` della sua gara con una tattica intermedia fra difesa del proprio robot ed attacco
   agli altri robot. Ovviamente si tratta di una tattica semplice e basata sul dinamismo */    
  while(damage()<50)
  {
   danni=damage()+3;
   /* Fino a quando non viene colpito continua a muoversi su e giu` sul lato prescelto sparando come
      un pazzo a tutto quello che riesce ad individuare */
   while (damage()<danni)
     {
	 drive(head=270,100);
	 while (loc_y()>150) Shoot();
	 drive(270,0);
	 while (speed()>48) Shoot();
	 drive(head=90,100);
	 while (loc_y()<850) Shoot();
	 drive(90,0);
	 while (speed()>48) Shoot();
	 }
   /* Quando viene colpito decide di cambiare lato andando sul versante opposto. La transizione avviene
      sempre mediante il lato superiore dell'arena per questioni di praticita` */
   if (loc_x()>500)
     {
	  drive(head=180,100);
	  while (loc_x()>150) Shoot();
	  drive(180,0);
	  while (speed()>48) Shoot();
	 }
	else
     {
	  drive(head=0,100);
	  while (loc_x()<850) Shoot();
	  drive(0,0);
	  while (speed()>48) Shoot();
	 }
  }
/* Se la tattica precedente non sta sortendo buoni effetti (contro avversari intermedi puo` bastare quella)
   si tenta un altra tattica semplice ma che risulta essere piu` offensiva in quanto il Robot entra di piu`
   verso il centro dell'arena cercando di "accerchiare" gli avversari. Il movimento tentato e` un "Rombo
   perfetto" che pero` a volte si puo` schiacciare molto tendendo a diventare una diagonale. Ho rinunciato
   al controllo perfetto della traiettoria preferendo il dinamismo e la semplicita`/linearita` del codice */  
   
/* Per cominciare la diagonale si sposta nel lato di destra se non c'e` gia`. Ovviamente non cessa mai
   di sparare  */
if (loc_x()<500)
     {
	  drive(head=0,100);
	  while (loc_x()<850) Shoot();
	  drive(0,0);
	  while (speed()>48) Shoot();
	 }

/* Ricerca la posizione intermedia sul lato destro senza smettere di sparare */
if (loc_y()>500)
     {
	  drive(head=270,100);
	  while (loc_y()>575) Shoot();
	  drive(270,0);
	  while (speed()>48);
	 }
  else
     {
	  drive(head=90,100);
	  while (loc_y()<425) Shoot();
	  drive(90,0);
	  while (speed()>48);
	 }

/* Parte con la vera e propria diagonale in senso orario. Continua a sparare lungo le diagonali, ma
   ho preferito rinunciare durante le fasi di rallentamento per garantire un po` piu` di regolarita` nella
   traiettoria. Mi sembrava infatti che inserendo uno shoot() anche nel ciclo di decelerazione il Rombo
   si tramutasse troppo presto in una "schiacciata" in diagonale */
while(1)
  {
	 drive(head=225,100);
	 while (loc_y()>150) Shoot();
	 drive(225,0);
	 while (speed()>48);
	 drive(head=135,100);
	 while (loc_x()>150) Shoot();
	 drive(135,0);
	 while (speed()>48);
	 drive(head=45,100);
	 while (loc_y()<850) Shoot();
	 drive(45,0);
	 while (speed()>48);
	 drive(head=315,100);
	 while (loc_x()<850) Shoot();
	 drive(315,0);
	 while (speed()>48);
  }  
}