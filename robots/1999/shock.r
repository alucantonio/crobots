/***********************
 *                     *
 *    S H O C K .r     *
 *                     *
 ***********************

 Rel 55b - 30/11/1999


 Michelangelo Messina                         


	Everything is free...


*/


int     ang, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        pt, /*contatore parziale*/
        orange, /*distanza*/
        dir, /*direzione*/
        att,
        pos; /*quadrante attuale*/
        int x,y;





main()
{
    /* 
       il crobot si muove lungo i bordi, e si ferma in ogni angolo, 
       oscillando lungo gli spigoli, fin quando non e' colpito
       o oltrepassa un certo numero di cicli (1660).
       Se e' colpito va nell'angolo adiacente libero (se c'e').
       Se rimane un solo nemico lo attacca puntandolo con un movimento oscillatorio.
       Se t>1660 e i danni sono minori del 40% attacca i nemici restanti, uno alla volta.
    */

    ang=370;
    t=0;
    att=0;
    while (1) {
	pos=2*(loc_x()>500)+(loc_y()>500); 
        dam=damage();
        while ( (damage() < dam+5) ) { /*fino quando non e' colpito o limite di tempo*/
		dam=damage();
                if (pos&1) {
			ymag(870,270,0);
			ymin(915,90,1);
                }
                else {
			
			ymin(130,90,0);
			ymag(85,270,1);
                }
                if (pos&2) {
			xmag(870,180,0);
			xmin(915,360,1);
                }
                else {
			xmin(130,360,0);
			xmag(85,180,1);
                }
		
		 /* se tutti sono lontani posso star fermo 
		 altrimenti oscillo intorno all'angolo attuale*/ 

                pt=0;
                while (!x || (x>750)) {
                        spara();
                        if(++pt>40) attacco();
                }
        }

	/* ricerca di un angolo libero */

        if(pos&1) {
        	if(libero(260)) ymag(90,270,1); 
   	} else {
		if(libero(80)) ymin(910,90,1);
	}
	if(x && x<751) {
		if(pos&2) {
			if(libero(170)) xmag(110,180,0);
		} else {
			if(libero(350)) xmin(890,360,0);
		}
	}
    }
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(((scan(i,10))+(scan(i+20,10)))<150);
}

spara() 
/* routine di sparo*/ 
{ 
        ++t; 
        if ((x=scan(ang, 10)) ) { 

		if (scan(ang-7,4)) { 
                        if (scan(ang-=7+3,2)) { 
                                if(scan(ang+=3-2,1)) ang-=2; 
			}  else if (scan(ang-3,2)) ang-=3; 
		} else if(scan(ang+7,4)) { 
                        if (scan(ang+=7+3,2)) ang+=3; 
		}  else if(scan(ang+2,2)) ang+=2; 
		else -- ang;

	}  else if ((x=scan(ang-=20,10))) { 
		if (scan(ang-7,4)) { 
                        if (scan(ang-=7-3,2)) ang-=3; 
		} else if(scan(ang+7,4)) ang+=7; 
	}  else if ((x=scan(ang+=40,10))) { 
                if (scan(ang+7,4)) ang+=7; 
	}  else if (!(x=scan(ang+=20,10))) { 
                if ((x=scan(ang+=20,10))) { 
                        if (x>730) { 
                                cannon(ang,700); 
                                if(!att) ang+=43; 
                                return; 
                        } 
                } else { 
                        if (!(scan(ang+=20,10))) ang+=39; 
                        return; 
                } 
	} 
        if (orange=scan(ang,10)){  
                cannon (ang, orange*165/(165+x-orange) ); 
                if(orange>710) if(!att) ang+=43; 
	}  else if(scan(ang-20,10)) ang-=20; 
        else if(!scan(ang+=20,10)) ang+=39; 
} 
  

attacco()
{
/* conta il nr dei nemici, 2 volte */

    pt=0;
    x=-10;
    y=0;
    while((x+=20)!=730) if (scan(x,10)) ++y;
    x=0;
    if (y<3) {
        if(damage()<30) att=101;
        else att=91;
    }
else if(y<5) {
	if (t>1540) {
		if(damage()<20) att=55;
		else att=50;
	}
	else return;
    } else return;
    t=0;     

/* attacco oscillante */

    while(damage()<att) {
        spara();
        {
                if ((x=loc_x())>900 ) {dir=180;
y=2;}
                else if (x<100 ) {dir=0;
y=6;}
                else if ((x=loc_y())>900 ) {dir=270;
y=2;}
                else if (x<100) {dir=90;
y=6;}
                else if (!((++y)%=8)) dir=ang+65;
                else if (y==4) dir=ang-65;
                drive(dir,100);
        }
    }
    att=(att>60);
    x=1;
    drive(dir+=180,100);
    pos=2*(loc_x()>500)+(loc_y()>500); 
}

/* spostamento */
xmag(x,d,a) { while(loc_x()>x) { drive(d,100);spara();} if(a)drive(d,0); } 
xmin(x,d,a) { while(loc_x()<x) { drive(d,100);spara();} if(a)drive(d,0); } 
ymag(y,d,a) { while(loc_y()>y) { drive(d,100);spara();} if(a)drive(d,0); } 
ymin(y,d,a) { while(loc_y()<y) { drive(d,100);spara();} if(a)drive(d,0); } 

