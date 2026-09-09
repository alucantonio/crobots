/* C-robots vikingo.r realizzato da www.cplusplus.it  */

int     fatto, grado, distanza,y,direzione;

main(){

    

     fatto=0; /*Variabile booleana */

     drive(0,100); /*Muovi il robot verso l’estrema destra*/

     grado=90; /*Imposta la posizione della scansione a 90 gradi*/

    

     /* Fin quando non si raggiunge l’estrema destra (loc_x()>900)

        continua a camminare*/

     while(!fatto){

      if (loc_x()>900){

          /*Raggiunto il lato destro, cambia direzione ed esci dal ciclo*/

          fatto=1;

          direzione=90;

           }

     }

    

           

     while(1){

       

        /*Il seguente blocco serve a far oscillare il robot sul lato destro*/

 

        y=loc_y(); /*Calcola la posizione corrente*/

       

        if(y<150) /* Se viene superato il limite inferiore cambia direzione */

          direzione=90;

       

        if(y>800) /* Se viene superato il limite superiore cambia direzione */

            direzione=270;

            

        drive(direzione,100); /*Muoviti nella posizione stabilita dal blocco precedente*/

       

        /*Funzione di sparo: se la scan ha successo allora spara altrimenti modifica la visuale*/

       

        if (distanza=scan(grado,20))

           cannon(grado,distanza);

              else if(grado>270)

                  grado=90; /*Setta di nuovo la visuale a 90 gradi perché il settore

                            270-360 e 0-90 non ci interessa visto che è alle nostre spalle*/

                    else

                      grado=grado+20;/*Sposta la visuale di 20 gradi in senso antiorario*/

     }

}