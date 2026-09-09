/******************
 *                *
 *  C R A Z Y .r  *
 *                *
 ******************

 Macro Robot per il torneo 2012

 Michelangelo Messina


*/






int rng, deg;     /* Distanza e Gradi          */
int orng, odeg;   /* Distanza precedente      */
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
Questo macro robot deriva dal macro 4ever.r del torneo 2k1 e dai midi todos.r
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
    
    while (danni=damage()+6) {
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
        if((ne=4-(  (!scan(sc+100,10))+
		(!scan(sc+80,10))+
		(!scan(sc+60,10))+
		(!scan(sc+40,10))+
		(!scan(sc+20,10))+
		(!scan(sc,10))))<0) boom(att=fp=5);
        else if(t>1550) { 
                if(ne<1) {if(danni<70) seek(att=80);}
                else if(danni<50) seek(att=60);
                else t*=(danni<69);
        } else ++t;
}



vai ()
{
    spara(drive (dir=deg(x,y),100));
    while (dist(x,y)>12000) spara(drive (dir,100));
    while (dist(x,y)>1600) drive (dir,100);
    ferma(dx=(x>500));
    if (up=(y>500)) {
        if(dx){sc=165;return dir=45;}
        else {sc=255;return dir=135;}
    } else {
        if(dx) {sc=75;return dir=315;}
        else {sc=345;return dir=225;}
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

fuoco() {
  t+=2;
  if (scan(deg,10));
  else if (scan(deg+=20,10));
  else if (scan(deg-=40,10));
  else if (scan(deg+=60,10));
  else return search();

  if (scan(deg-18,10)) deg-=7; if (scan(deg+18,10)) deg+=7;
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
  if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

  if (orng=scan(odeg=deg,10)) {
    if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
    if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
    if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;

    if (rng=scan(deg,10))
      return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
  }
}

search() {
	if ((orng=scan(deg-=80,10))) return cannon(deg,orng);
	else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
	else if ((orng=scan(deg+=120,10))) return cannon(deg,orng);
	else if ((orng=scan(deg+=20,10))) return cannon(deg,orng);
	else if ((orng=scan(deg-=160,10))) return cannon(deg,orng);
	else return deg+=260;
}

spara()
/* routine di sparo*/ 
{ 
        ++t; 
        if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,fp)) deg-=fp;
                                else ++deg;
                        }  else if (scan(deg-fp,fp)) deg-=fp;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,fp)) deg+=fp;
                        else --deg;
                }  else if(scan(deg+4,fp)) deg+=fp;
                else deg-=fp;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,fp)) deg-=fp;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=12;
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
                cannon (deg, rng*155/(155+orng-rng) ); 
                if(att); else if(rng>750) {
                                return deg+=41;
                        }
        }  
} 



seek() {
        if(scan(sc+100,10)) dir=deg=sc+100;
        else dir=deg=sc+20;
        fp=5;
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((i=loc_x())>890 ) dir=180;
                        else if (i<110 ) dir=360;
                        else if ((i=loc_y())>890 ) dir=270;
                        else if (i<110) dir=90;
			else if(orng>500) dir=deg+15+(b^=1)*235;
                        else if(orng>280) dir=deg+70+(b^=1)*210;
                        else dir=deg+100+(b^=1)*155;
                }
                if(orng); else {
                        if(ne) --ne;
                        else boom();
                }

        }
        fp=2;
        vai(att=0);
}

boom()
{
	    while(1) {
		if(orng>610) dir=deg+53+(b^=1)*180;
		else if(orng>150) dir=deg+80+(b^=1)*200;
                else dir=(deg/90)*90;                               
                if ((x=loc_x(y=loc_y()))>860) dir=165+30*(y>500);
                else if (x<140) dir=345+30*(y<500);
                else if (y>860) dir=255+30*(x<500);
                else if (y<140) dir=75+30*(x>500);
		else if(dam>79) dir+=180;
		spara(drive(dir,100));
                dam=damage()+1;
                if(orng>460) {
			spara(drive(dir,100));
                        fuoco(drive(dir,100));
                } else spara(drive(dir,100));
                
            }
}






