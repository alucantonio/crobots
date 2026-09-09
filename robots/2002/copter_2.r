/*
Nome: 		Copter_2.r
Autore: 	Franco Cartieri

Torneo 2002

Copter_2.r e' un microcrobots molto semplice. Non ha routine di controllo del numero degli avversari, controllo danni subiti o routine di attacco finale.
Esegue continuamente un ciclo in cui il robot si muove in senso antiorario lungo il quadrato che si ottiene, unendo i punti centrali dei lati del campo di gioco.
La routine di sparo deriva da MicroDNA.
Spero che questo microcrobots si comporti bene nel f2f.
*/

int angdir,deg,odeg,rng,orng;

main()
{
     	while(1)
     	{
		angdir=angolo(900,500);
		while(loc_x()<875) fuoco();
		angdir=angolo(500,900);
		while(loc_y()<875) fuoco();
		angdir=angolo(100,500);
		while(loc_x()>125) fuoco();
		angdir=angolo(500,100);
		while(loc_y()>125) fuoco();	
 	}
}

fuoco()
{
	drive(angdir,100);
    	if (orng=scan(deg,10))
    	{
        	if(orng<400) 
	        {
          		if (orng<100) return cannon(deg,orng);
          		if (scan(deg-10,6)) deg-=10;
          		else if (scan(deg+10,6)) deg+=10;
         		cannon(deg,(scan(deg,10)<<1)-orng); 
       			return;   
        	}
        	if (!scan(deg-=6,6)) deg+=12; 
	        find();
		if (orng=scan(odeg=deg,5))
        	{
            		find();
            		cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9)-(sin(deg-angdir)>>14),
                   		rng*250/(250+orng-rng-(cos(deg-angdir)>>12))); 
        	} 
     	}
     	else
     	{
        	if (scan(deg-=20,10)) return fuoco();
        	if (scan(deg+=40,10)) return fuoco();
        	deg+=40; 
     	}
}

find()
{
  	if(scan(deg-7,3)) deg-=7;
  	if(scan(deg+7,3)) deg+=7;
  	if(scan(deg-4,2)) deg-=4;
  	if(scan(deg+4,2)) deg+=4;
  	if(scan(deg-2,1)) deg-=2;
  	if(scan(deg+2,1)) deg+=2;
}
	
angolo(xx, yy)
int xx,yy;
{     
	int x;
       	return (180+((x=xx-(loc_x()))>0)*180+atan(((yy-loc_y())*100000)/x));
}

