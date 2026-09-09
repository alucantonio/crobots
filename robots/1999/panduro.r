/*

                         *** CRobot Y2K Tournament ***
                               *****************


                           Panduro CRobot D' Acciaio

autore: Andrea Pandurino (LECCE)
        
in collaborazione con : Dario Serino & Enzo Maritati

per gentile concessione de : Panduro Fans Club Italia

"alla fine del II millennio si organizzo' una agguarrita guerra tra i migliori
crobot del mondo. Questa lotta avrebbe impegnato i poveri abitanti di Pandur-
landia in un duro scontro per scacciare ed eliminare i cattivi crobot alieni
dell'arena. Lo scontro sembrava gia' perso in partenza ma ecco, dal nulla,
sorgere il baluardo della liberta' crobotica: PANDURO CROBOT D'ACCIAIO.
Con la forza del rimbalzo e del rimpallo unite alla grande intelligenza dei
pandurlandiesi, istruzione dopo istruzione nacque questo robottino il cui
unico scopo e' di difendere la piccola arena di gioco dagli attacchi nemici."

TATTICA:

Il crobot rimbalza lungo le pareti dell'arena sparando all'impazzata verso
chiunque sia a tiro e cercando di restare lontano dai possibili nemici sia
contro tre che contro uno o due nemici.
Due routine di fuoco riescono a gestire le varie situazioni in cui necessita
precisione o velocita' di tiro.
Per gli spostamenti usa un movimento a zig-zag lungo le pareti.

RINGRAZIAMENTI:

Si ringrazia il Pandurino e il Panduro Fans Club per la gentile concessione
del nome, tutti gli adepti del club, Dario per la pazienza, Andrea per la
tolleranza e Zac per l'assistenza.

*/

int dir,orng,deg,elpimi;
int sd,ud,lim_x,lim_y;

/* la cervella del P.R.D.A. 
   (Panduro Robot D' Acciaio) */

main() {
  int osd,oud;
  sd=osd=2*(loc_x()<500)-1;
  ud=oud=2*(loc_y()>500)-1;
  lim_y=420+500*ud;
  while(1) {
    while(horz()) sd=(osd*=-1);
    lim_x=-50-lim_x;
    ud=(oud*=-1);
    while(vert()) ud=(oud*=-1);
    lim_y=50-lim_y;
    sd=(osd*=-1);
  }
}
    
/* tra la destra e la sinistra... */
    
horz() {
  dir=180-ud*(90-45*sd);
  lim_x=500*sd-420;
  while((sd*loc_x())>lim_x) {
    drive(dir,100); vojapizza();
    if ((ud*loc_y())>lim_y) {
      ud*=-1;
      lim_y=50-lim_y;
      drive(dir=360-dir,0); vojapizza();
      if (sd>0) {if ((scan(170,10) + scan(190,10)) > 350) return elpimi=1;}
      else      {if ((scan(350,10) + scan(370,10)) > 350) return elpimi=1;}
    }
  }
  sd*=-1;
  return 0;
}

/* su e giu'... su e giu' */

vert() {
  dir=180-ud*(90-45*sd);
  lim_y=420+500*ud;
  while((ud*loc_y())<lim_y) {
    drive(dir,100); vojapizza();
    if ((sd*loc_x())<lim_x) {
      sd*=-1;
      lim_x=-50-lim_x;
      drive(dir=540-dir,0); vojapizza();
      if (ud>0) {if ((scan(80,10)  + scan(100,10)) > 350) return elpimi=1;}
      else      {if ((scan(260,10) + scan(280,10)) > 350) return elpimi=1;}
    }
  }
  ud*=-1;
  return 0;
}

/* pausa riflessione 
   con sparo alla serpiko */

stop() {
  int ahiya,odeg,rng;
  elpimi=0;
  ahiya=damage();
  while ((!orng || orng>350) && (damage()<ahiya+4)) {
    ahiya=damage();
    if (orng=scan(deg,10)) {
      if (scan(deg-=5,5)); else deg+=10;
      if (orng>720) {
        if (scan(deg-=3,3)); else deg+=6;
        cannon(deg,orng);
      } else {
        if (scan(deg-5,1)) deg-=5; if (scan(deg+5,1)) deg+=5;
        if (scan(deg-3,1)) deg-=3; if (scan(deg+3,1)) deg+=3;
        if (scan(deg-1,1)) deg-=1; if (scan(deg+1,1)) deg+=1;
        if (orng=scan(odeg=deg,5)) {
          if (scan(deg-5,1)) deg-=5; if (scan(deg+5,1)) deg+=5;
          if (scan(deg-3,1)) deg-=3; if (scan(deg+3,1)) deg+=3;
          if (scan(deg-1,1)) deg-=1; if (scan(deg+1,1)) deg+=1;
          if (rng=scan(deg,10))
            cannon(deg+(deg-odeg)*((1200+rng)>>9),rng*172/(172+orng-rng));
        }
      }
    } else if (scan(deg-=21,10)) ;
        else if (scan(deg+=42,10)) ;
          else deg+=42;
  }
}

/* sparo a mitraglietta */

vojapizza() {
  int orng,rng,odeg;
  if (orng=scan(deg,10)) {
    odeg=deg;
    if (scan(deg+=5,5)); else deg-=10;
    if (scan(deg+=3,3)); else deg-=6;
    if (rng=scan(deg,10)) cannon(deg+(deg-odeg),rng+(rng-orng)*2);
    if (orng>720) return deg+=42;
  }
  else if (scan(deg-=21,10)) return;
  else if (scan(deg+=42,10)) return;
  else return deg+=42;
}

/*

                                            XXXXXXXXX
                                          XXXXXXXXXXXXX
                                        XXXXXXXXXXXXXXXXX
                                       XXXXXXXXXX    XXXXX
      X                                XXXXXXXXXX    XXXXX
 XX   X  X                      XXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX XXX    XXXXX              XXXXXXXXXXXXXXXXXXXXXXXXXXX
     XXX XXXXX   XXXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX XXX           XXX   XX    XXXXXXXXXXXXXXXXXXXXXXXXXXX
 XX   X  XX           XXXXX     XXXXXXXXXXXXXXXXXXXXXXXXXXX
      X                                XXXXXXXXXXXXXXXXXXX
                                       XXXXXXXXXXXXXXXXXXX
                                        XXXXXXXXXXXXXXXXX
                                          XXXXXXXXXXXXX
                                            XXXXXXXXX


... il Panduro e' come una bomba... quando ti esplode vicino... te lo senti!!!

*/
