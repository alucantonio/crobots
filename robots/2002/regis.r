/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2002)                                 */
/*                                                                          */
/*  CROBOT: Regis.r                                                         */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
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
  poiche' viene fatto in piu' passaggi, e qualche volta Regis parte all'attacco contro
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
  solo avversario Regis attacca indipendentemente dal danno subito (la migliore 
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
    4) Non viene mai perso il nemico puntato (nel 4vs4 tale operazione e gestita dalla
       funzione Stop) con controlli tipo "if (rgn>700)...".
    5) La routine di fuoco del 4vs4 esegue correzioni minori sull'angolo poichè si
       suppone che gli avversari siano piu' lontani e che si mantengano nelle
       vicinanze degli angoli.

ROUTINE OFFENSIVA:
  
  La routine offensiva del 4vs4 funziona in questo modo:
    
    1) Fino alla fine del match viene descritto un quadrato al centro dell'arena.
       

*/
int deg,rng,odeg,t,xs,ys,en,rd,ren,timer,sc1,sc2,ff,f;

main()
{
  xs=loc_x(ys=(loc_y(sc1=en=3))>499)>499;
  sc2=2;  
  
  while(en>1) {
    if (xs) {
      Run(180); while (loc_x()>935) ; Stop(180);
      Run();   while (loc_x()<936) Radar(); Stop();
    } else {
      Run();   while (loc_x()<65) ; Stop();
      Run(180); while (loc_x()>64) Radar(); Stop(180);
    } 
    if (ys) {
      Run(270); while (loc_y()>935) ; Stop(270);
      Run(90);  while (loc_y()<936) Radar(); Stop(90);
    } else {
      Run(90);  while (loc_y()<65) ; Stop(90);
      Run(270); while (loc_y()>64) Radar(); Stop(270);
    }
  }
 sc1=5; sc2=3;  ff=1; 

 while(1) {
      while (loc_x()<505) PendoloMagico();
      Fire(drive(90,0));  
      while (loc_y()<505) PendoloMagico(90);
      Fire(drive(180,0)); 
      while (loc_x()>495) PendoloMagico(180);
      Fire(drive(270,0));     
      while (loc_y()>495) PendoloMagico(270);
      Fire(drive(0,0)); 
  }


}


Fire()
{
  if (rng=scan(odeg=deg,10))
  {    
    if (scan(deg+350,10)) deg-=sc1; else deg+=sc1;
    if (scan(deg+350,10)) deg-=sc2; else deg+=sc2; 
    cannon(deg+(deg-odeg)*ff,(scan(deg,10)<<1)-rng); 
  } else {
        while (!(rng=(scan(deg+=20,10)))) ; cannon(deg,rng);
/*        if (rng=scan(deg+=340,10)) return cannon(deg,rng);
        if (rng=scan(deg+=40,10))  return cannon(deg,rng);
        deg+=40;  */
  }
}

Run(d) { while(speed()<70) drive(d,100); }

Radar() {
  if (rd==380) { en=ren; rd=ren=0; } else { if (scan(rd+=20,10)) ren+=1; } 
}

Stop(d) { 
  if (++timer>675) en=1;  
  if (scan(f+=90,10)) deg=f;  
  drive(d,0); 
  Fire(); 
  while(speed()>59) drive(d,0); 
}

PendoloMagico(rosso) { Fire(drive(rosso,100)); }
