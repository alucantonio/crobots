/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2002)                                 */
/*                                                                          */
/*  CROBOT: Wulfgar.r                                                       */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/


/*

SCHEDA TECNICA:
  
  All'inizio del match Wulfgar esegue un controllo (Radar1) per verificare se si tratta
  di un incontro f2f, in tal caso adotta immediatamente la routine offensiva di f2f.
  Il robot si reca quindi nell'angolo più vicino e inizia un movimento oscillatorio
  a "L". Durante le oscillazioni controlla se è rimasto un solo avversario e, in
  tal caso lo aggredisce con la routine offensiva. Intorno ai 140000 cicli la
  strategia cambia: vengono effettuate oscillazioni piu' lunghe in direzione degli
  angoli adiacenti (250 unita' se c'e' un nemico, altrimenti 350); se i due angoli sono
  liberi allora attacca, mentre se i danni superano 85% allora continua fino alla
  fine con le oscillazioni brevi. 
  Verso i 180000 cicli se i danni subiti sono minori del 85% attacca. Il controllo del 
  numero di avversari non e' molto accurato, poiche' viene fatto in piu' passaggi, e 
  qualche volta Wulfgar parte all'attacco contro 2 avversari.

OSCILLAZIONI:

  Il movimento nell'angolo e' alla base della strategia del 4vs4. Il robot esegue 2 
  oscillazioni in orizzontale e in verticale mantenendosi il piu' possibile vicino
  all'angolo (al limite dell'autolesionismo) controllando che la velocità rimanga 
  elevata anche nei cambi di direzione e sparando in fase di frenata nei punti di
  massimo avvicinamento contro gli avversari e in prossimità dell'angolo.
  Durante le oscillazioni si controlla il numero degli avversari con una funzione 
  non troppo precisa a causa del movimento stesso e del frazionamento della 
  scansione completa in piu' chiamate alla stessa funzione (Radar). Se rimane un
  solo avversario Wulfgar attacca indipendentemente dal danno subito (la migliore 
  difesa e' l'attacco).
  Vengono infine tenuti costantemente sotto controllo gli angoli adiacenti con
  correzioni sull'angolo di puntamento della routine di fuoco.  
  
ROUTINE DI FUOCO:
  Le routine di fuoco sono molto semplici e non utilizzano toxiche.
  L'alto rendimento nei test e' dovuto soprattutto a una serie di accorgimenti:
  
    1) Sono temporizzate in maniera tale da sparare piu' colpi possibili.
       In particolare la funzione Fire unitamente al controllo del movimento 
       impiega circa 75 cicli virtuali e quindi spara un colpo ogni 3 esecuzioni.
       Anche la funzione Stop, utilizzata nelle oscillazioni e' sincronizzata 
       congiuntamente alle altre funzioni usate nel movimento per sparare ogni 220
       cicli circa.
    2) Il puntamento rimane ampio (10) anche nelle correzioni dell'angolo seguendo
       in maniera efficiente anche i nemici vicini.
    3) In un'unica chiamata (Fire) vengono scansionati 180 gradi (stesso motivo
       del punto 2).
    4) Non viene mai perso il nemico puntato (nel 4vs4 tale operazione e gestita dalle
       Funzioni LookX, LookY e Stop) con controlli tipo "if (rgn>700)...".
    5) La routine di fuoco del 4vs4 esegue correzioni minori sull'angolo poichè si
       suppone che gli avversari siano piu' lontani e che si mantengano nelle
       vicinanze degli angoli.

ROUTINE OFFENSIVA:
  
  La routine offensiva del 4vs4 funziona in questo modo:
    
    1) Il robot si porta al centro dell'arena;
    2) Finche non si subisce un danno maggiore del 10% si esegue un'oscillazione
       media in direzione del nemico puntato dalla routine di fuoco prima con uno
       sfasamento di +45 gradi e poi di -45 gradi;
    3) Fino alla fine del match viene descritto un quadrato al centro dell'arena:
       il quadrato e' minimo se il robot avversario si trova a una distanza 
       maggiore di 300, altrimenti si allarga di circa 200 unità. Questa scelta
       serve a rendere difficile il puntamento ai robot vicini.  
  
*/

