/*
        r_Cyborg.r

        Robot sperimentale
        Ver 2.10 del 14.09.1993

        (c) 1992,93 by ++dmitrij; soft

        Autore.....:    Mario   MEO - COLOMBO

        Strategia..:    Il robot si posiziona nei vertici dell'arena di
                        combattimento ed esegue una scansione del solo angolo
                        retto rimanente. Se trova un altro robot, lo segue con
                        lo scanner, ed appena e' a tiro spara, calcolando la
                        gittata in funzione delle velocita' relative.
                        Se il robot viene colpito, passa al vertice successivo
                        (muovendosi in senso antiorario), spostandosi alla mas
                        sima velocita' consentita e sparando a qualsiasi cosa
                        incontri. Giunto al nuovo vertice ripende la strategia
                        precedente.
*/


int     ang, counter, degree, delta, _damage, oldrange, range, newrange, verso;


spara()
{
        int loc_degree;

        if ( (degree < (verso + 74)) || (degree > (verso + 196)) ) {
                degree = verso + 90;
                delta = 2;
        }
        if ( newrange = scan( degree, 2 ) ) {
                loc_degree = degree;
                degree -= (2*delta);
        }
        if ( (newrange < 700) && (newrange > 0) ) {
                if ( oldrange < newrange ) {
                        cannon( loc_degree, 8 * newrange / 7);
                        oldrange = newrange;
                } else if ( oldrange > newrange ) {
                        cannon( loc_degree, 7 * newrange / 8);
                        oldrange = newrange;
                } else
                        cannon( loc_degree, newrange );
                counter = 0;
        } else
                degree += delta;
        if ( degree > (verso + 190) )
                delta = -2;
        if ( degree < (verso + 80) )
                delta = 2;
} /* end spara() */

spara_veloce()
{
        if ( range = scan( ang, 10 ) )
                cannon( ang, range );
        else
                ang -= 20;
} /* end spara_veloce() */

spostati()
{
        verso += 90;
        verso %= 360;
        delta = 2;
        counter = 0;
        ang = degree;

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
        degree = ang;
} /* end spostati() */


main()
{
        _damage = verso = 270;

        spostati();
        while ( 1 ) {
                spara();
                if ( _damage != damage() ) {
                        spostati();
                        _damage = damage();
                } /* endif */
        } /* endwhile */
} /* end main() */
