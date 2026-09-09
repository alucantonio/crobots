/*                                1&1.r 
                             Rel 13a - 20/9/1997

 Michelangelo Messina                           Angelo Ciufo
*/


int   ang,dir,dam,t,limt;


main()
{
	ang = 0;
	t   = 0;
        limt=500;

	/* ciclo principale:
	   il crobot si muove lungo i bordi, secondo un percorso non rettilineo
	   e si ferma in ogni angolo, oscillando, fin quando non e' colpito
	   o oltrepassa un certo numero di cicli, contenuti nella variabile limt*/

	while (1) {
		angolo(200,500);
		while (loc_y() < 400) mosso();
		angolo(0,999);
                while (loc_y() < 800) mosso();
		stop();


		angolo(500,800);
		while (loc_x() < 400) mosso(); 
		angolo(999,999);
                while (loc_x() < 800) mosso();
		stop();


		angolo(800,500);
		while (loc_y() > 600) mosso();
		angolo(999,0);
                while (loc_y() > 200) mosso();
		stop();


		angolo(500,200);
		while (loc_x() > 600) mosso();
		angolo(0,0);
                while (loc_x() > 200) mosso();
		stop();


	}

}


stop()        
/* routine di gestione del crobot oscillante */
{
	drive (dir,0);
	spara();
        if ((dam=damage()+4)>95) limt=2000;
	while ( (damage() < dam) && (++t < limt) ) {
		drive((dir+=180)%=360,100);
		spara();
		spara();
		drive(dir,0);
		spara();
                if(!speed()){
                        drive(dir+180,100);
                        dam=damage()+4;
                        spara();
                }
	}
}

spara()
/* routine di sparo oscillando */
{
	int     range,oldr;

	if ((range=scan(ang, 10)) ) {
		if (scan(ang-7,4)) {
			if (scan(ang-=7-2,2)) {
				if(scan(ang-=2-1,1)) ang-=1;
			}
			else if (scan(ang+2,2)) ang+=2;
		}
		else if(scan(ang+7,4)) {
			if (scan(ang+=7+2,2)) ang+=2;
		}
		else if(scan(ang+2,2)) ang+=2;
	}
	else if ((range=scan(ang-=20,10))) {
		if (scan(ang-7,4)) {
			if (scan(ang-=7-2,2)) ang-=2;
		}
		else if(scan(ang+7,4)) ang+=7;
	}
	else if ((range=scan(ang+=40,10))) {
		if (scan(ang-7,4)) ang-=7;
	}
	else if (!(range=scan(ang+=20,10))) {
                if (!(range=scan(ang+=20,10))) {
                        ang+=20;
                        if (!(scan(ang,10))) ang+=40;
                }
                else {
                        cannon(ang,7*range/8);
                        if (range>710) ang+=60;
                }
		ang%=360;
		return;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
                if(oldr>710) ang+=60;
	}
}


mosso()
/* routine di sparo in movimento */
{
        int     range,oldr,sfas;

	drive(dir,100);

        if (!(oldr = scan (ang, 3))) {
                if (oldr = scan(ang -=6, 3)) sfas = -4;
                else if (oldr = scan(ang +=12, 3)) sfas = 4;
                else if (oldr = scan(ang -=19, 4)) sfas = -7;
                else if (oldr = scan(ang +=26, 4)) sfas = 7;
                else if (oldr = scan(ang -=40, 10)) sfas = -10;
                else if (oldr = scan(ang +=54, 10)) sfas = 10;
		else {
                        while(!scan(ang+=20,10));
			return;
		}
	}
        else sfas=0;

        if (range=scan(ang,10)){
                cannon (ang + sfas, range*183/(183+oldr-range) );
                if (range>705) ang+=35;
        }
}

angolo(xx, yy)
int xx,yy;
/* restituisce la direzione per raggiungere un dato punto */
{
	int x,y;

	drive(dir,0);
	x = loc_x() - xx;
	y = (loc_y() - yy) * 100000;
	if (x<0)
		dir= ( 360 + atan(y / x));
	else
		dir= ( 180 + atan(y / x));
	drive(dir,100);
	spara();
	mosso();
}
