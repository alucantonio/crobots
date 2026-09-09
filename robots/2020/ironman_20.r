/*

Torneo 2020
Nome: 	ironman_20.r	(1975 istruzioni - macro)
Autore: Franco Cartieri

All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo due triangoli disegnati sui lati dell'angolo.
Se uno dei due angoli adiacenti e' libero il movimento diventa asimmetrico verso questo angolo.
Se i due angoli adiacenti sono entrambi occupati o se sono stati effettuati piu' di 10 cicli il movimento diventa simmetrico.
Oltre i 25 cicli parte comunque per l'attacco finale.
Ad ogni ciclo controlla il numero di avversari, se ne e' rimasto uno solo inizia l'attacco finale.

*/

int deg,rng,odeg,orng,t,nc,xs,ys,xd,yd,xmd,ymd,dmin,dmax,xdr,ydr,e;

main() 
{
	while(deg<360)
	{
		if(rng=scan(deg+=21,10))
		{		
			cannon(deg+=3, rng);
			if((++e)>1)
			{
				if (xs=loc_x()>499) Xmin(850,0,0); else Xmax(150,180,0); 
				if (ys=loc_y(xd=180*xs)>499) Ymin(850,90,0); else Ymax(150,270,0);
				Radar(dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100);
				xdr=xd-180;
				ydr=yd-180;
				if(xs) 	{ xmd=(150+(ys*60)); ymd=(120+(ys*120));	}
				else	{ xmd=(30+(ys*300)); ymd=(60+(ys*240));		}
				while(1) 
				{
					if((nc+=1)<10)
					{
						if(t%2) { if(!Look(xd)) t+=1; }
						else    { if(!Look(yd)) t+=1; }
					}
					else
					{	t+=1;
						if(nc>25)
							F2f();
					}
					if(t%2)
					{
						if (ys) Ymax(300,ymd,0); else Ymin(700,ymd,0); 
						if (xs) Xmin(850,xdr,0); else Xmax(150,xdr,0);
						if (ys) Ymin(850,ydr,1); else Ymax(150,ydr,1);
					}
					else
					{
						if (xs) Xmax(300,xmd,0); else Xmin(700,xmd,0);
						if (ys) Ymin(850,ydr,0); else Ymax(150,ydr,0);
						if (xs) Xmin(850,xdr,1); else Xmax(150,xdr,1);
					}	
				}
			}
		}
	}
	F2f();
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
		Raggio(dir);
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		Raggio(dir);
		if(orng>500) Missile(dir);
	}
}

Stop(dir,testf2f) { drive(dir,0); 	if(testf2f) Radar(); else while(speed()>59); }

Ymin(dis,dir,testf2f) { while(loc_y()<dis) 	Spara(dir); 	Stop(dir,testf2f); }

Ymax(dis,dir,testf2f) { while(loc_y()>dis)	Spara(dir); 	Stop(dir,testf2f); }

Xmin(dis,dir,testf2f) { while(loc_x()<dis)	Spara(dir); 	Stop(dir,testf2f); }

Xmax(dis,dir,testf2f) { while(loc_x()>dis)	Spara(dir);		Stop(dir,testf2f); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Radar() { int ang,en; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); if(en<2) F2f();	}

Missile(dir) 
{
	drive(dir,100); 	
	if(scan(deg,10));
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else if(scan(deg+=60,10));
	else return Ritrova();
	if(scan(deg-18,10)) deg-=7; 	
	if(scan(deg+18,10)) deg+=7; 	
	if(orng=Affina()) 
	{
		if(rng=Affina(odeg=deg))
			cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
		else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
		else deg+=40;
	}	
	else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
	else deg+=40;
}

Affina() 
{
	if(scan(deg+13,10)) deg+=3; 	if(scan(deg-13,10)) deg-=3;
	if(scan(deg+12,10)) deg+=2; 	if(scan(deg-12,10)) deg-=2;
	if(scan(deg+10,10)) deg+=1;		if(scan(deg-10,10)) deg-=1;
	return scan(deg,10);
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

Raggio(dir)
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

Spara(dir)
{
  	int asin,acos;
	drive(dir,100); 	
	if(scan(dir,10))
			deg=dir;
	else	if(rng > 700) deg+=180;
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
		else 	Cerca(); 
  	} 
	else 	Cerca();  
}

Cerca()
{
  	if (scan(deg-=350,10)) 	return Raffica();
  	if (scan(deg-=20, 10))  return Raffica();
  	if (scan(deg-=320,10)) 	return Raffica();
  	if (scan(deg-=60, 10))  return Raffica();
  	if (scan(deg-=280,10)) 	return Raffica();
  	if (scan(deg-=100,10)) 	return Raffica();
  	if (scan(deg-=240,10)) 	return Raffica();
  	if (scan(deg-=140,10)) 	return Raffica();
  	if (scan(deg-=200,10)) 	return Raffica();
	if (scan(deg-=180,10)) 	return Raffica();
	if (scan(deg-=160,10)) 	return Raffica();	
	if (scan(deg-=220,10)) 	return Raffica();
  	if (scan(deg-=120,10)) 	return Raffica();
  	if (scan(deg-=260,10)) 	return Raffica();
	if (scan(deg-=80, 10))  return Raffica();
	if (scan(deg-=300,10)) 	return Raffica();
	if (scan(deg-=40, 10))  return Raffica();
  	if (scan(deg-=340,10))	return Raffica();
}

Raffica()
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
		return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng));
  	}  
	else 	Cerca();
}
