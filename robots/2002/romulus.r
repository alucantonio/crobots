/* 
ROMULUS.r

Scritto da:
Angelo Ciufo


Il robot e' una netta espansione di harris.r del 2001.
La tattica del robot e' molto simile a quella del fratellino
Remus.r
Si reca nell'angolo piu' vicino, e oscilla percorrendo un movimento
triangolare ('rubato' a tornado.r del 98)
Se e' colpito cerca un angolo libero.
Dopo 1140 chiamate alle funzioni di sparo attacca i superstiti
se e' in buone condizioni
*/



int rng, deg;     /* Distanza e Gradi          */
int orng, odeg;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */
int normal;

int danni;
int i,b,d;
int x,y;
int t;
int att;

main()
{
    ne=3;
    if (loc_x ()<500) x=100; else x=900;
    if (loc_y ()<500) y=85; else y=915;
    vai (x,y);
    
    while (danni=damage()+25) {
                                            /*angle ();*/
            while (damage(i=9)<danni) {
                                        /*oscilla (9);*/
                while (--i) {
                if (loc_x()<500) if (loc_y()<500)
                         { xsmin(160,0); xsmag(80,135); ysmag(80,270); }
                         else
                         { ysmag(840,270); ysmin(920,45); xsmag(80,180); }
                else if (loc_y()<500)
                         { ysmin(160,90); ysmag(80,225); xsmin(920,0); }
                         else
                         { xsmag(840,180); xsmin(920,315);ysmin(920,90); }
                }
                if(!orng||orng>850) {
                        i=-10; ne=0;
                        while (i<360) {
                                if (scan (i+=20, 10)) ++ne;
                        }
                        if (ne<2) boom ();
                        else if(t>1140) { 
                                if(ne<3 && damage()<60) seek(att=70);
                                else if(damage()<40) seek(att=45);
                                else t=0;

                        }
                } 
            }
                                        /*move ();*/
            if (loc_y()<500) {
                if (libero(90)) vai(x,y=915);
                else sxdx ();
            } else {
                if (libero(270)) vai(x,y=85);
                else sxdx ();
            }
    }        
}

sxdx () 
{ 
    if (loc_x()<500) {
        if (libero(0)) vai(x=900,y);
    }
    else { 
        if (libero(180)) vai(x=100,y);
    }
}

xsmag(x,d) { while(loc_x()>x) spara(drive(d,100)); drive(d,0); }
xsmin(x,d) { while(loc_x()<x) spara(drive(d,100)); drive(d,0); }
ysmag(y,d) { while(loc_y()>y) spara(drive(d,100)); drive(d,0); }
ysmin(y,d) { while(loc_y()<y) spara(drive(d,100)); drive(d,0); }

vai (x,y)
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>22500) fuoco(drive (dir,100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    spara(drive (dir,0));
}

/* Angolo per andare in una certa direzione */
deg(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }


/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!(scan(gradi+350,10) ||scan(gradi+10,10)));
}


fuoco() {
    ++t;
    if (orng=scan(deg,10)) 
    { 
        if (orng>850) if(ne>1) {deg+=40; return;}
        if (!scan(deg+=354,6)) deg+=12; 
        find();
        if (orng=scan(odeg=deg,10)) 
        { 
           find();
           if (rng=scan(deg,10)) 
           { 
                cannon(deg+((deg-odeg)*((700+rng))>>9)-(sin(deg-dir)>>14), 
                       rng*179/(179+orng-rng-(cos(deg-dir)>>12))); 
           } 
 
        } 
        else search(); 
     } 
     else search(); 
} 

find()
{
            if(scan(deg-7,3)) deg-=7; 
            if(scan(deg+7,3)) deg+=7; 
            if(scan(deg-4,2)) deg-=4; 
            if(scan(deg+4,2)) deg+=4; 
            if(scan(deg-2,1)) deg-=2; 
            if(scan(deg+2,1)) deg+=2; 
}

 
search() 
{ 
        if (!(orng=scan(deg+=339,10))){  
                if (!(orng=scan(deg+=41,10))) { 
                        if(!(orng=scan(deg+=21,10))) { 
                                deg+=41; 
                                return; 
                        } 
		} 
        } 
        else if (!scan(deg+=354,6)) deg+=12;  
        cannon(deg,orng); 
} 

spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((orng=scan(deg, 10)) ) { 
                if (orng<150) return cannon(deg,2*scan(deg,10)-orng);
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
                if (orng<150) return cannon(deg,2*scan(deg,10)-orng);
                if (scan(deg-8,4)) { 
                        if (scan(deg-=8-3,2)) deg-=3;
                        else ++deg;
                } else if(scan(deg+7,4)) deg+=7; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (orng<150) return cannon(deg,2*scan(deg,10)-orng);
                if (scan(deg+7,4)) deg+=7;
        }  else if (!(orng=scan(deg+=20,10))) { 
                if ((orng=scan(deg+=21,10))) { 
                        if (orng>850) { 
                                cannon(deg,700); 
                                if(!att) deg+=57; 
                                return; 
                        } 
                } else { 
                        if (!(scan(deg+=21,10))) deg+=40; 
                        return; 
                } 
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*165/(165+orng-rng) ); 
                if(rng>720) if(!att) if(rng>orng || rng>850) {
                                deg+=57;
                                return orng=0;
                        }

        }  else if(scan(deg-20,10)) deg-=20; 
        else if(!scan(deg+=21,10)) deg+=57; 
} 

seek() {
        i=320;
        while(!(b=scan(i+=20, 10)));
        deg=i;
        while (i<700) {
                if ((d=scan(i+=20, 10)) ) {
                        if (d<b) {
                                b=d;
                                deg=i;
                        }
                }
        }
        drive(dir=deg,100);
        b=0;
        while((damage(spara(drive(dir,100)))<att)&&orng) {
                if(t%2) {
                        if (loc_x()>910 ) dir=180;
                        else if (loc_x()<90 ) dir=360;
                        else if (loc_y()>910 ) dir=270;
                        else if (loc_y()<90) dir=90;
                        else dir=deg+70+(b^=1)*215;/*65*/
                }
        }
        att=0;
        drive((dir+180),100);
        vai (x,y);
}

boom()
{
            b=att=1;
            while(1) {
                if(t%2) {
                        if (loc_x()>910 ) dir=180;
                        else if (loc_x()<90 ) dir=360;
                        else if (loc_y()>910 ) dir=270;
                        else if (loc_y()<90) dir=90;
                        else dir=deg+65+(b^=1)*205+180*(orng<250);/*65*/
                        spara(drive(dir,100));
                } else {
                        if(orng>400) fuoco(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}
