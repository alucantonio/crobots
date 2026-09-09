/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots Y2K (Io Programmo)  (1999)                            */
/*                                                                          */
/*  CROBOT: ALIEN.R                                                         */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

  SCHEDA DESCRITTIVA:

  Inizialmente Alien si reca nell'angolo piu' vicino.
  Negli angoli viene usata la seguente strategia:
    1) Se gli avversari sono fuori dalla portata di fuoco e se non si
       subiscono danni, si rimane fermi nell'angolo;
    2) Se non c'e' nessuno nell'angolo adiacente in verticale, allora si
       raggiunge tale angolo;
    3) Se non c'e' nessuno nell'angolo adiacente in orizzontale, allora si
       raggiunge tale angolo;
    4) Si oscilla verticalmente fino a circa 280 dall'angolo; se entrambi
       gli angoli sulla verticale sono occupati, allora ci si sposta in
       orizzontale sul lato opposto; ci si reca nell'angolo libero sulla
       verticale preferendo quello piu' lontano.

  Dopo circa 170000 cicli si controllano gli avversari rimasti ogni 10000
  cicli, attaccando se e' rimasto un solo avversario; verso i 190000 si
  attacca comunque se i danni sono inferiori al 50%; e, sempre se i danni
  sono minori del 50% si fa' un'oscillazione in verticale per smuovere le
  situazioni di stallo.

  La routine di fuoco e' la stessa utilizzata dal CRobot Coppi.r del Torneo
  del 1998, con una piccola modifica per quanto riguarda il puntamento.

  La routine di attacco e' molto semplice: ci si sposta a destra e a sinistra
  a meta' altezza dell'arena. 

*/

int rng,orng,deg,odeg,dir,dam,avv,timer,aa,rr,c;

main()
{
  if (loc_x()<500) sx(100); else dx(900);
  if (loc_y()<500) dw(100); else up(900);

  timer=170000;
   
  while(1) Angolo();

}

up(d) {
  dir=90;
  while (loc_y()<d) { drive(90,100); Fire(); }
  drive(270,0);
}

dw(d) {
  dir=270;
  while (loc_y()>d) { drive(270,100); Fire(); }
  drive(90,0);
}

dx(d) {
  dir=0;
  while (loc_x()<d)  { drive(0,100); Fire(); }
  drive(180,0);
}

sx(d) {
  dir=180;
  while (loc_x()>d) { drive(180,100); Fire(); }
  drive(0,0);
}

Angolo()
{
  dam=damage();
  while ((!orng || orng>740) && (damage()<=dam)) {
    dam=damage();
    Fire();
    if ((timer-=190)<0) {
      Radar();
      if (damage()<50) {
          if (c>1) Attacca();
          if (loc_y()<500) { up(350); dw(100); } else { dw(650); up(900); }
      }
      timer=10000; ++c;
    }
      
  }

  if (loc_y()<500) {
    if (Look(90)) { 
      if (XMove()) return;
      up(280); 
    } else { up(880); timer-=2000; return; } 
    if (Look(90))
      if (Look(270)) { Move(); return; }
      else dw(120);
    else up(880);
  } else {
    if (Look(270)) {
      if (XMove()) return;
      dw(720); 
    } else { dw(120); timer-=2000; return; }
    if (Look(270))
      if (Look(90)) { Move(); return; }
      else up(880);
    else dw(120);
  }
  timer-=2000;
}

Move()
{
  if (loc_x()<500) dx(900); else sx(100); timer-=3000;
}

XMove()
{
  if (loc_x()<500) { 
    if (Look(360)) return 0; else dx(880); 
  } else { 
    if (Look(180)) return 0; else sx(120); 
  } 
  timer-=2000; 
  return 1;
}

Radar()
{
      deg=330; avv=0; 
      while((deg+=20)!=710) if (scan(deg,10)) ++avv; 
      if (avv<2)  Attacca(); 
}

Attacca()
{
  up(450); dw(550);
  while(1) {
    dx(850); 
    sx(150);
  }
}

Look(d) { return scan(d-10,10)+scan(d+10,10); }

scan14() 
{ 
  if(scan(deg+353,1)) deg+=353; 
  if(scan(deg+7,  1)) deg+=7; 
  if(scan(deg+355,1)) deg+=355; 
  if(scan(deg+5,  1)) deg+=5; 
  if(scan(deg+357,1)) deg+=357; 
  if(scan(deg+3,  1)) deg+=3; 
} 
 
scan_low() 
{ 
        if (orng=scan(deg+340,10)) cannon(deg+=340,(scan(deg,10)<<1)-orng); 
   else if (orng=scan(deg+20, 10)) cannon(deg+=20 ,(scan(deg,10)<<1)-orng); 
   else if (orng=scan(deg+320,10)) cannon(deg+=320,(scan(deg,10)<<1)-orng); 
   else if (orng=scan(deg+40, 10)) cannon(deg+=40 ,(scan(deg,10)<<1)-orng); 
   else if (orng=scan(deg+300,10)) cannon(deg+=300,orng); 
   else if (orng=scan(deg+60, 10)) cannon(deg+=60 ,orng); 
   else deg+=140; 
} 
 
Fire() 
{ 
  if (!scan(deg,7)) 
  if (!scan(deg+=345,7)) 
  if (!scan(deg+=30,7)) {scan_low(); return;} 
  scan14(); 
  if ((orng=scan(deg,7)) && (orng<755)) 
     { 
      odeg=deg; 
      scan14(); 
      if (rng=scan(deg,10)) 
         { 
          if (speed()) 
            { 
             aa=(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14)); 
             rr=(rng*160/(160+orng-rng-(cos(deg-dir)>>12))); 
            } 
          else 
            { 
             aa=(deg+(deg-odeg)*((1200+rng)>>9)); 
             rr=(rng*165/(165+orng-rng)); 
            } 
          while(!cannon(aa,rr)); 
         } 
      else scan_low(); 
     } 
  else scan_low(); 
} 
 
