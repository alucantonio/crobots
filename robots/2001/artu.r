/*****************
 *   A R T U '   *
 *****************

Autor   : Serino Dario

STRATEGIA
A causa del tempo limitato a disposizione non ho potuto progettare un nuovo
crobot ma ho assimilato il caro Daryl che a malincuore si e' visto smontare
la routine d'attacco e riconfigurare i parametri di puntamento.
Non saro' lungo nella spiegazione e mi soffermero' esclusivamente sulle differenze
dal precedessore:

- La strategia difensiva e' meno aggressiva con lo scopo di ridurre i danni
  ingenti che Daryl accumulava nel corso della battaglie;
  Artu' attacca l'avversario nell'angolo adiacente una volta ogni quattro cicli
  fino a meta' partita, dopo di che lo bombarda ad ogni ciclo per evitare
  che il match si concluda in pareggio;
  tali operazioni sono sincronizzate dalle variabili timer e fast;
- la procedura di fuoco imprecisa focusMed ha dei parametri variabili che
  vengono opportunamente settati in funzione della fase di gioco;
  cio' consente di contrastare efficacemente i Touch-like che oscillano notevolmente
  inibendo le routine che eseguono correzioni piccole di tiro
- la routine finale ha la stessa dinamica di Daryl, nel senso che per un po' di
  tempo aspetta che l'ultimo nemico rimasto si faccia avanti altrimenti esce
  allo scoperto immaginando che quest'ultimo sia troppo danneggiato per cercare
  una sfida;
  attacco difensivo: oscilla a breve distanza dall'angolo sparando con precisione
    o meno in funzione della distanza del nemico (credo che questo sia il suo maggior
    punto debole in quanto un nemico molto lontano e oscillante oppure uno molto preciso
    e che si avvicini spesso possono aver facilmente la meglio (spero solo che non
    abbiate presentato qualcosa del genere)
  attacco offensivo: Artu' oscilla al centro dell'arena fino alla fine dei suoi
    giorni (avrei voluto inserire una ritirata strategica ma non ho avuto il
    tempo e le istruzioni per farlo). L'unica novita' sta nel fatto che la routine
    di fuoco viene selezionata in funzione della media mobile a due periodi della
    scarto quadratico dell'angolo di puntamento; e' piu' difficile a dirsi che farlo.
    Non avrei immaginato che un calcolo cosi' pesante potesse dare buoni frutti
    ma i fatti mi hanno smentito.
    Per maggiori dettagli spulciate la variabile media.
    NB: durante le oscillazioni il robot controlla la distanza dal nemico e
    cerca di mantenerlo a 710m avvicinandosi od allontanandosi piano piano.

In conclusione non sono soddisfatto del risultato finale poiche' penso che i
nemici di quest'anno, specie i figli naturali di touch, boom, daryl e marine
mi bastoneranno ben bene. Volevo fare i miei complimenti a L.Cimini ed al suo
coppi_2k per i tormenti indiretti che mi ha dato nelle simulazioni 
*/

int dir,dir45,deg,odeg,rng,orng;
int dx,dy,sx,dw,x,y;
int anti,how,count,dam;
int low,high;
int focus1,focus2;
int media;

main() {
  int delta,fast,timer;

  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) deg=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else deg=630-180*dw;

  destroy(focus1=drive(dir=deg+180,100));
  focus2=3;

  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  f2f(waveDef(dir=(dir45=225-180*dw+90*(sx^dw))));

  how=65000; delta=45;

  while(waveDef()) {
    if (orng && (orng<770)) {
      dam=damage();
      if (damage(wave(dir45+90*anti-45))>dam+9) 
        {how=65000; delta=21-delta; anti^=1;}
    }
    else if ((rng=scan(dir45+delta-21,10)+scan(dir45+delta,10))&&(rng<770)) {
      wave(deg=dir45+90*(anti^=1)-45);
      how=65000; delta=21-delta;
    }

    else {
      if (scan(dir45-delta,10)+scan(dir45-delta+21,10)) {
        if (rng);
        else if (scan(dir45,10));
        else f2f();

        if ((++timer)>3) {
          if (fast<20) timer=0;
          waveAtt(++fast);
        }
      }
      else if (rng) {
        if (scan(dir45,10));
        else f2f();

        how=65000; delta=21-delta;
        waveAtt(anti^=1);
      }
      else f2f();
    }

    if (damage()>85) {
      if (dw) low=75;
      else {
        destroy(drive(dir=270,100));
        while(loc_y()>895) focusMed();
        focusEasy(low=895);
      }

      high=low+30;
      dir=90;

      while(drive(dir,100)) {
        destroy();
        while(loc_y()<high) focusMed();
        focusEasy();

        destroy(drive(dir,100));
        while(loc_y()>low) focusMed();
        focusEasy();
      }
    }
  }
}

