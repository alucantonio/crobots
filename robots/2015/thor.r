/* 

Torneo 2015
Nome:	thor.r		(1000 istruzioni)
Autore: Franco Cartieri

Descrizione robot:
Thor è Leopon del torneo 2013 con alcune varianti prese da Lamela per il f2f.
Altra differenza è che se tra 2 oscillazioni i danni subiti sono superiori a 16 parte con l'attacco finale, 
perchè vuol dire che è in balia di un robot che lo sta massacrando e in quelle condizioni non sarebbe durato comunque molto.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e controlla se è un f2f in questo caso parte subito all'attacco.
Altrimenti inizia a muoversi lungo lati dell'arena prima orizzontalmente poi verticalmente senza mai allontanarsi troppo dall'angolo.
Ogni 8 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.
Utilizza 2 routine di fuoco una veloce per il 4vs4 e 1 mirata allo scontro f2f.

*/

int x,y,dir,rng,orng,deg,odeg,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd,dam,odam;

spara(dir)
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
		if ((orng=scan(deg-=80,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) return cannon(deg,orng);
		else return deg+=100;
	}  
        if (rng=scan(deg,10)){  
                cannon (deg, rng*135/(135+orng-rng) ); 
        } else if (rng=scan(deg-=20,10)) cannon(deg,rng); 
		else if (rng=scan(deg+=40,10)) cannon(deg,rng); 
		else deg+=40; 
} 

count()
{
	while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
	dmin=zd; 
}

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=0))>499)*880)>499)*880;
	drive(dir=((xd=180*xs)+180),100);
	while(check(xp,3-xs)) drive(dir,100);
	fire(dir);  
	drive(dir=((yd=90+180*ys)+180),100);
	while(check(yp,7-ys)) drive(dir,100);
	fire(dir);  
	count(dmax=(dmin=zd=(yd-105+90*(xs^ys)))+100);
	while(en>1) 
	{
		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
		if((dam=damage()) > (odam+16))
			f2f();
		else	odam = dam;
  	}
	f2f();
}

fireto(deg)
{
	if (orng=scan(deg,10)) 
		return cannon(deg,2*scan(deg,10)-orng);
	else 	return 0;
}

fire(dir)
{
	drive(dir,0);
	if (rng=scan(odeg=deg,10))
	{
		if (scan(deg-8,5)) 
		{ 	
			if (scan(deg-=5,2)) ; 
			else deg-=4; 
		} 
		else 
		{
			if (scan(deg+8,5)) 
			{
				if (scan(deg+=5,2)) ; 
				else deg+=4; 
			} 
			else 
			{
				if (scan(deg,1)) ;
				else if (scan(deg-=3,2)) ; else deg+=6;
			}
		}
		return (cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); 
	} 
	else 
	{
		if(fireto(deg+=340))	return;
		if(fireto(deg+=40))	return;
		deg+=80;
	}
}

run(d,l,m) 
{ 
  	int r;
  	if(timer%8==2)
	{
		count(en=0);
  	}
	while((++r)<3) 
	{
		drive(d,100);
 		if (++timer>400+dam) f2f();
		if (scan(d,10)) 
		{ 
			deg=d; 
			while (scan(d,10)>840) ; 
		} 
		else 	while(check(l,m)) ;
		fire(d); 
	  	while(speed()>59) ;
  		++m;  
  		d+=180;
  	} 
}

check(l,m) 
{
  	int c1;
  	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	

f2f()
{
	int b;
	while(1) 
	{
		if (orng>400) dir=deg+60+(b^=1)*240;
		else dir=deg+80+(b^=1)*200;	       
		if ((x=loc_x(y=loc_y()))>850) dir=150+60*(y>500);
		else if (x<150) dir=330+60*(y<500);
       		else if (y>850) dir=240+60*(x<500);
        	else if (y<150) dir=60+60*(x>500);
		if(scan(deg-15,10)) deg-=4;
		spara(dir);
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		spara(dir);
	}
}
