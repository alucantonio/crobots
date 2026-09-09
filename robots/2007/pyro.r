/*
Nome: 	pyro.r		(micro)
Autore: 	Franco Cartieri

Torneo 2006

All'inizio dell'incontro pyro.r si stampa sul bordo verticale piu' vicino ed inizia ad oscillare su e giu'.
L'oscillazione diventa piu' ampia ad ogni ciclo fino ad arrivare a tutta la lunghezza del lato verso 
la fine dell'incontro.
Non controlla i danni subiti e nemmeno il numero di avversari, non ha di conseguenza nessuna 
routine di attacco finale.
L'unico suo punto di forza e' la routine di fuoco che ho copiato da Caos.r. 
(Provando a modificarla sono solo riuscito a peggiorarne le prestazioni!!!) 

*/

int deg,rng,odeg,orng,t1,t2,ys,yd,ydr;

main()
{
	if(loc_x(t1=800)>499)
		Xmin(925,0);
	else	Xmax(75,180);
	ydr=(yd=90+180*(ys=loc_y(t2=200)>499))-180;
  	while (1) 
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
}

Stop(dir) { drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis) Fuoco(dir); Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis) Fuoco(dir); Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis) Fuoco(dir); Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis) Fuoco(dir); Stop(dir); }

Fuoco(dir)
{
  	int asin,acos;
    	if (speed()<100) 	drive(dir,100); 	else 	{	if (scan(dir,10)) deg=dir;	if (rng>850) deg+=120;	}
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
  	if(scan(deg-13,10)) 		deg-=5;
  	else if(scan(deg+13,10))	deg+=5;
  	if(scan(deg+12,10)) 		deg+=4;
  	else if(scan(deg-12,10))	deg-=4;
  	if(scan(deg-11,10)) 		deg-=2;
  	if(scan(deg+11,10)) 		deg+=2;
}

Search()
{
  	if (rng=scan(deg+=350,10))	return cannon(deg,rng);
  	if (rng=scan(deg+=20,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=320,10)) 	return cannon(deg,rng);
  	if (rng=scan(deg+=60,10))  	return cannon(deg,rng);
  	if (rng=scan(deg+=280,10)) 	return cannon(deg,rng);
  	Search(deg-=220);
}
