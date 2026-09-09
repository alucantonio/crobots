/****************************************************************************/
/*                                                                          */
/*  CROBOT: TEQUILA.R                                                       */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo (7/4/1973)                                        */
/*                                                                          */
/****************************************************************************/

/* Nel caso si rendesse necessario limitare i combattimenti ad un solo robot
   per concorrente preferisco veder combattere B52.R.                       */

/*               
			  SCHEDA TECNICA:

    Inizialmente il crobot resta fermo finchä viene colpito. Si reca 
    in centro e vede quale angolo ä pió sicuro, quindi ci va e ci resta
    finchä non subisce danni oppure passa un certo periodo di tempo e
    si accorge che ä rimasto un solo avversario; a questo punto ritorna in
    centro e riinizia a cercare un angolo sicuro.
    Le routine di fuoco sono prese dallo splendido lazyii.r con qualche
    modifica; in particolare ä stata rifatta la routine di puntamento.

*/

int   deg,    /* Angolo di scansione     */
      dir,    /* Direzione di movimento  */
      
      dam,    /* Danno attuale    */
      ddam,   /* Tolleranza danno */
      ldam,   /* Danno massimo    */
      
      t;      /* Timer        */


main()
{

    ddam=1; ldam=88;               /* Definizione costanti */

    deg=360002; t=50; dam=ddam;    /* Inizializzazione variabili */

/*  Finchä non ti colpiscono resta fermo!!! */    
    while ( (! damage()) && t ) { --t; fuoco(); }

/*  Vai al centro sparando... */    
    if (loc_y()<500)
    {
	dir = 360090;
	while (loc_y() < 450) { drive (dir,100); fuoco2(); }
	stop();
    }
    else
    {     
	dir = 360270;
	while (loc_y() > 550) { drive (dir,100); fuoco2(); }
	stop();
    }

    if (loc_x()<500)
    {
	dir = 360000;
	while (loc_x() < 450) { drive (dir,100); fuoco2(); }
	stop();
    }
    else
    {     
	dir = 360180;
	while (loc_x() > 550) { drive (dir,100); fuoco2(); }
	stop();
    }


    while (1)      /* Fino alla fine... */
    {
	
	dir=360135;                    /* Inizializza direzione movimento */
	while(! libero(dir)) dir-=90;  /* Aspetta che si liberi un angolo */

/*  Vai nell'angolo libero e spara!!! */
	if (dir%360==135) 
	while ((loc_x()>160) && (loc_y()<840)) { drive (dir,100); fuoco2(); }
	
	else if (dir%360==45) 
	while ((loc_x()<840) && (loc_y()<840)) { drive (dir,100); fuoco2(); }
	
	else if (dir%360==315) 
	while ((loc_x()<840) && (loc_y()>160)) { drive (dir,100); fuoco2(); }
	
	else if (dir%360==225) 
	while ((loc_x()>160) && (loc_y()>160)) { drive (dir,100); fuoco2(); }
	
	stop();          /* Fermati finchä puoi e spara!!! */
	dir+=180;        /* Aggiorna la direzione per tornare al centro */

/*  Torna al centro sparando */
	while ((loc_x()<450) || (loc_x()>550)) { drive (dir,100); fuoco2(); }
	stop();

    }
}

/* Routine che stabilisce se ä il caso di andare in direzione dd */

libero(dd)
int dd;
{
    if (! scan(dd,10))
       if (! scan(dd-20,10))
	  if (! scan(dd+20,10)) return 1;
    return 0;
}

/* Routine di gestione del robot da fermo */

stop()        
{
    drive (dir,0);                 /* Fermati           */
    
    t=50;                          /* Aggiorna il Timer */
    
    dam=damage()+ddam;             /* Aggiorna il danno che puoi subire */
    if (dam>ldam) t=100000;        /* Se sei ridotto male resta fermo   */
				   /* fino alla fine                    */
	
    while ( (damage()<dam) && t )  /* Finchä non aumenta il danno o non */
	  { --t; fuoco(); }        /* passa troppo tempo spara!!!       */

    if (!t) if (radar()>1)  stop();  /* Se non ti hanno colpito, ma c'ä */
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
/* Le routine di fuoco sono state prese dallo splendido lazyii.r      */
/* E' stata rifatta la funzione di puntamento che ha ora una maggiore */
/* risoluzione , anche se ä un po' meno precisa; in questo modo il    */
/* bersaglio viene perso pió difficilmente.                           */
/* Una lieve modifica ä stata apportata anche nel calcolo dell'angolo */
/* nella routine di fuoco da fermo e in alcune costanti della routine */
/* di fuoco in movimento.                                             */


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

find()    /* Risoluzione: 7   ProfonditÖ: 4  Approssimazioni: 6 */
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
		 /* robots avversari e modifica deg in base all'ultimo */
		 /* robot avvistato.                                   */
{
    int n,       /* Numero avversari            */
	d;       /* Angolo attuale di scansione */
    
    n=0; d=0;

    while (d!=360) 
    { 
	if (scan(d,10)) { ++n; deg=d; }
	d+=20;
    }
    return n;
}
