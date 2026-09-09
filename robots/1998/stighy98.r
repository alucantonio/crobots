/*
        Stighy98.r

	CREATO DA : MATTEO STUCCHI
	
	Inizialmente Stighy98 cerca dei nemici per colpirli subito,
	dopodiche' si muove verso il primo angolo libero.
	A questo punto gira da un angolo all'altro cercando di colpire
	i nemici che gli capitano a tiro.
	Il principale difetto di questo robot e' la scarsa precisione
	di fuoco: difatti coi nemici in movimento ha una scarsa mira e
	precisione.
	
	Il robot non e' molto forte... 
	Se dovesse arrivare tra i primi 15 sarei già contento :-)!!!

	Purtroppo sono venuto a conoscenza del CROBOTS solo da pochi giorni
	e non ho avuto modo di poter studiare in modo approfondito i 
	robot degli scorsi tornei.
	Non sono ancora riuscito a capire una cosa di questo CROBOTS :
	come faccio a capire la "fisica" del gioco ??? 
	Devo andare a tentavi ??? 

	Vorrei promuovere una iniziativa : perchè qualcuno che sia molto
	volenteroso non si prende la briga di creare una interfaccia
	grafica per il Crobots (sempre che l'autore del programma non
	sia d'accordo) e ricreare il compilatore di modo che si possa
	superare il fastidioso limite di 1000 istruzioni macchina ?


*/


int   

        posizione,      /* angolo occupato: 1 SW - 2 NW - 3 NE - 4 SE */
        oang,           /* vecchio angolo */
        ang=0,          /* angolo attuale di scansione */
        rng,            /* range attuale */
        orng,           /* vecchio range */
        dam=100,        /* damage attuale */
        odam=0          /* vecchio damage */
        ;


main()
{
        /* Immediata scansione per indivudazione di nemici */
        while(ang < 359 && damage()<5) {
                if( (orng=scan(ang,10)) )
                        spara();
                else ang+=20;
                
        }

                
        /* Determinazione angolo verso cui dirigersi */
        if( (scan(225,10))==0 ) {
                drive(225,80);
                while(loc_x() > 50 && loc_y() >50)
                        ;
                drive(225,0);
                posizione=1;
        }
        else if( (scan(135,10))==0 ) {
                drive(135,80);
                while(loc_x() > 50 && loc_y() < 950)
                        ;
                drive(135,0);
                posizione=2;
        }
        else if( (scan(45,10))==0 ) {
                drive(45,80);
                while(loc_x() < 950 && loc_y() < 950)
                        ;
                drive(45,0);
                posizione=3;
        }
        else if( (scan(315,10))==0 ) {
                drive(315,80);
                while(loc_x() < 950 && loc_y() > 50)
                        ;
                drive(315,0);
                posizione=4;
        }



        while(1) {
                /* guarda in molte direzioni la presenza di robot */
                if(posizione==1) {
                        /* Siamo nell'angolo SW */
                        ang=0;
                        while(ang < 120 && ( (dam=damage()) == odam)) {
                                odam=dam;
                                orng=scan(ang,10);
                                if(orng) spara();
                                else ang+=20;

                                }
                        ang=0;
                }
                if(posizione==2) {
                        ang=250;
                        /* Siamo nell'angolo NW */
                        while(ang < 380 && ((dam=damage()) == odam)) {
                                odam=dam;
                                orng=scan(ang,10);
                                if(orng) spara();
                                else ang+=20;
                                }
                        ang=260;
                }
                if(posizione==3) {
                        ang=160;
                        /* Siamo nell'angolo NE */
                        while(ang < 290 && ( (dam=damage()) == odam)) {
                                odam=dam;
                                orng=scan(ang,10);
                                if(orng) spara();
                                else ang+=20;

                                }
                        ang=180;
                }
                if(posizione==4) {
                        ang=70;
                        /* Siamo nell'angolo SE */
                        while(ang < 200 && ( (dam=damage()) == odam) ) {
                                odam=dam;
                                orng=scan(ang,10);
                                if(orng) spara();
                                else ang+=20;

                                }
                        ang=80;
                }

                /* cambia angolo */
                NuovoAngolo(); 
                odam=dam=damage();

                }
}



/* Routine di fuoco in movimento */
spara()
{
        if( (scan(ang+5,10)) )
                ang+=5;
        else    ang-=5;

        if( (scan(ang+3,5))  )
                ang+=3;
        else    ang-=3;                
        oang=ang;

        if( (scan(ang+1,3))  )
                ang+=1;
        else    ang-=1;


        /* L'angolo e' stato approssimato in modo ottimale */
        if( (orng=scan(ang,5)) )  
                if( (rng=scan(ang,5)) ) 
        /* Da prove effettuate e' ottimo ang X 2 e rng X 4 */
                        cannon(ang - ( (oang-ang)*2), rng+( (rng-orng)*4) );
        if(orng > 700) ang+=20;
}

NuovoAngolo()
{
        ang=0;

        if(posizione==1 ) {
                /* muoversi in posizione 2 */
                /* angolo NW */                
                drive(90, 80);
                while(loc_y() < 920) {
                        orng=scan(ang,10);
                        if(orng) spara();
                        else ang+=20;
                        }                        
                drive(90,0);
                while(speed() > 49) ;                        
                posizione=2;
        }

        else if(posizione==2 ) {
                /* muoversi in posizione 3 */
                /* angolo NE */               
                drive(0, 80);
                while(loc_x() < 920) {
                        orng=scan(ang,10);
                        if(orng) spara();
                        else ang+=20;
                }
                drive(0,0);
                while(speed() > 49) ;                        
                posizione=3;
        }


        else if(posizione==3 ) {
                /* muoversi in posizione 2 */
                /* angolo SE */
                
                drive(270, 80);
                while(loc_y() > 80){
                        orng=scan(ang,10);
                        if(orng) spara();
                        else ang+=20;
                }                        
                drive(270,0);
                while(speed() > 49) ;                        
                posizione=4;
        }

        else if(posizione==4 ) {
                /* muoversi in posizione 1 */
                /* angolo SW */
                
                drive(180, 80);
                while(loc_x() > 80) {
                        orng=scan(ang,10);
                        if(orng) spara();
                        else ang+=20;
                }                        
                drive(180,0);
                while(speed() > 49) ;                        
                posizione=1;
        }

}
