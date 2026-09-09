	     /*---------------------------------------------------------------------*/
             /*	     #####    ##   #####  #####    ##   #####  #   ##   #    #      */
	     /*      #    #  #  #  #    # #    #  #  #  #    # #  #  #  ##   #      */
	     /*	     #####  #    # #    # #####  #    # #    # # #    # # #  #      */
	     /*      #    # ###### #####  #    # ###### #####  # ###### #  # #      */
	     /*	     #    # #    # #   #  #    # #    # #   #  # #    # #   ##      */
	     /*      #####  #    # #    # #####  #    # #    # # #    # #    #      */
	     /*---------------------------------------------------------------------*/
/*

	|	Autore: Luca Giacometti                                                		|
	|	Nome robot: barbarian per via della sua tattica poco ortodossa			|
	|	Data di nascita: 11/09/2003 versione 0.1 attuale 0.9 [non usata in questo torneo]

thebarbarian.r is a c-robot based on a d-robot (www.plasmacode.com and a lot of thanks to mrqzzz)   
 the basic tought is that if a d-robot (delphi robot) tattics win ... why don't use it another time? 
 tattics is that if you found a robot you must run forward him and hit him with a big MACE ! hehehe
	Tattica: barbarian non fa altro che saltare addosso all altro robot	
		 [si muove sempre verso il bersaglio] scansionando allo stesso
		 angolo del ciclo precedente se ha visto il nemico, nei 20 gradi
		 successivi se non lo ha visto.Questo mi assicura un ottima strategia di	
		 inseguimento.Ben poche volte barbarian perde il nemico durante	
		 l attacco e anche nel caso in cui succedesse,		
		 lo recupera entro 18 cicli di scansione [360/20].		
		 barbarian non tiene conto del cannon recharge, se posso sparare			
		 sparo, dopo potrei aver problemi ben maggiori del recharge	
		 o del range che me lo impediscono [vedi morte 8)]
		 barbarian non e altro che la versione f2f di piiico
		 
barbarian e il robot che intendo usare nei combattimenti f2f 

												Samel  */
int rng,ang;

main()
	{
		while(1)
			{
				if(rng=scan(ang+=20,10))
					{
						cannon(ang,rng+10);
						drive(ang,rng);
						ang-=20;
					}
			}
	}