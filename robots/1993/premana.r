/* PREMANA.R */
/* Andrea Tenderini */

int range;  /* valore restituito dalla scan() */
int ang;    /* angolo di scansione attuale */
int danni;  /* percentuale di danni */
int k;      /* correzione casuale allo spostamento */

main()
{
    /* il robot si posizione nel primo punto di coordinate x:250 y:750 */

    /* prima verifica le condizioni per la coordinata y */
    if (loc_y() < 700)
    {
        drive(90,100);
        while(loc_y() < 700)  scanna();
        drive(180,0);
        while(speed() > 49)   scanna();
    }
    else
    {
        drive(270,100);
        while(loc_y() > 800)  scanna();
        drive(180,0);
        while(speed() > 49)   scanna();
    }

    /* quindi per la coordinata x */

    if (loc_x() > 300)
    {
        drive(180,100);
        while(loc_x() > 300)  scanna();
        drive(315,0);
        while(speed() > 49)   scanna();
    }
    else
    {
        drive(0,100);
        while(loc_x() < 200)  scanna();
        drive(315,0);
        while(speed() > 49)   scanna();
    }

    while(1)
    {
        /* calcolo della correzione casuale */
        k = rand(150);

        /* aggiorno le variabili */
        ang = 0;
        danni = damage();

        /* fino a quando scanna restituisce 0 continuo a richiamarla */
        while(scanna());

        /* quando scanna() restituisce un numero diverso da 0 */
        /* mi sposto nel secondo punto */
        drive(270,100);
        while(loc_y() > (300-k)) scanna();
        drive(0,0);

        /* ripeto le operazioni precedenti per gli altri punti */
        danni = damage();
        while(scanna());
        drive(0,100);
        while(loc_x() < (700+k)) scanna();
        drive(90,0);

        danni = damage();
        while(scanna());
        drive(90,100);
        while(loc_y() < (700+k)) scanna();
        drive(180,0);

        danni = damage();
        while(scanna());
        drive(180,100);
        while(loc_x() > (300-k)) scanna();
        drive(270,0);

    }
}

int scanna()
{

/* Se lo scanner e' orientato verso un nemico gli sparo */
    if (range = scan(ang, 3))
        cannon (ang ,range);
    else
    {
/* Altrimenti scandisco velocemente fino a quando non ne trovo */
/* e gli sparo 3 colpi */

        ang -= 13;
        if (range = scan(ang, 10))
        {

/* Se il robot e' stato colpito ritorno 0 (faccio muovere il robot) */

            if ((damage() - danni) > 0)
                return 0;
            if (range < 60)
                range = 60;
            cannon (ang,7 * range / 8);
            cannon (ang-12,range);
            cannon (ang+12,range);
            ang += 20;
        }
    }

/* altrimenti restituisco un valore che ha 1/200 di probabilita' di essere 0 */
/* quindi ho la probabilita' del 0,5% di muovermi comunque */

    return rand(200);
}


