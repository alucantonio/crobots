/*

Torneo 2015
Nome:	hulk.r		(1000 istruzioni)
Autore:	Franco Cartieri

Descrizione robot:
Hulk è un crobots molto offensivo. E' in sostanza una rivisitazione di Lamela del torneo 2013. 
E' ottimizzato per lo scontro a 2 in particolare contro robot oscillanti, perde qualche punto nel 4vs4.

*/

int deg,odeg,rng,dir,orng,x,y,b;

main()
{
	if (loc_y(x=(loc_x()>500))>500) 
	{
		if (x) deg=210; else deg=300;
	}else 
	{
		if (x) deg=120; else deg=30;
	}
	spacca(dir=deg);
	while(1) 
	{
		if (orng>400) dir=deg+60+(b^=1)*240;
		else dir=deg+80+(b^=1)*200;	       
		if ((x=loc_x(y=loc_y()))>850) dir=150+60*(y>500);
		else if (x<150) dir=330+60*(y<500);
       		else if (y>850) dir=240+60*(x<500);
        	else if (y<150) dir=60+60*(x>500);
		if(scan(deg-15,10)) deg-=4;
		spacca();
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		spacca();
		if(orng>500) rompi();
	}
}

trova() 
{
	if (scan(deg+13,10)) deg+=3; if (scan(deg-13,10)) deg-=3;
	if (scan(deg+12,10)) deg+=2; if (scan(deg-12,10)) deg-=2;
	if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;
	return scan(deg,10);
}

rompi() 
{
	drive(dir,100);
	if (scan(deg,10));
	else if (scan(deg+=20,10));
	else if (scan(deg-=40,10));
	else if (scan(deg+=60,10));
	else if (scan(deg-=80,10));
	else {
		if (orng=scan(deg+=100,10)) return cannon(deg,orng);
		else if (orng=scan(deg-=120,10)) return cannon(deg,orng);
		else if (orng=scan(deg+=140,10)) return cannon(deg,orng); 
		else if (orng=scan(deg-=160,10)) return cannon(deg,orng);
	}
	if (scan(deg-18,10)) deg-=7; 
	if (scan(deg+18,10)) deg+=7;
	if (orng=trova()) 
	{
		if (rng=trova(odeg=deg))
			return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
		else if (rng=scan(deg-=20,10)) cannon(deg,rng); 
		else if (rng=scan(deg+=40,10)) cannon(deg,rng); 
	}	
	else if (rng=scan(deg-=20,10)) cannon(deg,rng); 
	else if (rng=scan(deg+=40,10)) cannon(deg,rng); 
}

spacca()
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
		if ((orng=scan(deg-=80,10))) 		return cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) 	return cannon(deg,orng);
		else if ((orng=scan(deg-=160,10))) 	return cannon(deg,orng);
		else return deg+=260;
	}  
    	if (rng=scan(deg,10))		cannon(deg,rng*135/(135+orng-rng)); 
	else if (rng=scan(deg-=20,10)) 	cannon(deg,rng); 
	else if (rng=scan(deg+=40,10))	cannon(deg,rng); 
	else if (rng=scan(deg-=60,10)) 	cannon(deg,rng); 
	else if (rng=scan(deg+=80,10)) 	cannon(deg,rng); 
	else deg+=40; 
} 
