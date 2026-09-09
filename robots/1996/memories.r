/*                              Memories.r 
                             Rel 7 - 9/9/1996

 Michelangelo Messina                           Angelo Ciufo
                                                Email: MC8579@mclink.it
*/


int   ang,dir,dam,t,limt;


main()
{
        ang = 0;
        t   = 0;
        dam = 4;
        limt=100;

        /* ciclo principale:
           il crobot si muove lungo i bordi, secondo un percorso non rettilineo
           e si ferma in ogni angolo, oscillando, fin quando non e' colpito
           o oltrepassa un certo numero di cicli, contenuti nella variabile limt*/

        while (1) {
                dir = angolo(0,999);
                while (loc_y() < 800) 
                      { drive (dir,100); mosso(); }
                stop();


                dir = angolo(500,800);
                while (loc_x() < 400) 
                      { drive (dir,100); mosso(); }
                dir = angolo(999,999);
                while (loc_x() < 800) 
                      { drive (dir,100); mosso(); }
                stop();


                dir = angolo(800,500);
                while (loc_y() > 600) 
                      { drive (dir,100); mosso(); }
                dir = angolo(999,0);
                while (loc_y() > 200) 
                      { drive (dir,100); mosso(); }
                stop();


                dir = angolo(500,200);
                while (loc_x() > 600) 
                      { drive (dir,100); mosso(); }
                dir = angolo(0,0);
                while (loc_x() > 200) 
                      { drive (dir,100); mosso(); }
                stop();


                dir = angolo(200,500);
                while (loc_y() < 400) 
                      { drive (dir,100); mosso(); }
        }

}


stop()        
/* routine di gestione del crobot oscillante */
{
	drive (dir,0);
	t=0;
        dam = damage()+4;
        if (dam>95) limt=2000; 
        while ( (damage() < dam) && (t < limt) ) {
                ++t;
                drive((dir+=180)%=360,100);
                spara();
                spara();
                drive(dir,0);
                spara();
                while (speed()>40);
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
		else if(scan(ang+7,4)) ang+=7;
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
		if (!(scan(ang+=20,10))) ang+=40;
		ang%=360;
                return;
	}
	if (oldr=scan(ang,10)){ 
                cannon (ang, oldr*183/(183+range-oldr) );
                if(oldr>710) ang+=40;
	}
}


mosso()
/* routine di fuoco in movimento, ricavata da Tox.r e modificata */
{
        int range, orange, oang;
        if(speed()<90) {
                /* uso l'altra routine di fuoco */
                spara();
                return;
        }
        if(scan(ang,5))
        {
                if(scan(ang-5,1)) ang-=5;
                if(scan(ang+5,1)) ang+=5;
                if(scan(ang-3,1)) ang-=3;
                if(scan(ang+3,1)) ang+=3;
                if(scan(ang-1,1)) ang-=1;
                if(scan(ang+1,1)) ang+=1;
                if (orange=scan(ang,5))
                {
                        oang=ang;
                        if(scan(ang-5,1)) ang-=5;
                        if(scan(ang+5,1)) ang+=5;
                        if(scan(ang-3,1)) ang-=3;
                        if(scan(ang+3,1)) ang+=3;
                        if(scan(ang-1,1)) ang-=1;
                        if(scan(ang+1,1)) ang+=1;
                        if (range=scan(ang,10))
                        {
                                cannon(
                                (ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14)),
                                (range*160/(160+orange-range-(cos(ang-dir)>>12))));
                                if (range>700) ang+=30;
                        }
      /* SE NON TROVATO SCANNA A SINISTRA E POI A DESTRA  */
                        else if(scan(ang-=10,6));
                        else if(scan(ang+=20,6));
                        else while (!(scan(ang+=15,10)));
                }
                else if(scan(ang-=10,6));
                else if(scan(ang+=20,6));
                else while (!(scan(ang+=15,10)));
        }
        else if(scan(ang-=10,6));
        else if(scan(ang+=20,6));
        else while (!(scan(ang+=15,10)));
}

int angolo(xx, yy)
int xx,yy;
/* restituisce la direzione per raggiungere un dato punto */
{
        int x,y,curx;

	curx = loc_x();
	x = curx - xx;
	y = (loc_y() - yy) * 100000;
	if (xx > curx)
                return ( 360 + atan(y / x));
	else
                return ( 180 + atan(y / x));
}


/* ... Memories of love ...
        Summer '95           */

