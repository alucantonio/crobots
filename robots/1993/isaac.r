/*  == Isaac ==  di  Federico Macchi   17/07/1993

    Questo robot si muove velocemente sulla diagonale che va dall'angolo 
    in basso a sinistra a quello in alto a destra, in modo da non essere
    mai molto lontano dagli altri robot. Spara in continuazione correggendo
    il tiro di un 10% sulla distanza, a seconda che il robot nemico si stia
    allontanando o avvicinando
*/

int ang, newrange, oldrange;

main()
{
        ang=0;
        drive(180,100);                         /* Si porta verso l'angolo
                                                   in basso a sinistra */
        while(loc_x()>69 && speed()) spara();
        drive(270,0);
        while(speed()>49) spara();
        drive(270,100);
        while(loc_y()>69 && speed()) spara();
        drive(180,0);

        while(1) {                           /* Routine di movimento principale
                                                lungo la diagonale */
                drive(45,0);
                while(speed()>49) spara();

                drive(45,100);
                while(loc_x()<931) spara();

                drive(225,0);
                while(speed()>49) spara();

                drive(225,100);
                while(loc_x()>69) spara();
        }
}

spara()
{
        if(newrange=scan(ang,10)) {            /* Routine unica di sparo */
                if(newrange>oldrange) {
                        cannon(ang,newrange*11/10);
                        oldrange=newrange;
                        }
                else {
                        cannon(ang,newrange*9/10);
                        oldrange=newrange;
                }
        }
        else 
                ang=(ang+20)%360;
}

