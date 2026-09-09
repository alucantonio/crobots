
/* ARES.r                                                        */
/* Comportamento: Corre su e giu lungo il lato Est dell'arena.   */
/*                Corregge range e angolo di tiro in funzione    */
/*                dello spostamento relativo del bersaglio.      */
/*                                                               */
/* Autore: Luciano Mei                                           */



int  Ang, Ris, Range1, Range2, AngIni, AngMax;

main()
{
	drive(0,80);			/* Si dirige verso il lato Est. */
	AngIni=0; AngMax=359;
	while(loc_x()<950) spara();
	drive(0,0);
	AngIni=90; AngMax=270;
	while(speed()>50) spara();

	if(loc_y()<500)			     /* Se si trova troppo a Sud   */
	{	drive(90,100);               /* incomincia a correre lungo */ 
		while(loc_y()<849) spara();  /* il lato Est in direzione   */
		drive(270,0);		     /* Nord.                      */
		while(speed()>50) spara();
	}

	while (1) 
	{	drive(270,100);                
		if(scan(90,10)) Ang=89;       /* Controlla che non vi siano*/
		else if(scan(270,10)) Ang=271;/* nemici davanti o dietro.  */
		while(loc_y()>150) spara();   /* Mentre corre spara.*/
		drive(90,0);
		while(speed()>50) spara();

		drive(90,100);
		if(scan(90,10)) Ang=89;
		else if(scan(270,10)) Ang=271;
		while(loc_y()<849) spara();
		drive(270,0);
		while(speed()>50) spara();
	}
}


spara()
{   
    if(Range1=scan(Ang,10))		/* Cerca un bersaglio. */
    {    if(Range1<50) cannon(Ang,50);	/* Evita di spararsi addosso. */
         else
         {    if(Range1<287) Ris=8;	/* Pi— il bersaglio Š lontano      */
	      else Ris=2300/Range1;	/* e pi— aggiusta l'angolo di tiro.*/
              if(Range2=scan(Ang,Ris)) 
              {    if(Range2<Range1) 
                        cannon(Ang,7*Range2/8);
		   else 
                        cannon(Ang,7*Range2/6);
	      }
	      else	    /* Se il bersaglio Š uscito dal primo angolo di*/ 	      {    Ris+=5;  /* scansione lo cerca un po' pi— indietro...   */ 
                   Ang-=Ris;
                   if(Range2=scan(Ang,5))
                   {   if(Range2<Range1) 
                   	     cannon(Ang,7*Range2/8);
		       else 
                             cannon(Ang,7*Range2/6);
                   }
	           else		/* ... oppure cerca un po' pi— avanti.     */
	           {   Ang+=2*Ris;
                       if(Range2=scan(Ang,5)) 
                       {     if(Range2<Range1) 
                   	          cannon(Ang,7*Range2/8);
		             else 
                                  cannon(Ang,7*Range2/6);
                       }     
 		   };
	      }
         }
    }
    else
    {    Ang-=13;
         while(!(scan(Ang,10)))
         {    Ang+=20;
              if(Ang>AngMax) Ang=AngIni;
         };
    };
}
