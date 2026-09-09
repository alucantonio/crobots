/* -------------------------------------------------------------- */
/*  ROBOT:          Kami                                          */
/*                                                                */
/*  Programma terminato il 6 settembre 1993                       */
/*                                                                */
/*                      Paolo Pepe                                */
/* -------------------------------------------------------------- */

int     step,
        old_dst,
        target,
        dir_sca,
        i;
main()
{
    dir_sca=269;
    step=4;
    i=0;
    drive(180,100);     /* kami si sposta verso l'angolo in alto a sinistra */
    while(loc_x()>90);
    drive(180,0);
    while(speed()>49);
    drive(90,100);
    while(loc_y()<920);
    drive(180,0);
    while(1)
        {
                spara();  /* quando arriva comincia sparare*/
                if(i>=3376) /*il robot si suicida dopo circa n*54 cicli n è il valore max di i*/
                        drive(180,100);
         }             
}
    spara() /* la funzione spara() controlla lo schermo con apertura di scan() uguale a quattro*/
{

        if(i<=2200)
        {
                if((target = scan(dir_sca, step))!=0 && target<700)
                {
                        if(old_dst < target)                     /* se il bersaglio si allontana*/
                        {
                                cannon(dir_sca, 8 * target / 7); /* spara più lontano della distanza*/
                                old_dst = target;                /*data da scan()*/
                        }
                        else                                     /* spara più vicino della distanza*/
                        {
                        cannon(dir_sca, 7 * target / 8); /*data da scan()*/
                        old_dst = target;
                        }
                } 
                else   
                {
                        dir_sca += step*2;
                        if (!(dir_sca >=259 && dir_sca <=369)) 
                        step=-step;
                }
        }
        else
        {
                if((target = scan(dir_sca, step))!=0)
                {
                        if(old_dst < target)                     /* se il bersaglio si allontana*/
                        {
                                cannon(dir_sca, 8 * target / 7); /* spara più lontano della distanza*/
                                old_dst = target;                /*data da scan()*/
                        }
                        else                                     /* spara più vicino della distanza*/
                        {
                        cannon(dir_sca, 7 * target / 8); /*data da scan()*/
                        old_dst = target;
                        }
                } 
                else   
                {
                        dir_sca += step*2;
                        if (!(dir_sca >=259 && dir_sca <=369)) 
                        step=-step;
                }
        }
        ++i;
        return(1);
}




