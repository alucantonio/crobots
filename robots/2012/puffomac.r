/*
Nome: 	Puffo Macro
Autore:	Franco Cartieri

Torneo 2012

Poco tempo e nessuna idea nuova.

*/

int deg,rng,odeg,orng,t,nc,xs,ys,en,xd,yd,xmd,ymd,dmin,dmax;
int ff, dir, x, y, b, timer, xp, yp;


Stop(dir) { drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis)	Fire(dir); 	Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis)	Fire(dir); 	Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis)	Fire(dir); 	Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis)	Fire(dir); 	Stop(dir); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Radar() { int ang; en=0; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); }

Fire(dir)
{
  	int asin,acos;
	if(scan(dir,10))
		deg = dir;
  	if (speed()<100) drive(dir,100); 	
	else 	
	{
		if(rng > 850) deg+=180;
	}
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
  	int r=0;
  	if ((timer%12==2) && (rng > 400))
		Radar();
	while(r<2) 
	{
	  	drive(d,100);
		++r;
		++timer;
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
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
  	if (xs=loc_x(timer=0)>499) Xmin(850,0); else Xmax(150,180); 
  	if (ys=loc_y(xd=180*xs)>499) Ymin(850,90); else Ymax(150,270);
	dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100;
    	if (xs) { if (ys) { xmd=200; ymd=250; } else { xmd=160; ymd=110; } } 
	else {  if (ys) { xmd=340; ymd=290; } else { xmd=20; ymd=70; }  }
    	Radar(ff=0);
	while((en>2) && (timer < 100) && (damage() < 30))
	{
    		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
 	while (en>1) 
	{
		while(Look(xd) || Look(yd) || en) 
		{
			/*if(++timer > (300-damage())) f2f();*/
			en=0;
      			if((nc+=1)<20)
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
	f2f();
}


