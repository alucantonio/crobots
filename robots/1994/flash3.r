/*
                        ===      Flash       ===
                        ===   versione 3.0   ===
                        ===  04 - 05 - 1994  ===

Autore: Lorenzo Ancarani

        Flash3 si sposta come i suoi predecessori Flash, Flash2, scritti
        da mio cugino Maurizio, percorrendo in senso antiorario il perimetro
        del campo di battaglia.
        La funzione di fuoco si basa sulla correzione dell'angolo e della
        gittata in base allo spostamento proprio e dell'avversario.

*/

int ang, range, orange, delta, h, count;
int recharge, dir;

main()                /*  main() routine, versione del 6:2:1993 */
{
        ang=22;
        find();
        drive(dir=180,100);
        while (loc_x() > 75) fire();
        drive(dir=270,0);

        while (speed() > 49) fire();
        while (1)
        {
                drive(dir,100);
                while (loc_y() > 80)  {
                        fire();
                        if ((ang < 260) && (ang > 100)) ang = 270;
                }
                drive(dir=0,0);
                while (speed() > 49) fire();
                drive(dir,100);
                while (loc_x() < 920) {
                        fire();
                        if (ang > 190) ang = 0;
                }
                drive(dir=90,0);
                while (speed() > 49) fire();
                drive(dir,100);
                while (loc_y() < 920) {
                        fire();
                        if ((ang < 80) || (ang > 280)) ang = 90;
                }
                drive(dir=180,0);
                while(speed() > 49) fire();
                drive(dir,100);
                while(loc_x() > 65)   {
                        fire();
                        if ((ang < 170) || (ang > 370)) ang = 180;
                }
                drive(dir=270,0);
                while(speed() > 49) fire();
        }
}

find()                                  /* Trova il bersaglio */
{
        ang-=22;
        count=23;
        while((!scan(ang,8)) && (count-=1)) ang+=16;
        if (ang > 360) ang%=360;
        recharge=1;
}

checkit()                               /* Segue il bersaglio */
{                                       /* e migliora la mira */
        h=225;
        orange=range;
        if (range=scan(ang,2)) { delta=0; h=200; }
        else if (range=scan(ang-=4,2)) delta=-7;        /*  -4  */
        else if (range=scan(ang+=8,2)) delta=7;         /*  +4  */
        else if (range=scan(ang-=12,2)) delta=-8;       /*  -8  */
        else if (range=scan(ang+=16,2)) delta=8;        /*  +8  */
        else if (range=scan(ang-=20,2)) delta=-10;      /* -12  */
        else if (range=scan(ang+=24,2)) delta=10;       /* +12  */
        else if (range=scan(ang-=34,10)) delta=-12;     /* -22  */
        else if (range=scan(ang+=44,10)) delta=12;      /* +22  */
        if (range) {                    /* e' ancora sotto tiro */
                range+=((range - orange)*range/h);
                if (speed() > 50) {
                        range+=(cos(ang - dir)*range/900000);
                }
        }
}

shot()                                  /* Procedura di fuoco */
{
        checkit();
        if (range > 40) {
                recharge=cannon(ang + delta,range);
        } else {
                if (range > 0) {        /* Molto vicino ! */
                        recharge=cannon(ang,46);
                }
        }
}

fire()                                  /* Si basa sullo stato del cannone */
{
        if ((range=scan(ang,8)) && (range < 751)) {
                if (!(recharge)) {      /* L'ultima Cannon() e' andata  */
                        shot();         /* a vuoto, ora e' sicuramente  */
                } else recharge=0;      /* carico, allora spara!        */
                if (recharge) checkit();/* Se ho appena sparato, allora */
                shot();                 /* aspetta, ricalcola e spara!  */
        } else find();                  /* Bersaglio da trovare!        */
}

