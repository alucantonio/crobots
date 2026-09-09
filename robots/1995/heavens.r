/* Robot HEAVENS.R
   Creato nel Settembre 1995 da Massimo Paradisi per il Torneo di MC

   Il Robot si dirige verso il basso ed una volta raggiunto il fondo
   si muove a destra e sinistra sul lato pi— basso del campo di gioco.
   Durante il movimento esegue una routine di scanna_e_spara durante il
   percorso.
   */



int deg;            /* angolo di ricerca dei nemici */
int range;          /* distanza del nemico */
int incdeg;         /* incremento (+20 / -20) che da allo scan() */
int oldrange;       /* memorizza il vecchio valore del range */

main()
{
    /* dirige verso il basso e si ferma a circa 70 di distanza dal bordo */
    deg=10;
    incdeg=20;
    while(loc_y()>70)
    {
    drive(270,100);
    scanna_e_spara();
    }


    while (1)
    {

        /* dirige verso sinistra ricercando i nemici e sparandogli addosso */
        drive (180,100);
        while (loc_x() > 110 && speed())
        {
           scanna_e_spara();
        };
        while (speed() > 50) drive (0,50);

        /* dirige verso destra ricercando i nemici e sparandogli addosso */
        drive (0,100);
        while (loc_x() < 890 && speed())
        {
            scanna_e_spara();
        };
        while (speed() > 50) drive (180,50);
    };
}



/* prima fa una ricerca stretta all'angolo precedente. Se non trova niente
   allarga il raggio scanna la parte nord del campo a spazzola, come un
   tergicristallo*/

scanna_e_spara()

{
    /*spara subito al presunto deg con uno scan stretto, se lo trova spara*/

    /*memorizza il vecchio range*/
    oldrange=range;

    if (range=scan(deg,5))  cannon(deg+incdeg,range+range-oldrange);

    else

    {
        /* se trova un roboto gli spara, altrimenti incrementa l'angolo e torna
           al ciclo principale*/
        if (range = scan (deg,10))
            {
            if (range<60) range=60;
            cannon (deg, range+range-oldrange);
            }
        else
        {
            /* a seconda di dove Š arrivata la spazzolata mette incdeg
               ad un valore positivo o negativo per tornare indietro*/
            deg = deg + incdeg;
            if(deg==170)         incdeg=-20;
            else
            if(deg==10)          incdeg=20;
        }
    }
}

