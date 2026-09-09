/* 

Torneo 2020
Nome: 	antman_20.r	(500 istruzioni - micro)
Autore: Franco Cartieri

Descrizione robot:
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e controlla se e' un f2f in questo caso parte subito all'attacco.
Altrimenti inizia a muoversi lungo lati dell'arena prima orizzontalmente poi verticalmente senza mai allontanarsi troppo dall'angolo.
Ogni 2 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Se ha subito troppi danni o il numero di oscillazioni supera una certa soglia parte all'attacco finale.

*/

int rng,orng,deg,odeg,x,y,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,dam,odam,dir,b;

main()
{
	Radar(dmax=340);
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y())>499)*880)>499)*880;
	drive(xd=180*xs,100); 
	dmax=(dmin=((yd=(90+180*ys))-105+90*(xs^ys)))+100;
	while(1) 
	{
		if((dam=damage()) > (odam+16))
			F2f();
		else	odam = dam;
		Run(xd,xp,2-xs);	
		Run(yd,yp,6-ys);			
		if(++b%2)	Radar();		
	}
}

Spara(v)
{
	drive(dir,v);
	if(rng=scan(odeg=deg,10))
	{
		if(scan(deg-8,5)) 
		{ 	
			if(scan(deg-=5,2)) ; 
			else deg-=4; 
		} 
		else 
		{
			if(scan(deg+8,5)) 
			{
				if(scan(deg+=5,2)) ; 
				else deg+=4; 
			} 
			else 
			{
				if(scan(deg,1)) ;
				else if(scan(deg-=3,2)) ; else deg+=6;
			}
		}
		return cannon(deg+(deg-odeg),2*scan(deg,10)-rng); 			
	} 
	else 
	{
		if(rng=scan(deg+=20,10)); 
		else if(rng=scan(deg-=40,10));
		else return	deg+=80;
		return cannon(deg, rng);
	}	
}

Run(d,l,m) 
{ 
  	int r;
  	while((++r)<3) 
	{
		drive(dir=d,100);
		if(++timer>375+dam) F2f();			
		if(scan(d,10)) 
		{ 
			deg=d; 
			while(scan(d,10)>840) ; 
		} 
		else	while(Check(l,m)) ;
	    Spara(0);  
  		while(speed()>59) ;
  		++m;  
  		d+=180;
  	} 
}

Check(l,m) 
{
  	int c1;
  	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	

F2f()
{
	while(1)
	{
		if(((x=loc_x())%850)<150) dir=180*(x>500);
		else if(((y=loc_y())%850)<150) dir=90+180*(y>500);
		else if (rng<250) dir=deg+180;
		else dir=deg+180*(b^=1);
		Spara(100); 
		Spara(100); 
		Spara(100);
	}
}

Radar() { int ang,en; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); if(en<2) F2f(); }
