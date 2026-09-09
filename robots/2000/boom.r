/**********************
 *                    *
 *     B O O M .r     *
 *                    *
 **********************


 Michelangelo Messina                         


        'cause my heart goes BOOM


*/


int     ang,oang, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        pt, /*contatore parziale*/
        orange, /*distanza*/
        dir, /*direzione*/
        att,
        pos; /*quadrante attuale*/
        int x,y;
        int i,d,b;





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
    vai(1000*(loc_x()>500),1000*(loc_y()>500));
    pt=48;
    while (1) {
        dam=damage(pos=2*(loc_x()>500)+(loc_y()>500));
        while ( (damage() < dam+5) ) { /*fino quando non e' colpito o limite di tempo*/
		dam=damage();
                if (pos&1) {
                        yfmag(840);
                        ymin(905);
                }
                else {
			
                        yfmin(160);
                        ymag(95);
                }
                if (pos&2) {
                        xfmag(840);
                        xmin(905);
                }
                else {
                        xfmin(160);
                        xmag(95);
                }
		
		 /* se tutti sono lontani posso star fermo 
		 altrimenti oscillo intorno all'angolo attuale*/ 

                while (!x || (x>750)) {
                        if(++pt>50) attacco();
                        spara();
                }
        }

        if(pos&1) {
                if(libero(260)) yfmag(110);
                else fuggi();
   	} else {
                if(libero(80)) yfmin(890);
                else fuggi();
	}
        pt=43;
    }
}

fuggi()
{
        if(pos&2) {
                if(libero(170)) xfmag(110);
                else angle();
        } else {
                if(libero(350)) xfmin(890);
                else angle();
        }
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}

spara() 
/* routine di sparo*/ 
{ 
        ++t; 
        if ((x=scan(ang, 10)) ) { 

                if (scan(ang-8,4)) { 
                        if (scan(ang-=8+3,2)) { 
                                if(scan(ang+=3-2,1)) ang-=2;
			}  else if (scan(ang-3,2)) ang-=3;
                } else if(scan(ang+8,4)) { 
                        if (scan(ang+=8+3,2)) ang+=3;
                        else --ang;
                }  else if(scan(ang+3,2)) ang+=3; 
                else --ang;

	}  else if ((x=scan(ang-=20,10))) { 
                if (scan(ang-8,4)) { 
                        if (scan(ang-=8-3,2)) ang-=3;
                        else ++ang;
                } else if(scan(ang+7,4)) ang+=7; 
	}  else if ((x=scan(ang+=40,10))) { 
                if (scan(ang+7,4)) ang+=7;
	}  else if (!(x=scan(ang+=20,10))) { 
                if ((x=scan(ang+=21,10))) { 
                        if (x>800) { 
                                cannon(ang,700); 
                                if(!att) ang+=57; 
                                return; 
                        } 
                } else { 
                        if (!(scan(ang+=21,10))) ang+=40; 
                        return; 
                } 
	} 
        if (orange=scan(ang,10)){  
                cannon (ang, orange*165/(165+x-orange) ); 
                if(orange>720) if(!att) if(orange>x || orange>800) {
                                ang+=57;
                                x=0;
                        }

	}  else if(scan(ang-20,10)) ang-=20; 
        else if(!scan(ang+=21,10)) ang+=57; 
} 


/* spostamento */
xmag(x) { while(loc_x()>x) spara(drive(180,100)); stop(180); } 
xmin(x) { while(loc_x()<x) spara(drive(360,100)); stop(360); } 
ymag(y) { while(loc_y()>y) spara(drive(270,100)); stop(270); } 
ymin(y) { while(loc_y()<y) spara(drive(90,100)); stop(90); } 

xfmag(x) { spara(drive(dir=180,100));while(loc_x()>x) Fire(drive(180,100)); stop(180); }
xfmin(x) { spara(drive(dir=360,100));while(loc_x()<x) Fire(drive(360,100)); stop(360); } 
yfmag(y) { spara(drive(dir=270,100));while(loc_y()>y) Fire(drive(270,100)); stop(270); } 
yfmin(y) { spara(drive(dir=90,100));while(loc_y()<y) Fire(drive(90,100)); stop(90); } 