int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd,bis,x,y;
int rd,ren,en2;
int timer;

Up(d) { dir=90; while (loc_y()<d) Fire(drive(90,100)); }
Dw(d) { dir=270; while (loc_y()>d) Fire(drive(270,100)); }
Dx(d) { dir=0; while (loc_x()<d) Fire(drive(0,100)); }
Sx(d) { dir=180; while (loc_x()>d) Fire(drive(180,100)); }

Up2(d) { dir=90; while (loc_y()<d) Fire2(drive(90,100)); }
Dw2(d) { dir=270; while (loc_y()>d) Fire2(drive(270,100)); }
Dx2(d) { dir=0; while (loc_x()<d) Fire2(drive(0,100)); }
Sx2(d) { dir=180; while (loc_x()>d) Fire2(drive(180,100)); }

main()
{
if (Radar1()) {
/*  xd=180*(xs=loc_x(yd=90+180*(ys=(loc_y(en2=en=3))>499))>499); */

  xs=loc_x()>499;  
  if (xs) Dx(900); else Sx(100); 
  ys=loc_y()>499;
  if (ys) Up(880); else Dw(120);
  
  xd=180*xs;
  yd=90+180*ys;
  Stop(dir);
  en2=en=3;
  
  Wait();
  t=0;

    while(1) {  
      if (x=scan(deg=xd,10)) {
        if (xs) { Sx2(750); Dx2(900); } else { Dx2(250); Sx2(100); }
      } else { 
        deg=yd;
        if (xs) { Sx(650); Dx(900); } else { Dx(350); Sx(100); }
      }
      if (damage()>85) {
        Stop(dir); 
        timer=en2=1;   
        Wait();
      }
      if (++t>20) Attacca();
      if (y=scan(deg=yd,10)) {
        if (ys) { Dw2(750); Up2(900); } else { Up2(250); Dw2(100); }
      } else { 
        deg=xd;
        if (ys) { Dw(650); Up(900); } else { Up(350); Dw(100); }
      } 
      if (x+y==0) Attacca();
    }
    if (scan(xd,10)<300) {
      if (xs) Sx(100); else Dx(900); 
      xd=180*(xs=loc_x()>499);
    } else {
      if (ys) Dw(100); else Up(900);
      yd=90+180*(ys=loc_y()>499);
    }
    drive(dir,0);
}
  Attacca(); 

}

Wait()
{
  while(en2) {
    if (xs) {
      Run(180); while (loc_x()>940) LookX(); Stop(180);
      Run(0);   while (loc_x()<945) Radar(); Stop(0);
    } else {
      Run(0);   while (loc_x()<60)  LookX(); Stop(0);
      Run(180); while (loc_x()>55)  Radar(); Stop(180);
    }
    if (ys) {
      Run(270); while (loc_y()>940) LookY(); Stop(270);
      Run(90);  while (loc_y()<945) Radar(); Stop(90);
    } else {
      Run(90);  while (loc_y()<60)  LookY(); Stop(90);
      Run(270); while (loc_y()>55) Radar();  Stop(270);
    }
  }
}

