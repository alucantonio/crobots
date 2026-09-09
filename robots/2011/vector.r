/* 
Nome: 	Vector.r		(midi)
Autore: 	Franco Cartieri

Torneo 2011

Descrizione robot:
Vector utilizza una strategia molto offensiva, praticamente consiste nell'attacco finale di Gru.
Ottiene ottimi risultati nel f2f, scadenti nel 3vs3 e pessimi nel 4vs4.
Il movimento consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.

*/

int x,y,b,dir,rng,orng,deg,odeg,asin,acos;

fuoco() 
{
	if (scan(deg,10));
	else { 	if (scan(deg+=20,10));
        	else { 	if (scan(deg-=40,10));
	                else { 	if (scan(deg+=60,10));
        	                else { 	if (scan(deg-=80,10));
                	                else {
                        	  		if (scan(deg+=100,10)) return;
                                	        else 	if (scan(deg-=120,10)) return;
                                        		return deg+=180;
	                                }
                	        }
        	       }
       	}
  	}
	if (scan(deg,10) > 50)
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
	      	if (orng=scan(odeg=deg,3))
     		{
        	    	if(scan(deg-13,10)) deg-=5;
            		else if(scan(deg+13,10)) deg+=5; 
	            	if(scan(deg+12,10)) deg+=4;
        	    	else if(scan(deg-12,10)) deg-=4;
            		if(scan(deg-11,10)) deg-=2;
	            	if(scan(deg+11,10)) deg+=2;
        	    	cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin, rng*230/(orng-rng-acos)); 
     		}  
	}
}

spara()
{
	if ((orng=scan(deg, 10)) ) 
	{ 
		if (scan(deg-9,5)) 
		{ 
			if (scan(deg-=13,5)) 
			{ 
				if(scan(deg-3,5)) deg-=5; 
				else ++deg;
			}  
			else 
			{	
				if (scan(deg-5,5)) deg-=5;
				else ++deg;
			}
		} 
		else 	
		{
			if(scan(deg+9,5)) 
			{ 
				if (scan(deg+=13,5)) deg+=5;
				else --deg;
			}  
			else 	
			{
				if(scan(deg+5,5)) deg+=5;
				else --deg;
			}
		}
	}  
	else 	
	{
		if ((orng=scan(deg-=20,10))) 
		{ 
			if (scan(deg-9,10)) 
			{ 
				if (scan(deg-=13,5)) deg-=5;
				else ++deg;
			} 
			else 
			{	
				if(scan(deg+9,10)) deg+=5; 
				else --deg;
        		}  
		}
		else 	
		{
			if ((orng=scan(deg+=40,10))) 
			{ 
     	        	 	if (scan(deg+9,10)) deg+=12;
        		}  
			else 	
			{
				if ((orng=scan(deg+=20,10)));
				else 
				{ 
					if (orng=scan(deg-=80,10)) 		return cannon(deg,orng); 
					else if (orng=scan(deg-=20,10)) 	return cannon(deg,orng); 	
					else if (orng=scan(deg+=120,10)) 	return cannon(deg,orng); 	
					else if (orng=scan(deg+=20,10))	return cannon(deg,orng); 	
					else if (orng=scan(deg-=160,10))	return cannon(deg,orng); 
					else return deg+=260;
				} 
			}
		}
	}
   	if (rng=scan(deg,10))
	{    
		cannon (deg, rng*135/(135+orng-rng) ); 
		if(rng>1000) 
			return deg+=40;
    	}  
	else if(scan(deg-20,10)) deg-=20; 
        	else if(scan(deg+=20,10));
			else deg+=40; 
} 

main()
{
	while(1) 
	{
		if ((x=loc_x(y=loc_y()))>850) dir=155+50*(y>500);
             	else 	if (x<150) dir=335+50*(y<500);
         	else 	if (y>850) dir=245+50*(x<500);
            	else 	if (y<150) dir=65+50*(x>500);
		else 
		{
 			if (orng<600) dir=deg+80+(b^=1)*190;
			else  dir=deg+50+(b^=1)*230; 
		}
		spara(drive(dir,100));
		if(scan(deg-10,10)) deg-=5;
		if(scan(deg+10,10)) deg+=5;
		if(orng>500) 	
		{
                 	spara(drive(dir,100));
			fuoco(drive(dir,100));
		}
		else 	spara(drive(dir,100));
	}
}
