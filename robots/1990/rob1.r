/* rob1.r  -  prima versione minimamente competitiva (forse) di C-robot */
/*
           -  di Roberto Cerruti - Brescia 22 Aprile 1991
*/

int d;
int degcl;
int rangcl;
int corner;
int cornflag;

main()
{
  int y;
  int alfa;
  int range;
  int deg;
  int f1;
  int cnt;
  int corner;
  int tp1,tp2;
  int oldeg, oldrang;

  drive(y,0);

  /* initialize starting parameters */
  d = damage();
  corner = 0;

  goto (980,980); /* hide in corner 1 */

  degcl = 0;
  while(1) {
  	f1 = 1;
	while (f1) {
		dam();
		if (cornflag)				/* if is in a corner */
			alfa = 90 + cornflag * 90;
		else						/* if not in a corner */
			alfa = degcl - 30;
		if (search(alfa))
			if (aim(degcl,12)) 
				f1 = 0;
		if (d < 70 && ++cnt > 75) {	/* if waiting for too long*/
			cnt = 0;				/* change corner */
			--d;
		}

	}
	oldeg = degcl;
	oldrang = rangcl;
	f1 = 1;
	while (f1) {
		tp1 = degcl+degcl-oldeg;
		if ((tp2 = rangcl+rangcl-oldrang) < 40)
			tp2 = 40;
		cannon (tp1,tp2);
		if (d < 60) {
			cornflag = 0;
			if (tp2 > 350)
				drive(tp1,50);
			else if (tp2 < 250)
				drive(tp1+180,50);
			else
				drive(tp1,0);
		}
		dam();
		oldeg = degcl;
		oldrang = rangcl;
		if (aim(degcl,5) == 0) {
			f1 = 0;
			drive(degcl,0);
		}
	}
  }
}

dam()
{
	if (d != damage()) {
		cornflag = --corner;		/* versioni pari ++, dispari -- */
		if (corner == 1) {
			flee (850,850);
			goto (980,980);
		} else if (corner == 2) {
			flee (150,850);
			goto (20,980);
		} else if (corner == 3) {
			flee (150,150);
			goto (20,20);
		} else {
			flee (850,150);
			goto (980,20);
			corner = 4;				/* versioni pari 0, dispari 1 */
		}
		d = damage();
	/*	drive(tp1+90,100);*/
	}
}

goto(x,y)
int x,y;
{
	reachx(x);
	reachy(y);
	drive (0,0);
}
reachy(y)
int y;
{
	int f;
	int dist;
	int dir;

	f = 0;
	if (loc_y() > y) 
		dir = 270;
	else 
		dir = 90;
	while ((dist = abs(loc_y()-y)) > 10) {
		drive(dir,dist+f);
	}
}

reachx(x)
int x;
{
	int f;
	int dist;
	int dir;

	f = 0;
	if (loc_x() > x) 
		dir = 180;
	else 
		dir = 0;
	while ((dist = abs(loc_x()-x)) > 10) {
		drive(dir,dist+f);
	}
}

flee(x,y)
int x,y;
{
	int dist;
	int dir;
	int dx,dy;
	int tp1;

	dist = 200;
	while (dist > 50) {
		dx = loc_x() - x;
		dy = loc_y() - y;
		dist = maxabs(dx,dy);
		if (dx > 0)
			if (dy > 0)
				dir = 225;
			else
				dir = 135;
		else
			if (dy > 0)
				dir = 315;
			else
				dir = 45;
		drive(dir,dist);
		if (dist > 200)
			aim(dir,5);
	}
}

maxabs(a,b)
int a,b;
{
	if (a < 0) a = -a;
	if (b < 0) b = -b;
	if (a > b) return(a);
	else return(b);
}

abs(n)
int n;
{
	if (n < 0)
		n = -n;
	return (n);
}


search(alfa)
int alfa;
{
	int endalfa;
	int dis;
	int found;

	if (cornflag)
		endalfa = alfa + 90;
	else
		endalfa = alfa + 360;
	alfa -= 15;
	found = 0;
	while (alfa < endalfa && found == 0) {
		if (dis = (scan ((alfa += 18),10))) {
			if (dis <= 700) {
				degcl = alfa;
				rangcl = dis;
				found = 1;
			}
		}
	}
	return (found);
}

aim(alfa,span)
int alfa;
int span;
{
	int dis;
	int alfend;
	int found;

	alfend = alfa + span - 1;
	alfa -= span + 1;
	found = 0;
	while (found == 0 && alfa <= alfend) {
		if (dis = (scan ((alfa += 2),1))) {
			if (dis <= 700) {
				cannon(alfa,dis);
				degcl = alfa;
				rangcl = dis;
				found = 1;
			}
		}
	}
	return (found);
}
