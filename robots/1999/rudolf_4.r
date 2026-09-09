/*                        R  U  D  O  L  F      4            

        AUTORE
        Nome: Alessandro Carlin

SCHEDA TECNICA:
Rudolf si porta inizialmente a destra o a sinistra a seconda di dove nasce
(raggiunge la parete piu' vicina), dopodiche' si porta in alto se vede l'
angolo libero, altrimenti va in basso.
Qui rimane fermo sparando con Fire (toxiche o quasi) finche' non subisce
danni o non ha nemici vicini.
In caso contrario esegue il seguente loop:
- corre per 300 metri lungo un lato
- controlla l' angolo che sta per raggiungere
- se e' libero ci va
- se e' occupato torna all' angolo iniziale e ripete l' operazione lungo
  l' altro lato
- se ancora e' occupato torna all' angolo
Il numero di avversari viene continuamente controllato e se ne rimane uno solo
Rudolf lo attacca oscillando dx-sx al centro dell' arena.

COMMENTO:
Lo spostamento da un angolo all' altro e' tale da permettere a Rudolf di
muoversi subito non appena e' a tiro, e da analizzare meglio la situazione
sugli altri angoli "saltando" l' eventuale robot con cui condivide la
posizione. Restando fermo per il resto del tempo si espone poco ai colpi
degli avversari.
Rudolf controlla prima gli angoli di destra per le note questioni riguardanti
il bug di scansione.
Il radar e' stato velocizzato rispetto a quello dall' anno scorso e la
procedura termina appena ha contato 2 robot.
L' attacco e' simile a quello di "The invisible man", ma con le toxiche
opportunamente modificate in modo che non venga mai perso di vista
l' unico nemico.
Si e' preferito evitare scansioni sugli angoli alla Goblin perche' se
e' vero che le toxiche rendono megli se l' obbiettivo e' distante, e' anche
vero che i controlli rallentano tutto; rimanendo a meta' dell' arena si
e' cercato di evitare di avvicinarsi agli angoli.
Inoltre cosi' la procedura di attacco non occupa tanto spazio (anzi).
Forse il robot e' un po' fifone attaccando un solo nemico, ma penso che
con avversari forti sia la soluzione migliore; e poi i tentativi di
farlo piu' coraggioso non sono serviti.
Con banali ottimizzazioni si arriva a 85% di codice occupato ma non ho
trovato validi innesti da fare nel 15% libero.

Noterete che l' unica differenza da Cyborg sta in un parametro...
Questo ci pensa meglio prima di scappare.

Un ringraziamento a Joshua per l' impegno che si e' preso, a Simone e
Michelangelo per gli utilissimi programmi di gestione e a Daniele, Marco,
e tutti gli altri giocatori vecchi e nuovi che grazie ai report in ML
mi hanno stimolato a migliorare e hanno reso molto piu' divertente il
torneo di quest' anno.
Speriamo di oranizzarlo anche nel nuovo millennio!
Ciao
  Ale                                                                       */


int b,rng,orng,tt,deg,odeg,dir,t,q,dam,reg;

/*                       WELCOME TO MY WORLD!!!
                   COME PLAY WITH ME... I'M WAITING...                      */

main()
{
    if (loc_x()<500) {sx(70);
    if ((!scan(90,10))&&(!scan(70,10))) up(930); else dw(70);}
    else {dx(930);
    if ((!scan(90,10))&&(!scan(110,10))) up(930); else dw(70);}
    deg=3600;
    tt=1;
    while(1)
    {
    dam=damage();       
    while ((!orng || orng>450) && (damage()<dam+5))
    {
        if (t>12)
           if (Radar()) End();
        dam=damage();
        Fire(1);
    }
 b=(loc_x()>500)+2*(loc_y()>500);
      if (b==0)     {dx(300);if (!scan(350,10)&&!scan(10,10)) dx(930); else {sx(70);
        up(300);if (!scan(95,10)&&!scan(75,10)) up(930); else dw(70);}}
      else if (b==1) {up(300);if (!scan(85,10)&&!scan(105,10)) up(930); else {dw(70);
        sx(700);if (!scan(185,10)&&!scan(165,10)) sx(70); else dx(930);}}
      else if (b==2) {dx(300);if (!scan(10,10)&&!scan(350,10)) dx(930); else {sx(70);
        dw(700);if (!scan(265,10)&&!scan(285,10)) dw(70); else up(930);}}
      else           {dw(700);if (!scan(275,10)&&!scan(255,10)) dw(70); else {up(930);
        sx(700);if (!scan(175,10)&&!scan(195,10)) sx(70); else dx(930);}}
    }
}

