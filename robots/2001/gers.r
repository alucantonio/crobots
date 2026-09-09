/*
GERS.r

Derivato da:
1&1.r Rel 13a - 20/9/1997

 Angelo Ciufo
*/


int   ang,dir,dam,t,limt;


main()
{
        limt=500;

	/* ciclo principale:
	   il crobot si muove lungo i bordi, secondo un percorso non rettilineo
	   e si ferma in ogni angolo, oscillando, fin quando non e' colpito
	   o oltrepassa un certo numero di cicli, contenuti nella variabile limt*/

	while (1) {
                go(200,500,0,999);
                go(500,800,999,999);
                go(800,500,999,0);
                go(500,200,0,0);
	}

}


go(x1,y1,x2,y2)
/* va in x2,y2 passando per x1,y1 */
int x1,x2,y1,y2;
{
        angolo(x1,y1);
        stop(angolo(x2,y2));
}


angolo(xx, yy)
int xx,yy;
/* raggiunge un dato punto */
{
        int x,y;

        dir=180+((x=xx-(loc_x()))>0)*180+atan(((yy-loc_y())*100000)/x);
        while ((x=xx-loc_x())*x+(y=yy-loc_y())*y>17000) spara(drive(dir,100));
        /*spara(drive (dir,0));*/
}


stop()        
/* routine di gestione del crobot oscillante */
{
        spara(drive(dir,0));
        if ((dam=damage()+4)>95) limt=2000;
	while ( (damage() < dam) && (++t < limt) ) {
                spara(spara(drive((dir+=180),100)));
                spara(drive(dir,0));
                if(!speed()){
                        drive(dir+180,100);
                        spara(dam=damage()+4);
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
		return;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
                if(oldr>710) ang+=60;
	}
}

