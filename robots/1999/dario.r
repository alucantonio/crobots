/*
                       .-^-.
                       (_ _)
                       )~^~(
                       ~lll~
                     ___) (__
                   .'/`.\ /.'`.
                  / /   :::  ::`.
                 /      :|:   :::\
                /   .-. :|: .-;:::\
               (   (   _|||_   ):::)     _
           ... |  __==;_____;==__::|-/ / .~-._     .
       _.-~ \\\| ( ~`--'   `--~  ):| / .'    /~-. /|
    .-'   .'    > ~~~] /: \ [~~~~:<  // :   /  / `.)
 .-~/ .'/ /  .'|   || ~`__'` ||::::| /   : /  /   /`-._
/ / / .'       |  .;'/.^   ^\`:.::/|/     / :/   /    />
 ` `  //' / .' |\ ||/ (|vvv|)\||://(   o /  / :.'   .;/`.
  /  .'         \\|| `- -- -' ||//  \_.-'o /  /  : //    \
.'  / // .'/     \ |`-._____.-| /      ~~\~o_/   .;'      `.
 /   /.'    /     `'          `'          ~~\_o_//          \______
        /            _                       ~~~        .--'~_  O  ~
.'/ ' /    /   .- ~     |    -.                       .'.--'~:\   /~
  .'       :  |                 -                   .'.'.. .:::| |:.
     .' : ;           _    _      `.        |      / / . . .:::| |::
'`-. .::' :   |  .- '   |    ` .    `.     /`     / /. .  ..:::| |::
    ~     :    .'       |       .     .   )  `.  / /  . ...::::| |::
`-.____   |                              :     `; ;     . :::::| |::
      ~`-.'  _                    `     .'      | |   .  ..::::| |::
o             `.      /   \        .    |      .'.'       .::::| |::
   o   o |      `.   /     \            |      | |        :::::| |::
`-.__   .'\       _.'       `._         |     .'.'      :::::::| |::
     ~~`|  X._                 `      _.'     | |     :::::::::| |::
        | /   ~-.________________.--'~  \     | `-.____________| |__
        `/\          / ___ \         _.-'\    | O  ____________ X __
         |:`-.______/ / _ \ \_____.-:--'~~)   | ,-' .`:::::::::| |::
         `.ll:l:l:l :( ;   )l l:l:l'       \  | |     :.:::::::| |::
          `. l:l:l:l:l\___/l:l:l.'     .    \ `.`.   .  .::::::| |::
|           `.__l:l:l:l:l:l:l:l'             : | |       :.::::| |::
\          .    ~--..l:l:l:l:l/              `.| |      .  ::::| |::
 \       .        .  `.-.`l:l/                |`.`.         .::| |::
  `._              `./  /l:l/      \          : | |         :::| |::
     :-..          ;/  / :l|                  `.`.`.      .  .:| |::
     :  \         ;/  / `-._         `.        |  \ \        ::| |::
     |   `-._    ;/  /      `-._               |   \ \       .:| |:
    .'       `--'/  /_    -._   `-._   .       |    \ \   .  . | |.
    |     .'     `.'  :-._   `-._   `-._       |     \ `.      | |.
   .'          .      |   `-._   `-._   `-._   |      `. `-.__/ O \.
   |                  |       `-._   `-._   `-._        `-.________.
                                | `-._   `-._   `-._
                                      `-._   `-._   `.
                                          `-._   `-   `.
                                              `-._      `.
                                                  ~~~~~~~

DARIO.R - Y2K Tournment
Efficienza in Torneo 91-98 : 62.33 %

Autor   : Serino Dario 75

****************
*              *
*  STRATEGIA   *
*              *
****************

Inizialmente il robot si porta velocemente nell` angolo piu` prossimo sparando
all` impazzata e una volta avvicinatosi smette di sparare per accostarsi
al muro quanto piu` e` possibile. Se e` attaccato fin dall` inizio o qualcun
altro e` nei pressi dello stesso angolo evita l` accostamento al muro e fugge
in uno adiacente.
Quand`e` al sicuro cerca un nemico che non sia troppo lontano e lo spara
rimanendo immobile (se tutti sono lontani preferisce conservare le munizioni).
Se un avversario si avvicina pericolosamente o subisce il 5% di danni cerca un
angolo adiacente libero o con il nemico piu` vicino e gli va incontro in tutta
fretta. Ovviamente se e` tranquillo cerchera` di lambire il muro a destinazione.
Di tanto in tanto, se tutti gli avversari sono lontani, conta il numero dei
superstiti e se ne trova solo due individua tra essi un eventuale robot statico
o la cui distanza non vari significativamente nel tempo. Se oscillano entrambi,
ahime`, si rassegna sperando che prima o poi uno schiatti, altrimenti si avvicina
velocemente al malcapitato puntandolo ad oltranza, bombardandolo e tornando
rapidamente dietro le barricate.
Se il poveretto fugge Dario occupa il suo vecchio angolo e ripete l`esecuzione.
Quando rimane solo una tomba da abbellire viene eseguita la piu` potente
routine di attacco che quel demonio di me stesso abbia mai inventato: si porta
verso il centro e controlla continuamente angolo e distanza relativi del
futuro zombie, quando uno di questi parametri si stabilizza o sono stati gia`
sparati 4 colpi cambia direzione di marcia scegliendo alternativamente quella
a 135 e 225 gradi rispetto all`avversario in modo tale che angoli e distanze
cambino cosi` velocemente che un tipo di fuoco impreciso risulti inefficace.
Anche un nemico cecchino ha grossi problemi dato che Dario puo` cambiare
repentimente la sua direzione facendo perdere le sue tracce. La toxica e` stata
opportunamente modificata per seguire il nemico su intervalli angolari piu`
estesi. Avrei potuto ottimizzarla ulteriormente se non fosse esistito il
celeberrimo bug che falsa le scansioni di ampia veduta.
Questi commento illustra sostanzialmente la dinamica, se vi interessano i
dettagli implementativi con tutte le ottimizzazioni e diavolerie crobernetiche
provate a decodificare il codice.

****************
*              *
*  Thanks To:  *
*              *
****************

First of all uno dei miei Bestio friend, Aintz, geniale consigliere,
senza la cui instancabile perseveranza avrei certamente dormito di piu`, sia
a letto che nel torneo. Grazie a Daniele per aver chiamato Stealth uno dei suoi
robot suggerendo di nasconderci ben bene negli angolini e a Simone per
i suoi report con i quali abbiamo scoperto come sia divertente ed efficiente
attaccare i robot statici. Grazie a Gianmarco per le sue innovatissime idee sul
futuro di Crobots (allagamenti dell` arena, campi magnetici, scudi parabolici,
molle a lungo raggio, invisibilita` permanente, bombe a grappolo...), a Panduro,
mascotte di ogni demenza pubblica, allo ionizzatore di Stefano senza cui
avrei gia sette tumori a polmoni per la nubi notturne di Enzo e le sue Gauloises,
ai rutti di Salamina per non averci fatto crollare di sonno, a Maurizio per
lo spirito e professionalita`, ad Alessandro Carlin per il sostegno morale,
a mio fratello Marco, che tra un assolo di Malmsteen ed un altro sputava
strategie, glissati, sweet-picking e ottimizzazioni indispensabili del codice.
Grazie a mia madre per aver immaginato che stessi preparando un esame
complicatissimo e non avermi mai rotto le scatole. Grazie alle ninne nanne
del mio DX2 e a Tom per il bug con cui vi scannerete a vicenda.
Volevo salutare tutti gli amici leccesi che hanno preso a buon cuore le nostre
fatiche e hanno voluto partecipare accompagnarci in quest`avventura con dei
crobots scritti in poco tempo sotto la nostra supervisione. Non saranno
spettacolari, ma l`impegno e il nostro pugno si fara` notare certamente.

By the way: ho dovuto peggiorare il comportamento in Face-2-Face x guadagnare
un punto e mezzo netti in torneo 91-98. Speriamo che Satana.r difenda
la bellezza della mia routine d`attacco.
*/

