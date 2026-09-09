/****************************
 * D.A.R.Y.L. - La Vendetta *
 ****************************

Autor   : Serino Dario

STRATEGIA

Daryl nasce dalla dura lotta contro due limiti notevoli del caro Dario, uno
di carattere tecnico legato alla ridotta disponibilit… di istruzioni macchina
che ha fortemente condizionato quella dinamica che avevo in mente gi… un anno
fa ma che solo ora riesco ad interpretare liberamente, ed un altro di stampo
concettuale dovuto a preconcetti tattici che ora come non mai ho messo in
discussione sperimentando soluzioni impreviste ed innovative (almeno per quanto
mi riguarda data la mia fondamentale inesperienza in manifestazioni ufficiali).
Provero' a dare un' illustrazione concisa ed efficace della logica del crobot
anche se invito gli animi piu' curiosi ed esploratori a ricercare nel codice
quei dettagli diabolici che un' po' per dimenticanza, un po' per il loro carattere
puramente implementativo non riusciro' a raccontare in modo esaustivo.

La peculiarit… maggiore di Daryl consiste nel rapporto morboso con l'angolo
dell'arena scelto come trincea all'inizio dell'incontro: come un capitano
dignitoso egli si rifiuter… sistematicamente ad abbandonare la nave fino
alla morte a meno che l'ultimo avversario rimasto sia talmente debole o
intimorito da evitare lo scontro finale; solo in tale condizione proceder…
all' assalto senza tregua in campo aperto.

All' inizio del match viene quindi tracciata la traiettoria migliore per
l' angolo piu' prossimo che viene raggiunto e difeso ad oltranza qualora
qualche sprovveduto avesse gi… deciso di conquistarlo (in passato avrei
preferito fuggire in una simile situazione ma non Š stato snervante osservare
che anche il mio antagonista farebbe fatto lo stesso ragionameto e prima o poi,
se avessi resistito con tenacia, sarebbe stato lui a gettare la spugna e cercare
un angolo adiacente in cui suicidarsi con un altro rivale).

Una volta al sicuro Daryl esegue due oscillazioni ritmiche, una nella direzione
di un nemico adiacente, ed una piu' corta verso il centro del campo. Nel primo
movimento il fuoco Š opportunamente calibrato per ottenere la massima efficacia
contro dei crobot oscillanti dato che quelli statici sono talmente pesanti da
soccombere alla lunga contro questi attacchi cosi' repentini e martellanti
sebbene imprecisi.

Qui entra in gioco un' altra notevole intuizione: un avversario, una volta
puntato, non viene ma abbandonato dal mirino dato che lo scopo di Daryl non Š
quello di far male al primo che sia a tiro di fucile, ma abbattere il piu'
velocemente possibile tutti gli avversari, uno alla volta, dando la priorit…
a quelli adiacenti e quindi non vede il motivo di andare a cercare un' altra
preda quando quella finora colpita Š probabilmente agonizzante. Tuttavia
se il nostro avversario Š talmente incazzato da scaricarci addosso un intero
arsenale Š bene che si dia una calmata e nel frattempo la compagnia sar…
riservata all' altro robot adiacente. E' interessante notare il movimento
eseguito quando un "walker crobot" si reca nel suo angolo: l' effetto sul
mirino nemico Š devastante; non male se si pensi che Š nato per un errore
di programmazione.

Prima di effettuare un oscillazione angolare Daryl da una rapida occhiata agli
altri angoli e nel caso in cui risultino vuoti si ferma a contare attentamente
i sopravvissuti. Se la resa dei conti Š giunta si prepara al duello finale.

Contrariamente alle predizioni la strategia finale Š molto difensiva.
Rimanendo nel proprio angolo ed oscillando ancora piu' brevemente vanifica
le tecniche di fuoco troppo precise e nello stesso tempo viene a contatto col
nemico che passa la maggior parte del suo tempo a decidere la traiettoria
e posizione d'attacco migliore e poco a sparare all'impazzata. Se dopo un certo
tempo nessuno si Š fatto avanti allora ringrazia l'angoletto dell'ospitalit…
e conquista il centro dell'arena oscillando verticalmente intorno ad esso.
A questo punto finchŠ l'avversario si tiene a debita distanza la strategia
rimane immutata fino alla fine, ma se quest'ultimo si fa avanti (un po' in
ritardo) Daryl si defila in basso a sinistra e da li' controller… la situazione.

Personalmente ho sfruttato le istruzioni disponibili mettendo qua e l…
ridondanze di codice, quindi non stupitevi quando individuerete ben due toxiche:
non sapevo cos'altro inventarmi ed ho preferito permettervi di recuperare
facilmente dello spazio per fare esperimenti a mo' di piccolo chimico
e darmi qualche interessante suggerimento.

CONSIDERAZIONI

Innalzare il limite delle istruzioni Š stata una manna dal cielo che ha
permesso a me di attuare soluzioni alternative e al club crobotico di
salutare un ambiente di gioco ormai divenuto saturo di idee. Secondo me
un aggiornamento radicale del kernel che arricchi l'equipaggiamento di fuoco
e routine di calcolo preconfezionate piu' evolute gioveranno non poco al
gioco ed offro il mio aiuto ad iniziative del genere sebbene il mio C
abbisogni di una rispolverata. 
*/

