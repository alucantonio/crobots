/****************************************************************************/
/*                                                                          */
/*  VI Torneo di CRobots di MCmicrocomputer                                 */
/*                                                                          */
/*  CROBOT: XABARAS.R                                                       */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere l'altro robot (NEWB52.R).    */

/*               
                          SCHEDA TECNICA:

    Il robot gira intorno all'arena di combattimento fermandosi negli angoli.
    Le routines di fuoco sono prese da TEQUILA.r.
*/

int   deg,    /* Angolo di scansione     */
      dir,    /* Direzione di movimento  */
      dam,    /* Danno attuale    */
      t;      /* Timer        */


main()
{

    deg=360002; t=500;     /* Inizializzazione variabili */

/*  FinchŠ non ti colpiscono resta fermo!!! */    

    while ( (! damage()) && t ) { --t; fuoco(); }

/* Gira intorno all'arena, fermandoti agli angoli : */

    while(1)
    {
        dir=270;
        while (loc_y()>120) { drive(dir,100); fuoco2(); }
        stop();

        dir=180;
        while (loc_x()>120) { drive(dir,100); fuoco2(); }
        stop();

        dir=90;
        while (loc_y()<880) { drive(dir,100); fuoco2(); }
        stop();

        dir=0;
        while (loc_x()<880) { drive(dir,100); fuoco2(); }
        stop();
    }
}

/* Routine di gestione del robot da fermo */

stop()        
{
    drive (dir,0);                 /* Fermati           */
    
    t=50;                          /* Aggiorna il Timer */
    
    dam=damage()+1;             /* Aggiorna il danno che puoi subire */
    if (dam>90) t=100000;        /* Se sei ridotto male resta fermo   */
				   /* fino alla fine                    */
	
    while ( (damage()<dam) && t )  /* FinchŠ non aumenta il danno o non */
	  { --t; fuoco(); }        /* passa troppo tempo spara!!!       */

    if (!t) if (radar()>1)  stop();  /* Se non ti hanno colpito, ma c'Š */
				     /* ancora troppa folla rimani fermo */
}



int   odeg,      /* Angolo precedente di scansione */
      df,        /* Angolo corretto per il tiro    */

      alfa,      /* Angolo tra deg e dir                         */
      cos_alfa,  /* Cos(alfa)                                    */
      sin_alfa,  /* Sin(alfa)                                    */
      rng,       /* Variabile di range                           */
      rng2,      /* Posizione precedente del bersaglio           */
      rg;        /* Posizione attuale del bersaglio              */


/* Routine di fuoco da fermo e in movimento */
/* Le routine di fuoco sono state prese da tequila.r  */

fuoco()         
{
    if (find()) spara();
    else    
    {
	deg-=15;
	if (find()) spara();
	else 
	{
	    deg+=30;
	    if (find()) spara();
	    else while (! scan((deg+=19),10)) {}
	}
    }
}

fuoco2()
{
    if (find()) spara2();
    else    
    {
	deg-=15;
        if (find()) spara2();
	else 
	{
	    deg+=30;
            if (find()) spara2();
	    else while (! scan((deg+=19),10)) {}
	}
    }
}

find()    /* Risoluzione: 7   Profondit…: 4  Approssimazioni: 6 */
{
    if (rng=scan(deg,7))
    {
	if (scan(deg+4,3))
	   if (scan(deg+6,2))
	      if (scan(deg+4,1)) deg+=4;
	      else deg+=6;
	   else if (scan(deg+1,0)) deg+=1;
		else deg+=2;
	else if (scan(deg-5,2))
		if (scan(deg-4,1)) deg-=4;
		else deg-=6;                    
	     else if (scan(deg+0,0)) deg+=0; 
		  else deg-=2;

	return 1;
    }
    else return 0;
}

spara()
{
    odeg=deg;
    
    if (find())
       if (find())
       {   
	  if (find())
	  {
	      rng2=rng;
	      
	      df=deg+(deg-odeg)*1550/1000;
	      
	      cannon(df,(rg=scan(deg,10))*183/(183+rng2-rg));
	  }
       if (rng>700) deg+=42;
      }
}

spara2()
{
    odeg=deg;
    
    if (find())
    {
	rng2=rng;
	
	alfa=(dir-deg)-((dir-deg)/360)*360;                   
	sin_alfa=sin(alfa);
	cos_alfa=cos(alfa);
	
	df=deg+(deg-odeg)*3000/1000+sin_alfa/50000;
	
	if (rg=scan(deg,10)) rng=rg;
	
	while (! cannon(df,rng*183/(183+rng2-rng-cos_alfa/2700)));
	
	if (rng>700) deg+=42;
    }
}


radar()          /* Restituisce un intero che identifica il numero di  */
                 /* robots avversari                                   */
{
    int d,n;       /* Angolo attuale di scansione */
    
    n=0; d=0;

    while (d!=360) 
    { 
        if (scan(d,5)) ++n;
        d+=10;
    }
    return n;
}
