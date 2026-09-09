/****************************************************************************/
/*                                                                          */
/*  VIII Torneo di CRobots di MCmicrocomputer (1998)                        */
/*                                                                          */
/*  CROBOT: TORNADO.R                                                       */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere l'altro crobot (GOBLIN.R)    */

/*               
                          SCHEDA TECNICA:

   La strategia di gioco Š la stessa di Goblin.r (vedi relativa scheda) tranne
   che per una cosa: invece di defilarsi negli angoli utilizza un movimento a
   forma di triangolo nell'angolo in cui si trova.

*/

int rng,orng,dir,deg,odeg,x,y,q,t;

main()
{
/* Vai nell'angolo pi— vicino: */

    if (loc_x()<500) xmag(130,180,0); else xmin(870,0,0);
    if (loc_y()<500) ymag(130,270,0); else ymin(870,90,0);

/* Ciclo principale */
    while(1)
    {
            /* Oscillazioni nell'angolo */

            while ((!orng || orng>300) && UpDown())
            {
                /* Controlla se Š rimasto un unico avversario */
                if (t>15)
                {
                    deg=-10; t=3;
                    while((deg+=20)!=710) if (scan(deg,10)) --t;
                    if (t>0) { Stop(); while(1) diag(); }   /* Attacca!!! */
                }

                if (loc_x()<500) if (loc_y()<500)
                         { xmin(180,0,1); xmag(70,135,1); ymag(70,270,1); }
                         else
                         { ymag(820,270,1); ymin(930,45,1); xmag(70,180,1); }
                else if (loc_y()<500)
                         { ymin(180,90,1); ymag(70,225,1); xmin(930,0,1); }
                         else
                         { xmag(820,180,1); xmin(930,315,1);ymin(930,90,1); }
            }

            /* Cambia Angolo */
            if (t<=15) if (UpDown()) Move();
    }
}

f1(ff) { drive(dir,100); Fire(ff); }

xmag(x,d,f) { dir=d; while(loc_x()>x) f1(f); drive(d,0); }
xmin(x,d,f) { dir=d; while(loc_x()<x) f1(f); drive(d,0); }
ymag(y,d,f) { dir=d; while(loc_y()>y) f1(f); drive(d,0); }
ymin(y,d,f) { dir=d; while(loc_y()<y) f1(f); drive(d,0); }

Move()
{
    if (loc_x()<500) xmin(870,0,0); else xmag(130,180,0);
}

UpDown()
{
    if (t>15) return 1;

    if (loc_y()<500)
    { if (!scan(80,10) && !scan(100,10)) { ymin(870,90,0); return 0; } }
    else
    { if (!scan(260,10) && !scan(280,10)) { ymag(130,270,0); return 0; } }

    return 1;
}

Stop()
{
    if (loc_x()<500) if (loc_y()<500) q=0; else q=3;
                else if (loc_y()<500) q=1; else q=2;
    drive(dir=45+90*q);
}

diag()
{
    while ((loc_x()<450) || (loc_x()>550)) f1(0);

    if ((scan(dir-10,10)) || (scan(dir+10,10)))
      if ((scan(dir-80,10)) || (scan(dir-100,10))) drive(dir+=90); 
      else drive(dir-=90); 

    while ((loc_x()<850) && (loc_x()>150) &&
           (loc_y()<850) && (loc_y()>150)) f1(0);
    Stop();
}

Fire(flag)
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=5,5)) deg+=10;
        if (orng>700) { cannon(deg,700); ++t; deg+=40; return; }

        if (flag)
        {
            if (scan(deg+5,3)) deg+=10; else if (scan(deg-5,3)) deg-=10;
            if (rng=scan(deg,10)) cannon(deg,2*rng-orng);
        }
        else
        {
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
                cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                       rng*160/(160+orng-rng-(cos(deg-dir)>>12)));
            }
        }
        }
     }
     else
     {
        if (scan(deg-=20,10)) ;
        else if (scan(deg+=40,10)) ;
        else deg+=40;

        return;
     }
     t=0;
}