int dir,dir45,deg,odeg,rng,orng;
int dx,dy,sx,dw,x,y;
int anti,how,count,dam;

main() {
  int delta;

  /* vai nell' angolo pi— vicino */
  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) deg=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else deg=630-180*dw;

  drive(dir=deg+180,100);
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  /* oscilla per affinare il posizionamento */
  waveDef(dir=(dir45=225-180*dw+90*(sx^dw)));

  how=65000; delta=45;

  /* oscilla brevemente a 45 gradi */
  while(waveDef()) {
    /* se il nemico puntato Š vicino... */
    if (orng && (orng<770)) {
      dam=damage();
      /* oscilla fino a che non si allontana */
      wave(dir45+90*anti-45);
      /* se ha procurato troppo danno punta un altro nemico */
      if (damage()>dam+8) {how=65000; delta=21-delta; anti^=1;}
    }
    /* se l'altro nemico adiacente Š vicino... */
    else if ((rng=scan(dir45+delta-21,10)+scan(dir45+delta,10))&&(rng<770)) {
      /* oscilla fino a che non si allontana */
      wave(deg=dir45+90*(anti^=1)-45);
      how=65000; delta=21-delta;
    }

    /* se il nemico puntato Š ancora vivo */
    else {
      /* controlla se Š l'ultimo sopravvissuto */
      if (scan(dir45-delta,10)+scan(dir45-delta+21,10)) {
        if (rng);
        else if (scan(dir45,10));
        else f2f();

        /* attaccalo oscillando nella sua direzione */
        waveAtt();
      }
      /* punta l'altro avversario nell'angolo adiacente */
      else if (rng) {
        /* controlla se Š l'ultimo sopravvissuto */
        if (scan(dir45,10));
        else f2f();

        /* attaccalo oscillando nella sua direzione */
        how=65000; delta=21-delta;
        waveAtt(anti^=1);
      }
      else f2f();
    }

    /* se ci sono troppi danni oscilla verticalmente senza pi— attaccare */
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

/* oscilla a 45 gradi ripetutamentea per liberarsi di un nemico troppo vicino*/
wave(look) {
  count=2;

  while(count) {
    waveDef();

    if (orng && (orng<770)) count=2;
    else if ((rng=scan(look,10)) && (rng<770)) {deg=look; count=2;}
    else --count;
  }
}

/* oscilla a 45 gradi per temporeggiare */
waveDef() {
  focusHard(drive(dir,100));
  focusEasy(dir=180+((x=dx-loc_x())<0)*180+atan(((dy-loc_y())*100000)/x));

  focusMed(focusMed(focusMed(focusMed(focusMed(drive(dir,100))))));
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  return dir=dir45;
}

/* attacca il nemico nell'angolo adiacente a 15 gradi */
waveAtt() {
  deg=dir45+90*anti-45;

  /* avvicinamento */
  focusMed(drive(dir+=60*anti-30,100));
  count=10; while(--count) focusMed();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y<how)
    if (orng>800) destroy(); else focusMed();
  focusEasy(how+=1000);

  /* allontamento */
  focusMed(drive(dir,100));
  count=10; while(--count) focusMed();
  while((x=dx-loc_x())*x+(y=dy-loc_y())*y>5200) focusMed();
  focusEasy();

  return dir=dir45;
}

/* freno e fuoco intermedio tra precisione e velocit… */
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

/* fuoco veloce */
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

/* fuoco impreciso durante oscillazione a 45 gradi */
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

/* conteggio avversari */
f2f() {
  int three;

  odeg=dir45-53;
  count=(three=16); while(three && (count>11))
    if (scan(odeg+15*((--three)%8),7)) --count;

  if (count>=14)
    if (dw) decide(75);
    else {
      destroy(drive(dir=270,100));
      while(loc_y()>895) focusMed();
      focusEasy();
      decide(895);
    }
}

/* oscilla 30 volte e decidi se attaccare o meno */
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

  /* se i danni subiti sono pochi (avversario non ha attaccato) fatti avanti */
  if (damage()<dam+5) attack();
  /* altrimenti continua ad oscillare */
  else wall(low);
}


/* oscilla nell' angolo nel Face2Face */
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

/* attacco centrale */
attack() {
  /* posizionati al centro dell' arena */
  destroy(drive(dir=dir45,100));
  if (sx) while(loc_x()<460) focusMed();
  else    while(loc_x()>540) focusMed();
  focusEasy();
  dir=270; 
  
  /* oscilla verticalmente */
  while(drive(dir,100)) {
    destroy();
    while(loc_y()>475) focusMed();
    focusEasy();
  
    /* se l'avversario Š troppo vicino */
    if (orng && (orng<300)) {
      destroy(drive(dir=240,100));
      while(loc_y()>90) focusMed();
      focusEasy();

      /* defilati in basso a sinistra */
      wall(75);
    }

    destroy(drive(dir,100));
    while(loc_y()<525) focusMed();
    focusEasy();
  }
}

/* fuoco preciso per l' attacco finale */
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
