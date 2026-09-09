/***********************
 *                     *
 *       FABLE.r       *
 *                     *
 ***********************

 Rel 2 - 20/9/1997


 Michelangelo Messina                           Angelo Ciufo


                Tell me a FABLE ...


*/


int     ang, /*angolo di sparo*/
        dir, /*direzione*/
        dam, /*percentuale di danni attuale*/
        t, /*conta cicli*/
        limt, /*limite per l'attacco*/
        pos; /*quadrante attuale:
                0 - basso sinistra
                1 - alto sinistra
                2 - alto destra
                3 - basso destra
        */


main()
{
    ang = 0;
    t   = 0;
    limt=500;
    pos=0;

    /* ciclo principale:
       il crobot si muove lungo i bordi, secondo un percorso non rettilineo
       e si ferma in ogni angolo, oscillando, fin quando non e' colpito
       o oltrepassa un certo numero di cicli, contenuti nella variabile limt.
       Se Š colpito va nell'angolo adiacente libero.
       Se t>limt e i danni sono minori dell'80% cerca i nemici girando
       in senso orario
    */

    angolo(500,500);    /*va al centro e poi in basso a sinistra*/
    angolo(0,0);
    while (1) {
        if(!pos) {
                if(dam<80 && t>limt) {
                        angolo(200,500);
                        angolo(0,999);
                        pos=1;
                }
                else if(!scan(80,10) && !scan(100,10)) {
                        angolo(200,500);
                        angolo(0,999);
                        pos=1;
                }
                else if(!scan(260,10) && !scan(280,10)) {
                        angolo(500,200);
                        angolo(999,0);
                        pos=3;
                }
		stop();
        }

        if(pos==1) {
                if(dam<80 && t>limt) {
                        angolo(500,800);
                        angolo(999,999);
                        pos=2;
                }
                else if(!scan(350,10) && !scan(10,10)) {
                        angolo(500,800);
                        angolo(999,999);
                        pos=2;
                }
                else if(!scan(260,10) && !scan(280,10)) {
                        angolo(200,500);
                        angolo(0,0);
                        pos=0;
                }
		stop();
        }

        if(pos==2) {
                if(dam<80 && t>limt) {
                        angolo(800,500);
                        angolo(999,0);
                        pos=3;
                }
                else if(!scan(260,10) && !scan(280,10)) {
                        angolo(800,500);
                        angolo(999,0);
                        pos=3;
                }
                else if(!scan(350,10) && !scan(10,10)) {
                        angolo(500,800);
                        angolo(0,999);
                        pos=1;
                }
		stop();
        }

        else if(pos==3) {
                if(dam<80 && t>limt) {
                        angolo(500,200);
                        angolo(0,0);
                        pos=0;
                }
                else if(!scan(170,10) && !scan(190,10)) {
                        angolo(500,200);
                        angolo(0,0);
                        pos=0;
                }
                else if(!scan(80,10) && !scan(100,10)) {
                        angolo(800,500);
                        angolo(999,999);
                        pos=2;
                }
		stop();
        }

    }

}


stop()        
/* routine di gestione del crobot oscillante */
{
	drive (dir,0);
	spara();
        if ((dam=damage()+4)>95) limt=2000; /*non attacca pi—*/
        while ( (damage() < dam) && (++t < limt) ) { /*oscilla fino a che non Š colpito*/
		drive((dir+=180)%=360,100);
		spara();
		spara();
		drive(dir,0);
		spara();
                if(!speed()){ /*controlla se c'Š collisione col bordo*/
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
        spara();

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
        while (dist(xx,yy) > 18000) mosso();

}

dist(xx1, yy1)
int xx1,yy1;
/* restituisce la distanza (al quadrato) del robot dal punto xx1,yy1 */
{
        int x,y;

	x = xx1 - loc_x();
	y = yy1 - loc_y();
        return((x * x) + (y * y));
}



/*
        ... a FABLE that will never end

        and now, I DREAM!
*/
