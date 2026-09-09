/* nome del Crobot:                  NL                                      */
/* versione:                        3.00  B                                  */
/* data finale di realizzazione:    26/11/99                                 */
/*                                                                           */
/* dati dell'autore:                                                         */
/*               Tognon Stefano                                              */
/*                                                                           */
/* strategia:                                                                */
/* Questo crobots si basa in gran parte su goblin.r e sottolin.r per cercare */
/* di trarne gli aspetti positivi di entrambi.                               */
/* La parte di combattimento a più nemici è la stessa di goblin (scappa al   */
/* sicuro e spara). La differenza rispetto a goblin è nello sparo in fase di */
/* rallentamento: ovvero si spara con una routine meno precisa ma più veloce */
/* in modo di cercare di colpire anche in questa fase, prima di decidere la  */
/* nuova strategia.                                                          */
/* Quando rimane un solo avvarsario si utilizza la tattica di sottolin, ma   */
/* con un movimento a L (rovesciata), in modo da coprire gran parte dell'    */
/* arena. Questo movimento semplice si basa sulla considerazione che credo   */
/* che la maggioranza dei crobots che parteciperanno al torneo utilizzeranno */
/* una tattica finale che preveda di cacciare l'ultimo rimasto, pertanto     */
/* verrà a tiro da solo.                                                     */
/* Pertanto viene utilizzata anche in questa fase lo sparo di goblin in modo */
/* da colpire con molta precisione, mentre per la fase di rallentamento si   */
/* spara con la routine veloce di sottolin.                                  */
/*                                                                           */
/* nota personale:                                                           */
/* Spero che per il torneo del nuovo millennio ci siano novita per crobots:  */
/* sparizione del codice limitato a 1000 e magari esecuzione in codice non   */
/* interpretato.                                                             */
/* Devo dire che la mia ultima apparizione nel 93 era dettata proprio dalla  */
/* velocità di esecuzione: col 286 bisognava aspettare mezza giornata per    */
/* avere dei risultati quasi significativi per valutare l'efficienza del     */
/* proprio crobot per poterlo migliorare. Col computer attuale in un ora si  */
/* hanno delle indicazioni definitive. Rimane però il vincolo dei 1000 sul   */
/* byte code...                                                              */
/* Un ultimo appunto: i crobots che presento non sonno il massimo in quanto  */
/* ad originalità, ma vi assicuro che neanche per efficienza; sono però il   */
/* massimo che ho potuto creare in una settimana di lavoro.                  */

int rng,orng,deg,odeg,dir,t,q,dam,x,y,flag,r;

int pp,d,ang;

main() {
  ang=0;

  /* Vai nell'angolo più vicino: */
  if (loc_x()<500) sx(); else dx();
  if (loc_y()<500) dw(); else up();

  while(1) {
    if (UpDown()) {
      Angle();
      if (UpDown()) Move();
    }
 }
}

up() { dir=90;  while(loc_y()<900) { drive(90,100);  Fire(); } drive(270,0); shot(); }
dw() { dir=270; while(loc_y()>100) { drive(270,100); Fire(); } drive(90,0);  shot(); }
dx() { dir=0;   while(loc_x()<900) { drive(0,100);   Fire(); } drive(180,0); shot(); }
sx() { dir=180; while(loc_x()>100) { drive(180,100); Fire(); } drive(0,0);   shot(); }

Angle() {
  dam=damage();
  while ((!orng || orng>450) && (damage()<dam+4)) {
    if (t>15)
      if (Radar()) {
        ang=0;
        attack();
      }
    dam=damage();
    Fire(1);
  }
}

Move() {
  if (loc_x()<500) dx(); else sx();
}

UpDown() {
  if (t>15) return 1;
  if (loc_y()<500) {
    if (!scan(80,10) && !scan(100,10)) { up(); return 0; }
  } else {
      if (!scan(260,10) && !scan(280,10)) { dw(); return 0; } 
    }
  return 1;
}

Radar() {
  deg=-10; t=0;
  while((deg+=20)!=710) if (scan(deg,10)) ++t;
  if (t<3) return 1;
  t=0;
  return 0;
}

Fire(flag) {
  if (orng=scan(deg,10)) {
    if (!scan(deg-=5,5)) deg+=10;
    if (orng>700) {
      if (!scan(deg-=3,3)) deg+=6;
      cannon(deg,orng); ++t; deg+=40; return;
    }
  
    if(scan(deg-5,1)) deg-=5;
    if(scan(deg+5,1)) deg+=5;
    if(scan(deg-3,1)) deg-=3;
    if(scan(deg+3,1)) deg+=3;
    if(scan(deg-1,1)) deg-=1;
    if(scan(deg+1,1)) deg+=1;

    if (orng=scan(odeg=deg,5)) {
      if(scan(deg-5,1)) deg-=5;
      if(scan(deg+5,1)) deg+=5;
      if(scan(deg-3,1)) deg-=3;
      if(scan(deg+3,1)) deg+=3;
      if(scan(deg-1,1)) deg-=1;
      if(scan(deg+1,1)) deg+=1;

      if (rng=scan(deg,10)) {
        if (flag) {
          cannon(deg+(deg-odeg)*((1200+rng)>>9), rng*160/(160+orng-rng));
        } else {
            cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
          }
        t=0;
      }
    }
  } else {
      if (scan(deg-=20,10)) return;
      if (scan(deg+=40,10)) return;
        deg+=40; return;
    }
}

attack() {
  while(loc_y()<850) {
    drive(90,100);destroy();
  }
  drive(90,0);
  while(speed()>49)
    destroy();
  while(1) {         /* movimento a L ruotata */
   dx();
   sx();
   dw();
   up();
  }
}

destroy(){
  if (pp=scan(ang,10))
    cannon(ang+=7*(!(scan(ang+356,7)))+353*(!(scan(ang+4,7))),2*scan(ang,10)-pp);
  else ang+=21;
}

shot() {
 while (speed() > 49)
   if ((d=scan(ang,10))) {
     if (!scan(ang+=5,5)) ang-=10;
       cannon(ang,d);
   } else ang+=20;
}
