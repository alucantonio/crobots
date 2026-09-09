/*                      C   Y   B   O   R   G     II                

        AUTORE
        Nome: Alessandro Carlin

SCHEDA TECNICA:
Cyborg_2 si porta per prima cosa all'angolo vicino.
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
Cyborg lo attacca come Zorn.

COMMENTO:
Ovviamente come i veterani avranno capito si tratta solo di un rimodernamento
di Cyborg del 1999. La domanda e': perche?
1) Non ho avuto tempo di sviluppare un crobot forte
2) Cyborg mi piaceva un sacco anche se sfiguro' non poco
3) Sono curioso di vedere cosa fa un crobot toxico e per di piu' ad angolo
variabile (come piace a Mich) ora che le tattiche sono cambiate cosi' tanto
Va detto che non ha alcuna ambizione... si tratta solo di un piccolo ammodernamento
*/                                                          

int b,rng,orng,tt,deg,odeg,dir,t,q,dam,reg,daa;

/*                       WELCOME TO MY WORLD!!!
                   COME PLAY WITH ME... I'M WAITING...                      */

main()
{
    if (loc_x()<500) sx(80);else dx(920);
    if (loc_y()<500) dw(80);else up(920);
    if (Radar()) End();
    deg=3600;
    while(1)
    {
    dam=damage();       
    while ((!orng || orng>450) && (damage()<dam+3))
    {
        if (t>4)
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
    while((reg+=20)!=370) if (scan(reg,10)) if(++t>1) {t=0; return 0;}
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

                    

Fire(flag)
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (orng>770)
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

/*                          COME STEP ON ME                                 
                         CALLING OUT FOR THE CYBORG
                             GONNA RUB YOU OUT
                         TIME IS UP FOR THE CYBORG
                           YOU'LL NEVER GET OUT
                         CALLING OUT FOR THE CYBORG
                          GONNA PUT YOUR LIGHT OUT
                     BAH! YOU'RE NOTHING BUT A CYBORG
                           YOU'LL NEVER GET OUT                             */

udo(){
while(loc_x()>500) {while(loc_y()>885) {drive(240,100);Fuocoe();}
                    while(loc_y()<885) {drive(120,100);Fuocoe();}
                    }
}

uso(){
while(loc_x()<500) {while(loc_y()>885) {drive(300,100);Fuocoe();}
                    while(loc_y()<885) {drive(60,100);Fuocoe();}
                    }
}

ddo(){
while(loc_x()>500) {while(loc_y()>115) {drive(240,100);Fuocoe();}
                    while(loc_y()<115) {drive(120,100);Fuocoe();}
                    }
}

dso(){
while(loc_x()<500) {while(loc_y()>115) {drive(300,100);Fuocoe();}
                    while(loc_y()<115) {drive(60,100);Fuocoe();}
                    }
}


End()
{
if (b=0) dso();
else if (b=1) ddo();
else if (b=3) udo();
else uso();
daa=damage();
if(b>1){
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
}
else{
while(loc_y()<850) {drive(90,100);Fuocoe();
                     }
}
daa-=5;
while (damage()<(daa+16)) {
daa=damage();
while(loc_y()>150) {drive(270,100);Fuocoe();
                     }
while(loc_y()<850) {drive(90,100);Fuocoe();
                    }                      
}
while(1)
{
while(loc_y()>150) {while(loc_x()>500) {drive(190,100);Fuocoe();}
                    while(loc_x()<500) {drive(350,100);Fuocoe();}
                    }
while(loc_y()<850) {
                    while(loc_x()>500) {drive(170,100);Fuocoe();}
                    while(loc_x()<500) {drive(10,100);Fuocoe();}
                    }
}
  
}

Fuocoe()
{
    if (orng=scan(odeg=deg,10)) {
           
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-orng));}
           if (scan(deg+=14,4)){if (!(scan(deg-=2,2))) deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-orng));}
           if (scan(deg-=7,4)){if (!(scan(deg+=2,2))) deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-orng));}
    }                
    else {
        if (orng=scan(deg+=340,10)) return cannon(deg,orng);
        if (orng=scan(deg+=40,10)) return cannon(deg,orng);
        if (orng=scan(deg+=300,10)) return cannon(deg,orng);
        if (orng=scan(deg+=80,10)) return cannon(deg,orng);
        if (orng=scan(deg+=260,10)) return cannon(deg,orng);
        if (orng=scan(deg+=120,10)) return cannon(deg,orng);
        deg+=80;
    }
}

/*                       I'M GONNA ERASE YOUR FILE                          
                                                          (Brian May)       */

