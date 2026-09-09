/*  
 Apache.r
 20/08/1994
 Michelangelo Messina
 Angelo Ciufo
*/

int ang,dir,oldr,pausa,dam;

main()               
{
	fuggi();     /* va vicino a un bordo */
	while (1)    /* ciclo principale */
	{
		if ( damage()>(dam+3) ) fuggi(); /* se colpito fugge */
		else /* se in movimento usa routine di sparo in movimento, 
			altrimenti usa la routine di sparo da fermo */
		{
			if (speed()) mosso();
			else fermo();
		}
	}
}

int quadrante()
{
/* restituisce 0,1,2 e 3 a seconda dell'angolo in cui si trova il robot
   oppure 5 se si trova nella fascia centrale */

	int x,y;

	y=loc_y();
	if ((x=loc_x())<333){
		if (y<=500) return(0);
		else return(3);
	}
	else if (x>667) {
		if (y>500) return(2);
		else return(1);
	}
	return(5);
}
 
fuggi()
{
	int a1,a2,range,sfas,i;

	/* cerco la direzione di fuga */

	drive(dir,0);
	a1=quadrante();
	if (a1!=5) {
		a1*=90;
		a2=a1+90;
		if (!scan(a2,10)) dir=a2;
		else if(!scan(a1,10)) dir=a1;
		else if(!scan(a1+45,10)) dir=a1+45;
		else if(!scan(a1+22,10)) dir=a1+22;
		else dir=a2-22;
	}
	else {
		if(!scan(0,10)) dir=0;
		else if(!scan(90,10)) dir=90;
		else if(!scan(180,10)) dir=180;
		else dir=270;
	}
	drive (dir,100);
	pausa=0;
	dam=damage();
	
	/* routine di sparo semplificata */
	if (!(range = scan (ang, 5))) {
		if (range = scan(ang -= 10, 5)) sfas = -6;
		else if (range = scan(ang -= 15, 10)) sfas = -10;
		else if (range = scan(ang += 35, 5)) sfas = 6;
		else if (range = scan(ang += 15, 10)) sfas = 10;
		else {
			i=6;
			while (!(oldr = scan(ang += 20, 10)) && (--i));
			return;
		}
	}
	else sfas=0;

	if (range<710) {
		if (oldr) cannon(ang + sfas, range + (range - oldr) / 3);
		else cannon(ang, range);
	}
	else if (range>850) {
		ang+=40;
		oldr=0;
		return;
	} 

	oldr=range;
}

mosso()
{
	/* routine di sparo in movimento */

	int     range,sfas,i;
	int     x,y,cx,sx;
	
	/* controllo se vicino al bordo */
	if ((x=loc_x())>880 && (cx=cos(dir))>0) drive(dir,0);
	else if (x<120 && cx<0) drive(dir,0);
	else if ((y=loc_y())>880 && (sx=sin(dir))>0) drive(dir,0);
	else if (y<120 && sx<0) drive(dir,0);

	/* sparo */
	if (!(range = scan (ang, 3))) {
		if (range = scan(ang -= 6, 3)) sfas = -4;
		else if (range = scan(ang -= 7, 4)) sfas = -7;
		else if (range = scan(ang -= 12, 8)) sfas = -10;
		else if (range = scan(ang += 31, 3)) sfas = 4;
		else if (range = scan(ang += 7, 4)) sfas  = 7;
		else if (range = scan(ang += 12, 8)) sfas = 10;
		else {
			i = 6;
			while (!(oldr = scan(ang += 20, 10)) && (--i));
			return;
		}
	}
	else sfas=0;

	if (range<710) {
		if (oldr) cannon(ang + sfas, range + (range - oldr) / 3);
		else cannon(ang, range);
	}
	else if (range>850) {
		ang+=40;
		oldr=0;
		return;
	} 

	oldr=range;
}

fermo()
{
	/* routine di sparo da fermo */

	int range,range1,sfas,olda;

	olda=ang;
	if (! (range1=scan(ang, 10)) ) {
		if (! (range1=scan(ang-=20,10))) {
			ang+=40;
			while (!(range1=scan(ang,10))) ang += 20;
		}
	}
		
	/* se nessuno e' vicino, allora attacco */
	if (range1>700) {
		if (++pausa==40 && dam<85) {
			dir=(ang/30)*30;
			pausa=0;
			drive(dir,100);
			oldr=range1;
		}
		else {
			ang+=40;
			oldr=0;
		}
		return;
	}

	/* altrimenti sparo */
	if (!(scan(ang,2))) {
		if ((range=scan(ang + 8, 2))) ang += 8;
		else if ((range=scan(ang - 8, 2)))  ang -= 8;
		else if ((range=scan(ang + 4, 2))) ang += 4;
		else if ((range=scan(ang - 4, 2))) ang -= 4;
		else {
			oldr=range1;
			return;
		}
	}
	else {
		if (range=scan(ang+2,1)) ++ang;
		else if (range=scan(ang-2,1)) --ang;
		else if(!(range=scan(ang,1))) {
			oldr=range1;
			return;
		}
	}
	if(oldr) sfas=(ang-olda)%360;
	else sfas=0;
	cannon(ang+sfas, range + (range * 7 / 50 + 20) * (range - range1) / 21);
	oldr=range;
}

