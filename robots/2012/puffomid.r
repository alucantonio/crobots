/* 
Nome: 	Puffo Midi
Autore:	Franco Cartieri

Torneo 2012

Poco tempo e nessuna idea nuova.

*/

int b,dir,rng,orng,deg,odeg,x,y,ff;
int xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd;

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
		}
		return(cannon(deg+ff*(deg-odeg),2*scan(deg,10)-rng)); 
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
 	if ((timer%12==2) && (rng > 400)) 
	{
		en=0;
		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
		dmin=zd; 
	}
	spara(drive(d,100));
 	if (++timer>500-damage()) f2f(); 
    	if (scan(d,10)) 
	{ 
		deg=d; 
		while (scan(d,10)>840) ;
	} 
	else 	while(check(l,m)) drive(d,100);
	fire(d,0);  
     	while(speed()>59) ;
  	++m;  
  	drive(d+=180,100);
 	if (++timer>500-damage()) f2f(); 
	while(check(l,m)) drive(d,100);
	fire(d,0);  
     	while(speed()>59) ;
}

check(l,m) 
{
  	int c1;
  	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	

f2f()
{
	ff=1;
	while(1) 
	{
		if ((x=loc_x())>880) dir=180;
                else if (x<120 ) dir=0;
                else if ((y=loc_y())>880) dir=270;
                else if (y<120) dir=90;
		else if (rng>600) dir=deg+30;
		else if (rng<150) dir=deg+210;
		else dir=deg+180*(b^=1);
		fire(dir,100);
		fire(dir,100); 
		fire(dir,100);
	}
}

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(ff=en=0))>499)*880)>499)*880;
	drive(dir=((xd=180*xs)+180),100);
	while(check(xp,3-xs));
	fire(drive(dir,0));  
     	while(speed()>59);
	drive((dir=(yd=90+180*ys)+180),100);
	while(check(yp,7-ys));
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
