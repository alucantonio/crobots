/* 

Torneo 2020
Nome:	thor_20.r		(1975 istruzioni - macro)
Autore: Franco Cartieri

Descrizione robot:
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e controlla se è un f2f in questo caso parte subito all'attacco.
Altrimenti inizia a muoversi lungo lati dell'arena prima orizzontalmente poi verticalmente senza mai allontanarsi troppo dall'angolo.
Ogni 4 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.
Se un avversario si avvicina troppo il movimento diventa asimmetrico e triangolare.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.

*/

int x,y,rng,orng,deg,odeg,xs,ys,timer,xd,yd,xp,yp,dmax,dmin,dam,odam,e,t;
int nc,tt,xdr,ydr,xmd,ymd,vs3;

main()
{
	while (deg<360)
	{
		if (rng=scan(deg+=21,10))
		{		
			cannon(deg, rng);
			if ((++e)>1)
			{
				if (xs=loc_x()>499) Xmin(850,0,0); else Xmax(150,180,0); 
				if (ys=loc_y(xd=180*xs)>499) Ymin(850,90,0); else Ymax(150,270,0);
				Radar(dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100);	
				xp=60+xs*880;
				yp=60+ys*880;
				
				xdr=xd-180;
				ydr=yd-180;
				if (xs) { xmd=(150+(ys*60)); ymd=(120+(ys*120));	}
				else 	{ xmd=(30+(ys*300)); ymd=(60+(ys*240));		}
				odam=damage(vs3=0);
				while(1) 
				{
					if(vs3)
					{	
						if((nc+=1)<10)
						{
							if(tt%2) { if(!Look(xd)) tt+=1; }
							else    { if(!Look(yd)) tt+=1; }
						}
						else
						{	tt+=1;
							if(nc>25)
								F2f();
						}
						if(tt%2)
						{
							if (ys) Ymax(325,ymd,0); else Ymin(675,ymd,0); 
							if (xs) Xmin(850,xdr,0); else Xmax(150,xdr,0);
							if (ys) Ymin(850,ydr,1); else Ymax(150,ydr,1);
						}
						else
						{
							if (xs) Xmax(325,xmd,0); else Xmin(675,xmd,0);
							if (ys) Ymin(850,ydr,0); else Ymax(150,ydr,0);
							if (xs) Xmin(850,xdr,1); else Xmax(150,xdr,1);
						}	
						if(rng > 500)
						{
							odam=damage(vs3=0);							
						}
					}
					else
					{	
						Run(xd,xp,2-xs);	
						Run(yd,yp,6-ys);	
						if((dam=damage()) > (odam+16))
							F2f();
						else	odam = dam;
						if((rng > 0) && (rng < 250)) 
						{
							if((t+=(vs3=1)) > 2)
							{
								if(!Look(xd))	
								{ 
									gox();
								}
								else	
								{
									if(!Look(yd))	
									{ 
										goy();
									}
									else	
									{ 
										gox();
										goy();
									}
								}
								t=0;
							}
						}
						else t=0;
					}
				}
			}
		}
	}
	F2f();
}

gox()  {	xd=180*(xs=!xs); xp=60+xs*880; 	if (xs) Xmin(850,0, 0); else Xmax(150,180,0);   }
goy()	{	yd=yd=90+180*(ys=!ys); 		yp=60+ys*880; 				if (ys) Ymin(850,90,0); else Ymax(150,270,0);  }

Stop(dir,testf2f) { drive(dir,0); 	if(testf2f) Radar(); else while(speed()>59); }

Ymin(dis,dir,testf2f) { while(loc_y()<dis) 		Fulmine(dir); 	Stop(dir,testf2f); }

Ymax(dis,dir,testf2f) { while(loc_y()>dis)		Fulmine(dir); 	Stop(dir,testf2f); }

Xmin(dis,dir,testf2f) { while(loc_x()<dis)		Fulmine(dir); 	Stop(dir,testf2f); }

Xmax(dis,dir,testf2f) { while(loc_x()>dis)		Fulmine(dir);	Stop(dir,testf2f); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Martello()
{
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
		Cerca();
	}
}

