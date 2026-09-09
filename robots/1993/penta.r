/*  Robot: Penta.r ideato da:       */
/*                                  */
/*  Stefano Giacomini               */

/*  Strategia:                                           */
/*  Il robot si muove su un pentagono al centro del      */
/*  quadrato di combatimento con velocita' 50.           */
/*  Quando il danneggiamento supera l' 85% si posiziona  */
/*  in prossimita' di uno dei quattro angoli e continua  */
/*  a sparare.                                           */


int ang, angd, nr, or,c,an,inf,sup;

main () {

        ang=360; 
        
        /* Si posiziona nel punto di partenza: x=250, y=550  */
        if (loc_y() > 550) {
                drive(270,50);
                while(loc_y() > 550) spara();
                drive(270,0);
                while (speed() > 10) spara();
        }
        if (loc_y() < 550) {
                drive(90,50);
                while(loc_y() < 550) spara();
                drive(90,0);
                while (speed() > 10) spara();
        }
        if (loc_x() > 250) {
                drive(180,50);
                while(loc_x() > 250) spara();
                drive(180,0);
                while (speed() > 10) spara();
        }
        if (loc_x() < 250) {
                drive(0,50);
                while(loc_x() < 250) spara();
                drive(180,0);
                while (speed() > 10) spara();
        }

        /* comincia a muoversi sul pentagono */
        angd=216;  /* angd: direzione attuale da seguire  */
        while(1) {
                angd += 72;
                if (angd > 360) angd = 72;
                drive(angd,50);
                c=0;
                while (c < 40) {
                        ++c;

                        /* routine di sparo con correzione della distanza */
                        if (nr = scan(ang,10)) {
                                if (or < nr) 
                                        cannon(ang, 106*nr/100);
                                else 
                                        cannon(ang, 93*nr/100);
                                or = nr;
                        }
                        else {
                                ang -= 20;
                                if (ang < 0) ang = 360;
                        }

                }

                /* controlla il danneggiamento */
                if (damage() > 85) {

                        /* si ferma e sceglie a caso un angolo in cui andare */
                        drive(angd,0); 
                        an=rand(4); 
                        while(speed() > 10) spara();

                        /* va nell'angolo scelto */
                        if (an == 0) {
                                drive(180,100);
                                while(loc_x() > 80) spara();
                                drive(180,0);
                                while (speed() > 49) spara();
                                drive(270,100);
                                while(loc_y() > 80) spara();
                                drive(270,0);
                                while (speed() > 49) spara();
                                inf = 350; sup= 460; 
                        }
                        if (an == 1) {
                                drive(0,100);
                                while(loc_x() < 920) spara();
                                drive(0,0);
                                while (speed() > 49) spara();
                                drive(270,100);
                                while(loc_y() > 80) spara();
                                drive(270,0);
                                while (speed() > 49) spara();
                                inf = 80; sup= 190; 
                        }
                        if (an == 2) {
                                drive(0,100);
                                while(loc_x() < 920) spara();
                                drive(0,0);
                                while (speed() > 49) spara();
                                drive(90,100);
                                while(loc_y() < 920) spara();
                                drive(90,0);
                                while (speed() > 49) spara();
                                inf = 170; sup= 280; 
                        }
                        if (an == 3) {
                                drive(180,100);
                                while(loc_x() > 80) spara();
                                drive(180,0);
                                while (speed() > 49) spara();
                                drive(90,100);
                                while(loc_y() < 920) spara();
                                drive(90,0);
                                while (speed() > 49) spara();
                                inf = 260; sup= 370; 
                        }
                        ang=sup;

                        /* nuova routine di sparo con coefficienti   */
                        /* corretti per lo sparo da fermo            */
                        while (1) {
                                if (nr = scan(ang,5)) {
                                        if (or < nr) 
                                                cannon(ang, 117*nr/100);
                                        else 
                                                cannon(ang, 84*nr/100);
                                        or = nr;
                                }
                                else {
                                        ang -= 10;
                                        if (ang < inf) ang = sup;
                                }
                        }
                }
        }
}

/* la funzione spara() viene richiamata solo           */
/* durante il posizionamento nel punto di partenza     */
/* e durante lo spostamento negli angoli               */
spara() {
        
        if (nr = scan(ang,10)) {
                if (or < nr) 
                        cannon(ang, 106*nr/100);
                else 
                        cannon(ang, 93*nr/100);
                or = nr;
        }
        else {
                ang -= 20;
                if (ang < 0) ang = 360;
        }
}