Attacca()
{
    while (loc_x()<509) Fire(drive(0,100));
    while (loc_y()<509) Fire(drive(90,100));
    while (loc_x()>492) Fire(drive(180,100));
    while (loc_y()>492) Fire(drive(270,100));  
    
  
  dam=damage();
  while(damage()<dam+10) {
    dir=deg+45; t=12;
    dam=damage(); 
    while (--t) Fire(drive(dir,100));
    dir+=180;	t=12;    
    while (--t) Fire(drive(dir,100));
    dir=deg+315; t=12;
    while (--t) Fire(drive(dir,100));
    dir+=180;	t=12;
    while (--t) Fire(drive(dir,100));
  }

  while(1) {
    if (rng>300) {
      while (loc_x()<500) Fire(drive(0,100));
      Fire(drive(90,0)); 
      while (loc_y()<500) Fire(drive(90,100));
      Fire(drive(180,0)); 
      while (loc_x()>499) Fire(drive(180,100));
      Fire(drive(270,0));     
      while (loc_y()>499) Fire(drive(270,100));
      Fire(drive(0,0)); 
    } else {
      while (loc_x()<600) Fire(drive(0,100));
      Fire(drive(90,0)); 
      while (loc_y()<600) Fire(drive(90,100));
      Fire(drive(180,0)); 
      while (loc_x()>400) Fire(drive(180,100));
      Fire(drive(270,0)); 
      while (loc_y()>400) Fire(drive(270,100));
      Fire(drive(0,0)); 
    }
  }
}

Fire()
{
  if (rng=scan(odeg=deg,10))
  {    

    if (scan(deg+350,10)) deg+=355; else deg+=5;
    if (scan(deg+350,10)) deg+=357; else deg+=3; 
    
    cannon(deg+deg-odeg,(scan(deg,10)<<1)-rng); 

  } else {
        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        if (rng=scan(deg+=80,10))  return cannon(deg,rng);
        if (rng=scan(deg+=260,10)) return cannon(deg,rng);
        if (rng=scan(deg+=120,10)) return cannon(deg,rng);
        if (rng=scan(deg+=220,10)) return cannon(deg,rng);
        if (rng=scan(deg+=160,10)) return cannon(deg,rng);
        if (rng=scan(deg+=180,10)) return cannon(deg,rng);
        deg+=270; 
  }
}

Fire2()
{
  if (scan(deg,10))
  {    

    if (scan(deg+350,10)) deg+=357; else deg+=3;
    if (scan(deg+350,10)) deg+=358; else deg+=2; 
    
    cannon(deg,scan(deg,10)); 

  } else {
        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        if (rng=scan(deg+=300,10)) return cannon(deg,rng);
        if (rng=scan(deg+=80,10))  return cannon(deg,rng);
        if (rng=scan(deg+=260,10)) return cannon(deg,rng);
        if (rng=scan(deg+=120,10)) return cannon(deg,rng);
        if (rng=scan(deg+=220,10)) return cannon(deg,rng);
        if (rng=scan(deg+=160,10)) return cannon(deg,rng);
        if (rng=scan(deg+=180,10)) return cannon(deg,rng);
        deg+=270; 
  }

}
LookX()
int dd;
{
  if (dd=scan(xd,10)) {
    if (dd<scan(yd,10)) deg=xd; else deg=yd; 
  } else deg=yd;
  if (++timer>225) en2=0; 
}

LookY()
int dd;
{
  if (dd=scan(yd,10)) {
    if (dd<scan(xd,10)) deg=yd; else deg=xd;  
  } else  deg=xd;
}

Radar()
{
  if (rd==380) { 
    if (ren<2) Attacca();
    rd=ren=0;
  } else {
    if (scan(rd+=20,10)) ren+=1;
  }  	
}

Run(d)
{
  drive(d,100);
  while(speed()<70) drive(d,100);	
}

Stop(d)
{
  drive(d,0);
  if (orng=scan(odeg=deg,10))
  {    

    if (scan(deg+350,10)) deg+=357; else deg+=3;
    if (scan(deg+350,10)) deg+=358; else deg+=2; 
    
    cannon(deg,(scan(deg,10)<<1)-orng); 

  } 
  else if (rng=scan(deg+=340,10)) cannon(deg,rng);
  else if (rng=scan(deg+=40,10))  cannon(deg,rng);
  else if (rng=scan(deg+=300,10)) cannon(deg,rng);
  else if (rng=scan(deg+=80,10))  cannon(deg,rng);
 	
  while(speed()>59) drive(d,0);	
}

Radar1()
{
  while (bis<=360) if (scan(bis+=20,10)) { if (++en>1) return 1; else Fire(deg=bis); }
  return 0;
}