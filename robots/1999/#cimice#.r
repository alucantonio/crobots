/****************************************************************************
/*                                                                          *
/*  Y 2 K - C r o b o t s  T o u r n a m e n t                              *
/*                                                                          *
/*  CROBOT: CIMICE.R                                                        *
/*                                                                          *
/*  AUTORE: Sandro Zacchino                                                 *
/*                                                                          *
/****************************************************************************

Tattica :

Questa robottina e' molto semplice: si reca al lato ed inizia ad oscillare
in verticale ... sperando di poter approfittare del bug sull'angolo zero alme-
no nei casi in cui inizia a giocare a destra.
Essendo questa una robottina vibrante e' senza dubbio una femminuccia (avete
mai visto un maschiaccio vibrare?) per cui ho deciso di chiamarla Cimice.
Le routine di fuoco sono prese dai mitici Goblin e Goldrake (torneo 1998).
Il movimento e' davvero molto semplice.
L'unica accortezza e' quella di non avvicinarmi troppo ad un nemico in un
angolino.

*/

int dist,ang,oldang,range,oldrange,dir;
int attacco,flag,cambio,clock;

main() {
  ang=501;
  if (loc_x()>500) while (loc_x()<850) preciso(drive(dir,180));
  else { dir=180; while (loc_x()>150) preciso(drive(dir,180)); }
  while(dir=270) {
    drive(dir,100);
    dist=((scan(260,10)+scan(280,10))>0)*300;
    while(loc_y()>(150+dist)) preciso(drive(270,100));
    veloce(drive(dir=90,0));
    drive(dir=90,100);
    dist=((scan(80,10)+scan(100,10))>0)*300;
    while(loc_y()<(850-dist)) preciso(drive(90,100));
    veloce(drive(270,0));
    if (++cambio>2) {
      ang=712-180*(loc_y()>500)+90*((loc_y()>500)^(loc_x()>500));
      cambio=(flag=24); 
      while(flag && (cambio>20)) if (scan(ang+15*((--flag)%8),7)) --cambio;
      if (cambio/=21) {
        attacco=(flag=5);
        while (drive(dir,100)) {
          preciso();
          if (--flag) 
            if (loc_y()>700) frena(270); 
            else if (loc_y()<300) frena(90);
                 else if (loc_x()>700) frena(180); 
                      else if (loc_x()<300) frena();
          else frena(ang+135+90*(clock^=1));
        } 
      }
    }
  }
}

frena(ndir){
  drive(dir=ndir,0);
  veloce();
  return (drive(dir,100));
}

veloce() {                     
  while (speed()>50) {
  if (!(range=scan(ang,10)))
    if (!(range=scan(ang-=20,10)))
      if (!(range=scan(ang+=40,10)))
        return ang+=40;
  oldang=ang;
  if (!scan(ang+=5,5)) ang-=10;
  if (!scan(ang+=3,3)) ang-=6;
  if ((oldrange=scan(ang,10)))
    cannon(ang+(ang-oldang),oldrange+(oldrange-range)*2);
  if (oldrange>705)
    return ang+=40;
 
  }
}

preciso() {
    if (oldrange=scan(ang,10))
    {
        if (!scan(ang-=5,5)) ang+=10;
        if ((oldrange>700) && (attacco))
        {
            if (!scan(ang-=3,3)) ang+=6;
            cannon(ang,oldrange); return ang+=40;
        }

        if(scan(ang-5,1)) ang-=5;
        if(scan(ang+5,1)) ang+=5;
        if(scan(ang-3,1)) ang-=3;
        if(scan(ang+3,1)) ang+=3;
        if(scan(ang-1,1)) ang-=1;
        if(scan(ang+1,1)) ang+=1;

        if (oldrange=scan(oldang=ang,5))
        {
            if(scan(ang-5,1)) ang-=5;
            if(scan(ang+5,1)) ang+=5;
            if(scan(ang-3,1)) ang-=3;
            if(scan(ang+3,1)) ang+=3;
            if(scan(ang-1,1)) ang-=1;
            if(scan(ang+1,1)) ang+=1;

            if (range=scan(ang,10))
                cannon(ang+(ang-oldang)*((1200+range)>>9)-(sin(ang-dir)>>14),
                       range*172/(172+oldrange-range-(cos(ang-dir)>>12)));
        }
     }
     else
     {
        if (scan(ang-=20,10)) return;
        if (scan(ang+=40,10)) return;
        return ang+=40;
     }
}

