/*
Janick.r
Macro robot per il torneo 2003

Scritto da:
Angelo Ciufo


Il robot e' basato su Remus.r del 2000, ma contiene molte ottimizzazioni.
Si reca nell'angolo piu' vicino, e oscilla con un movimento a 45ø.
Se e' colpito cerca un angolo libero.
Dopo 1220 chiamate alle funzioni di sparo attacca i superstiti,
se e' in buone condizioni.
L'attacco deriva da yerba.r
*/



int rng, deg;     /* Distanza e Gradi          */
int orng, odeg;   /* Distanza e Gradi Old      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */

int danni;
int i,b,d;
int x,y;
int t;
int att;

main()
{
    vai (x=100+800*(loc_x(ne=3)>500),y=100+800*(loc_y()>500));
    
    while (danni=damage()+5) {
                                            /*angle ();*/
            while (damage()<danni) {

                if(!orng||orng>850) {
                        i=-10; ne=0;
                        while (i<360) {
                                if (scan (i+=20, 10)) ++ne;
                        }
                        if (ne<2) {
                                if (damage()<90) boom ();
                                else t=0;
                        } else if(t>1220) { 
                                if(ne<3 && damage()<60) seek(att=70);
                                else if(damage()<40) seek(att=45);
                                else t=0;

                        }
                } 
                                        /*oscilla (7);*/
                i=7;
                while (--i) {
                        spara(drive (dir,100));
                        while (loc_y()<=y) spara(drive (dir,100)); 
                        dir+=180;
                        spara(drive (dir,100));
                        while (loc_y()>=y) spara(drive (dir,100)); 
                        dir-=180;
                }
                spara(drive (dir,0));
            }
                                        /*move ();*/
            if (loc_y()<500) {
                if (libero(90)) vai(x,y=900);
                else sxdx ();
            } else {
                if (libero(270)) vai(x,y=100);
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

vai (x,y)
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>22500) fuoco(drive (dir,100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    spara(drive (dir,0));
    if (y<500) { 
        if (x<500) {dir=135;}
        else {dir=45;}
    } else { 
        if (x<500) {dir=45;}
        else {dir=135;}
    }

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
        if (!(orng=scan(deg+=340,10))){  
                if (!(orng=scan(deg+=40,10))) { 
                        if(!(orng=scan(deg+=20,10))) { 
                                deg+=40; 
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
        else if(!scan(deg+=20,10)) deg+=57; 
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
                        else {
                                if(orng<250) dir=deg+95+(b^=1)*155;
                                else if(orng<500) dir=deg+50+(b^=1)*220;
                                else dir=deg+25+(b^=1)*265;
                        }
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
                        if ((x=loc_x(y=loc_y()))>860) dir=145+70*(y>500);
                        else if (x<140) dir=325+70*(y<500);
                        else if (y>860) dir=235+70*(x<500);
                        else if (y<140) dir=55+70*(x>500);
                        else {
                                if(orng<300) dir=(deg/90)*90;/*65*/
                                else if (orng<530) dir=deg+60+(b^=1)*210;/*65*/ 
                                else dir=deg+25+(b^=1)*235;/*65*/
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>470) fuoco(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}
