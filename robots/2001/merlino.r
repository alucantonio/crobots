/*********************
 *   M E R L I N O   *
 *********************

Autor   : Serino Dario

STRATEGIA
E' la fotocopia di Artu' con delle leggere variazioni sulle routine finali:
- routine difensiva: si tiene molto piu' vicino all'angolo ed e' piu'
    performante contro i robot oscillanti(se non ricordo male)
- routine d'attacco: ho eliminato la storia sulla media mobile che non mi
    ha mai convinto seriamente ed al suo posto la selezione delle routine
    di fuoco da utilizzare e' fatta in funzione dell'angolo relativo del
    nemico rispetto al centro dell'arena, cioe'
    1) vedo il nemico approssimativamente a 45,135,225,315 gradi =>
       probabilmente sta oscillando bevemente nel proprio angolo quindi
       lo attacco con focusMed (imprecisa)
    2) altrimenti l'avversario sta facendo delle oscillazioni lunghe o
       tenta addirittura di abbandonare l'angolo => destroy (toxica)
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
    focus1=2; focus2=7;

    high=(low=895-820*dw)+30;
    dir=90;

    while(count=45) {
      dam=damage();

      while(--count) {
        drive(dir,100);
        if (orng>680) destroy(); else focusMed();
        while(loc_y()<high) focusMed();

        focusEasy();

        drive(dir,100);

        if (orng>680) destroy(); else focusMed();
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

  dir=90;

  while(focusEasy()) {
    drive(dir,100);

    if (orng<450) focusMed();
    else if (((deg-35)%90)<20) focusMed();
    else destroy();

    while(loc_y()>480) focusMed();
    focusEasy(dir=270);

    drive(dir,100);

    if (orng<450) focusMed();
    else if (((deg-35)%90)<20) focusMed();
    else destroy();

    while(loc_y()<520) focusMed();

    if (orng<450);
    else if (((deg-90)%360)<180) dir=88+4*(orng<710);
    else dir=92-4*(orng<710);
  }
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
