/* POGNANT.R */
/* Andrea Tenderini */

int range;  /* valore restituito dalla scan() */
int ang;    /* angolo di scansione attuale */
int angi;   /* angolo di inizio scansione */
int angf;   /* angolo di fine scansione */

main()
{
    /* il robot si posiziona lungo il lato orizzontale superiore */
    angi = 0;
    angf = 360;
    ang = angi;
    drive(90,100);
    while(loc_y() < 950)  scanna();
    drive(180,0);
    while(speed() > 49)   scanna();

    while(1)
    {

/* Il robot si muove lungo il primo lato (orizzontale superiore). */
/* Nel frattempo scandisce e spara, fino a quando non si trova prossimo */
/* al muro di fronte. Quindi rallenta e gira di 90 gradi. */
/* L'operazione viene ripetuta sui quattro lati. */

/* L'aggiornamento delle variabili angi e angf serve a far puntare */
/* lo scanner non contro al muro. */

        angi = 160;
        angf = 380;
        ang = angi;
        drive (180,100);
        while (loc_x() > 60) scanna();
        drive (270,0);
        while(speed() > 49)  scanna();

        angi = 250;
        angf = 470;
        ang = angi;
        drive (270,100);
        while (loc_y() > 50) scanna();
        drive (0,0);
        while(speed() > 49)  scanna();

        angi = -20;
        angf = 200;
        ang = angi;
        drive (0,100);
        while (loc_x() < 950) scanna();
        drive (90,0);
        while(speed() > 49)   scanna();

        angi = 70;
        angf = 290;
        ang = angi;
        drive (90,100);
        while (loc_y() < 950) scanna();
        drive (180,0);
        while(speed() > 49)   scanna();
    }
}

scanna()
{

/* Se lo scanner e' orientato verso un nemico gli sparo */

    if (range = scan(ang, 5))
        cannon (ang ,7 * range / 8);
    else
    {

/* Altrimenti scandisco velocemente fino a quando non ne trovo e gli sparo */
/* Se supero i limiti angi o angf, assegno a ang il valore angi */
 
        ang -= 20;
        if (ang < angi)
            ang = angi;
        while((range = scan(ang, 10)) == 0)
        {
            ang +=20;
            if (ang > angf)
                ang = angi;
        }
        if (range < 60)
            range = 60;
        if (range <= 700)
            cannon (ang, range);
    }
}


