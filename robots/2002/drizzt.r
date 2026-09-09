/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2002)                                 */
/*                                                                          */
/*  CROBOT: Drizzt.r                                                        */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/


/*

STORIA:


"Nelle viscere della terra, dimora dei malvagi elfi scuri, dove il buio regna sovrano e dimorano creature mostruose, vive il principe Drizzt Do'Urden, deciso a non piegarsi ai voleri degli elfi.
Quegli esseri immondi vorrebbero che il giovane principe rinunciasse alla sua integrità degradandosi al pari di tutte le creature del mondo sotterraneo.
Drizzt ha dunque l'animo lacerato da un dilemma: può vivere  in un mondo che rifiuta la sua probità e dove immondi esseri non gli concederanno tregua finchè non avrà rinunciato alle sue nobili doti?
Può fuggire da Menzoberranzan, abbandonare il sottosuolo per unirsi agli abitanti della superficie, rinnegando così per sempre l'intera sua stirpe?

Il dilemma di Drizzt si è risolto: il giovane drow abbandonerà il sottosuolo e rinnegherà l'intera sua stirpe. Soltanto così potrà assaporare il gusto della libertà, sottrarsi al giogo dei suoi malvagi simili e alle leggi meschine dei Buio Profondo.
Accompagnato dalla magica pantera Guenhwyvar, Drizzt si lascia alle spalle Menzoberranzan per penetrare quel dedalo oscuro di sotterranee gallerie che via via conducono alla luce del sole.
Ma per il principe drow la fuga si profila più ardua del previsto. Gli elfi scuri non dimenticano facilmente i torti subiti e un vile tradimento come quello attuato da Drizzt merita vendetta.
Determinati a ritrovarlo e a condurlo, anche morto, nella buia città dove è nato, gli elfi sono già sulle sue tracce: un drappello di esseri feroci contro un drow solo, la cui unica ma somma colpa scaturì un giorno da un limpido desiderio di giustizia.

Astuzia e coraggio hanno già aiutato Drizzt ad abbandonare il mondo delle tenebre; ora che non è più una creatura delle viscere della terra, Drizzt non ha rimpianti per aver rinnegato le proprie origini nè ha nostalgia dell'eterna notte del Buio Profondo.
Desidererebbe stringere amicizia con gli abitanti della superficie, far capire loro che ha scelto di vivere alla luce del sole, ma, ahimè, come non fu facile impresa sottrarsi all'ira funesta dei suoi simili, così ora è arduo farsi accettare da quella gente che gli elfi scuri teme, peggio, aborrisce, e che alla vista di uno di loro prova un moto di repulsione, fugge per paura di rimanere vittima di qualche orrendo incantesimo.
A nulla sembrano valere le dichiarazioni di pace da parte di Drizzt, i suoi miti atteggiamenti, quel suo allargare le braccia e sorridere di fronte alla spada sguainata di chi in lui vede un avversario da combattare. E' ancora guerra per l'elfo scuro?
Esiliato, sempre più solo, questa volta il principe drow si ritrova coinvolto in un'estrema battaglia che sperava di non dover mai combattere...

Un fluire inarrestabile di avventure e di battaglie fra i signori del male e le vittime dei loro perfidi sortilegi si svolge nel mondo incantato della Valle del Vento Ghiacciato.
In questa landa inospitale le leggi naturali sono sovvertite dalla inarrestabile forza di Crenshinibon, una reliquia stregata di trasparente cristallo. Un apprendista stregone, Akar Kessell, s'impossessa del prezioso cimelio e, assetato di potere, trama piani di conquista e vendetta. 
Intanto le tribù dei barbari, da sempre divise da antiche gelosie, si coalizzano per espugnare Ten-Towns.
L'efferato attacco alle città segna il loro destino e la sorte di Wulfgar, un giovane barbaro liberato dal nano Bruenor e costretto, in cambio, a prestargli servizio. Con l'aiuto di Drizzt, Bruenor trasforma Wulfgar in un valoroso guerriero, destinato a pacificare le indomite tribù barbare.
Riusciranno l'elfo e il nano a convincere gli abitanti di Ten-Towns a dimenticare i vecchi dissapori per conquistare Cryshal-Tirith, la roccaforte di Kessell, e neutralizzare la magica reliquia di cristallo?" 

Estorta a Drizzt la promessa di accompagnarlo alla riconquista della sua patria perduta, Bruenor si mette in marcia con l'elfo, Regis e Wulfgar. Ciò che i tre non sanno è che Artemis Entreri, sicario agli ordini del Pasha Pook, è già alle loro calagna con un prezioso ostaggio: la bella e valorosa Cattie-brie. Ma Entreri non è l'unico sulle tracce del gruppo: attritato dal potere della reliquia di cristallo, Morkai il Pezzato della torre della stregoneria di Luskan stringe un alleanza con l'assassino. 
Le difficoltà non sembrano dunque essere poco per Drizzt e i suoi amici che dovranno affrontare terre desolate e pericolose con il fiato nei nemici sempre sul collo in una ricerca che si preannuncia al limite dell'impossibile."


Ce la faranno i nostri amici a riconquistare le mitiche Mithril Hall?


Un ringraziamento a R.A. Salvarore, autore degli splendidi romanzi da cui ho ripreso i nomi dei protagonisti e li ho utilizzati per i robottini di quest'anno.


SCHEDA TECNICA:
  
  All'inizio del match Drizzt esegue un controllo (Radar1) per verificare se si tratta di
  un incontro f2f, in tal caso adotta immediatamente la routine offensiva di f2f.
  Il robot si reca quindi nell'angolo più vicino e inizia un movimento oscillatorio
  a "L". Durante le oscillazioni controlla se è rimasto un solo avversario e, in
  tal caso lo aggredisce con la routine offensiva del 4vs4. Intorno ai 160000 cicli
  virtuali attacca comunque se i danni subiti sono minori del 60% e verso i 180000 
  cicli se i danni subiti sono minori del 80%. Il controllo del numero di avversari
  non e' molto accurato, poiche' viene fatto in piu' passaggi, e qualche volta Drizzt
  parte all'attacco contro 2 avversari.

OSCILLAZIONI:

  Il movimento nell'angolo e' alla base della strategia del 4vs4. Il robot esegue 2 
  oscillazioni in orizzontale e in verticale mantenendosi il piu' possibile vicino
  all'angolo (al limite dell'autolesionismo) controllando che la velocità rimanga 
  elevata anche nei cambi di direzione e sparando in fase di frenata nei punti di
  massimo avvicinamento contro gli avversari e in prossimità dell'angolo.
  Durante le oscillazioni si controlla il numero degli avversari con una funzione 
  non troppo precisa a causa del movimento stesso e del frazionamento della 
  scansione completa in piu' chiamate alla stessa funzione (Radar). Se rimane un
  solo avversario Drizzt attacca indipendentemente dal danno subito (la migliore 
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

ROUTINE OFFENSIVA DEL 4vs4:
  
  La routine offensiva del 4vs4 funziona in questo modo:
    
    1) Il robot si porta al centro dell'arena;
    2) Finche non si subisce un danno maggiore del 10% si esegue un'oscillazione
       media in direzione del nemico puntato dalla routine di fuoco prima con uno
       sfasamento di +45 gradi e poi di -45 gradi;
    3) Fino alla fine del match viene descritto un quadrato al centro dell'arena:
       il quadrato e' minimo se il robot avversario si trova a una distanza 
       maggiore di 300, altrimenti si allarga di circa 200 unità. Questa scelta
       serve a rendere difficile il puntamento ai robot vicini.

ROUTINE OFFENSIVA DEL 2vs2:
  
  Nonostante questa routine abbia prestazioni inferiori alla precedente, ho voluto
  utilizzarla comunque per diversi motivi:
    
    1) Mi piace il movimento che descrive;
    2) Mediamente esegue oscillazioni piu' ampie e quindi spero che regga meglio
       contro i robot di quest'anno che non credo utilizzeranno toxiche;
    3) Vorrei provare 2 routine distinte per il f2f dal momento che ho 2 robot a 
       disposizione.
  
  Per contro spero di non perdere terreno con Drizzt per l'utilizzo di questa 
  routine (potevo anche mantenere la stessa del 4vs4 che utilizza anche Wulfgar nel 
  f2f), ma d'altra parte non potevo inserirla in Wulfgar per mancanza di codice.
    
  La routine offensiva del f2f funziona in questo modo:
    
    1) Il robot descrive un grosso quadrato con x e y che variano da 300 a 700;
    2) I lati del grosso quadrato non vengono percorsi linearmente, ma tramite quadrati
       piu' piccoli che seguono la traiettoria prestabilita;       
  
*/

