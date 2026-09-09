/*  
 Passion.r
 19/09/1995

 Michelangelo Messina                           Angelo Ciufo
						Internet: MC8579@mclink.it
*/

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
/* restituisce un valore a seconda della posizione in cui si trova il robot
   secondo lo schema:
	3 8 2
	5 4 7
	0 6 1 */

{

	int x,y;

	y=loc_y();
	x=loc_x();
	if (x<333){
		if (y<333) return(0);
		else if (y>667) return(3);
		return(5);
	}
	if (x>667) {
		if (y>667) return(2);
		else if (y<333) return(1);
		return(7);
	}
	if (y<333) return(6);
	else if (y>667) return(8);
	return(4);
}
 
fuggi()
/* routine attivata se colpito dal nemico: cerca la direzione di fuga */

{
	int a1,a2,b,c,d,i;

	drive(dir,0);
	a1=quadrante();
	if (a1<4) {
		a1*=90;
		a2=a1+90;
		if (!(d=scan(a1+65,10)) && !(scan(a2-5,10))) dir=a2;
		else if (!(scan(a1+5,10)) && !(b=scan(a1+25,10))) dir=a1;
		else if (!(c=scan(a1+45,10)) && !b ) dir=a1+22;
		else if(!c && !d) dir=a1+68;
		else dir=a1+45;
	}
	else if (a1==4) {
		i=0;
		while(i<4) {
			if(!scan(dir+=20,10)) ++i; 
			else i=0;
		}
		dir=(dir-40)%360;
	}
	else {
		if (a1==5||a1==7) a1=90;
		else a1=0;
		if (!scan(a1,10) && !scan(a1+20,10) && !scan(a1-20,10)) dir=a1;
		else dir=a1+180;
	}

	drive (dir,100);
	pausa=0;
	dam=damage()+3;
	spara();        
	spara();
	spara();
}

mosso()
/* routine attivata se il robot e' in movimento:
   controlla se si trova nelle vicinanze del bordo e poi
   chiama la routine di fuoco in movimento */

{
	int     x,y,cx,sx;
	
	if ((x=loc_x())>850 && (cx=cos(dir))>0) drive(dir,0);
	else if (x<150 && cx<0) drive(dir,0);
	else if ((y=loc_y())>850 && (sx=sin(dir))>0) drive(dir,0);
	else if (y<150 && sx<0) drive(dir,0);
	spara();
}

spara()
/* routine di sparo in movimento */
{
	int     range,sfas;

	if (!oldr) 
	/* se non si aveva il nemico sotto mira, usa una routine semplificata */ 
	{
		while (!(range = scan(ang += 20, 10)) );
		if (scan(ang-7,4)) ang-=7;
		else if(scan(ang+7,4)) ang+=7;
		if (oldr=scan(ang,10)) cannon(ang, oldr*oldr/range);
		return;
	}

	/* altimenti usa la routine "normale" */
	if (!(range = scan (ang, 3))) {
		if (range = scan(ang -=6, 3)) sfas = -4;
		else if (range = scan(ang +=12, 3)) sfas = 4;
		else if (range = scan(ang -=19, 4)) sfas = -7;
		else if (range = scan(ang +=26, 4)) sfas = 7;
		else if (range = scan(ang -=38, 8)) sfas = -10;
		else if (range = scan(ang +=50, 8)) sfas = 10;
		else {
			oldr=0;
			return;
		}
	}
	else sfas=0;

	if (range<710) cannon(ang + sfas, range + (range - oldr) / 3);
	else if (range>oldr) {
		ang+=10;
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
		if (++pausa==40 && dam<90) {
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
		else if(!(range=scan(ang,10))) {
			oldr=0;
			return;
		}
	}
	if(oldr) sfas=(ang-olda)%360;
	else sfas=0;
	cannon(ang+sfas, range + (range * 7 / 50 + 20) * (range - range1) / 21);
	oldr=range;
}