int dir,deg,odeg,rng,orng,dam,count;
int attack,normal,clock;
int hidd_x,hidd_y;
int sx,dw,far;

main() {
  int r1,r2;

/* vai nell`angolo piu` vicino */
  sx=loc_x(dw=loc_y()>(count=(deg=500)))>500;
  move(move());

  while(1) {
/* se piu` di un nemico fermati nell`angolo */
    if (attack);
    else stop(dam=damage());

/* via nell`angolo adiacente migliore */
    if (((r1=scan(190+180*sx,10)+scan(169+180*sx,10))==0) && (sx)) move(1);
    else move((r2=scan(280+180*dw,10)+scan(259+180*dw,10)) && (r1<r2));
  }
}

stop() {                                               
  int lim,sign,xor,three;

  while((!orng || (orng>550)) && (damage()<dam+4)) {
/* accostati al muro */
    if (hidd_x) {
      lim=500*(sign=2*sx-1)-490;
      hidd_x^=drive((dir=270+90*sign)+180,40);
      while((sign*loc_x())>lim);
      drive(dir,0);
    }
  
    if (hidd_y) {
      lim=500*(sign=2*dw-1)-490;
      hidd_y^=drive((dir=90*sign)+180,40);
      while((sign*loc_y())>lim);
      drive(dir,0);
    }

/* se sei al sicuro conta i nemici */
    if (count>10) {
      deg=532+180*dw+90*(xor=dw^sx);
      count=(three=24); while(three && (count>17))
        if (scan(deg+15*((--three)%8),7)) --count;

/* se ne e` rimasto solo uno attaccalo o aspettalo oscillando */
      if (count/=21) {
        if (dam>(attack=90)) return;
        else {
          dir=deg+53;
  
          while(normal=4) {
            drive(dir%=360,100);

            if (dir>=270)      while(focus() && loc_y()>280);
            else if (dir>=180) while(focus() && loc_x()>280);
            else if (dir>=90)  while(focus() && loc_y()<720);
            else               while(focus() && loc_x()<720);

/* rimabalza sul muro o devia a 135 gradi relativi */
            if (normal) dir+=180;
            else        dir=( ((deg+180)/90) + (clock^=1) )*90;
        
            drive(dir,50);
            while(speed()>50);
          }
        }
      }
/* se non sei troppo danneggiato e ne sono rimasti due
   rompi le scatole a quello statico */
      else if (three || (dam>90));
      else {
        focus(attack=(deg+=88-70*clock));

        if (orng) {
          if (orng==rng) {
            far=580;
            far=move(clock^xor);
            dam=damage(move(clock^xor));

            count=6;
          }
          else clock^=1;
        }
        else return attack=0;

        attack=0;
      }
    }
    focus(1);
  }
}