int deg,rng,dir,odeg,orng,dam,t;
int xs,ys,en,xd,yd,dd,x,y,dd2;
int rd,ren;
int timer;

main()
{

if (Radar1()) {

  /* Raggiungi l'angolo piu' vicino e calcola alcuni parametri: */

  xs=loc_x()>499;  
  if (xs) while (loc_x()<900) Fire(drive(0,100)); else while (loc_x()>100) Fire(drive(180,100)); 
  ys=loc_y()>499;
  if (ys) while (loc_y()<880) Fire(drive(90,100)); else while (loc_y()>120) Fire(drive(270,100));
  
  xd=180*xs;
  yd=90+180*ys;
  Stop(90);
  en=3;
  
  /* Oscilla nell'angolo:  */

  while(en>1) {
    if (xs) {
      Run(180); while (loc_x()>945) LookX(); Stop(180);
      Run(0);   while (loc_x()<950) Radar(); Stop(0);
    } else {
      Run(0);   while (loc_x()<55)  LookX(); Stop(0);
      Run(180); while (loc_x()>50)  Radar(); Stop(180);
    }
    if (ys) {
      Run(270); while (loc_y()>945) LookY(); Stop(270);
      Run(90);  while (loc_y()<950) Radar(); Stop(90);
    } else {
      Run(90);  while (loc_y()<55)  LookY(); Stop(90);
      Run(270); while (loc_y()>50) Radar();  Stop(270);
    }
  }
  

  /* Routine offensiva di 4vs4: */
  
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
    if (orng>300) {
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
  /* Routine offensiva di f2f: */
  while (1) {
  
  while(loc_x()<700) { 
    x=loc_x();
    while(loc_x()<x+120) Fire(drive(0,100));
      Fire(drive(90,0)); 
    while (loc_y()<320) Fire(drive(90,100));
      Fire(drive(180,0)); 
    while (loc_x()>x+150) Fire(drive(180,100));
      Fire(drive(270,0)); 
    while (loc_y()>300) Fire(drive(270,100));      
      Fire(drive(0,0)); 
  }
  while(loc_y()<700) { 
    y=loc_y();
    while(loc_y()<y+120) Fire(drive(90,100));
      Fire(drive(180,0)); 
    while (loc_x()>680) Fire(drive(180,100));
      Fire(drive(270,0)); 
    while (loc_y()>y+150) Fire(drive(270,100));
      Fire(drive(0,0)); 
    while (loc_x()<700) Fire(drive(0,100));      
      Fire(drive(180,0)); 
  }
  while(loc_x()>300) { 
    x=loc_x();
    while(loc_x()>x-120) Fire(drive(180,100));
      Fire(drive(270,0)); 
    while (loc_y()>680) Fire(drive(270,100));
      Fire(drive(0,0)); 
    while (loc_x()<x-150) Fire(drive(0,100));
      Fire(drive(90,0)); 
    while (loc_y()<700) Fire(drive(90,100));      
      Fire(drive(180,0)); 
  }
  while(loc_y()>300) { 
    y=loc_y();
    while(loc_y()>y-120) Fire(drive(270,100));
      Fire(drive(0,0)); 
    while (loc_x()<320) Fire(drive(0,100));
      Fire(drive(90,0)); 
    while (loc_y()<y-150) Fire(drive(90,100));
      Fire(drive(180,0)); 
    while (loc_x()>300) Fire(drive(180,100));      
      Fire(drive(270,0)); 
  }
  
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
{
  if (dd=scan(xd,10)) {
    if (dd<scan(yd,10)) deg=xd; else deg=yd; 
  } else deg=yd;
  if (++timer>315)  if (timer>365) { if (damage()<80) en=1; } else if (damage()<60) en=1; 
}

LookY()
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
  if (rng=scan(odeg=deg,10))
  {    

    if (scan(deg+350,10)) deg+=357; else deg+=3;
    if (scan(deg+350,10)) deg+=358; else deg+=2; 
    
    cannon(deg,(scan(deg,10)<<1)-rng); 

  }   
  else if (rng=scan(deg+=340,10)) cannon(deg,rng);
  else if (rng=scan(deg+=40,10))  cannon(deg,rng);
  else if (rng=scan(xd,10)) cannon(xd,rng);
  else if (rng=scan(yd,10)) cannon(yd,rng);
  else if (rng=scan(deg+=300,10)) cannon(deg,rng);
  else if (rng=scan(deg+=80,10))  cannon(deg,rng); 
  	
  while(speed()>59) drive(d,0);	
}


Radar1()
{
  while (dir<=360) if (scan(dir+=20,10)) { if (++en>1) return 1; else Fire(deg=dir); }
  return 0;
}
