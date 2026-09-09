/***********************
 *                     *
 *       STAY.r        *
 *                     *
 ***********************

 Rel 9B - 26/9/1998


 Michelangelo Messina                           Ing. Angelo Ciufo


                I had a dream last night ...


*/




int     ang, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli*/
        range, /*distanza*/
        pos; /*quadrante attuale*/


main()
{
    /* ciclo principale:
       il crobot si muove lungo i bordi, secondo un percorso non rettilineo
       e si ferma in ogni angolo, oscillando, fin quando non e' colpito
       o oltrepassa un certo numero di cicli (1600).
       Se Š colpito va nell'angolo adiacente libero.
       Se t>1600 e i danni sono minori dell'80% cerca i nemici girando
       in senso antiorario
    */
    ang=0;
    t=0;
    angolo((loc_x()>500)*999,(loc_y()>500)*999);    /*va nell' angolo piu' vicino*/
    stop();
    while (1) {
        if(!pos) {
                if(libero(260)) go(890,10,990,110);
                else if(libero(80)) go(10,890,110,990);
		stop();
        }

        if(pos==2) {
                if(libero(80)) go(990,890,890,990);
                else if(libero(170)) go(110,10,10,110);
		stop();
        }

        if(pos==3) {
                if(libero(350)) go(110,990,10,890);
                else if(libero(260)) go(990,110,890,10);
		stop();
        }

        if(pos==1) {
                if(libero(260)) go(10,110,110,10);
                else if(libero(350)) go(890,990,990,890);
		stop();
        }


        if (t>1450) while(damage()<81) {
                if(!pos) go(20,850,150,980);
                if(pos==1) go(850,980,980,850);
                if(pos==3) go(980,150,850,20);
                if(pos==2) go(150,20,20,150);
	}
    }

}


stop()        
/* routine di gestione del crobot oscillante */
/* Pentathlon Processor by Ing. Ciufo */
{
        if ((dam=damage()+10)>100) t=0; /*non attacca pi—*/
        while ( (damage() < dam) && (t < 1600) ) { 
                                /*fino quando non e' colpito o limite di tempo*/
                while ((!range || (range>720)) && t<1600) spara();
                                 /* se tutti sono lontani sta fermo
                                 altrimenti oscilla intorno all'angolo attuale*/
                drive(dir+=180,100);
                spara();
                spara();
                spara();
                drive(dir,0);
                spara();
        }
}

spara()
/* routine di sparo*/
/***********************
Works Better,
Plays Better
if you remove it
***********************/
{
        int     oldr;

        ++t;
	if ((range=scan(ang, 10)) ) {
		if (scan(ang-7,4)) {
                        if (scan(ang-=7+2,2)) {
                                if(scan(ang+=2-1,1)) --ang;
			}
                        else if (scan(ang-2,2)) ang-=2;
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
                if (scan(ang+7,4)) ang+=7;
	}
	else if (!(range=scan(ang+=20,10))) {
                if ((range=scan(ang+=20,10))) {
                        if (range>730) {
                                cannon(ang,700);
                                ang+=60;
                        }
                        else cannon(ang,7*range/8);
                }
                else {
                        if (!(scan(ang+=20,10))) ang+=40;
                        ang%=360;
                }
		return;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
                if(oldr>710) ang+=50;
	}
        else {
                if(scan(ang-20,10)) ang-=20;
                else ang+=30;
        }
}


go(x1,y1,x2,y2)
/* va in x2,y2 passando per x1,y1 */
int x1,x2,y1,y2;
{
        angolo(x1,y1);
        angolo(x2,y2);
        pos=((y2>500)+2*(x2>500));
}

angolo(xx, yy)
int xx,yy;
/* raggiunge un dato punto */
{
        int x,y,dist;

        dist=18001;
	x = loc_x() - xx;
	y = (loc_y() - yy) * 100000;
	if (x<0)
		dir= ( 360 + atan(y / x));
	else
		dir= ( 180 + atan(y / x));
        while (dist>18000) {
		drive(dir,100);
		spara();
		x=xx-loc_x();
		y=yy-loc_y();
		dist=x*x+y*y;
        }
	drive (dir,0);
        spara();
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(((scan(i,10))+(scan(i+20,10)))<130);
}