focus(hidden) {
/* cerca un nemico */
  if (orng=scan(deg,10));
  else if (orng=scan(deg-=21,10));
  else if (orng=scan(deg+=42,10));
  else {deg+=42; return --normal;}

/* se e` vicino spara immediatamente */
  if (orng<150) return cannon(deg,orng);
  else if (attack);
/* se e` lontano cercane un altro */
  else if (orng>735) {++count; return deg+=42;}

  if (scan(deg-=5,5)); else deg+=10;
  if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
  if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
  if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;
  if (orng=scan(odeg=deg,5)) {
    if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
    if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
    if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;

    if (rng=scan(deg,10)) {
/* sparo da fermo o in movimento */
      if (hidden)
        cannon(deg+(deg-odeg)*((1200+rng)>>9),rng*172/(172+ orng-rng));
      else
        cannon(deg+(deg-odeg)*((1200+rng)>>9)- (sin(deg-dir)>>14),
               rng*172/(172+ orng-rng- (cos(deg-dir)>>12)));

/* se sei in attacco e i parametri direzionali sono pressoche` costanti
   cambia direzione di moto */
      if (attack)
        if (deg==odeg) return normal>>=1;
        else return --normal;
      else return count=0;
    }
  }
}

/* procedura di movimento da angolo in angolo */
move(horz) {
  int sign,lim;

  if (horz) sign=2*(sx^=1)-1;
  else sign=2*(dw^=1)-1;

  lim=500*sign-350+far;
  drive(dir=90*(sign+2-horz),100);

  if (horz) {while((sign*loc_x())>lim) focus(); hidd_x=1;}
  else      {while((sign*loc_y())>lim) focus(); hidd_y=1;}

  focus(drive(dir+180,0));
  while(speed()>50);
}
