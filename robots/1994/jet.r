
/*
        Jet.r

        Robot sperimentale
        (c) 1992 ++dmitrij; soft
        
        Autore.....:    Mario  MEO - COLOMBO
        
        Strategia..:    Il robot percorre in senso antiorario il perimetro
                        dell'arena, alla massima velocita', sparando alla
                        impazzata. La sua velocita' dovrebbe essere un suo
                        punto di forza, mentre l'alta risoluzione adottata
                        per lo scan() riesce a fargli ottenere buone per -
                        entuali di danneggiamento degli avversari.
*/


int     degree, verso;


spara_veloce()
{
        if ( range = scan( degree, 2 ) )
                cannon( degree, range);
        else
                degree -= 4;
} /* end spara_veloce() */

spostati()
{
        verso += 90;
        verso %= 360;

        drive( verso, 100 );
        if ( verso == 0 ) {
                while ( loc_x() < 950 )
                        spara_veloce();
        } else if ( verso == 90 ) {
                while ( loc_y() < 950 )
                        spara_veloce();
        } else if ( verso == 180 ) {
                while ( loc_x() > 50 )
                        spara_veloce();
        } else if ( verso == 270 ) {
                while ( loc_y() > 50 )
                        spara_veloce();
        } /* endif */
        drive( verso, 0 );
        while ( speed() )
                spara_veloce();
} /* end spostati() */


main()
{
        verso = 270;


        while (1)
                spostati();

} /* end main() */

