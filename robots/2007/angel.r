/*

Nome: 	angel.r		(micro)
Autore: 	Franco Cartieri

Torneo 2006

Angel.r e' un crobots molto semplice:
si muove lungo i lati di un quadrato al centro dell'arena per tutto il tempo.
Non controlla i danni subiti e nemmeno il numero di avversari, non ha di conseguenza nessuna 
routine di attacco finale.
L'unico suo punto di forza e' la routine di fuoco che ho copiato da Zeus.r. 
(Provando a modificarla sono solo riuscito a peggiorarne le prestazioni!!!) 
Spero che almeno nel f2f si comporti discretamente...

*/

int deg,rng,odeg,orng;

main()
{
    	while(1)
     	{
		while(loc_x()>400) Fuoco(180); 	Stop();    
		while(loc_y()<600) Fuoco(90); 	Stop();    
		while(loc_x()<600) Fuoco(0); 		Stop();    
		while(loc_y()>400) Fuoco(270); 	Stop();    
	}
}

Stop() { drive(0,0);  while(speed()>59); }

Fuoco(dir)
{
  	int asin,acos;
    	if(speed()<100) drive(dir,100); 
    	if(scan(deg,10) > 100)
  	{  
      	asin=(sin(deg-dir)/14384);
	      acos=(cos(deg-dir)/3796)-230;
      	deg-=18*(scan(deg-18,10)>0); 
	      deg+=18*(scan(deg+18,10)>0); 
      	if(scan(deg-16,10)) deg-=8;
	      else if(scan(deg+16,10)) deg+=8;
      	if(scan(deg-12,10)) deg-=4;
	      else if(scan(deg+12,10)) deg+=4;
      	if(scan(deg-11,10)) deg-=2;
	      if(scan(deg+11,10)) deg+=2;
      	if(orng=scan(odeg=deg,3))
		{
      	      if(scan(deg-13,10)) deg-=5;
            	else if(scan(deg+13,10)) deg+=5;
	            if(scan(deg+12,10)) deg+=4;
      	      else if(scan(deg-12,10)) deg-=4;
            	if(scan(deg-11,10)) deg-=2;
	            if(scan(deg+11,10)) deg+=2;
      	      cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin, rng*230/(orng-rng-acos)); 
		}
		else 	Search(); 
  	}
	else 	Search();  
}

Search()
{
  	if (rng=scan(deg+=350,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=20,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=320,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=60,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=280,10)) 	return cannon(deg,rng);
  	Search(deg-=220);
}