Run(d,l,m) 
{ 
  	int r;
  	if(timer%4==3)
	{
		Radar();
  	}	
	drive(d,100);
	if(++timer>175+dam) F2f();			
	if(scan(d,10)) 
	{ 
		deg=d; 
		while (scan(d,10)>840) drive(d,100);
	} 
	else 	
	{
		while(Check(l,m)) drive(d,100);
	}
	Martello(drive(d,0)); 
	while(speed()>59);
  	++m;  
  	d+=180;
  	drive(d,100);
	while(Check(l,m)) drive(d,100);
	Martello(drive(d,0)); 
	while(speed()>59);
}

Check(l,m) 
{
  	int c1;
  	if(m<5) c1=loc_x(); else c1=loc_y();
  	if(m%2) return (c1>l); else return (c1<l);	
}	

F2f()
{
	int b,x,y,dir;
	while(1) 
	{	
		if (orng>400) dir=deg+60+(b^=1)*240;
		else dir=deg+80+(b^=1)*200;	       
		if ((x=loc_x(y=loc_y()))>850) dir=150+60*(y>500);
		else if (x<150) dir=330+60*(y<500);
       		else if (y>850) dir=240+60*(x<500);
        	else if (y<150) dir=60+60*(x>500);
		if(scan(deg-15,10)) deg-=4;
		Fuoco(dir);
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		Fuoco(dir);
		if(orng>500) 
		{
			drive(dir,100); 			
			Saetta(dir);
		}
	}
}

Radar() { int ang,en=0; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); if(en<2) F2f(); }

Saetta(dir) 
{
	int asin, acos;
	if(scan(deg,10))
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
		else Cerca();
  	} 
	else	Cerca();
}

Cerca()
{
  	if (rng=scan(deg-=350,10))  return cannon(deg,2*scan(deg,10)-rng);
  	if (rng=scan(deg-=20, 10))  return cannon(deg,2*scan(deg,10)-rng);
  	if (rng=scan(deg-=320,10))  return cannon(deg,2*scan(deg,10)-rng);
  	if (rng=scan(deg-=60, 10))  return cannon(deg,rng);
	if (rng=scan(deg-=280,10))  return cannon(deg,rng);
	return deg-=100;

}

Fulmine(dir)
{
	drive(dir,100);
	if(scan(dir,10))
		deg=dir;
	else	if(rng > 700)	deg+=180;
	Saetta(dir);
}

Ritrova()
{
	if((orng=scan(deg-=80,10))) 		return cannon(deg,orng);
	else if((orng=scan(deg-=20,10))) 	return cannon(deg,orng);
	else if((orng=scan(deg+=120,10))) 	return cannon(deg,orng);
	else if((orng=scan(deg+=20,10))) 	return cannon(deg,orng);
	else if((orng=scan(deg-=160,10))) 	return cannon(deg,orng);
	else return deg+=260;
}

Fuoco(dir)
{
	drive(dir,100);
	if(orng=scan(deg, 10))
	{ 
        	if(scan(deg-15,10)) 
		{ 
			if(scan(deg-=13,4)) 
			{ 
                		if(scan(deg-3,5)) deg-=5;
		            }
			else if(scan(deg-5,5)) deg-=5;
        	}
		else if(scan(deg+14,10)) 
		{ 
            if(scan(deg+=13,5)) deg+=5; 
        	}  
		else if(scan(deg+4,5)) deg+=5; else deg-=5;
    	} 
	else if((orng=scan(deg-=20,10))) 
	{ 
        	if(scan(deg-9,10)) 
		{ 
        	    if(scan(deg-=13,5)) deg-=5; 
	        } 
			else if(scan(deg+9,10)) deg+=6; 
	    }
		else if((orng=scan(deg+=40,10))) 
		{ 
	        if(scan(deg+9,10)) deg+=12;
	}
	else if(orng=scan(deg+=20,10));
	else return Ritrova();
    	if(rng=scan(deg,10))  cannon(deg,rng*135/(135+orng-rng)); 
	else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
	else if(rng=scan(deg+=40,10)) cannon(deg,rng); 
	else deg+=40; 
} 

