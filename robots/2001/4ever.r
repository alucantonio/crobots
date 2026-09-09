/************************
 *                      *
 *    4 E V E R .r      *
 *                      *
 ************************


 Michelangelo Messina


        'cause my heart goes BOOM


*/






int rng, deg;     /* Distanza e Gradi          */
int orng, odeg;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */

int danni;
int i,b;
int x,y;
int t;
int att;
int sc;
int up;

/*
All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
Durante il match oscilla nell'angolo con una routine leggermente modificata
rispetto a quella di dav46.r.
Se e' colpito cerca un eventuale angolo libero dove spostarsi.
L'attacco e' quello classico di boom.r con piccoli ritocchi.

That's all folks
*/

main()
{


    vai (x=80+840*(loc_x(spara())>500),y=80+840*(loc_y()>500));
    i=sc+120;
    while (i>sc) {
        if (scan (i-=20, 10)) if(++ne==2) i=sc-1;
    }
    if (ne<2) {
        att=1;
        while(t<1000&&(!rng||rng>735)) spara();
        boom(t=1);
    } else ne=3;

    
    while (danni=damage()+ne*8) {
                                            /*angle ();*/
            while (damage(i=ne*3)<danni) {
                                        /*oscilla (7);*/
                if(up) {
                        while (--i) {
                                spara(drive (dir+=180,100));
                                while (loc_y()>=y) spara(drive (dir,100)); 
                                spara(drive (dir-=180,100)); 
                                while (loc_y()<y) spara(drive (dir,100));
                        }
                } else {
                        while (--i) {
                                spara(drive (dir+=180,100));
                                while (loc_y()<=y) spara(drive (dir,100)); 
                                spara(drive (dir-=180,100)); 
                                while (loc_y()>y) spara(drive (dir,100));
                        }
                }
                if(!orng) {
                        drive (dir,0);
                        ne=0;
                        i=sc+120;
                        while (i>sc) {
                                if (scan (i-=20, 10)) ++ne;
                        }
                        if (ne<2) {
                                if (damage(att=t=1)<90) /*boom();*/ seek(att=101);
                        } else if(t>1420) { /*1400*/
                                if(ne<3 && damage()<60) seek(att=80);
                                else if(damage()<40) seek(att=45);
                                else t=0;
                        }
                } 
            }
            drive (dir,0);
                                        /*move ();*/
            if(up) {
                if (libero(260)) vai(x,y=80);
                else sxdx ();
            }
            else {
                if (libero(80)) vai(x,y=920);
                else sxdx ();
            }
    }        
}

sxdx () 
{ 
    if (x<500) {
        if (libero(350)) vai(x=920,y);
    }
    else { 
        if (libero(170)) vai(x=80,y);
    }
}

vai (x,y)
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>22500) fuoco(drive (dir,100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    spara(drive (dir,0));
    if (y<500) {
        up=0;
        if (x<500) {sc=355;return dir=225;}
        else {sc=85;return dir=315;}
    } else {
        up=1;
        if (x<500) {sc=265;return dir=135;}
        else {sc=175;return dir=45;}
    }

}

/* Angolo per andare in una certa direzione */
deg(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }


/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!(scan(gradi,10) ||scan(gradi+20,10)));
}


fuoco() {
    ++t;
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=20,10));
    else if (orng=scan(deg+=40,10));
    else return deg+=41; 
    { 
        if (orng>850) if(!att) {return deg+=41;}
        if (!scan(deg+=354,6)) deg+=12; 
        if(scan(deg-6,2)) deg-=6; 
        else if(scan(deg+6,2)) deg+=6; 
        if(scan(deg-4,1)) deg-=4; 
        if(scan(deg+4,1)) deg+=4; 
        if(scan(deg-2,1)) deg-=2; 
        if(scan(deg+2,1)) deg+=2; 
        if (orng=scan(odeg=deg,10)) 
        { 
           if(scan(deg-7,3)) deg-=7; 
           else if(scan(deg+7,3)) deg+=7; 
           if(scan(deg-4,2)) deg-=4; 
           if(scan(deg+4,2)) deg+=4; 
           if(scan(deg-2,1)) deg-=2; 
           if(scan(deg+2,1)) deg+=2; 
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
           } 
 
        } 
        else { 
                if (!(orng=scan(deg+=339,10))){  
                        if (!(orng=scan(deg+=41,10))) { 
                                if(!(orng=scan(deg+=21,10))) { 
                                        return deg+=41; 
                                } 
                        } 
                } 
                else if (!scan(deg+=354,6)) deg+=12;  
                return cannon (deg, 2*scan(deg,10)-orng);
        }
     } 
} 


spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((orng=scan(deg, 10)) ) { 

                if (scan(deg-8,4)) { 
                        if (scan(deg-=8+3,2)) { 
                                if(scan(deg+=3-2,1)) deg-=2; 
                        }  else if (scan(deg-3,2)) deg-=3;
                } else if(scan(deg+8,4)) { 
                        if (scan(deg+=8+3,2)) deg+=3;
                        else --deg;
                }  else if(scan(deg+2,2)) deg+=2; 
                else --deg;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-8,4)) { 
                        if (scan(deg-=8-3,2)) deg-=3;
                        else ++deg;
                } else if(scan(deg+7,4)) deg+=7; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+7,4)) deg+=7;
        }  else if (!(orng=scan(deg+=20,10))) { 
                if ((orng=scan(deg+=21,10))) { 
                        if (orng>900) { 
                                cannon(deg,700); 
                                if(!att) deg+=57; 
                                return orng=0;
                        } 
                } else { 
                        if (!(scan(deg+=21,10))) deg+=40; 
                        return; 
                } 
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*165/(165+orng-rng) ); 
                if(rng>720) if(!att) if(rng>orng || rng>900) {
                                deg+=41;
                                return orng=0;
                        }

        }  else if(scan(deg-20,10)) deg-=20; 
        else if(!scan(deg+=21,10)) deg+=41; 
} 

seek() {
        i=sc+120;
        while(!(orng=scan(i-=20, 10)));
        deg=i;
        while (i>sc) {
                if ((rng=scan(i-=20, 10)) ) {
                        if (rng<orng) {
                                orng=rng;
                                deg=i;
                        }
                }
        }
        drive(dir=deg,100);
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((i=loc_x())>910 ) dir=180;
                        else if (i<90 ) dir=360;
                        else if ((i=loc_y())>910 ) dir=270;
                        else if (i<90) dir=90;
                        else {
                                dir=deg+70+(b^=1)*215+180*(orng<210);/*65*/
                        }
                }
        }
        drive((dir+180),100);
        att=0;
        vai (x,y);
}


boom()
{
            while(1) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>910) dir=145+70*(y>500);
                        else if (x<90) dir=325+70*(y<500);
                        else if (y>910) dir=235+70*(x<500);
                        else if (y<90) dir=55+70*(x>500);
                        else {
                                dir=deg+65+(b^=1)*205+180*(orng<260);/*65*/
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>430) fuoco(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}
