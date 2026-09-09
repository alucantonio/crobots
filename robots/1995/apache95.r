/*  
 Apache95.r
 24/08/1995

 Michelangelo Messina                           Angelo Ciufo
						Internet: MC8579@mclink.it
*/

/***************
 *             *   
 *  S T A R T  *
 *             *
 ***************
 e non Š un bidone
 (e neanche a 32 bit) */


int ang,dir,oldr,pausa,dam;

main()
{
	fuggi();        /* va verso un bordo */
	while (1)       /* ciclo principale */
	{
		if ( damage()>dam ) fuggi();    /* se colpito, fugge */
		else            /* usa 2 routine di sparo diverse:
				   una in movimento, l'altra da fermo */
		{
			if (speed()) mosso();
			else fermo();
		}
	}
}

int quadrante()
/* restituisce 0,1,2 e 3 a seconda dell'angolo in cui si trova il robot
   oppure 5 se si trova al centro */

{

	int x,y;

	y=loc_y();
	x=loc_x();
	if (x<333){
		if (y<=500) return(0);
		return(3);
	}
	if (x>667) {
		if (y>500) return(2);
		return(1);
	}
	if (y<333) { 
		if (x<=500) return(0);
		return(1);
	}
	if (y>667) {
		if (x<=500) return(3);
		return(2);
	}
	return(5);
}
 
fuggi()
/* routine attivata se colpito dal nemico: cerca la direzione di fuga e spara */

{
	int a1,a2,range,sfas;

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
	dam=damage()+4;
	
	/* routine di sparo semplificata */
	if (!(range = scan (ang, 5))) {
		if (range = scan(ang -= 10, 5)) sfas = -6;
		else if (range = scan(ang -= 15, 10)) sfas = -10;
		else if (range = scan(ang += 35, 5)) sfas = 6;
		else if (range = scan(ang += 15, 10)) sfas = 10;
		else {
			while (!(oldr = scan(ang += 20, 10)));
			return;
		}
	}
	else sfas=0;

	if (range<710) {
		if (oldr) cannon(ang + sfas, range + (range - oldr) / 3);
		else cannon(ang, range);
	}
	else {
		ang+=40;
		oldr=0;
		return;
	} 

	oldr=range;
	mosso();
}

mosso()
/* routine di sparo in movimento */

{
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
	else if (range>oldr) {
		ang+=40;
		oldr=0;
		return;
	} 

	oldr=range;
}

fermo()
/* routine di sparo da fermo */

{
	int range,range1,sfas,olda;

	olda=ang;
	if (! (range1=scan(ang, 10)) ) {
		if (! (range1=scan(ang-=20,10))) {
			ang+=40;
			while (!(range1=scan(ang,10))) ang += 20;
		}
	}
		
	/* se nessuno e' vicino, e sono fermo da molto tempo, allora attacco */
	if (range1>700) {
		cannon(ang,range1);
		if (++pausa==40 && dam<92) {
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
		else if ((range=scan(ang + 4, 3))) ang += 4;
		else if ((range=scan(ang - 4, 3))) ang -= 4;
		else {
			oldr=range1;
			return;
		}
	}
	else {
		if (range=scan(ang+2,1)) ++ang;
		else if (range=scan(ang-2,1)) --ang;
		else if(!(range=scan(ang,10))) {
			oldr=0;
			return;
		}
	}
	if(oldr) sfas=(ang-olda)%360;
	else sfas=0;
	cannon(ang+sfas, range +(7 * range + 1000) * (range - range1) / 1050);
	oldr=range;
}
