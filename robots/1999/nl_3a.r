/* nome del Crobot:                  NL                                      */
/* versione:                        3.00  A                                  */
/* data finale di realizzazione:    26/11/99                                 */
/*                                                                           */
/* dati dell'autore:                                                         */
/*               Tognon Stefano                                              */
/*                                                                           */
/* strategia:                                                                */
/* Il crobots si basa su goblin.r cercando di utilizzare i suoi punti di     */
/* forza. Purtroppo la limitazione di 1000 sul codice ha impedito di attuare */
/* tutte le idee e il risultato non è propriamente quello voluto.            */
/*                                                                           */
/* Il crobots si sposta nell'angolo più vicino e vi rimane finchè non subisce*/
/* danni. A questo punto cerca in modo preciso che un' angolo sia libero e vi*/
/* si porta. Nel caso nessun angolo adiacente sia libero (e qui iniziano le  */
/* limitazioni dovute al codice troppo lungo) dovrebbe spostarsi in una zona */
/* sicura. In realtà il robot si sposta fino a metà lato e poi ritorna       */
/* indietro sperando che il pericolo sia passato.                            */
/* Notate che un punto di forza di goblin è proprio questo: starsene in un   */
/* angolo aspettando che gli altri si scannano e fuggire in caso qualcuno lo */
/* minacci.                                                                  */
/* Noterete che la routine di fuoco è la stessa di goblin, salvo qualche     */
/* modifica per ridurne il codice.                                           */
/* A questo punto il robot è identico a goblin: se rimane un solo concorrente*/
/* lo attacco con la stessa strategia (n.b. il finale di goblin è uno dei    */
/* migliori del panorama attuale).                                           */
/* L'unico tocco perdonale è quello di passare alla fase finale se stiamo per*/
/* raggiungere la fine del tempo simulato. Infatti un punto debole di goblin */
/* è quello di incorrere in patte se gli altri robot hanno un comportamento  */
/* simile (se ne stanno fermi in un angolo o si muovono in una zona limitata */
/* del campo) aspettando che rimanga un solo avversario.                     */
/*                                                                           */
/* nota personale:                                                           */
/* devo dire che dalla mia ultima apparizione (93) i progressi nella         */
/* crobotica sono stati straordinari. Purtroppo sono fuori allenamento:      */
/* questo crobots non è il massimo (è troppo lento nel scegliere la via senza*/
/* nemici e rischia di essere colpino prima di azionare i motori).           */


int rng,orng,dir,deg,odeg,flag,q,t;

int temp1,temp2,temp3,dam;

int cycle;
int strat; /* strategia attuale: angolo: 0=dxup 1=sxup 3=sxdn 2=dxdn */

main() {
  strat=0;
  cycle=3300;   /* cicli di attesa */
  if (loc_x()<500) {sx(100); ++strat;} else dx(900);
  if (loc_y()<500) {dw(100); strat+=2;} else up(900);

  while (1) {
    dam=damage();
    while ((damage()<(dam+4))&(--cycle>=0))
      Fire(1);
   
    if (strat==0) strat=StDxUp();            /* scegli la strategia */
    else if (strat==1) strat=StSxUp();
         else if (strat==3) strat=StSxDn();
              else strat=StDxDn();

    /* radar */
    deg=-10;
    t=0;
    while((deg+=20)!=710) if (scan(deg,10)) ++t;

    if ((t<3) | (--cycle<=0)) {        /* E' ora di attaccare ? */
       Stop();
       while(1) {
         diag();
         Stop();
       }
    }
  }    
}

up(l) { dir=90;  while(loc_y()<l) { drive(90,100);  Fire(); } drive(270,0); }
dw(l) { dir=270; while(loc_y()>l) { drive(270,100); Fire(); } drive(90,0);  }
dx(l) { dir=0;   while(loc_x()<l) { drive(0,100);   Fire(); } drive(180,0); }
sx(l) { dir=180; while(loc_x()>l) { drive(180,100); Fire(); } drive(0,0);   }

/* Calcola le distanze dai bersagli negli angoli (e lati) */
dist(ang) {
  temp1=scan(ang,10)+scan(ang+20,10);
  temp2=scan(ang+60,10)+scan(ang+80,10);
}

int StDxUp() {
  dist(185);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    sx(100);
    return 1;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dw(100);
    return 2;
  }
  if (temp1<temp2) {   /* vado dove c'è più distanza  */
    dw(600);
    up(900);
  } else {
      sx(600);
      dx(900);
    }
  return 0;
}

int StSxUp() {
  dist(275);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dw(100);
    return 3;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dx(900);
    return 0;
  }
  if (temp1<temp2) {   /* vado dove c'è più distanza */
    dx(400);
    sx(100);
  } else {
      dw(600);
      up(900);
    }  
  return 1;
}

int StSxDn() {
  dist(5);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    dx(900);
    return 2;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    up(900);
    return 1;
  }
/*  if (temp1<temp2)*/ {   /* oops: codice finito! */
    up(400);
    dw(100);
  }/* else {
      dx(400);
      sx(100);
    }*/
  return 3;
}

int StDxDn() {
  dist(85);
  if (temp1==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    up(900);
    return 0;
  }
  if (temp2==0) {   /* Se non c'è nessuno vicino all'angolo, ci vado*/
    sx(100);
    return 3;
  }
/*  if (temp1>temp2) {*/   /* oops: codice finito */
    sx(600);
    dx(900);
/*  } else {
      up(400);
      dw(100);
    }*/
  return 2;
}

Stop()
{
  if (loc_x()<500)
    if (loc_y()<500) q=0;
    else q=3;
  else if (loc_y()<500) q=1;
       else q=2;
  dir=45+90*q;
  drive(dir,0);
}

diag()
{
  while ((loc_x()<450) || (loc_x()>550)) {
    drive(dir,100);
    Fire();
  }

  if ((scan(dir-10,10)) || (scan(dir+10,10))) {
    if ((scan(dir-80,10)) || (scan(dir-100,10))) {
      dir+=90; drive(dir);
    } else {
        dir-=90; drive(dir);
      }
  }

  while ((loc_x()<850) && (loc_x()>150) &&
        (loc_y()<850) && (loc_y()>150)) {
    drive(dir,100);
    Fire();
  }
  Stop();
}

/* Routine necessaria per ridurre lo spazio occupato dal programma*/
calc() {
  if(scan(deg-5,1)) deg-=5;
  if(scan(deg+5,1)) deg+=5;
  if(scan(deg-3,1)) deg-=3;
  if(scan(deg+3,1)) deg+=3;
  if(scan(deg-1,1)) deg-=1;
  if(scan(deg+1,1)) deg+=1;
}

Fire(flag)
{
  if (orng=scan(deg,10)) {
    if (!scan(deg-=5,5)) deg+=10;
     if (orng>700) {
       if (!scan(deg-=3,3)) deg+=6;
         cannon(deg,orng); deg+=40; return;
     }

    calc();

    if (orng=scan(odeg=deg,5)) {
      calc();

      if (rng=scan(deg,10)) {
        temp3=deg+(deg-odeg)*((1200+rng)>>9); /* diminuisce codice*/
        if (flag) {
          cannon(temp3, rng*160/(160+orng-rng));
        } else {
            cannon(temp3-(sin(deg-dir)>>14),
                         rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
          }
      }
    }
  } else {
      if (scan(deg-=20,10)) return;
      if (scan(deg+=40,10)) return;
      deg+=40; 
   }
}

