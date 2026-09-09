/*C-robots selvaggio.r tratto da Erica.r*/

int     direzione, distanza, grado;

main()

    {

       direzione = rand(360);  /*Generazione casuale di una direzione per il movimento*/

       grado = rand(360);      /*Direzione del cannone*/

       /*Ciclo infinito*/

       while (1){

                 drive(direzione, 100); /* Muovi il robot con velocità massima*/

 

                 /*Controlli per il cambio di direzione in prossimità dei bordi*/

                 if (loc_y() > 850 )

                    direzione = 180 + rand(180);

                 if (loc_y() < 150)

                    direzione = rand(180);

                 if (loc_x() > 850 )

                    direzione = 90 + rand(180);

                 if (loc_x() < 150 )

                    direzione = 270 + rand(180);

                

                 /*Attiva il radar in un certo settore del piano*/

                 distanza = scan (grado,20);

 

                 /*Se la scan ha individuato un nemico allora può sparare*/

                 if (distanza > 0 )

                    cannon(grado, distanza);

                      else

                         /*Se la scan ha fallito cambia il settore di scansione*/

                        grado = grado+20;

 

       }/*Fine del while*/

}/*Fine del main*/