/* 
Nome: 	gantu.r		(macro)
Autore: 	Franco Cartieri

Torneo 2010

Descrizione squadra:
La squadra di quest'anno è formata da Stitch, Jumba, Reuben e Gantu. I nomi derivano dal film Lilo&Stitch di cui mio figlio è un grande fan.
Stitch (micro): è un piccolo esperimento creato da Jumba, ma ha una forza 3000 volte superiore al suo peso, speriamo si comporti bene anche con robot di categoria maggiore...
Reuben (midi): è un altro esperimento malriuscito di Jumba, come forza lascia molto a desiderare, però è simpatico...
Gantu (macro): è un alieno grande, grosso e un po' sfigato, penso che non combinerà molto neanche qui...
Jumba (macro): è uno scienziato un po' pazzo, le sue invenzioni sono quasi sempre improbabili, chissà se questa volta avrà un colpo di genio...

Descrizione robot:
All'inizio dell'incontro Gantu si posiziona nell'angolo piu' vicino e controlla se è un f2f in questo caso parte subito all'attacco.
Altrimenti inizia a muoversi lungo lati dell'arena prima orizzontalmente poi verticalmente senza mai allontanarsi troppo dall'angolo.
Ogni 12 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.
Gantu utilizza 3 routine di fuoco una veloce per il 4vs4 e 2 mirate allo scontro f2f.

Un ringraziamento a tutti gli autori da cui ho preso parti di codice, in particolare agli autori di Alien, Danica, Proud e Wgdi.
*/

int fp,b,x,y,dir,rngscan,rng,orng,deg,odeg;
int asin,acos,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd;

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

f2f()
{
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
		spara(drive(dir,100));
		++fp; if(fp>5) ++fp; fp=5; 
		if(orng>450) 	
		{
                 	spara(drive(dir,100));
			fuoco(drive(dir,100));
		}
		else 	spara(drive(dir,100));

	}
}

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=0))>499)*880)>499)*880;
	drive(dir=((xd=180*xs)+180),100);
	while(check(xp,3-xs)) drive(dir,100);
	fire(drive(dir,0));  
     	while(speed()>59);
	drive((dir=(yd=90+180*ys)+180),100);
	while(check(yp,7-ys)) drive(dir,100);
	fire(drive(dir,0));  
     	while(speed()>59);

	dmax=(dmin=zd=(yd-105+90*(xs^ys)))+100;
   	while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
	dmin=zd; 

  	while(en>1) 
	{
   		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
	f2f();
}


fire()
{
  	if (rng=scan(odeg=deg,10))  
  	{    
		if (scan(deg+350,10)) deg-=1; else deg+=1;
    		if (scan(deg+10,10)) deg+=1; else deg-=1; 
		cannon(deg,(scan(deg,10)<<1)-rng);
 	} 
	else 
	{
      	if (rng=scan(deg+=340,10)) return cannon(deg,rng); 
	      if (rng=scan(deg+=40,10))  return cannon(deg,rng);  
	      while (!(rng=scan(deg+=20,10))) ; 
      		cannon(deg,rng);
  	}
}

run(d,l,m) 
{ 
	if ((timer%12==2) && (rng > 400)) 
	{
		en=0;
		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
		dmin=zd; 
	}
	spara(drive(d,100));
 	if (++timer>500+damage()) f2f(); 
	if (scan(d,10)) 
	{ 
		deg=d; 	
		while (scan(d,10)>840) ;	
	} 
	else 	while(check(l,m)) drive(d,100);
	fire(drive(d,0));  
     	while(speed()>59) ;
	++m;  
  	d+=180;

	drive(d,100);
 	if (++timer>500+damage()) f2f(); 
	while(check(l,m)) drive(d,100);
	fire(drive(d,0));  
	while(speed()>59) ;
}

check(l,m) 
{
  	int c1;
 	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	







