/****************************
 * 7 di 9 - Tecnologia Borg *
 ****************************

Autor   : Serino Dario

NOTE

"7 di 9" Š l'affascinante drone borg strappato alla collettivit… ed integrato
nell' equipaggio della Voyager. Gli amanti di Star Trek hanno gi… individuato
le forme molto intriganti del personaggio in questione e renderanno omaggio
al crobot in questione.
La strategia Š identica a Daryl per cui non spreco parole a riparlarne, l'unica
differenza consiste nella routine di attacco finale che meglio interpreta
i nemici oscillanti della famiglia Rudolf e compagni del Torneo 91-98.
Essa ancora una volta consiste nell' aspettare l'ultimo sopravvissuto
per lo scontro finale. Quando quest'ultimo evita il duello viene conquistato
il centro dello schermo ed eseguita un' oscillazione la cui direzione
orizzontale o verticale e la cui lunghezza Š modulata dalla posizione
del nemico di modo da evitare l'effetto catastrofico delle scariche di fuoco
imprecise che danneggiano troppo Daryl. Le differenze pertanto si ritroveranno
esclusivamente nella routine attack().
*/

int dir,dir45,deg,odeg,rng,orng;
int dx,dy,sx,dw,x,y;
int anti,how,count,dam,defend;

main() {
  int delta;

  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) deg=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else deg=630-180*dw;

  drive(dir=deg+180,100);
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  f2f(waveDef(dir=(dir45=225-180*dw+90*(sx^dw))));

  how=65000; delta=45;

  while(waveDef()) {
    if (orng && (orng<770)) {
      dam=damage();
      wave(dir45+90*anti-45);
      if (damage()>dam+8) {how=65000; delta=21-delta; anti^=1;}
    }
    else if ((rng=scan(dir45+delta-21,10)+scan(dir45+delta,10))&&(rng<770)) {
      wave(deg=dir45+90*(anti^=1)-45);
      how=65000; delta=21-delta;
    }

    else if (scan(dir45-delta,10)+scan(dir45-delta+21,10)) {
      if (rng);
      else if (scan(dir45,10));
      else f2f();

      waveAtt();
    }
    else if (rng) {
      if (scan(dir45,10));
      else f2f();

      how=65000; delta=21-delta;
      waveAtt(anti^=1);
    }
    else f2f();

    if (damage()>80)
      if (dw) wall(75);
      else {
        destroy(drive(dir=270,100));
        while(loc_y()>895) focusMed();
        focusEasy();
        wall(895);
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

  focusMed(focusMed(focusMed(focusMed(focusMed(drive(dir,100))))));
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

  return defend=(dir=dir45);
}

focusEasy() {
  drive(dir+=180,0);

  while (speed()>50)
    if (orng=scan(deg,10)) {
      odeg=deg;
      if (scan(deg+=5,5)); else deg-=10;
      if (scan(deg+=3,3)); else deg-=6;
  
      if (rng=scan(deg,10))
        cannon(deg+(deg-odeg),rng+(rng-orng)*2);
    }
    else if (orng=scan(deg-=20,10)) cannon(deg,orng);
    else if (orng=scan(deg+=40,10)) cannon(deg,orng);
    else deg+=40;
}

focusMed() {
  if (orng=scan(deg,10)) {
         if (rng=scan(deg,1))   return cannon(deg,rng);
    else if (rng=scan(deg-5,4)) return cannon(deg-=3,rng);
    else if (rng=scan(deg+5,4)) return cannon(deg+=3,rng);
  }
  else if (rng=scan(deg-=20,10)) return cannon(deg,rng);
  else if (rng=scan(deg+=40,10)) return cannon(deg,rng);
  else return deg+=40;
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

f2f() {
  int three;

  odeg=dir45-53;
  count=(three=16); while(three && (count>11))
    if (scan(odeg+15*((--three)%8),7)) --count;

  if (count>=14)
    if (defend)
      if (dw) decide(75);
      else {
        destroy(drive(dir=270,100));
        while(loc_y()>895) focusMed();
        focusEasy();
        decide(895);
      }
    else attack();
}

decide(low) {
  int high;

  high=low+30;
  dir=90;

  dam=damage(count=30);

  while(--count) {
    destroy(drive(dir,100));
    while(loc_y()<high) focusMed();
    focusEasy();

    destroy(drive(dir,100));
    while(loc_y()>low) focusMed();
    focusEasy();
  }

  if (damage()<dam+5) attack();
  else wall(low);
}


wall(low) {
  int high;

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

attack() {
  /* guadagna il centro dell' arena*/
  destroy(drive(dir=dir45,100));
  if (sx) while(loc_x()<460) focusMed();
  else    while(loc_x()>540) focusMed();
  focusEasy();

  /* sceglie la direzione di oscillazione: Verticale/Orizzontale */
  while(drive(dir=(((deg+180)/90)*90)%360,100)) {
    destroy();
    /* avvicinamento */
    if (dir==270)     while(loc_y()>350) destroy();
    else if (dir==90) while(loc_y()<650) destroy();
    else if (dir)     while(loc_x()>350) destroy();
    else              while(loc_x()<650) destroy();
    focusEasy();

    /* allontamento di 770 m */
    destroy(destroy(drive(dir,100)));
    while(orng>770) focusMed();
    focusEasy();

    /* se l'avversario Š troppo vicino */
    if (orng && (orng<300)) {
      destroy(drive(dir=240,100));
      while(loc_y()>90) focusMed();
      focusEasy();

      /* defilati in basso a sinistra */
      wall(75);
    }
  }
}

destroy() {
  if (orng=scan(deg,10));
  else if (orng=scan(deg+=20,10));
  else if (orng=scan(deg-=40,10));
  else return deg+=80;

  if (orng<200) return cannon(deg,orng);

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
