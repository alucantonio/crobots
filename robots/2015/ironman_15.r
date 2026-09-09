/*

Torneo 2015
Nome: 	ironman_15.r	(2000 istruzioni)
Autore: Franco Cartieri

Ironman è un l'evoluzione di Colosso con il f2f di Lamela.
All'inizio dell'incontro Ironmansi posiziona nell'angolo piu' vicino e si muove lungo due triangoli 
disegnati sui lati dell'angolo.
Se uno dei due angoli adiacenti e' libero il movimento diventa asimmetrico verso questo angolo.
Se i due angoli adiacenti sono entrambi occupati o se sono stati effettuati piu' di 50 cicli il movimento diventa simmetrico.
Oltre i 60 cicli parte comunque per l'attacco finale.
Ad ogni ciclo controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.

*/

int deg,rng,odeg,orng,t,nc,xs,ys,en,xd,yd,xmd,ymd,dmin,dmax, x,y,dir,b;

main()
{
  	if (xs=loc_x(t=0)>499) Xmin(850,0); else Xmax(150,180); 
  	if (ys=loc_y(xd=180*xs)>499) Ymin(850,90); else Ymax(150,270);
	if (xs) { if (ys) { xmd=200; ymd=250; } else { xmd=160; ymd=110; } } 
	else {  if (ys) { xmd=340; ymd=290; } else { xmd=20; ymd=70; }  }
	Radar(dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100);
  	while (en>1) 
	{
		while((Look(xd) || Look(yd) || en) && (t<8)) 
		{
			en=0;
		  	if((nc+=1)<50)
			{
				if(t%2) { if(!Look(xd)) t+=1; }
				else    { if(!Look(yd)) t+=1; }
			}
			else 
			{	t+=1;
				if(nc>60)
					f2f();
			}
			if(t%2)
			{
		     		if (ys) Ymax(450,ymd);    else Ymin(550,ymd); 
			      if (xs) Xmin(850,xd-180); else Xmax(150,xd-180);
		      	if (ys) Ymin(850,yd-180); else Ymax(150,yd-180);
			}
			else
			{
		      	if (xs) Xmax(450,xmd);    else Xmin(550,xmd);
	     			if (ys) Ymin(850,yd-180); else Ymax(150,yd-180);
			      if (xs) Xmin(850,xd-180); else Xmax(150,xd-180);
			}	
		}
	    	Radar(t=0);
  	}
	f2f();
}

f2f()
{
	while(1) 
	{
		if (orng>400) dir=deg+60+(b^=1)*240;
		else dir=deg+80+(b^=1)*200;	       
		if ((x=loc_x(y=loc_y()))>850) dir=150+60*(y>500);
		else if (x<150) dir=330+60*(y<500);
       		else if (y>850) dir=240+60*(x<500);
        	else if (y<150) dir=60+60*(x>500);
		if(scan(deg-15,10)) deg-=4;
		Spara();
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		Spara();
		if(orng>500) Fuoco();
    	}
}

Stop(dir) { 	drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis) 	Fire(dir); 	Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis)	Fire(dir); 	Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis)	Fire(dir); 	Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis)	Fire(dir); 	Stop(dir); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Radar() { int ang; en=0; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); }

Trova() 
{
	if (scan(deg+13,10)) deg+=3; if (scan(deg-13,10)) deg-=3;
	if (scan(deg+12,10)) deg+=2; if (scan(deg-12,10)) deg-=2;
	if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;
	return scan(deg,10);
}

Fuoco() 
{
	drive(dir,100);
	if (scan(deg,10));
	else if (scan(deg+=20,10));
	else if (scan(deg-=40,10));
	else if (scan(deg+=60,10));
	else if (scan(deg-=80,10));
	else {
		if (orng=scan(deg+=100,10)) 	 return cannon(deg,orng);
		else if (orng=scan(deg-=120,10)) return cannon(deg,orng);
		else if (orng=scan(deg+=140,10)) return cannon(deg,orng); 
		else if (orng=scan(deg-=160,10)) return cannon(deg,orng);
		return deg+=260;
	}
	if (scan(deg-18,10)) deg-=7; 
	if (scan(deg+18,10)) deg+=7;
	if (orng=Trova()) 
	{
		if (rng=Trova(odeg=deg))
			return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
	}	
}

Spara()
{
	drive(dir,100);
	if ((orng=scan(deg, 10)) ) { 
        if (scan(deg-15,10)) { 
            if (scan(deg-=13,4)) { 
                if(scan(deg-3,5)) deg-=5; else ++deg;
            }  else if (scan(deg-5,5)) deg-=5;
        } else if(scan(deg+14,10)) { 
            if (scan(deg+=13,5)) deg+=5; else --deg;
        }  else if(scan(deg+4,5)) deg+=5; else deg-=5;
    	} else if ((orng=scan(deg-=20,10))) { 
        if (scan(deg-9,10)) { 
            if (scan(deg-=13,5)) deg-=5; else ++deg;
        } else if(scan(deg+9,10)) deg+=6; 
    	} else if ((orng=scan(deg+=40,10))) { 
        if (scan(deg+9,10)) deg+=12;
    	}  else if ((orng=scan(deg+=20,10)));
	else {
		if ((orng=scan(deg-=80,10))) 		return cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg-=160,10))) 	return cannon(deg,orng);
		else return deg+=260;
	}  
    	if (rng=scan(deg,10))		cannon(deg,rng*135/(135+orng-rng)); 
	else if (rng=scan(deg-=20,10)) 	cannon(deg,rng); 
	else if (rng=scan(deg+=40,10))	cannon(deg,rng); 
	else deg+=40; 
} 

Fire(dir)
{
  	int asin,acos;
  	if (speed()<100) drive(dir,100); 	
	else 	if(rng > 700) deg+=180;
  	if (scan(deg,10))
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
		else 	Search(); 
  	} 
	else 	Search();  
}

Search()
{
  	if (scan(deg-=350,10)) return FireXX();
  	if (scan(deg-=20,10))  return FireXX();
  	if (scan(deg-=320,10)) return FireXX();
  	if (scan(deg-=60,10))  return FireXX();
  	if (scan(deg-=280,10)) return FireXX();
  	if (scan(deg-=100,10)) return FireXX();
  	if (scan(deg-=240,10)) return FireXX();
  	if (scan(deg-=140,10)) return FireXX();
  	if (scan(deg-=200,10)) return FireXX();
	if (scan(deg-=180,10)) return FireXX();
	if (scan(deg-=160,10)) return FireXX();
	if (scan(deg-=220,10)) return FireXX();
  	if (scan(deg-=120,10)) return FireXX();
  	if (scan(deg-=260,10)) return FireXX();
	if (scan(deg-=80,10))  return FireXX();
	if (scan(deg-=300,10)) return FireXX();
}

FireXX()
{
  	if (rng=scan(odeg=deg,10)) 
	{    
    		if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
  	}  
	else 	Search();
}
