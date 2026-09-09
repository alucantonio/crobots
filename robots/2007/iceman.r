/*
Nome: 	iceman.r		(midi)
Autore: 	Franco Cartieri

Torneo 2006

All'inizio dell'incontro iceman.r si stampa sul bordo verticale piu' vicino ed inizia ad oscillare su e giu'.
L'oscillazione diventa piu' ampia ad ogni ciclo fino ad arrivare a tutta la lunghezza del lato verso 
la fine dell'incontro.
All'inizio dell'incontro e dopo ogni 10 cicli controlla il numero di avversari, se ne e' rimasto uno solo inizia
l'attacco finale che consiste in un movimento lungo il quadrato che si ottiene unendo i punti centrali dei lati 
dell'arena di gioco.
L'unico suo punto di forza sono le routine di fuoco (una per 4vs4 e una per f2f) che ho copiato da Caos.r e Zeus.r. 
(Provando a modificarle sono solo riuscito a peggiorarne le prestazioni!!!) 

*/

int deg,rng,odeg,orng,t1,t2,ydr,cnt,xs,ys,en,xd,yd,dmin,dmax;

main()
{
	if(xs=loc_x(t1=800)>499)
		Xmin(925,0);
	else	Xmax(75,180);
	ydr=(yd=90+180*(ys=loc_y(t2=200)>499))-180;
	Radar(dmax=(dmin=yd+90*(xs^ys)-105)+100);
  	while (en>1) 
	{		
		while((cnt+=1)<10)	
		{
			if(ys) 
			{
				Ymax(t1-=8,yd);
				Ymin(850,ydr); 
			}
			else 
			{
				Ymin(t2+=8,yd); 	
	      		Ymax(150,ydr);
			}
		}
	 	Radar();
 	}
	Ymaxf(150,270);
	if(loc_x() < 500)	Xminf(450,0);
	else			Xmaxf(550,180);
    	while(1)
     	{
		Xmaxf(150,135);
		Yminf(850,45);
		Xminf(850,315);
		Ymaxf(150,225);
 	}
}

Stop(dir) { drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis) 	Fuoco(dir); 	Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis) 	Fuoco(dir); 	Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis) 	Fuoco(dir); 	Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis) 	Fuoco(dir); 	Stop(dir); }

Yminf(dis,dir) { while(loc_y()<dis) Fuocof2f(dir); 	Stop(dir); }

Ymaxf(dis,dir) { while(loc_y()>dis) Fuocof2f(dir); 	Stop(dir); }

Xminf(dis,dir) { while(loc_x()<dis) Fuocof2f(dir); 	Stop(dir); }

Xmaxf(dis,dir) { while(loc_x()>dis) Fuocof2f(dir); 	Stop(dir); }

Radar() { int ang; cnt=(en=0); ang=dmin; while(ang<=dmax) en+=(scan(ang+=20,10)>0); }

Fuoco(dir)
{
	int asin,acos;
    	if (speed()<100) drive(dir,100); else { if (scan(dir,10)) deg=dir; if (rng>850) deg+=120; }
    	if (scan(deg,10) > 100) 
	{  
   		asin=(sin(deg-dir)/14384); 
		acos=(cos(deg-dir)/3796)-230;
    		Find();
    		if (orng=scan(odeg=deg,3)) 
		{
      		Find();
      		cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,rng*230/(orng-rng-acos)); 
    		}
		else	Search(); 
	}
	else	Search(); 
}

Find()
{
  	if(scan(deg-13,10)) 	deg-=5;
  	else if(scan(deg+13,10))deg+=5;
  	if(scan(deg+12,10)) 	deg+=4;
  	else if(scan(deg-12,10))deg-=4;
  	if(scan(deg-11,10)) 	deg-=2;
  	if(scan(deg+11,10)) 	deg+=2;
}

Fuocof2f(dir)
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
	      if(orng=scan(odeg=deg,3))
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
  	if (rng=scan(deg+=350,10)) 	return cannon(deg,rng); 
  	if (rng=scan(deg+=20,10))  	return cannon(deg,rng); 
  	if (rng=scan(deg+=320,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=60,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=280,10)) 	return cannon(deg,rng);
  	Search(deg-=220);
}
