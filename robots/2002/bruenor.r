/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2002)                                 */
/*                                                                          */
/*  CROBOT: Bruenor.r                                                       */
/*                                                                          */
/*  CATEGORIA: 1000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/


/*

SCHEDA TECNICA:
  
  Il robot si reca nell'angolo più vicino e inizia un movimento oscillatorio
  a "L". Durante le oscillazioni controlla se è rimasto un solo avversario e, in
  tal caso lo aggredisce con la routine offensiva del 4vs4. Intorno ai 180000 cicli
  virtuali attacca comunque. Il controllo del numero di avversari non e' molto accurato,
  poiche' viene fatto in piu' passaggi, e qualche volta Bruenor parte all'attacco contro
  2 avversari.

OSCILLAZIONI:

  Il movimento nell'angolo e' alla base della strategia del 4vs4. Il robot esegue 2 
  oscillazioni in orizzontale e in verticale mantenendosi il piu' possibile vicino
  all'angolo (al limite dell'autolesionismo) controllando che la velocità rimanga 
  elevata anche nei cambi di direzione e sparando in fase di frenata nei punti di
  massimo avvicinamento contro gli avversari e in prossimità dell'angolo.
  Durante le oscillazioni si controlla il numero degli avversari con una funzione 
  non troppo precisa a causa del movimento stesso e del frazionamento della 
  scansione completa in piu' chiamate alla stessa funzione (Radar). Se rimane un
  solo avversario Bruenor attacca indipendentemente dal danno subito (la migliore 
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
    3) Fino alla fine del match viene descritto un quadrato al centro dell'arena.
       

*/


int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd;
int rd,ren;
int timer;

main()
{
  xd=180*(xs=loc_x(yd=90+180*(ys=(loc_y(en=3))>499))>499);
  
  while(en>1) {
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


    while (loc_x()<509) Mithryl(0);
    while (loc_y()<509) Mithryl(90);
    while (loc_x()>492) Mithryl(180);
    while (loc_y()>492) Mithryl(270);  
    
  
  dam=damage();
  while(damage()<dam+10) { 
    dir=deg+45; t=12;
    dam=damage(); 
    while (--t) Mithryl(dir);
    dir+=180;	t=12;    
    while (--t) Mithryl(dir);
    dir=deg+315; t=12;
    while (--t) Mithryl(dir);
    dir+=180;	t=12;
    while (--t) Mithryl(dir);
  }

  while(1) {
      while (loc_x()<500) Mithryl(0);
      Fire(drive(90,0)); 
      while (loc_y()<500) Mithryl(90);
      Fire(drive(180,0)); 
      while (loc_x()>499) Mithryl(180);
      Fire(drive(270,0));     
      while (loc_y()>499) Mithryl(270);
      Fire(drive(0,0)); 
  }


}


Fire()
{
  if (orng=scan(odeg=deg,10))
  {    

    if (scan(deg+350,10)) deg+=355; else deg+=5;
    if (scan(deg+350,10)) deg+=357; else deg+=3; 
    
    cannon(deg+deg-odeg,(scan(deg,10)<<1)-orng); 

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

  if (++timer>355) en=1;
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
    en=ren;
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
  if (orng=scan(deg,10))
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

Mithryl(Hall) { Fire(drive(Hall,100)); }
