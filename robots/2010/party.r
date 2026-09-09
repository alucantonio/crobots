/******************
 *                *
 *  P A R T Y .r  *
 *                *
 ******************

 Midi Robot per il torneo 2010

 Michelangelo Messina


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
int fp;

/*
Questo midi robot deriva dal macro 4ever.r del torneo 2k1 e dai midi todos.r
del 2k2, spaceman.r del 2k3, wgdi.r del 2k4 e rythm del 2007.
Le differenze sono poche, soprattutto nella routine di sparo leggermente
migliorata (nel f2f), anche perché fare peggio era difficile.
Nell'ultima implementazione è stato velocizzato il conteggio degli avversari.
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


    attacco(vai (x=80+840*(loc_x()>500),y=80+840*(loc_y(fp=3)>500)));
    
    while (danni=damage()+10) {
            while (damage()<danni) {
                                        /*oscilla */
		
                spara(drive(dir+=180,100));
                if(up) while (loc_y()>=y) spara(drive (dir,100)); 
                else while (loc_y()<=y) spara(drive (dir,100)); 
                spara(drive (dir-=180,100)); 
                if(up) while (loc_y()<y) spara(drive (dir,100));
                else while (loc_y()>y) spara(drive (dir,100));
                attacco(ferma());

            }

            if(ne); else {
                                        /*si muove */
                    if(up) freey(260,80);
                    else freey(80,920);
            }
    }        
}

freey(j,k)
{
    if(occupato(j)) {    
	if (dx) freex(170,80);
	else freex(350,920);
    }
    else vai(y=k);
}

freex(j,k)
{
    if(occupato(j)) seek(att=101);
    else vai(x=k);
}

ferma()
{
	spara(drive(dir,0));
}

attacco()
{
        ne=4-(  (!scan(sc+100,10))+
		(!scan(sc+80,10))+
		(!scan(sc+60,10))+
		(!scan(sc+40,10))+
		(!scan(sc+20,10))+
		(!scan(sc,10)));

        if (ne<0) seek(att=101);
        else if(t>1300) { 
                if(ne<1) {if(damage()<60) seek(att=80);}
                else if(damage()<40) seek(att=60);
                else t*=(damage()<59);
        } else ++t;
}



vai ()
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    ferma(dx=(x>500));
    if (up=(y>500)) {
        if(dx){sc=185;return dir=45;}
        else {sc=275;return dir=135;}
    } else {
        if(dx) {sc=95;return dir=315;}
        else {sc=365;return dir=225;}
    }

}

/* Angolo per andare in una certa direzione */
deg(xx,yy) { return (180+((xx-=(loc_x()))>0)*180+atan(((yy-loc_y())*100000)/(xx+(xx==0)))); }

/* Calcola la distanza rispetto ad un punto dato */
dist(xx,yy) { return (((xx-=loc_x())*xx+(yy-=loc_y())*yy)); }


/* rende vero se il dato angolo e' occupato */
occupato (gradi)
{
    return ((scan(gradi,10) ||scan(gradi+20,10)));
}


spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-9,4)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,fp)) deg-=fp;
                                else ++deg;
                        }  else if (scan(deg-fp,fp)) deg-=fp;
                } else if(scan(deg+9,fp)) { 
                        if (scan(deg+=13,fp)) deg+=fp;
                        else --deg;
                }  else if(scan(deg+4,fp)) deg+=fp;
                else --deg;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,fp)) deg-=fp;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=9;
        }  else if (!(orng=scan(deg+=20,10))) { 
                if ((orng=scan(deg+=21,10))) { 
                        if (orng>900) { 
                                if(!att) deg+=41; 
                                return;
                        } 
                } else { 
                        if (!(scan(deg+=21,10))) deg+=40; 
                        return; 
                } 
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*165/(165+orng-rng) ); 
                if(att); else if(rng>720) if(rng>orng || rng>900) {
                                return deg+=41;
                        }

        }  
} 



seek() {
        if(scan(sc+105,10)) dir=deg=sc+105;
        else dir=deg=sc+15;
        fp=5;
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
        fp=2;
        vai(att=0);
}


