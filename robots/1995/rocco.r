/* Robot ROCCO.R
   Creato nel Settembre 1995 da Romolo Quaranta per il Torneo di MC

   Il Robot gira in senso antiorario i quattro angoli del campo da gioco 
   eseguendo uno scan verso il robot avversario e sparandogli addosso
   ad ogni ciclo
   Esce da un lato quando il danno Š troppo alto per evitare il tiro di un
   robot che sta puntandolo molto efficacemente*/

int deg;                /* gradi dove fa lo scan*/
int range;              /* distanza del target */
int danno;              /* memorizza il danno corrente */

main()
{

  int uscita;           /* flag che se =0 fa uscire dal ciclo*/
  scanna_e_spara();

  /* all'interno dello while principale ci sono 4 cicli ognuno dei quali
     serve per mantenere una delle direzioni che gli consentono
     di girare in senso antiorario nell'arena e poi cerca il nemico e spara*/
  
  drive(90,100);
  while(1)
        {
        danno=damage();
        uscita=1;
        /* corre verso l'alto*/
        while( loc_y() < 930 && speed() && uscita )
                {
                        scanna_e_spara();
                        if(damage()-danno>10) uscita=0;

                }
        drive(180,0);
        while (speed()>50)  scanna_e_spara();
        drive(180,100);
        danno=damage();
        uscita=1;
        /* corre verso sinistra*/
        while( loc_x() > 70  && speed() && uscita ) /*va fino a meta' andando a ovest*/
                {
                        scanna_e_spara();
                        if(damage()-danno>10) uscita=0;
                }
        drive(270,0);
        while (speed()>50)  scanna_e_spara();
        drive(270,100);
        danno=damage();
        uscita=1;
         /* corre verso il basso*/
        while( loc_y() > 70  && speed() && uscita )/* va fino a meta' andano a sud*/
                {
                        scanna_e_spara();
                        if(damage()-danno>10) uscita=0;
                }
        drive(0,0);
        while (speed()>50)  scanna_e_spara();
        drive(0,100);
        danno=damage();
        uscita=1;
         /* corre verso destra*/
        while(loc_x() < 930 && speed() && uscita ) /* va fino a meta' andando ad est*/
                {                  
                        scanna_e_spara();
                        if(damage()-danno>10) uscita=0;
                } 
        drive(45,0);
        while (speed()>50)  scanna_e_spara();
        danno=damage();
        uscita=1;
        while(loc_x() < 800 && speed() && uscita ) /* va fino a meta' andando ad nordest*/
                {                  
                        scanna_e_spara();
                        if(damage()-danno>10) uscita=0;
                } 
        drive(90,0);
        while (speed()>50) scanna_e_spara();
        drive(90,100);
        }

}



/* ricerca un nemico a partire dall'angolo precedente 
   e gli spara due volte con angolo di poco diverso*/

scanna_e_spara()

{
    if (range = scan (deg,10))
        {
        if (range<60) range=60;
        cannon (deg,   range);
        cannon (deg+5, range);
        }
    else
    {
        deg -= 20;
    };
}

