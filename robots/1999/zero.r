/****************************************************************************
/*                                                                          *
/*  Y 2 K - C r o b o t s  T o u r n a m e n t                              *
/*                                                                          *
/*  CROBOT: ZERO.R                                                          *
/*                                                                          *
/*  AUTORE: GianMarco Candido                                               *
/*                                                                          *
/****************************************************************************

 Tattica
---------

Il robottino si porta nella parte sinistra dell'arena ed inizia ad oscillare
orizzontalmente al centro della parete verticale.
Appena si libera un angolino vicino a lui lo raggiunge con un movimento "a
triangolo" (da cui il nome del crobot: Renato Zero... "il triangolo no, non
l'avevo considerato!").
Raggiunto torna alla posizione di partenza e ripete il movimento.
Se si rende conto di essere rimasto da solo nell'arena tenta una attacco
finale (routine presa dal crobot KakakaTz e iLbEsTiO di AinTz).
La procedura di scansione dell'arena deriva dal crobot Dario di Dario (appun-
to!).
"Zero" usa due routine di fuoco: una precisa ed una veloce.

*/

int oldang,range,ang,dir,oldrng,flag,cambio;

main(){
  int cont,radeg,radar;
  sx();
  if (loc_y()>500) dw(); else up();
  ang=90+180*(loc_y()<5(cambio=500));
  while(1){
    if (cambio>6) {
        cont=9; radeg=-10; radar=0;                                  
        while ((radeg+=20)!=710) if (scan(radeg,10)) ++radar;
        if ((radar<3) || ((radar<4))){
          attacco=(flag=5);
          while(drive (dir,100)){ 
            serpiko();       
            if (loc_x()>700) frena(180); 
              else if (loc_x()<300) frena(0); 
                   else if (loc_y()>700) frena(270); 
                        else if (loc_y()<300) frena(90);
                            else frena(deg+135);
          }
        }
      cambio=0;
    }
    sx();
    if (scan(291,10)+scan(312,10)) dx();
    else {
      while((loc_x()<930) && (loc_y()>70)) {
        drive(301,100);
        rambo();
      }
      drive();
      while (speed()) rambo();
      up();
    }
    sx();
    if (scan(49,10)+scan(70,10)) dx();
    else {
      while((loc_x()<930) && (loc_y()<930)) {
        drive(59,100);
        rambo();
      }
      drive();
      while (speed()) rambo();
      dw();
    }
  }  
}

sx(){
  dir=180;
  while (loc_x()>780) {
    drive(180,100);
    rambo();
  }
  drive();
  while (speed()) rambo();
}

dx(){
  dir=0;
  while (loc_x()<920) {
    drive(0,100);
    rambo();
  }
  drive();
  while (speed()) rambo();
}

up(){
  dir=90;
  while (loc_y()<470) {
    drive(90,100);
    serpiko();
  }
  drive();
  while (speed()) rambo();
}

dw(){
  dir=270;
  while (loc_y()>530) {
    drive(270,100);
    serpiko();
  }
  drive();
  while (speed()) rambo();
}

serpiko() { /*sparo preciso*/
  if (oldrng=scan(ang,10));
  else if (oldrng=scan(ang+=21,10));
  else if (oldrng=scan(ang-=42,10));
  else return (ang+=82);
  if (oldrng<120) return (cannon(ang,oldrng));
  else if (oldrng>735) return ang+=82;
  if (scan(ang-=5,5)); else ang+=10;
  if (scan(ang+5,2)) ang+=5; if (scan(ang-5,2)) ang-=5;
  if (scan(ang+3,1)) ang+=3; if (scan(ang-3,1)) ang-=3;
  if (scan(ang+1,1)) ang+=1; if (scan(ang-1,1)) ang-=1;
  if (oldrng=scan(oldang=ang,5)) {
    if (scan(ang+5,2)) ang+=5; if (scan(ang-5,2)) ang-=5;
    if (scan(ang+3,1)) ang+=3; if (scan(ang-3,1)) ang-=3;
    if (scan(ang+1,1)) ang+=1; if (scan(ang-1,1)) ang-=1;  
    if (range=scan(ang,10))
        return cannon(ang+(ang-oldang)*((1200+range)>>9)-(sin(ang-dir)>>14),
                      range*172/(172+oldrng-range-(cos(ang-dir)>>12)));
  }
}

rambo(){ /* sparo veloce */
  if ((range=scan(ang,10))) ;
  else if ((range=scan(ang+=21,10))) ;
    else if ((range=scan(ang-=42,10))) ;
      else return ang+=82;
  if (range>735) return ang+=82;
  if (scan((oldang=ang)+10,10)) ang+=10; else ang-=10;
  if (scan(ang+5,5)) ang+=5; else ang-=5;
  if ((oldrng=scan(ang,10))) 
    return cannon(ang+(ang-oldang),oldrng+(oldrng-range)*2);
}

frena(newdir){ /* frenata con sparo veloce e riaccelerata */
  drive(dir=newdir,0);
  while (speed()>50) {
    if (oldrng=scan(ang,10)) {
      if (range=scan((ang=(6*(scan((ang+=(10*(scan((oldang=ang)+10,10)>0)-5))+10,10)>0)-3)+ang),10))
        cannon(ang+(ang-oldang),range+(range-oldrng)*2);
    }
  }
  return (drive(dir,100));
}

/* by GianMa - 1999 */