wave(look) {
  count=2;

  while(count) {
    waveDef();

    if (orng && (orng<770)) count=2;
    else if ((rng=scan(look,10)) && (rng<770)) {deg=look; count=2;}
    else --count;
  }
}

waveDef() {
  focusHard(drive(dir,100));
  focusEasy(dir=180+((x=dx-loc_x())<0)*180+atan(((dy-loc_y())*100000)/x));

  focusMed(focusMed(focusMed(focusMed(drive(dir,100)))));
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  return dir=dir45;
}

waveAtt() {
  deg=dir45+90*anti-45;

  focusMed(drive(dir+=60*anti-30,100));
  count=10; while(--count) focusMed();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y<how)
    if (orng>800) destroy(); else focusMed();
  focusEasy(how+=1000);

  focusMed(drive(dir,100));
  count=10; while(--count) focusMed();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  return dir=dir45;
}

f2f() {
  int three;

  odeg=dir45-53;
  count=(three=16); while(three && (count>11))
    if (scan(odeg+15*((--three)%8),7)) --count;

  if (count>=14) {
    high=(low=880-800*dw)+30;
    
    focus1=2; focus2=7;
    destroy(drive(dir=dir45,100));
    if (sx) while(loc_x()<100) focusMed();
    else    while(loc_x()>900) focusMed();
    focusEasy();

    dir=90;

    while(count=45) {
      dam=damage();
  
      while(--count) {
        drive(dir,100);
        if (orng>600) destroy(); else focusMed();
        while(loc_y()<high) focusMed();
        focusEasy();

        drive(dir,100);
        if (orng>600) destroy(); else focusMed();
        while(loc_y()>low) focusMed();
        focusEasy();
      }

      if (damage()<dam+5) attack();
    }
  }
}

attack() {
  focus1=drive(dir=dir45,100);
  focus2=3;
  if (sx) while(loc_x()<460) focusMed();
  else    while(loc_x()>540) focusMed();

  while(focusEasy()) {
    go(dir=90);
    while(loc_y()<520) focusMed();

    if (orng<500) dir=90;
    else if (((deg-90)%360)<180) dir=88+4*(orng<710);
    else dir=92-4*(orng<710);

    go(focusEasy());
    while(loc_y()>480) focusMed();
  }
}

go() {
  int tick;
  
  drive(dir,100);

  if (orng<500) return focusMed();
  else if ((media=(media+(tick=deg-odeg)*tick)/2)>20) return destroy();
  else return focusMed();
}

focusHard(again) {
  if (orng=scan(deg,10));
  else if (orng=scan(deg-=20,10));
  else if (orng=scan(deg+=40,10));
  else {deg+=40; return focusHard(again);}

  if (orng<200) {cannon(deg,orng); return focusHard(again);}

  if (scan(deg-=5,5)); else deg+=10;
  if (scan(deg+8,5)) deg+=5; if (scan(deg-8,5)) deg-=5;
  if (scan(deg+7,5)) deg+=3; if (scan(deg-7,5)) deg-=3;
  if (scan(deg+5,5)) deg+=1; if (scan(deg-5,5)) deg-=1;

  if (orng=scan(odeg=deg,5)) {
    if (scan(deg+8,5)) deg+=5; if (scan(deg-8,5)) deg-=5;
    if (scan(deg+7,5)) deg+=3; if (scan(deg-7,5)) deg-=3;
    if (scan(deg+5,5)) deg+=1; if (scan(deg-5,5)) deg-=1;

    if (rng=scan(deg,10))                
      return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
  }
  else if (again) return focusHard();
}

focusEasy() {
  drive(dir+=180,0);

  while (speed()>50)
    if (orng=scan(odeg=deg,10)) {
      if (scan(deg+10,10)) deg+=5; else deg-=5;
      if (scan(deg+10,10)) deg+=3; else deg-=3;

      if (rng=scan(deg,10))
        cannon(deg+(deg-odeg),rng+(rng-orng)*2);
    }
    else if (orng=scan(deg-=20,10)) cannon(deg,orng);
    else if (orng=scan(deg+=40,10)) cannon(deg,orng);
    else deg+=40;
}

focusMed() {
  if (orng=scan(deg,10)) {
         if (rng=scan(deg,focus1)) return cannon(deg,rng);
    else if (rng=scan(deg-5,4))    return cannon(deg-=focus2,rng);
    else if (rng=scan(deg+5,4))    return cannon(deg+=focus2,rng);
  }
  if (rng=scan(deg-=20,10))        return cannon(deg,rng);
  else if (rng=scan(deg+=40,10)) return cannon(deg,rng);
  else return deg+=40;
}

destroy() {
  if (orng=scan(deg,10));
  else if (orng=scan(deg+=20,10));
  else if (orng=scan(deg-=40,10));
  else return deg+=80;

  if (scan(deg-=5,5)); else deg+=10;
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
  if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

  if (orng=scan(odeg=deg,5)) {
    if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
    if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
    if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

    if (rng=scan(deg,10))
      return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
  }
}
