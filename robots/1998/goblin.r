/****************************************************************************/
/*                                                                          */
/*  VIII Torneo di CRobots di MCmicrocomputer (1998)                        */
/*                                                                          */
/*  CROBOT: GOBLIN.R                                                        */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere questo crobot (GOBLIN.R).    */

/*               
                          SCHEDA TECNICA:

   Inizialmente il crobot si reca nell'angolo pió vicino.
   Nell'angolo viene utilizzata questa strategia:

       - Se il crobot si trova in un angolo in basso controlla nell'angolo
         sopra se ci sono altri crobots e se non c'ä nessuno si reca sopra
         nel nuovo angolo; analogamente se si trova a nord e non c'ä nessuno
         in basso scende;

        - Altrimenti rimane fermo e defilato nell'angolo finchä non viene
          colpito con una certa precisione (almeno 5% di danno) o finchä
          non si avvicina nessuno nell'angolo;

        - Quindi cambia angolo spostandosi sempre in uno dei due angoli
          adiacenti, preferendo se possibile (se non ci sono altri crobots)
          muoversi lungo le pareti verticali dell'arena di combattimento.

   Durante tutto il match il crobots controlla continuamente se ä rimasto
   un solo avversario ed in tal caso lo attacca; la routine di attacco ä
   basata sullo spostamento lungo le due grandi diagonali, utilizzando un
   piccolo accorgimento: il crobot non va mai incontro ad un avversario
   che si trova in un angolo; infatti dopo aver percorso metÖ diagonale
   (il crobots si trova pió o meno nel centro dell'arena) si controlla che
   l'angolo in cui si sta per andare sia libero, in caso contrario si cambia
   la diagonale di attacco.

   Vengono utilizzate 2 routine di fuoco a seconda che il crobots sia fermo
   o in movimento; tali routine sono pió o meno le stesse utilizzate in
   Diabolik.r e nei suoi predecessori. Quindi niente di nuovo per le routine
   di fuoco!


*/

int rng,orng,deg,odeg,dir,t,q,dam;

main()
{
/* Vai nell'angolo pió vicino: */

    if (loc_x()<500) sx(); else dx();
    if (loc_y()<500) dw(); else up();

    while(1)
    {
        if (UpDown())
        {
            Angle();
            if (UpDown()) Move();
        }
    }
     
}

up() { dir=90;  while(loc_y()<900) { drive(90,100);  Fire(); } drive(270,0); }
dw() { dir=270; while(loc_y()>100) { drive(270,100); Fire(); } drive(90,0);  }
dx() { dir=0;   while(loc_x()<900) { drive(0,100);   Fire(); } drive(180,0); }
sx() { dir=180; while(loc_x()>100) { drive(180,100); Fire(); } drive(0,0);   }

Angle()
{
    dam=damage();
    while ((!orng || orng>450) && (damage()<dam+4))
    {
        if (t>15)
           if (Radar())
              { Stop(); while(1) { diag(); Stop(); } }       /* Attacca!!! */
        dam=damage();
        Fire(1);
    }
}

Move()
{
    if (loc_x()<500) dx(); else sx();
}

UpDown()
{
    if (t>15) return 1;
    if (loc_y()<500) { if (!scan(80,10) && !scan(100,10)) { up(); return 0; } }
    else { if (!scan(260,10) && !scan(280,10)) { dw(); return 0; } }
    return 1;
}

Radar()
{
    deg=-10; t=0;
    while((deg+=20)!=710) if (scan(deg,10)) ++t;
    if (t<3) return 1;
    t=0;
    return 0;
}

Stop()
{
    if (loc_x()<500) if (loc_y()<500) q=0; else q=3;
                else if (loc_y()<500) q=1; else q=2;
    dir=45+90*q;
    drive(dir,0);
}

diag()
{
    while ((loc_x()<450) || (loc_x()>550)) { drive(dir,100); Fire(); }

    if ((scan(dir-10,10)) || (scan(dir+10,10)))
    {
        if ((scan(dir-80,10)) || (scan(dir-100,10)))
        { dir+=90; drive(dir); }
        else
        { dir-=90; drive(dir); }
    }

    while ((loc_x()<850) && (loc_x()>150) &&
           (loc_y()<850) && (loc_y()>150)) { drive(dir,100); Fire(); }
    Stop();
}

Fire(flag)
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (orng>700)
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
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
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

