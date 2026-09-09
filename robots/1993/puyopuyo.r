/* -------------------------------------------------------------- */
/*  ROBOT:          PuyoPuyo                                      */
/*                                                                */
/*  Programma terminato il 30 agosto 1993                         */
/*                                                                */
/* -------------------------------------------------------------- */










int     dir_sca,  /*direzione dello scan*/
        
        dir_rob,  /*direzione del robot*/
        
        old_dst,  /*memorizza il valore restituito dall'ultima funzione di scan*/ 
        
        dam_old,  /*qui viene memorizzato il danno */
        
        target,   /*distanza del bersaglio*/
        
        a,        /*indicatore di pericolo(per valori negativi inizia l'emergenza*/
        
        switch,   /*assume il valore 1 durante le emergenze e 0 quando non c'è pericolo*/
        
        schiavo,        
        servo,
        
        spia;     /*variabile usata per invertire il moto del robot in situzioni di pericolo*/ 
        
main()
{
        schiavo=0;      
        servo=0;
        switch=0;
        a=1;
        inizio();  
          
        
        
        while(1)
        {
                muoviy(90,270,10,0,50);                              
                latobasso();
                
                muovix(0,180,10,50,100);
                
        }
}
spara(min,max,step)
int     min,      /* i primi due parametri indicano gli estremi dell'area da controllare*/
        max,
        step;     /* apertura dello scan */
{
        /* la funzione di sparo si limita a controllare l'area indicata(min max)             */
        /* variando la direzione dello scan di un angolo 2*step.                             */
        /* Quando il bersaglio viene trovato la direzione dello scan non viene modificata    */
        /* fino a quando il bersaglio è inquadrato dallo scan oppure fino a quando           */                          
        /* si ritiene utile sparargli                                                        */
        /* l'ultima condizione è verificata dallo stato della variabile switch               */
        /* Quando c'e' pericolo switch è uguale a zero e quindi vengono trascurati i bersagli */
        /* più distanti(target<400) per concentrarsi su quelli vicini                       */
        /* Quando non c'e pericolo non si trascura alcun bersaglio                           */       
        
        if(switch==0)   /*se c'e' pericolo*/
        {
                if ((target = scan(dir_sca, step))!=0 && target<400)
                {
                        if (old_dst < target) 
                        {                                       /* la gittata cambia se il*/
                               cannon(dir_sca, 8 * target / 7); /* bersaglio si allontana*/
                               old_dst = target;                /* o si avvicina*/
                        
                        }
                        else
                        {
                               cannon(dir_sca, 7 * target / 8);
                               old_dst = target;/* si memorizza la distanza del bersaglio*/
                                                /* per controllarne il movimento*/
                        }
                }
                else
                {
                        dir_sca -= 2*step;
                        if (dir_sca < min-10 || dir_sca > max+10)
                              step=-step; /*si inverte l'incremento della direz dello scanner*/
                        
                        ++a;  /*non ci sono nemici quindisi diminusce lo stato di allerta*/
                }                                       /* vedi funzioni tiro() ed emerchk()*/
                
                sparads(dir_rob);
        }
        else if(switch==1)                              /* se non c'e' pericolo */
        {
                if ((target = scan(dir_sca, step))!=0)
                {
                        if (old_dst < target) 
                        {
                                cannon(dir_sca, 8 * target / 7);
                                old_dst = target;
                                
                        }
                        else
                        {
                                cannon(dir_sca, 7 * target / 8);
                                old_dst = target;
                                
                        }
                }
                else
                {
                        dir_sca -= 2*step;
                        if (dir_sca < min-10 || dir_sca > max+10) 
                                step=-step; 
                        
                }
                
        }
}


muovix(min,max,step,mind,maxd)  /* questa funzione fa muovere orizzontalmente il robot*/
int     min,
        max,
        step,                   /* per il significato dei parametri vedi muoviy()   */
        mind,
        maxd;
{
                                /* la funzione si comporta in maniera analoga a muoviy()*/
        spia=1;
        schiavo=0;
        servo=0;
        dam_old=damage();

                while(1)
                {       
                        spia=1;
                        if(loc_x()<850 && spia==1)
                        {
                                dir_rob=0;
                                drive(dir_rob,100);
                        }
                        while(loc_x()<850 && spia==1)
                        {
                                if(damage()<mind || damage()>=maxd)
                                        return(0);
                                spara(min,max,step);
                                
                                
                                emerchk();

                                tiro();

                        }
                        spia=1;    
                        drive(dir_rob,0);
                        while(speed()>0)           
                                spara(min,max,step);
                                             
                        if(loc_x()>150 && spia==1)
                        {                               
                                dir_rob=180;            
                                drive(dir_rob,100);
                        }                               
                        while(loc_x()>150 && spia==1)
                        {                               
                                if(damage()<mind || damage()>=maxd)
                                        return(0);      
                                spara(min,max,step);
                                
                                emerchk();

                                tiro();
                        }
                        drive(180,0);
                        while(speed()>0)
                                spara(min,max,step);
                        
                }      
}


