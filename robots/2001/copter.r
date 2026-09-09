/*
Nome: 		Copter.r
Autore: 	Franco Cartieri

Copter e' un microcrobots molto semplice: all'inizio dell'incontro si posiziona 
nell'angolo in basso a destra e si muove in senso orario lungo i lati di un triangolo.
Ogni 10 cicli controlla se sia rimasto solo un robot: in questo caso passa alla 
routine di attacco finale; mentre ogni 100 cicli controlla se ci sono dei robot 
raggiungibili con il cannone, in caso contrario passa alla routine di attacco finale.
La routine di attacco finale e' un ciclo in cui il robot si muove in senso antiorario 
lungo il quadrato che si ottiene, unendo i punti centrali dei lati del campo di gioco.
La routine di sparo e' veloce ma molto imprecisa.
*/

int r,t,last,ang,dis,contacicli;

/* routine di sparo */
fuoco(dir)
int dir;
{
	drive(dir,100);
     	if((r=scan(ang,10))&&(r<770))   			cannon(ang,2*scan(ang,10)-r);    
   	else	if((r=scan(ang+=339,10))&&(r<770))		cannon(ang,2*scan(ang,10)-r); 
         	else	if((r=scan(ang+=42,10))&&(r<770))	cannon(ang,2*scan(ang,10)-r); 
        		else    ang+=41;
}

main()
{
     	contacicli=ang=last=10;
	/* si sposta nell'angolo in basso a destra */
     	while(loc_x()<900) fuoco(0);
     	while(loc_y()>100) fuoco(270);

	while(last>1)
	{
		t=10;
		while(--t)
		{
			/* si muove lungo un triangolo */
               		dis=750+damage();
			while(loc_x()>dis) fuoco(180);
			while(loc_x()<925) fuoco(45);
               		while(loc_y()>100) fuoco(270);
           	}
		/* ogni 10 cicli controlla se ci sono supestiti */
         	drive(last=0,0);
		ang=10;
		while((ang+=20)<370) last+=(scan(ang,10)>0);
         	contacicli=contacicli-1;
		if(contacicli==0)
		{
			/* ogni 100 cicli controlla se ci sono dei robot raggiungibili */
			ang=contacicli=10;
			last=1;
             	while((ang+=20)<370) last+=((scan(ang,10)>0)&&(scan(ang,10)<700));
         	}
	}	
     	while(loc_x()>500) fuoco(180);
	/* attacco finale */
     	while(1)
     	{
		while(loc_x()<900) fuoco(45);
		while(loc_y()<900) fuoco(135);
		while(loc_x()>100) fuoco(225);
		while(loc_y()>100) fuoco(315);
 	}
}
