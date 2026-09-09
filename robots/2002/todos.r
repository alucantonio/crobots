/**********************
 *                    *
 *    T O D O S .r    *
 *                    *
 **********************


 Michelangelo Messina


        'cause my heart goes BOOM


*/






int rng, deg;     /* Distanza e Gradi          */
int orng;   /* Distanza precedente      */
int dir;               /* La mia direzione          */
int ne;                /* Numero avversari          */

int danni;
int i,b;
int x,y;
int t;
int att;
int sc;
int up;
int dx;

/*
Questo midi robot deriva dal macro 4ever.r del torneo 2k1.
All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
Durante il match oscilla nell'angolo con una routine leggermente modificata
rispetto a quella di dav46.r.
Se e' colpito cerca un eventuale angolo libero dove spostarsi.
Se i due angoli adiacenti sono occupati, e ci sono solo 2 avversari (worst
case), essendo in pieno controllo dei nemici, decide di attaccare come un
folle (tanto in quella situazione non sarebbe sopravvissuto a lungo).
L'attacco e' quello classico di boom.r con piccoli ritocchi e senza toxica.

That's all folks
*/

main()
{


    attacco(vai (x=80+840*(loc_x()>500),y=80+840*(loc_y()>500)));
    
    while (danni=damage()+20) {
            while (damage()<danni) {
                                        /*oscilla */
		
                spara(drive(dir+=180,100));
                if(up) while (loc_y()>=y) spara(drive (dir,100)); 
                else while (loc_y()<=y) spara(drive (dir,100)); 
                spara(drive (dir-=180,100)); 
                if(up) while (loc_y()<y) spara(drive (dir,100));
                else while (loc_y()>y) spara(drive (dir,100));
                ferma();
                if (orng) i=0;
                else if(++i>3) attacco(ne=0);

            }
                                        /*si muove */
            if(up) freey(260,80);
	    else freey(80,920); 
    }        
}

freey(j,k)
{
    if(libero(j)) vai(y=k);
    else {    
	if (dx) freex(170,80);
	else freex(350,920);
    }
}

freex(j,k)
{
    if(libero(j)) vai(x=k);
    else {if (ne==2) seek(att=100);}
}

ferma()
{
	spara(drive(dir,0));
}

attacco()
{
        i=sc+140;
        while (i>sc) {
        	if (scan (i-=20, 10)) ++ne;
        }
        if (ne<2) seek(att=101);
        else if(t>1400) { 
                if(ne<3) {if(damage()<65) seek(att=80);}
                else if(damage()<40) seek(att=55);
                else if(damage()>59) t=0;
        }
        i=0;
}



vai ()
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    ferma(up=(y>500));
    dx=(x>500);
    if (up) {
        if(dx){sc=165;return dir=45;}
        else {sc=255;return dir=135;}
    } else {
        if(dx) {sc=75;return dir=315;}
        else {sc=345;return dir=225;}
    }

}

/* Angolo per andare in una certa direzione */
deg(xx,yy) { return (180+((xx-=(loc_x()))>0)*180+atan(((yy-loc_y())*100000)/xx)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(xx,yy) { return (((xx-=loc_x())*xx+(yy-=loc_y())*yy)); }


/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!(scan(gradi,10) ||scan(gradi+20,10)));
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
                                if(!att) deg+=41; 
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

        }  
} 



seek() {
        if(scan(sc+105,10)) dir=deg=sc+105;
        else dir=deg=sc+15;
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((i=loc_x())>890 ) dir=180;
                        else if (i<110 ) dir=360;
                        else if ((i=loc_y())>890 ) dir=270;
                        else if (i<110) dir=90;
                        else {
                                if(orng>280) dir=deg+70+(b^=1)*210;/*65*/
                                else dir=deg+100+(b^=1)*155;/*65*/

                        }
                }
        }
        vai(att=att>100);
}


/*

Todo en todos
cada hombre en todos los hombres
todo en todos
todos los hombres en cada hombre
todo en todos
todas las cosas en cada cosa
todo en todos
cada cosa en todas las cosas
todo en todos
todo en todos
levantate

Strike a light tonight
everybody's standing
and all of us
will be one tonight

Close your eyes tonight
everything is shining
and you, and i, 
we will fly tonight


Copyright (c) Datura, 2002

*/
