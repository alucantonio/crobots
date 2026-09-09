/*------------------------------------------------------------------------------\
|	  	    ########  #### #### ####  ######   #######			|
|		    ##     ##  ##   ##   ##  ##    ## ##     ##			|
|		    ##     ##  ##   ##   ##  ##       ##     ##			|
|		    ########   ##   ##   ##  ##       ##     ##			|
|		    ##         ##   ##   ##  ##       ##     ##			|
|		    ##         ##   ##   ##  ##    ## ##     ##			|
|		    ##        #### #### ####  ######   #######			|
|-------------------------------------------------------------------------------|
|Autore: Luca Giacometti                                              		|
|	Nome robot: piiico [perche' piiico significa piccolissimo piu' di pico]	|
|	Tattica: piiico si sposta nell angolo in basso a destra [se ci sono piu]|
|		 di 3 robot nello scontro anche se la procedura di scan e molto |
|		 da modificare in quanto non molto precisa] e inizia a far	|
|		 fuoco nei 90 gradi tra il lato destro e quello inferiore del	|
|		 campo di battaglia [a differenza degli altri robot non si	|
|		 preoccupa dell occupazione dell angolo, se e occupato, lo	|
|		 disoccupa a cannonate].					|
|		 Nel caso in cui [con una scansione non molto precisa] individui|
|		 1 solo robot rimanente gli salta addosso [si muove sempre	|
|		 verso il bersaglio] scansionando allo stesso angolo del ciclo	|
|		 precedente se ha visto il nemico, nei 20 gradi successivi se	|
|		 non lo ha visto.Questo mi assicura un ottima strategia di	|
|		 inseguimento.Ben poche volte piiico perde il nemico durante	|
|		 l attacco finale e anche nel caso in cui succedesse,		|
|		 lo recupera entro 18 cicli di scansione [360/20].		|
|		 piiico non tiene conto del cannon recharge, se posso sparare	|
|		 sparo, dopo potrei aver problemi ben maggiori del recharge	|
|		 o del range che me lo impediscono [vedi morte 8)]		|
|		piiico e il robot che intendo usare in tutti gli scontri non f2f|
|	Data di nascita: 11/09/2003 versione 0.1 attuale 0.4 [versione corrente]|
|	Citta': Cuneo [Italy]							|
\------------------------------------------------------------------------------*/

int count,angle,range;

main()
	{
		while(angle<359)
			{
				if(range=scan(angle+=20,10)) count+=1;
			}
		if(count!=1) while(loc_x()<997) drive(180+180*(999>loc_x())+atan(100000*(loc_y()-0)/(loc_x()-999)),100);
		while(count!=1)
			{
				count=0;
				angle=80;
				while(angle<181)
					{
						if(range=scan(angle+=20,10)) {count+=1;cannon(angle,range+20);}
					}
			}
		while(1)
			{
				if(range=scan(angle+=20,10))
					{
						cannon(angle,range+10);
						drive(angle,range);
						angle-=20;
					}
			}
	}