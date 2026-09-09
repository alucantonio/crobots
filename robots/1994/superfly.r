/*-------------------------------------------------------------------------*/
/*  SUPERFLY.R                  Programmato da:  Ugolini Davide            */
/*                                                                         */
/* Questo cRobot rimbalza a 45 gradi contro i lati dell'area,    _______   */
/* con un'angolo di deviazione di 90 gradi,                     |  / \  |  */
/* mentre si muove viaggia con uno speed() massimo di 100,      |<     >|  */
/* quando ribalza lo speed() scende fino a 45.                  |  \ /  |  */
/* Il movimento viene eseguito in senso antiorario,              ~~~~~~~   */
/* durante gli spostamenti viene usata una routine unica di fuoco          */
/* che fa uno scan a 360 con step di 20 e risoluzione di 10,               */
/* fino a quando non e' stato trovato il bersaglio,                        */
/* appena trovato fa un cannon() con un range che viene corretto in base   */
/* a quello precedente sommando o sottraendo la differenza solo            */
/* se il range si trova sopra a 300, altrimenti fa un cannon() normale.    */
/* (Mi sembra che questa tecnica dia dei buoni risultati)                  */
/* Dopo il cannon lo scan riprende da 50 gradi piu indietro,               */
/* riniziando il ciclo di scan.                                            */
/*-------------------------------------------------------------------------*/

int d,r,o;

main() { drive(180,100); while(loc_x()>100) fire(); 
         drive(180,  0); while(speed()>45) fire();
         drive( 90,100); while(loc_y()<500) fire();
         drive( 90,  0); while(speed()>45) fire();
         drive(270,100); while(loc_y()>500) fire();
         while(1) {
                    drive(135,  0); while(speed()>45) fire();
                    drive( 45,100); while(loc_y()<850) fire(); 
                    drive( 45,  0); while(speed()>45) fire(); 
                    drive(315,100); while(loc_x()<850) fire(); 
                    drive(315,  0); while(speed()>45) fire(); 
                    drive(225,100); while(loc_y()>150) fire(); 
                    drive(225,  0); while(speed()>45)  fire();
                    drive(135,100); while(loc_x()>150) fire(); 
                  }
         }

fire() { d+=20;
         if (r=scan(d,10)) {
            if (r>300) {
               if (r>o) cannon(d,r+(r-o)); 
               if (r<o) cannon(d,r-(o-r));
            } else cannon(d,r);
            o = r;
            d += 290;
         }
       }

