/*
Nome: 	jumba.r		(macro)
Autore: 	Franco Cartieri

Torneo 2010

Descrizione squadra:
La squadra di quest'anno è formata da Stitch, Jumba, Reuben e Gantu. I nomi derivano dal film Lilo&Stitch di cui mio figlio è un grande fan.
Stitch (micro): è un piccolo esperimento creato da Jumba, ma ha una forza 3000 volte superiore al suo peso, speriamo si comporti bene anche con robot di categoria maggiore...
Reuben (midi): è un altro esperimento malriuscito di Jumba, come forza lascia molto a desiderare, però è simpatico...
Gantu (macro): è un alieno grande, grosso e un po' sfigato, penso che non combinerà molto neanche qui...
Jumba (macro): è uno scienziato un po' pazzo, le sue invenzioni sono quasi sempre improbabili, chissà se questa volta avrà un colpo di genio...

Descrizione robot:
All'inizio dell'incontro Jumba si posiziona nell'angolo piu' vicino e controlla se è un f2f in questo caso parte subito all'attacco.
Altrimenti inizia a muoversi lungo la bisettrice dell'angolo senza mai allontanarsi troppo dall'angolo.
Ogni tanto contro controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Durante lo scan per il numero dei nemici viene anche scelto come robot da puntare quello più vicino.
Se si è verso la fine dell'incontro e il numero di nemici è uguale a 2 e non è troppo danneggiato parte comunque all'attacco fino a quando non è colpito
poi ritorno alle oscillazioni nell'angolo.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.
Jumba utilizza 3 routine di fuoco una dedicata per il 4vs4 e 2 mirate allo scontro f2f.
Dei miei robot di quest'anno Jumba è quello che si differenzia di più dagli altri.

Un ringraziamento a tutti gli autori da cui ho preso parti di codice, in particolare agli autori di Alien, Danica, Proud e Wgdi.
*/

int rng, orng, deg, odeg, dir;
int ne, i, b, x, y, t, att;
int sc, up, dx, fp, asin, acos, sk, dam;

main()
{
	attacco(vai (x=80+840*(loc_x()>500),y=80+840*(loc_y(fp=2)>500)));
  	while (1)
	{			
		fuoco(drive(dir+=180,100));
            if(up) 	while (loc_y()>=y) spara(drive (dir,100)); 
            else 		while (loc_y()<=y) spara(drive (dir,100)); 
		spara(drive(dir-=180,100)); 
		if(up) 	while (loc_y()<y) spara(drive (dir,100));
		else	 	while (loc_y()>y) spara(drive (dir,100));
		ferma();
		if(!orng)
			attacco(ne=0);
    	}        
}

ferma()
{
	spara(drive(dir,0));
}

attacco()
{
     	i=sc+120;
	enrng=1500;
    	while (i>sc) 
	{
     		if (rng=scan(i-=20,10)) 
		{ 
     			++ne; 
     			if (rng<enrng) 
			{ 
		            deg=i; 
           			enrng=rng; 
      		} 
		}
      }
	if (ne<2) f2f();	
	else if(t>800) 
	{ 
        	if(ne<3) 
		{
			if(dam=damage()<80) 
			{
				att=dam+20;
				while(damage()<att) 
				{
					if ((x=loc_x(y=loc_y()))>850) dir=155+50*(y>500);
             			else 	if (x<150) dir=335+50*(y<500);
			         	else 	if (y>850) dir=245+50*(x<500);
            			else 	if (y<150) dir=65+50*(x>500);
					else 
					{
 						if (orng<700) dir=deg+80+(b^=1)*190;
						else  dir=deg+50+(b^=1)*230; 
					}
					sparaf2f(drive(dir,100));
					++fp; if(fp>5) ++fp; fp=5; 
					if(orng>450) 	
					{
		         	        	sparaf2f(drive(dir,100));
						fuoco(drive(dir,100));
					}
					else 	sparaf2f(drive(dir,100));
				}
				vai(att=0);
			}
     			else 	t=0;
		}
      	else t+=2;
	}
}

vai()
{
    	spara(drive(dir=deg(x,y),100));
    	while (dist(x,y)>12000) spara(drive(dir,100));
    	while (dist(x,y)>1600) drive(dir,100);
    	ferma(dx=(x>500));
    	if (up=(y>500)) 
	{
        	if(dx){sc=165;return dir=45;}
        	else {sc=255;return dir=135;}
    	} else 
	{
        	if(dx) {sc=75;return dir=315;}
        	else {sc=345;return dir=225;}
    	}
}

deg(xx,yy) { return (180+((xx-=(loc_x()))>0)*180+atan(((yy-loc_y())*100000)/(xx+(xx==0)))); }

dist(xx,yy) { return (((xx-=loc_x())*xx+(yy-=loc_y())*yy)); }

spara()
{ 
	++t; 
	if ((orng=scan(deg, 10)) ) 
	{ 
		if (scan(deg-9,4)) 
		{ 
			if (scan(deg-=13,4)) 
			{ 
				if(scan(deg-3,fp)) deg-=fp;
				else ++deg;
			}  else if (scan(deg-fp,fp)) deg-=fp;
		} 
		else if(scan(deg+9,fp)) 
		{ 
			if (scan(deg+=13,fp)) 
				deg+=fp;
			else --deg;
		}  
		else 	if(scan(deg+4,fp)) 
				deg+=fp;
			else --deg;
        }  
	else if ((orng=scan(deg-=20,10))) 
	{ 
		if (scan(deg-9,10)) 
		{ 
			if (scan(deg-=13,fp)) deg-=fp;
                        else ++deg;
		} else if(scan(deg+9,10)) deg+=6; 
	}  
	else 	if ((orng=scan(deg+=40,10))) 
		{ 
			if (scan(deg+9,10)) deg+=9;
		}  
		else 	if (!(orng=scan(deg+=20,10))) 
			{ 
                		if ((orng=scan(deg+=21,10))) 
				{ 
                        	if (orng>900) 
					{ 
                                	if(!att) deg+=41; 
                                	return orng=0;
                        	} 
                		} else 
				{ 
                        	if (!(scan(deg+=21,10))) deg+=40; 
                        		return; 
                		} 
			} 
        		if (rng=scan(deg,10))
			{  
                		cannon (deg, rng*165/(165+orng-rng) ); 
                		if(rng>720) if(!att) if(rng>orng || rng>900) 
				{
                                deg+=41;
                                return orng=0;
                        }
			}  
} 

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

sparaf2f()
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

f2f()
{
	fp=5;
	while(1) 
	{
		if ((x=loc_x(y=loc_y()))>850) dir=155+50*(y>500);
             	else 	if (x<150) dir=335+50*(y<500);
         	else 	if (y>850) dir=245+50*(x<500);
            	else 	if (y<150) dir=65+50*(x>500);
		else 
		{
 			if (orng<700) dir=deg+80+(b^=1)*190;
			else  dir=deg+50+(b^=1)*230; 
		}
		sparaf2f(drive(dir,100));
		++fp; if(fp>5) ++fp; fp=5; 
		if(orng>450) 	
		{
                 	sparaf2f(drive(dir,100));
			fuoco(drive(dir,100));
		}
		else 	sparaf2f(drive(dir,100));
	}
}


