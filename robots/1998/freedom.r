/***********************
 *                     *
 *      FREEDOM.r      *
 *                     *
 ***********************

 Rel 10 - 26/9/1998


 Michelangelo Messina                           Angelo Ciufo


	Everything is free...


*/


int     ang, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        range, /*distanza*/
        pos; /*quadrante attuale*/




main()
{
    /* ciclo principale:
       il crobot si muove lungo i bordi, secondo un percorso non rettilineo
       e si ferma in ogni angolo, oscillando, fin quando non e' colpito
       o oltrepassa un certo numero di cicli (1450).
       Se e' colpito va nell'angolo adiacente libero.
       Se t>1450 e i danni sono minori dell'80% cerca i nemici girando
       in senso orario
    */

    ang=0;
    t=0;
    pos=2*(loc_x()>500)+(loc_y()>500);
    range=1;
    stop();
    while (1) {
        if(!pos) {
                if(libero(80)) go(200,500,0,999);
                else if(libero(260)) go(500,200,999,0);
		stop();
        }

        if(pos==1) {
                if(libero(350)) go(500,800,999,999);
                else if(libero(260)) go(200,500,0,0);
		stop();
        }

        if(pos==3) {
                if(libero(260)) go(800,500,999,0);
                else if(libero(350)) go(500,800,0,999);
		stop();
        }

        if(pos==2) {
                if(libero(170)) go(500,200,0,0);
                else if(libero(80)) go(800,500,999,999);
		stop();
        }
        if (t>1450) while(damage()<81) {
                if(!pos) go(200,500,0,999);
                if(pos==1) go(500,800,999,999);
                if(pos==3) go(800,500,999,0);
                if(pos==2) go(500,200,0,0);
	}
    }

}


stop()        
/* routine di gestione del crobot oscillante */
{
        if ((dam=damage()+20)>100) t=0; /*non attacca piu'*/
        while ( (damage() < dam) && (t < 1450) ) { /*fino quando non e' colpito o limite di tempo*/
                while ((!range || (range>730)) && t<1450) spara();
				 /* se tutti sono lontani posso star fermo
				 altrimenti oscillo intorno all'angolo attuale*/
                if (pos&1) {
                        while(loc_y()>820) {
                                drive(270,100);
                                spara();
                        }
                        while(loc_y()<915) {
                                drive(90,100);
                                spara();
                        }
                }
                else {
                        while(loc_y()<180) {
                                drive(90,100);
                                spara();
                        }
                        while(loc_y()>85) {
                                drive(270,100);
                                spara();
                        }
                }
                drive(0,0);
                if (pos&2) {
                        while(loc_x()>820) {
                                drive(180,100);
                                spara();
                        }
                        while(loc_x()<915) {
                                drive(0,100);
                                spara();
                        }
                }
                else {
                        while(loc_x()<180) {
                                drive(0,100);
                                spara();
                        }
                        while(loc_x()>85) {
                                drive(180,100);
                                spara();
                        }
                }
                drive(90,0);
                spara();
        }
}


spara()
/* routine di sparo*/
{
        int     oldr;

        ++t;
	if ((range=scan(ang, 10)) ) {
		if (scan(ang-7,4)) {
                        if (scan(ang-=7+3,2)) {
                                if(scan(ang+=3-2,1)) --ang;
			}
                        else if (scan(ang-3,2)) ang-=3;
		}
		else if(scan(ang+7,4)) {
                        if (scan(ang+=7+3,2)) ang+=3;
		}
                else if(scan(ang+2,1)) ang+=2;
	}
	else if ((range=scan(ang-=20,10))) {
		if (scan(ang-7,4)) {
                        if (scan(ang-=7-3,2)) ang-=3;
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
                else if (!(scan(ang+=20,10))) (ang+=40)%=360;
		return;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
                if(oldr>710) ang+=50;
	}
        else if(scan(ang-20,10)) ang-=20;
        else if(scan(ang+20,10)) ang+=20;
        else ang+=60;
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
        int x,y,dist,dir;

        dist=99001;
        x=loc_x()-xx;
	y = (loc_y() - yy) * 100000;
        if (x<0)
		dir= ( 360 + atan(y / x));
	else
		dir= ( 180 + atan(y / x));
        while (dist>17000) {
		drive(dir,100);
		spara();
                dist=(x=xx-loc_x())*x+(y=yy-loc_y())*y;
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


/*
	Everyone is free

*/
