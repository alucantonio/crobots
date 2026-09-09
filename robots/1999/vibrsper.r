/*                         " Vibra - Spericolata "

        AUTORE
        Gianmarco Candido
        
        MUSA ISPIRATRICE
        Alessandro Carlin

SCHEDA TECNICA:
Questo crobot deriva da Sottolin, un crobot dello scorso torneo che mi ha
colpito molto per il suo comportamento (specie contro Alien).
Ho cercato di migliorare per quanto mi è stato possibile le procedure di
fuoco, il conteggio dei nemici nell'arena e compattare il codice originale.
Per onorare il creatore di questo crobot ho lasciato parte del commento ed i
nomi delle procedure identici all'originale. Alessandro sei un grande!

Inizialmente il crobot si porta vicino al fondo dello schermo, e da questa
posizione controlla l' angolo SUD-OVEST; nel caso in cui sia libero lo
raggiunge, altrimenti va ad occupare l' angolo SUD-EST. Raggiunta una di
queste posizioni inizia un movimento oscillatorio di circa 200 metri
che avviene in direzione verticale se non ci sono nemici negli angoli
adiacenti, e diventa orizzontale se e' presente un crobot nell' angolo
superiore. Durante questa fase (che dura almeno 8E+4 cicli virtuali di CPU)
VibrSper utilizza 2 diverse procedure di fuoco: kill() che consente
un puntamento molto preciso ma e' piuttosto lenta, e mortal() che e' di
esecuzione molto piu' rapida. Successivamente il crobot inizia ad effettuare
dei controlli (circa ogni 15 oscillazioni) sui robot rimasti: se ne individua
uno solo e i danni sono minori dell' 80% lo attacca con la procedura attack()
portandosi al centro del campo ed oscillando in direzione orizzontale.
La funzione di sparo e' diversa dalle due precedenti : destroy().

Ho omesso i commenti al codice in quanto, il comportamento di questo robottino
e' conosciuto (penso) già da tutti.
                                                                            */

int pp,dz,dw,dx,su,via,ang,dir,cont,c;
int   d,oang,range,orange,aa,rr,diff;

main() {
  c=14;
  ang=(cont=0);
  drive(dir=270,100);
  while (loc_y() > 160) kill();
  stop();
  if ((!scan(180,10))&&(!scan(162,10))) {
    drive(dir=180,100);
    dz=(dx=0);
    dw=180;
    while(loc_x() > 140) kill();
    stop();
  } else {
    dx=drive(dir=(dw=0),100);
    dz=180;
    while(loc_x() < 840) kill();
    stop(); 
  }
  while(1) { 
    su=scan(90,10);
    via=scan(dz,10);
    if (su<=via){
      drive(dir=90,100);
      while (loc_y() < 285) kill();
      stop();
      kill(kill(drive(dir=270,100)));
      while (loc_y() > 90) mortal();
      stop();
    } else {
      drive(dir=dz,100);
      if (dx==0) while(loc_x() <= 285) kill();
      else while(loc_x()>715) kill();
      stop();
      kill(kill(drive(dir=dw,100)));
      if (dx==0) while(loc_x() > 95) mortal();
      else while(loc_x() < 910) mortal();
      stop();  
    }
  }
}

kill() {
  if (orange=scan(ang,10));                   
  else if (orange=scan(ang-=21,10));          
  else if (orange=scan(ang+=42,10));
  else return (ang+=42);
  if (orange>710) { 
    cannon(ang,orange); 
    return ang+=42; 
  }
  if (scan(ang-=5,5)); else ang+=10;          
  if (scan(ang+5,2)) ang+=5; 
  if (scan(ang-5,2)) ang-=5;
  if (scan(ang+3,1)) ang+=3; 
  if (scan(ang-3,1)) ang-=3;
  if (scan(ang+1,1)) ang+=1;
  if (scan(ang-1,1)) ang-=1;
  if (orange=scan(oang=ang,5)) {
    if (scan(ang+5,2)) ang+=5; 
    if (scan(ang-5,2)) ang-=5;
    if (scan(ang+3,1)) ang+=3; 
    if (scan(ang-3,1)) ang-=3;
    if (scan(ang+1,1)) ang+=1; 
    if (scan(ang-1,1)) ang-=1;  
    if (range=scan(ang,10))
      return cannon(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14),range*172/(172+orange-range-(cos(ang-dir)>>12)));
  }             
}

attack() {
  while(loc_y()<450) {drive(90,100); destroy();}
  drive(90,0);
  while(speed()>50) destroy();
  while(1) {
    drive(0,100);
    while (loc_x()<600) destroy();
    drive(0,0);
    while (speed()>50) destroy();
    drive(180,100);
    while (loc_x()>400) destroy();
    drive(180,0);
    while (speed()>50) destroy();
  }
}

destroy() {
  if (orange=scan(ang,10)) 
    if (range=scan((ang=(6*(scan((ang+=(10*(scan((oang=ang)+10,10)>0)-5))+10,10)>0)-3)+ang),10)) 
      cannon(ang+(ang-oang),range+(range-orange)*2);
    else ;
  else ang+=21;
}

stop() {
  int num,da;
  drive(dir,0);
  if ((++cont >= 86) && (damage() < 80))    
    if ((++c)%15==0) {
      num=0; 
      da=370;
      while (da>0) if (scan(da-=21,10)) ++num;  
      if (num<2) attack();
    } 
  while(speed() > 50) mortal();
}

mortal() {  
  if ((d=scan(ang,10)) && (d<750)) { 
    if (d=scan(ang+353,3)) cannon(ang+=353,d);
    else if (d=scan(ang,3)) cannon(ang,d);
    else if (d=scan(ang+7,3)) cannon(ang+=7,d); 
  } else {
    if ((d=scan(ang+21,10))&&(d<710)) {ang+=21;cannon(ang,d);}
    else if ((d=scan(ang+42,10))&&(d<710)) ang+=42;
         else ang+=63;
  }  
}
