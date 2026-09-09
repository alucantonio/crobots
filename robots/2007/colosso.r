/*
Nome: 	colosso.r		(macro)
Autore: 	Franco Cartieri

Torneo 2006

All'inizio dell'incontro colosso.r si posiziona nell'angolo piu' vicino e si muove lungo due triangoli 
disegnati sui lati dell'angolo.
Se uno dei due angoli adiacenti e' libero il movimento di mystica.r diventa asimmetrico verso questo angolo.
Se i due angoli adiacenti sono entrambi occupati o se sono stati effettuati piu' di 50 cicli il movimento
diventa simmetrico.
Ad ogni ciclo controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale che 
consiste in un movimento lungo il quadrato che si ottiene unendo i punti centrali dei lati dell'arena di gioco.
L'unico suo punto di forza sono le routine di fuoco (una per 4vs4 e una per f2f) che ho copiato da Alien.r. 
(Provando a modificarle sono solo riuscito a peggiorarne le prestazioni!!!) 

*/

int deg,rng,odeg,orng,t,nc,xs,ys,en,xd,yd,xmd,ymd,dmin,dmax;

main()
{
  	if (xs=loc_x()>499) Xmin(850,0); else Xmax(150,180); 
  	if (ys=loc_y(xd=180*xs)>499) Ymin(850,90); else Ymax(150,270);
	dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100;
    	if (xs) { if (ys) { xmd=200; ymd=250; } else { xmd=160; ymd=110; } } 
	else {  if (ys) { xmd=340; ymd=290; } else { xmd=20; ymd=70; }  }
    	Radar();
  	while (en>1) 
	{
		while(Look(xd) || Look(yd) || en) 
		{
			en=0;
	      	if((nc+=1)<50)
			{
				if(t%2) { if(!Look(xd)) t+=1; }
				else    { if(!Look(yd)) t+=1; }
			}
			else t+=1;
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
	    	Radar();
  	}
    	YmaxF(150,270);
	if(loc_x() < 500)	XminF(450,0);
	else			XmaxF(550,180);
    	while(1)
     	{
		XmaxF(150,135);
		YminF(850,45);
		XminF(850,315);
		YmaxF(150,225);
 	}
}

Stop(dir) { drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis) 	Fire(dir); 	Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis) 	Fire(dir); 	Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis) 	Fire(dir); 	Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis) 	Fire(dir); 	Stop(dir); }

YminF(dis,dir) { while(loc_y()<dis) Fuoco(dir); Stop(dir); }

YmaxF(dis,dir) { while(loc_y()>dis) Fuoco(dir); Stop(dir); }

XminF(dis,dir) { while(loc_x()<dis) Fuoco(dir); Stop(dir); }

XmaxF(dis,dir) { while(loc_x()>dis) Fuoco(dir); Stop(dir); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Radar() { int ang; en=0; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); }

Fuoco(dir)
{
  	int asin,acos;
  	if (speed()<100) drive(dir,100); 
	if (scan(deg,10) > 100)
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
		else 	cerca(); 
  	} 
	else 	cerca();  
}

cerca()
{
  	if (scan(deg-=350,10)) return fuocodir();
  	if (scan(deg-=20,10))  return fuocodir();
  	if (scan(deg-=320,10)) return fuocodir();
  	if (scan(deg-=60,10))  return fuocodir();
  	if (scan(deg-=280,10)) return fuocodir();
  	if (scan(deg-=100,10)) return fuocodir();
  	if (scan(deg-=240,10)) return fuocodir();
  	if (scan(deg-=140,10)) return fuocodir();
  	if (scan(deg-=200,10)) return fuocodir();
  	if (scan(deg-=180,10)) return fuocodir();
  	if (scan(deg-=160,10)) return fuocodir();
  	if (scan(deg-=220,10)) return fuocodir();
  	if (scan(deg-=120,10)) return fuocodir();
  	if (scan(deg-=260,10)) return fuocodir();
  	if (scan(deg-=80,10))  return fuocodir();
  	if (scan(deg-=300,10)) return fuocodir();
  	if (scan(deg-=40,10))  return fuocodir();
  	if (scan(deg-=340,10)) return fuocodir();

}

fuocodir()
{
	if (rng=scan(odeg=deg,10))
	{    
   		if (scan(deg-=8,8)); else deg+=16;
    		if (scan(deg-=4,4)); else deg+=8;
    		if (scan(deg-=2,2)); else deg+=4;
		return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); 
	}
	else cerca();
}

Fire(dir)
{
  	int asin,acos;
  	if (speed()<100) drive(dir,100); 	else 	if(rng > 850) deg+=180;
  	if (scan(deg,10) > 100)
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
  	if (scan(deg-=40,10))  return FireXX();
  	if (scan(deg-=340,10)) return FireXX();
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