vai (x,y)
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>22000) Fire(drive (dir,100));
}

/* Angolo per andare in una certa direzione */
deg(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }



stop(dir) { drive(dir,0);spara();}

attacco()
{
/* conta il nr dei nemici */

    b=330;
    pt=i=0;
    while((b+=20)!=710) if (scan(b,10)) ++i;
    if (i<2) {
            b=330;
            i=0;
            while((b+=20)!=710) if (scan(b,10)) ++i;
            if (i<2) {
                att=91;
                t=1;
                if(damage()<91) boom();
                else angle();
            } else return 0;
    } else if (t>1460) {
        if (i<3) att=80;
        else att=50;
    } else return 0;
    if(damage()<att) {
        if(att<90) seek();
        x=1;
    } else t=0;
    att=(att>90);
    return 1;
}

seek() {
        i=320;
        while(!(b=scan(i+=20, 10)));
        ang=i;
        while (i<700) {
                if ((d=scan(i+=20, 10)) ) {
                        if (d<b) {
                                b=d;
                                ang=i;
                        }
                }
        }
        drive(dir=ang,100);
        b=0;
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((y=loc_x())>940 ) dir=180;
                        else if (y<60 ) dir=360;
                        else if ((y=loc_y())>940 ) dir=270;
                        else if (y<60) dir=90;
                        else dir=ang+80+(b^=1)*215;/*65*/
                }
        }
        drive((dir+180),100);
        pos=2*(loc_x()>500)+(loc_y()>500);
}
boom()
{
            b=0;
            while(1) {
                if(t%2) {
                        if ((y=loc_x())>910 ) dir=180;
                        else if (y<90 ) dir=360;
                        else if ((y=loc_y())>910 ) dir=270;
                        else if (y<90) dir=90;
                        else dir=ang+65+(b^=1)*205;/*65*/
                        spara(drive(dir,100));
                } else {
                        if(x>480) Fire(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}

angle()
{
    if (loc_y()<500) {
        y=85;
        if (loc_x()<500) dir=45;
        else dir=135;
    }
    else {
        y=915;
        if (loc_x()<500) dir=135;
        else dir=45;
    }
    pt=x=0;
    while(x<800) {
        drive(dir,100);
        spara();
        while (loc_y()<=y) spara(drive (dir,100));
        spara(drive (dir+=180,100));
        while (loc_y()>y) spara(drive (dir,100));
        if(++pt>7) if(!x) {
                        drive(dir,0);
                        if(attacco()) return;
        }
        dir-=180;
    }
    drive(dir,0);
    spara();
}
Fire() 
{
    ++t;
    if (x=scan(ang,10)) 
    { 
        if (!scan(ang+=354,6)) ang+=12; 
        if (!att) if (x>800)
        { 
            if (!scan(ang+=357,3)) ang+=6; 
            cannon(ang,700); 
            ang+=55; 
            return; 
        }
 
        find();
        if (x=scan(oang=ang,8)) 
        { 
           find();
           if (orange=scan(ang,10)) 
           { 
                cannon(ang+((ang-oang)*((700+orange))>>9)-(sin(ang-dir)>>14), 
                       orange*179/(179+x-orange-(cos(ang-dir)>>12))); 
           } 
 
        } 
        else search(); 
     } 
     else search(); 
} 
 
search() 
{ 
        if (!(x=scan(ang+=339,10))){  
                if (!(x=scan(ang+=41,10))) { 
                        if(!(x=scan(ang+=21,10))) { 
                                ang+=41; 
                                return; 
                        } 
		} 
        } 
        else if (!scan(ang+=354,6)) ang+=12;  
        cannon(ang,x); 
} 

find()
{
            if(scan(ang-6,2)) ang-=6; 
            if(scan(ang+6,2)) ang+=6; 
            if(scan(ang-4,1)) ang-=4; 
            if(scan(ang+4,1)) ang+=4; 
            if(scan(ang-2,1)) ang-=2; 
            if(scan(ang+2,1)) ang+=2; 
}

