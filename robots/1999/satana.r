/*                              
                              .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  ALIEN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.         .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
 

SATANA.R - Y2K F2F-Tournment
Efficienza in Torneo 91-98 F2F : 99.85 %

Autor   : Serino Dario 75

****************
*              *
*  STRATEGIA   *
*              *
****************

Satana e` un pazzoide sfrenato che distrugge chiunque osi sfidarlo in duello.
E` la prima creatura partorita dal quel diavolo del mio DX2 ed e` interamente
concepito per il Face-2-Face. Mi aspetto che becchi un 0 % netto negli altri
tornei ma in quanto a scontri diretti e` candidato alla vittoria. Il suo
comportamento e` semplicissimo ed e` praticamente lo stesso descritto in Dario.r
con la differenza che qui e` ottimizzato per annientare rapidamente lo sfidante.
Sostanzialmente cerca il nemico ed esegue un movimento a freccia rispetto ad
esso cambiando direzione quando angolo e/o distanza del nemico tendono a
stabilizzarsi o ha gia` sparato tre volte per far perdere rapidamente le sue
tracce e inebetire procedure di fuoco poco precise. Durante i cambi di direzione
utilizza un fuoco piu` rapido non troppo condizionabile dal fattore accelerazione.
Sono stati modificati notevolmente i parametri della toxica per rendere piu`
immediata la ricerca dell`avversario e diminuire la probabilita` di smarrirlo,
fattore chiave di successo.

!!! : Un ringraziamento tempestatu te diamanti ad Aintz che a 45 minuti
dalla scadenza della consegna dei crobots ha trovato una pecca in questo
robbottazzu facendogli sfiorare la perfezione (100 %).
*/

int dir,deg,normal;
int odeg,rng,orng;

main() {
  int clock;

/* vai in verticale verso il muro piu` lontano */
  if (loc_y()>500) {deg=450; dir=270;}
  else             {deg=630; dir=90; }

  while(normal=3) {
/* vai nella direzione dir fino ad una distanza di 175 dal muro
o finche` angolo e/o distanza del nemico divengono pressoche` costanti */
    if (dir==270)     while(focus(loc_y()<275));
    else if (dir==90) while(focus(loc_y()>725));
    else if (dir)     while(focus(loc_x()<275));
    else              while(focus(loc_x()>725));

/* se incontri il muro rimbalza altrimenti devia di 135 o 225 gradi
rispetto al nemico */
    if (normal) drive((dir+180)%=360,50);
    else        drive(dir=(( ((deg+180)/90) + (clock^=1) )*90)%360,50);

/* spara velocemente */
    while (speed()>50)
      if (orng=scan(deg,10)) {
        odeg=deg;
        if (scan(deg+=5,5)); else deg-=10;
        if (scan(deg+=3,3)); else deg-=6;
  
        if (rng=scan(deg,10))
          cannon(deg+(deg-odeg),rng+(rng-orng)*2);
      }
      else if (scan(deg+=21,10));  
      else if (scan(deg-=42,10));
      else deg+=84;

/* accelera nella nuova direzione */
    drive(dir,100);
  }
}

focus(exit) {
  if (exit) return 0;
  else {
    drive(dir,100);

/* cerca il nemico in un range angolare di 63 gradi */
    if (scan(deg,10));
    else if (scan(deg+=21,10));
    else if (scan(deg-=42,10));
    else {deg+=84; return --normal;}

/* famosissima toxica */
    if (scan(deg-=5,5)); else deg+=10;
    if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
    if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
    if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;
    if (orng=scan(odeg=deg,5)) {
/* peccato che questi parametri soffrono del bug ma in 1&1 sono magnifici
dato che non sono cosi` fesso da cascarci proprio mentre attacco */
      if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
      if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
      if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

      if (rng=scan(deg,10))
        cannon(deg+ (deg-odeg)*((1200+rng)>>9)- (sin(deg-dir)>>14),
               rng*192/(192+ orng-rng- (cos(deg-dir)>>12)));

/* se l`angolo diventa costante preparati per cambiare direzione */
      if (deg==odeg) return normal>>=1;
    }
/* ricordati che il tempo passa */
    return --normal;
  }
}

