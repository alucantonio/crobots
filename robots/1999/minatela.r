/*

 CROBOT : MINATELA.R

 Autore : Matteo Greco

Il robottino si reca all'inizio all'angolino piu' vicino. Rimane fermo finchŠ
qualcuno non si avvicina o lo attacca. Se vede ad un angolo adiacente un
robottino pressocchŠ statico lo attacca. Se si rende conto che Š rimasto
un solo crobot nell'arena lo attacca con una procedura di attacco finale che
porta il robottino a 135 gradi circa rispetto all'avversario con una sequenza
di oscillazioni verticali ed orizzontali alternate.
Il codice Š simile a quello dei robottini di AinTz da cui ho tratto spudorata-
mente ispirazione. Grazie AinTz.
Non ho avuto tempo per ottimizzare codice e parametri del robottino ma l'anno
prossimo.... eheheh!!!

*/


int cambio,oldang,range,ang,dir,oldrng,attacco;
int destra,sopra;

/* procedura principale */

main(){
  int danni,clock,flag;
  updw(sxdx());
  avvicina(90+180*sopra);
  while(1){
    danni=damage();
    while ((damage()==danni) && ((!oldrng) || (oldrng>450))) { 
      serpiko(1); 
      if (cambio>10) {    /* radar conteggio superstiti */
        ang=712-180*sopra+90*(sopra^destra);
        cambio=(flag=24); 
        while(flag && (cambio>20))
          if (scan(ang+15*((--flag)%8),7)) --cambio;  
        if (cambio/=21) { while (drive(dir,100)) {
              serpiko(); /* attacco finale */
              if (loc_y()>700) frena(270);
              else if (loc_y()<300) frena(90);
                   else if (loc_x()>700) frena(180);
                        else if (loc_x()<300) frena();
                             else frena(ang+135+90*(clock^=1));
            }
        } else avvicina((180*sopra+90*(destra^sopra)+90*(clock^=1))%360);
      }  
    }
    dir=(180*sopra+90*(destra^sopra)+90*((scan(dir+8,10))>(scan(dir+82,10))))%360;
    if ((dir==90) || (dir==270)) updw(1); else sxdx(1);
  }
}

/* oscillazione ed attacco */

avvicina(strab){
  ++attacco;
  serpiko(ang=strab);
  if ((oldang==ang) && (oldrng==range)) {
    while ((oldrng>720) && oldrng) { 
      serpiko(ang=strab); 
      drive(strab,100); 
    }
    drive();
    while (speed()>50) serpiko(1);
    updw();
    sxdx();
  }
  strab=(strab+180)%360;
  if ((strab==90) || (strab==270)) 
    while ((loc_y()>20) && (loc_y()<980)) serpiko(drive(strab,50));
  else 
    while ((loc_x()>20) && (loc_x()<980)) serpiko(drive(strab,50));
  drive(strab+180,0);
  --attacco;
}

/* cambio angolino in verticale */

updw(inv){
  if (((dir=90+180*(loc_y()<500)+180*inv)%360)==90) {
    drive(90,100);
    while (loc_y()<840) serpiko();
    drive(270,0);
  } else {
    drive(270,100);
    while (loc_y()>160) serpiko();
    drive(90,0);
  }
  while (speed()>50) ;
  return (sopra=(loc_y()>500));
}

/* cambio angolino in orizzontale */

sxdx(inv){
  if (((dir=180*(loc_x()<500)+180*inv))%360) {
    drive(180,100);
    while (loc_x()>160) serpiko();
    drive();
  } else {
    drive(0,100);
    while (loc_x()<840) serpiko();
    drive(180,0);
  }  
  destra=(loc_x()>500);
  while (speed()>50) ; 
  return inv;
}

/* frenata - attacco finale */

frena(newdir) {                     
  drive(newdir,0);
  while (speed()>50) {
    if (oldrng=scan(ang,10)) {
      if (range=scan((ang=(6*(scan((ang+=(10*(scan((oldang=ang)+10,10)>0)-5))+10,10)>0)-3)+ang),10))
        cannon(ang+(ang-oldang),range+(range-oldrng)*2);
    }
  }
  return (drive((dir=newdir),100));
}

/* procedura di sparo preciso */

serpiko(fermo) {
  if (oldrng=scan(ang,10));
  else if (oldrng=scan(ang-=21,10));
  else if (oldrng=scan(ang+=42,10));
  else return (ang+=42);
  if (oldrng>735) { ang+=42; return ++cambio; }
  if (scan(ang-=5,5)); else ang+=10;
  if (scan(ang+5,2)) ang+=5; if (scan(ang-5,2)) ang-=5;
  if (scan(ang+3,1)) ang+=3; if (scan(ang-3,1)) ang-=3;
  if (scan(ang+1,1)) ang+=1; if (scan(ang-1,1)) ang-=1;
  if (oldrng=scan(oldang=ang,5)) {
    if (scan(ang+5,2)) ang+=5; if (scan(ang-5,2)) ang-=5;
    if (scan(ang+3,1)) ang+=3; if (scan(ang-3,1)) ang-=3;
    if (scan(ang+1,1)) ang+=1; if (scan(ang-1,1)) ang-=1;  
    if (range=scan(ang,10))
      if (fermo)
        return cannon(ang+(ang-oldang)*((1200+range)>>9),range*172/(172+oldrng-range));
      else
        return cannon(ang+(ang-oldang)*((1200+range)>>9)-(sin(ang-dir)>>14),
                      range*172/(172+oldrng-range-(cos(ang-dir)>>12)));
  }
}