/*                        I PLAY THEIR FANTASY AND
                              I LIVE THEIR PAIN
                      MY HEART AND SOUL LOCKED UP IN A
                              COLD STEEL FRAME
                  A STRANGE CREATURE'S CRAWLING AND IT'S
                            CALLING OUT MY NAME
                              I DON'T WANT TO
                              I DON'T NEED TO
                          BUT I MUST FIGHT AGAIN
                       (LET ME OUT! - SET ME FREE!)                         */

up(l) { dir=90;  while(loc_y()<l) { drive(90,100);  Fire(); } drive(270,0); }
dw(l) { dir=270; while(loc_y()>l) { drive(270,100); Fire(); } drive(90,0);  }
dx(l) { dir=0;   while(loc_x()<l) { drive(0,100);   Fire(); } drive(180,0); }
sx(l) { dir=180; while(loc_x()>l) { drive(180,100); Fire(); } drive(0,0);   }

/*                       CALLING OUT FOR THE CYBORG
                             GONNA RUB YOU OUT
                         TIME IS UP FOR THE CYBORG
                           YOU'LL NEVER GET OUT
                     BAH! YOU'RE NOTHING BUT A CYBORG                       */

Radar()
{
    reg=10; t=0;
    while((reg+=20)!=730) if (scan(reg,10)) if(++t>2) {t=0; return 0;}
    return 1;
}

/*                      CYBORG, IT'S YOUR TIME                              
                      I'LL MAKE IT BACK THERE BABY
                         JUST YOU WATCH ME TRY
                  (ONE MORE TRY - JUST ONE MORE TRY)
                            WE'LL FLY AGAIN
                        INTO THE DEEP BLUE SKY
                         I FEEL A HUNGER BABY
                         CYBORG FEELS NO SHAME
                            LORD I HAVE TO
                            LORD I NEED TO
                         WIN THIS WICKED GAME                               */

End(){
        tt=0;
        dw(550);up(450);
        while(1) {
                 dx(850);sx(150);
                 }
}

/*                          COME STEP ON ME                                 
                         CALLING OUT FOR THE CYBORG
                             GONNA RUB YOU OUT
                         TIME IS UP FOR THE CYBORG
                           YOU'LL NEVER GET OUT
                         CALLING OUT FOR THE CYBORG
                          GONNA PUT YOUR LIGHT OUT
                     BAH! YOU'RE NOTHING BUT A CYBORG
                           YOU'LL NEVER GET OUT                             */

Fire(flag)
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (tt) if (orng>770)
        {
            if (!scan(deg-=3,3)) deg+=6;
            cannon(deg,orng); ++t; deg+=40; return;
        }

        if(scan(deg-5,1)) deg-=5;
        if(scan(deg+5,1)) deg+=5;
        if(scan(deg-3,1)) deg-=3;
        if(scan(deg+3,1)) deg+=3;
        if(scan(deg-1,1)) deg-=1;
        if(scan(deg+1,1)) deg+=1;

        if (orng=scan(odeg=deg,5))
        {
            if(scan(deg-5,1)) deg-=5;
            if(scan(deg+5,1)) deg+=5;
            if(scan(deg-3,1)) deg-=3;
            if(scan(deg+3,1)) deg+=3;
            if(scan(deg-1,1)) deg-=1;
            if(scan(deg+1,1)) deg+=1;

            if (rng=scan(deg,10))
            {
                if (flag)
                {
                cannon(deg+(deg-odeg)*((1200+rng)>>9),
                       rng*160/(160+orng-rng));
                }
                else
                {
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*165/(165+orng-rng-(cos(deg-dir)>>12)));
                }
                t=0;
            }
        }
     }
     else
     {
        if (scan(deg-=20,10)) return;
        if (scan(deg+=40,10)) return;
        deg+=40; return;
     }
}

/*                       I'M GONNA ERASE YOUR FILE                          
                                                          (Brian May)       */
