/*

                        ==     HAL  9000     ==
                        ==    versione 1.0   ==
                        ==     06-06-1994    ==

Autore: Maurizio Camangi

Strategia:
        Abbastanza complessa, il Crobot rimane fermo finche' non viene
        colpito da una bomba che gli procura un danno maggiore o uguale
        al 5%. Si sposta poi nell'angolo a sud-ovest del campo di
        battaglia. Da qui in poi il percorso che puo' compiere e' di
        forma triangolare (i cateti sono a ovest e a sud) e rimane
        fermo su ogni vertice finche' non viene colpito da una bomba
        vicina (5% o piu' di danni). Memorizza poi i danni durante ogni
        spostamento e sceglie il lato successivo dove ha subito meno danni.
        La funzione di fuoco e' piuttosto complessa e si basa sulla
        correzione dell'angolo e della gittata in base allo spostamento
        proprio e dell'avversario.
Commento:
        E' un Crobot ibrido, un po' tra Godel e Mister2 (che e'
        di mio cugino!), c'e' anche un po' di Secro, un Crobot
        americano. Alla fine e' venuto fuori un Crobot tutto mio!
        La routine Fire() e' il cuore dell'attacco, non assomiglia
        (mi pare) a nessun'altra routine. Come HAL 9000 di "2001
        Odissea nello spazio" ha i sui punti deboli.
        Come sconfiggerlo :
        costringerlo a stare fermo il meno possibile nei vertici
        colpendolo con molta precisione!.
*/

int ang, range, orange, recharge, delta, h, count;
int d, dmax, loc_dam, dir;

main()  /* Main() routine  data: 27-04-1994 */
{
        ang=22;
        loc_dam=0;
        dmax=9;
        find();
        while(loc_dam < 5) {
                fire_stop();
                if (ang > 360) ang%=360;
        }
        drive(dir=270,100);
        while (loc_y() > 105) fire();
        drive(dir=180,0);
        despeed();
        drive(dir,100);
        while(loc_x() > 105) {
                fire();
                if (ang > 190) ang=0;
        }
        l1up();
}

l1up()                                  /* Lato Ovest, direzione Nord */
{
        drive(dir=90,0);
        despeed();
        while(loc_dam < 5) {            /* Per adesso fermo */
                fire_stop();
                if (ang > 100) ang=0;
        }
        gospeed();                      /* Ok, direzione Nord */
        while (loc_y() < 895) {
                fire();
                if ((ang > 100) && (ang < 260)) ang=270;
        }
        if (flag()) {                   /* Ho subito piu' danni */
                dmax=damage() - d;
                dig1();                 /* Cambia direzione */
        } else l1down();                /* Altrimenti rimani su questo lato */
}

l1down()                                /* Lato Ovest, direzione Sud */
{
        drive(dir=270,0);
        despeed();
        while(loc_dam < 5) {            /* Come prima! */
                fire_stop();
                if ((ang < 260) || (ang > 370)) ang=270;
        }
        gospeed();
        while (loc_y() > 105) {
                fire();
                if ((ang > 100) && (ang < 260)) ang=270;
        }
        if (flag()) {
                dmax=damage() - d;
                l2right();
        } else l1up();
}

l2right()                               /* Lato Sud, direzione Est */
{
        drive(dir=0,0);
        despeed();
        while(loc_dam < 5) {
                fire_stop();
        if ((ang > 100) && (ang < 350)) ang=0;
        }
        gospeed();
        while (loc_x() < 895) {
                fire();
                if (ang > 190) ang=0;
        }
        if (flag()) {
                dmax=damage() - d;
                dig2();
        } else l2left();
}

l2left()                                /* Lato Sud, direzione Ovest */
{
        drive(dir=180,0);
        despeed();
        while(loc_dam < 5) {
                fire_stop();
                if ((ang > 190) || (ang < 80)) ang=90;
        }
        gospeed();
        while (loc_x() > 105) {
                fire();
                if (ang > 190) ang=0;
        }
        if (flag()) {
                dmax=damage() - d;
                l1up();
        } else l2right();
}

dig1()                                  /* Diagonale, direzione Sud-Est */
{
        drive(dir=315,0);
        despeed();
        while(loc_dam < 5) {
                fire_stop();
                if ((ang < 260) || (ang > 370)) ang=270;
        }
        gospeed();
        while ((loc_x() < 895) && (loc_y() > 105)) fire();
        if (flag()) {
                dmax=damage() - d;
                l2left();
        } else dig2();
}

dig2()                                  /* Diagonale, direzione Nord-Ovest */
{
        drive(dir=135,0);
        despeed();
        while(loc_dam < 5) {
                fire_stop();
                if ((ang > 190) || (ang < 80)) ang=90;
        }
        gospeed();
        while ((loc_x() > 105) && (loc_y() < 895)) fire();
        if (flag()) {
                dmax=damage() - d;
                l1down();
        } else dig1();
}

/* Utility per raccoglire il codice, indispensabili!!      */
/* Eliminandole il codice supererebbe le 1000 istruzioni!! */

gospeed()                               /* Vai! */
{
        drive(dir,100);
        d=damage();                     /* Salva i danni attuali */
}

despeed()                               /* Fermati! */
{
        loc_dam=0;
        while(speed() > 49) fire();
}

flag()
{
        return((damage() - d) > dmax);
}

/* Le routines d'attacco, le piu' importanti */

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

fire_stop()                             /* Come sopra ma per il robot fermo, */
{                                       /* quindi salva i danni ciclicamente */
        loc_dam=damage();
        fire();
        loc_dam=damage() - loc_dam;
}

/*
  P.S.: L'avrei dovuto chiamare Ceriago.r poiche' l'algoritmo principale
        e' stato concepito il 4 Maggio, S.Ciriaco (Ceriago) patrono di Ancona.
*/

