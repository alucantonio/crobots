/*

Torneo 2020	
Nome:	hulk_20.r		(997 istruzioni - midi)
Autore:	Franco Cartieri

Descrizione robot:
Hulk_20 e' un crobots molto offensivo.
E' ottimizzato per lo scontro a 2, ma si comporta bene anche nel 3vs3.
L'unica idea aggiunta e' quella di cercare di adattarsi all'avversario, 
se l'avversario e' distante si muove lungo un quadrato al centro dell'arena e attacca con una routine di fuoco lenta ma precisa,
se l'avversario e' vicino si muove con oscillazioni e usa una routine di fuoco più veloce.

*/

int deg,odeg,rng,dir,orng,x,y,b;

main()
{
	if(loc_y(x=(loc_x()>500))>500) 
	{
        if(x) 	Spacca(dir=deg=210);
        else	Spacca(dir=deg=300);
	}
	else 
	{
		if(x) 	Spacca(dir=deg=120);
		else 	Spacca(dir=deg=30);
	}
	Rompi();
	while(1) 
	{
		if(orng>525) 
		{
			Spacca(dir=180);
			while(Vai(loc_x() > 450));
			if(orng>525) 
			{
				Spacca(dir=270);
				while(Vai(loc_y() > 450));
			}
			if(orng>525) 
			{			
				Spacca(dir=0);
				while(Vai(loc_x() < 550));
			}
			if(orng>525) 
			{
				Spacca(dir=90);
				while(Vai(loc_y() < 550));
			}
		}
		else
		{	
			dir=deg+75+(b^=1)*210;
			if ((x=loc_x(y=loc_y()))>850) dir=150+60*(y>500);
			else if (x<150) dir=330+60*(y<500);
       		else if (y>850) dir=240+60*(x<500);
        	else if (y<150) dir=60+60*(x>500);
			else if(damage()>75) dir+=3;
			if(scan(deg-15,10)) deg-=5;
			Spacca();
			if(scan(deg-15,10)) deg-=5;
			if(scan(deg+15,10)) deg+=5;
			Spacca();
		}
	}	  
}

Rompi() 
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
			return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
		else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
		else if(rng=scan(deg+=40,10)) cannon(deg,rng); 
	}	
	else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
	else if(rng=scan(deg+=40,10)) cannon(deg,rng); 
	else deg+=40; 
	return 1;
}

Spacca()
{
	drive(dir,100);
    if(orng=scan(deg, 10))
	{ 
        if(scan(deg-15,10)) 
		{ 
			if(scan(deg-=13,5)) 
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
		else if(scan(deg+9,10)) deg+=5; 
    }
	else if((orng=scan(deg+=40,10))) 
	{ 
        if(scan(deg+9,10)) deg+=12;
    }
	else if(orng=scan(deg+=20,10));
	else return Ritrova();
	if(rng=scan(deg,10))  cannon(deg,rng*125/(125+orng-rng)); 
	else if(rng=scan(deg-=20,10)) cannon(deg,rng); 
	else if(rng=scan(deg+=40,10)) cannon(deg,rng); 
	else deg+=40; 
} 

Vai(c)
{
	if(c && (orng>525))
		return Rompi();
	else return 0;
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
