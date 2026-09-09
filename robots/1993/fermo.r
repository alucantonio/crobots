/*
        Fermo.r

        Robot sperimentale (dovrebbe riuscire a battere robocop2)
        Ver 1.00 del 24.12.1993

        (c) 1992 by ++dmitrij; soft

        Autore.....:    Mario   MEO - COLOMBO

        Strategia..:    Il robot si posiziona immobile circa al centro della
                        arena di combattimento, neutralizzando la routine di
                        fuoco di robocop2. Perde praticamente contro tutti
                        gli altri robot, ma riesce a battere robocop2.
*/


int     ang, range;


spara()
{
        if ( range = scan( ang, 10 ) )
                cannon( ang, range );
        else
                ang += 20;
}


main()
{
        if ( loc_x() < 500 ) {
                drive( 0, 49 );
                while ( loc_x() < 500 )
                        spara();
        } else {
                drive( 180, 49 );
                while ( loc_x() > 500 );
                        spara();
        }
        drive( 0, 0 );
        if ( loc_y() < 500 ) {
                drive( 90, 49 );
                while ( loc_y() < 500 )
                        spara();
        } else {
                drive( 270, 49 );
                while ( loc_y() > 500 );
                        spara();
        }
        drive( 0, 0 );

        while ( 1 )
                spara();
}
