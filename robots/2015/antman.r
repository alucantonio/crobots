/* 

Torneo 2015
Nome: 	antman.r	(500 istruzioni)
Autore: Franco Cartieri

Descrizione robot:
Antman è Axolotl con alcune varianti.
Se tra 2 oscillazioni i danni subiti sono superiori a 16 parte con l'attacco finale, 
perchè vuol dire che è in balia di un robot che lo sta massacrando e in quelle condizioni non sarebbe durato comunque molto.
All'inizio dell'incontro si posiziona nell'angolo e inizia a muoversi lungo i lati dell'arena prima orizzontalmente poi verticalmente 
senza mai allontanarsi troppo dall'angolo.
Ogni 8 cicli controlla il numero di avversari, se ne è rimasto uno solo inizia l'attacco finale.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.

*/

int rng,orng,deg,odeg,x,y,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd,dam,odam;

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
  	drive(xd=180*xs,100); 
 	dmax=(dmin=zd=((yd=(90+180*ys))-105+90*(xs^ys)))+100;
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

fire(dir,v)
{
	drive(dir,v);
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
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else deg+=80;
	}
}
run(d,l,m) 
{ 
  	int r;
  	if(timer%8==2)
	{
    		en=0;
    		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    		dmin=zd; 
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
	    	fire(d,0);  
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
	int b,dir;
	while(1) 
	{
		if (((x=loc_x())%850)<150) dir=180*(x>500);
		else if (((y=loc_y())%850)<150) dir=90+180*(y>500);
		else if (rng>600) dir=deg;
		else dir=deg+180*(b^=1);
		fire(dir,100);
		fire(dir,100); 
		fire(dir,100);
	}
}