muoviy(min,max,step,mind,maxd)  /* questa funzione fa muovere verticalmente il robot    */
int     min,                    /* estremi dell'area da                                 */
        max,                    /* controllare                                          */
        step,                   /* incremento della direzione dello scan                */
        mind,                   /* estremi dell'intervallo entro il quale può variare il*/
        maxd;                   /* danno prima che il controllo si restituito a main()  */                             
{
                                
        spia=1;
        schiavo=0;
        servo=0;
        dam_old=damage();
        
                while(1)
                {       
                        spia=1;
                        if(loc_y()<850 && spia==1)
                        {
                                dir_rob=90;        /*  il robot inverte la direzione*/
                                drive(dir_rob,100);/* e va in basso*/
                        }
                        while(loc_y()<850 && spia==1)
                        {
                                if(damage()<mind || damage()>=maxd) /*se il danno esce dall'intervallo si ritorna a main()*/
                                        return(0);
                                spara(min,max,step);/*richiama la funzione di sparo*/
                                emerchk();/*vedi descrizione della funz*/
                                tiro();   /*vedi descrizione della funz*/      

                        }
                        spia=1;    /*il diversivo per l'emergenza è stato attivato*/
                        drive(dir_rob,0);    /* il robot si ferma*/
                        while(speed()>0)     /* mentre rallenta*/      
                                spara(min,max,step); /* spara*/
                                             

        /*il seguente gruppo di istruzioni è analogo al precedente */
        /*ma stavolta il robot va in alto                          */


                        if(loc_y()>150 && spia==1)
                        {                               
                                dir_rob=270;            
                                drive(dir_rob,100);
                        }                               
                        while(loc_y()>150 && spia==1)
                        {                               
                                if(damage()<mind || damage()>=maxd)
                                        return(0);      
                                spara(min,max,step);
                                
                                emerchk();

                                tiro();
                                
                        }
                        drive(dir_rob,0);
                        while(speed()>0)
                               spara(min,max,step);
                        
                }      
}

emerchk() /*questa funzione controlla periodicamente i danni subiti dal robot e se superano*/
{         /*un certo valore azzera la variabile spia, facendo così cambiare direzione al robot.*/
          /*Inoltre attiva il segnale di emergenza (a<0) che viene controllato da tiro()*/
        
        
                ++schiavo;
                if(schiavo>=4)
                {
                        schiavo=0;
                        if(damage()-dam_old>=7) /* emergenza!! */
                        {
                                spia=0;
                                a=-4;
                        }
                        else
                                a=1;            /*fine emergenza*/
                        dam_old=damage();
                }
}         


tiro() /*questa funzione controllla i messaggi di emerchk() e modifica la procedura di */                      
{      /*sparo se c'e' pericolo e la riporta in condizioni normali quando il pericolo è finito*/
                
                
                if(a<=0 && damage()<70)
                        switch=0;       /*pericolo controlla solo vicino*/
                else if(a>0 || damage()>=70)
                        switch=1;       /*non c'e' pericolo controlla normalmente*/
                if(a<=0 && damage()>=70)
                        a=1;            
}        
sparads(lato)
int lato;
{
        int bers;
        if((bers=(scan(dir_rob,10)))!=0)
        {
                old_dst=bers;
                dir_sca=dir_rob;
        }
        else if((bers=(scan(dir_rob+180,10)))!=0)
        {
                dir_sca=dir_rob+180;
                old_dst=bers;
        }
        return(1);
}

inizio()                               /* questa funzione porta il robot */ 
{                                      /* sul lato sinistro del campo    */
        drive(0,100);
        while(loc_x()<940)
        {
                 while(loc_x()<900)        
                        spara(0,359,10);
        }
        drive(0,0);         
        while(speed()>49);       
        return(1);
}

latobasso()                              /* questa funzione porta il robot */ 
{                                        /* sul lato basso del campo    */
        drive(dir_rob,0);
        while(speed()>49);              
        drive(270,100);                  /*vai giù*/
        while(loc_y()>80)
                spara(270,270+179,10);
        drive(270,0);
        while(speed()>49);       

        drive(180,100);                 /*vai a sinistra*/
        while(loc_x()>100)
                spara(180,359,10);
        drive(180,0);
        while(speed()>49);
                
}
