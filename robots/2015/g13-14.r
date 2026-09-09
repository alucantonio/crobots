/* ************************************************************************************************************************************************************** */
/* == GUNNYBOY 2013 ==  By Paolo Di Benedetto											  */
/* Serie GUNNYBOY. Oscilla negli angoli, se non trova nessuno conta												  */
/* se trova 1 solo avversario banzai												  				  */
/* La routine di fuoco e puntamento come ormai tradizione ricca di parametri custom. 									          */
/* ************************************************************************************************************************************************************** */

/* dichiarazioni variabili globali */
int xpos,ypos, upperx, uppery, lowerx, lowery; /* memorizzano la posizione */
int dir; /* per muoversi */
int ang, range, orange, oang,a1,a2,a3,a4,a5,a6,a7,a8,a9,ab; /*parametri vari*/
int xa,ya, danni, ne;
int t;
/* guida banzai */
int x,y,uplimit, lowlimit, b;

main()
{
/* inizializzazione variabili banzai*/
	uplimit = 820;
	lowlimit = 180;
	b = 1;
/* inizializzazione variabili */
	
	a1= 1046; 	/* parametro di fuoco spara*/
	a2= 479; 	/* parametro di fuoco spara*/
	a3= 38081; 	/* parametro di fuoco spara*/
	a4= 142; 	/* parametro di fuoco spara*/
	a5= 9656; 	/* parametro di fuoco spara*/
	a6= 300; 	/* t soglia banzai*/
	a7= 100; 	/* parametro di fuoco frena*/
	a8= 60; 	/* parametro di fuoco frena*/
	a9= 60; 	/* parametro di fuoco frena*/
        ab= 2; 		/* parametro di fuoco frena*/

	t = 1;
	/* Routine che guida il robot nello angolo piu vicino	*/
	ypos=loc_y();
	xpos=loc_x();	
	xa=1000*(xpos>500);
	ya=1000*(ypos>500);

	dir = plot(xa, ya);
	drive(dir,100);
	ang = dir;
	while (((xpos-xa)*(xpos-xa)+(ypos-ya)*(ypos-ya))>=40000)
	{
		if (cerca()) spara();
		ypos=loc_y();
		xpos=loc_x();
	}
	frena();
	/* sono al sicuro verifico se è un 2v2 e poi calcolo i parametri di movimento nello angolo*/
	contali();
	confine();
	danni=damage();
	while(1) 
	{
		guida();
		if (cerca()) spara();
		if(t>310) {frena(); contali();t=1;} /* t aggiornato nella funzione spara */
	}
}

confine()
{
	ypos=loc_y();
	xpos=loc_x();
	upperx = 200*(xpos<500)+880*(xpos>500);
	lowerx = 120*(xpos<500)+800*(xpos>500);
	uppery = 50*(ypos<500)+950*(ypos>500);
}

spara()
{
		/*prima scansione*/
		refine();
		orange=scan(oang=ang,10);
		/*seconda scansione*/
		refine();
		ang = ang+(ang-oang)*((1172+(range=scan(ang,10)))/523)-(sin(ang-dir)/43997);
		range = range*156/(156+orange-range-(cos(ang-dir)/9516))+100*(range<60);
		cannon(ang,range);
		/*ang = ang-20+45*(range>700); vediamo se c'è qualcun altro piu interessante intorno*/
		t +=1;
}

refine()
{	
		if(scan(ang+8,8)) ang+=4;
		else ang-=4;

		if(scan(ang+8,8)) ang+=2;
		else ang-=2;

		if(scan(ang+8,8)) ang+=1; 
		else ang-=1;
}


cerca()
{
	if (scan(ang,10)) return 1;
	else if (scan(ang-=20,10)) return 1;
	else if (scan(ang+=40,10)) return 1;
	else if (scan(ang-=60,10)) return 1;
	else if (scan(ang+=80,10)) return 1;
	else if (scan(ang-=100,10)) return 1;
	else if (scan(ang+=120,10)) return 1;
	else if (scan(ang-=140,10)) return 1;
	else if (scan(ang+=160,10)) return 1;
	else if (scan(ang-=180,10)) return 1;
	else return 0;
}


guida()
{
/* Routine principale di oscillazione nello angolo */
	xpos=loc_x();
	ypos=loc_y();
	if (xpos>upperx) {dir=170+20*(ypos>uppery);frena();}
	if (xpos<lowerx) {dir=10-20*(ypos>uppery);frena();}
	drive(dir,100);
}

guida2()
{ 
		if ((xa=loc_x(ya=loc_y()))>820) dir=135+90*(ya>500);
                else if (xa<180) dir=45-90*(ya>500);
                else if (ya>820) dir=315-90*(xa>500);
                else if (ya<180) dir=45+90*(xa>500);
		else if (range>700) dir=ang+30;
		else if (range<500) dir=ang+210;
		else dir=ang+180*(b^=1);
}


contali()
{ 
int ang2, amax, amin;
	ne=0;
	amin = 90*(xa>500)*(ya<500)+180*(xa>500)*(ya>500)+270*(xa<500)*(ya>500);
	amax = 180*(xa>500)*(ya<500)+270*(xa>500)*(ya>500)+360*(xa<500)*(ya>500)+90*(xa<500)*(ya<500);
	ang2= amin-60;
	ne=0;
	while((ang2+=20)<=amax+40) if (scan(ang2,10)) {ne+=1;cannon(ang2, scan(ang2,10));} /* se vedo qualcosa nel dubbio sparo */
	if (ne<2) banzai();

}

banzai()
{
	while(1) 
	{
		guida2();
		fuocofast();
		fuocofast();
		fuocofast();
		fuocofast();
		fuocofast();
	}
}

fuocofast()
{
	drive(dir,100);
	if (range=scan(oang=ang,10))
	{
		refine();
		cannon(2*ang-oang,2*scan(ang,10)-range);
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
	}
}


frena() 
{ 
	drive(dir,0);           /* freno */ 
	while (speed()>50) 
	{              /* finchè freno sparo do coio coio */ 
		if (range=scan(oang=ang,10)) 
		{ 
			refine();
			cannon(2*ang-oang,2*scan(ang,10)-range); 
       		}
	} 
}
 

plot (x,y)     /* solita funzione arcinota data una coordinata cartesiana ritorna la direzione per */
int x, y, r;      /* raggingerla dalla posizione attuale */
{
	int locx, locy, r;
	locx = loc_x();
	locy = loc_y();
	if (locx==x)
	 {
		if (y>locy) return 90;
		else return 270;
	 } 
	else
	 {
		 r=atan(100000*(locy-y)/(locx-x));
		 if( y < locy)
		 {
		 	if (x > locx) return 360 + r;
			else return 180 + r;
		  }
		  else if (x > locx) return r;
				else return (180+r);
	 }
}