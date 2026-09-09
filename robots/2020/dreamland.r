/**************************
 *                        *
 *  D R E A M L A N D .r  *
 *                        *
 **************************

Don't be proud


 Michelangelo Messina                         
 Torneo 2020



*/


int     deg,odeg, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        rng, /*distanza*/
        dir,dir0; /*direzione*/
        int orng,x,y;
        int b;
        int sc;
        int dx,up;
        int ne;



main()
{
/*
Variante piu' aggressiva di Carillon.r
Non ha chance di ben figurare

*/
    if(dx=(loc_x(up=(loc_y()>500))>500)) {
    	if(up) deg=(sc=183)+23;
        else deg=(sc=93)+23;
	xmin(dir=360);
    } else {
        if(up) deg=(sc=273)+23;
	else deg=(sc=3)+23;
	xmag(dir=180);
    }
    if(up) attacco(ymin(dir=90)); else attacco(ymag(dir=270));

    while(1) {
        if(ne==3) {
		if(up) {
                        if(occupato(260)) fuggi(); 
			else step(1);
	   	} else {
                        if(occupato(80)) fuggi(); 
			else step(1);
		}
        }
        while ( (damage() <= dam) ) { /*fino quando non e' colpito o limite di tempo*/
                if (dx) xmin(xyf(dir=(dir0=180)-28+56*(up)));
                else xmag(xyf(dir=(dir0=360)+28-56*(up)));
                if (up) ymin(xyf(dir=(dir0=270)+28-56*(dx)));
                else ymag(xyf(dir=(dir0=90)-28+56*(dx)));
		attacco();

        }
	dam=damage(b^=1)+5;
    } 
}

fuggi()
{
        if(dx) {
                if(occupato(170)) boom(); 
		else step(0);
        } else {
                if(occupato(350)) boom(); 
		else step(0);
        }
}

step(w)
{
        if(w) { /*verticale*/
                if(up) {while(loc_y()>480) spara(drive(270,100));dir=270;}
                else {while(loc_y()<520) spara(drive(90,100));dir=90;}
                sc=318-180*(dx);
        } else { /*orizzontale */
                if(dx) {while(loc_x()>480) spara(drive(180,100));dir=180;}
                else {while(loc_x()<520) spara(drive(360,100));dir=360;}
                sc=48+180*(up);
        }
        while(damage(attacco(drive(dir+=180,0))) <= dam) {
                spara(drive(dir,100));
                spara(drive(dir,100));
        }
	boom();
}

                


int occupato(w)
/* restituisce 1 se non ci sono nemici nella direzione w */
int w;
{
        return(((scan(w,10))||(scan(w+21,10))));
}


/* spostamento */
xmag() { while(loc_x()>83) spara(drive(dir,100)); while(loc_x()>51) drive(dir,100);stop();} 
xmin() { while(loc_x()<917) spara(drive(dir,100));while(loc_x()<949) drive(dir,100);stop(); } 
ymag() { while(loc_y()>83) spara(drive(dir,100)); while(loc_y()>51) drive(dir,100);drive(dir,0); } 
ymin() { while(loc_y()<917) spara(drive(dir,100)); while(loc_y()<949) drive(dir,100);drive(dir,0); } 

xyf()  {
        if(orng>710||orng==0) deg=dir0;
        spara(drive(dir,100));
        if(b&&orng>450) fuoco(t+=2);
        stop(spara(drive(dir,100)));
        spara(drive(dir+=180,100));
}

stop() { 
        spara(drive(dir,0));
}

attacco()    
{
/* conta il nr dei nemici */
/*
ne=4 - 1 nemico
ne=3 - 2 nemici
ne=2 - 3 nemici
*/
    if((ne=((!scan(sc+84,10))+
        (!scan(sc+63,10))+
        (!scan(sc+42,10))+
        (!scan(sc+21,10))+
        (!scan(sc,10))))>3) boom();
    else if (t<1590) ++t;
    else {
        if(ne>2) {if (dam<75) boom(); else t=0;}
        else {if(dam<45) boom(); else t*=(dam<75);}
    } 
}


fuoco() 
{
  drive(dir,100);
  if (scan(deg,10));
  else if (scan(deg-=21,10));
  else if (scan(deg+=42,10));
  else if (scan(deg+=21,10));
  else return search();

  if (scan(deg-17,10)) deg-=6;  
  if (scan(deg+17,10)) deg+=6;


  
  if (orng=refine()) {
    if (rng=refine(odeg=deg))
      cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(192+orng-rng-(cos(deg-dir)>>12)));
    else if(rng=scan(deg-=21,10)) cannon(deg,rng); 
    else if(rng=scan(deg+=42,10)) cannon(deg,rng);
    else deg+=41;
  }
  else if(orng=scan(deg-=21,10)) cannon(deg,orng); 
  else if(orng=scan(deg+=42,10)) cannon(deg,orng);
  else deg+=41;
}

refine() {
  if (scan(deg+13,10)) deg+=4; if (scan(deg-13,10)) deg-=4;
  if (scan(deg+12,10)) deg+=2; if (scan(deg-12,10)) deg-=2;
  if (scan(deg+10,10)) ++deg; if (scan(deg-10,10)) --deg;
  return scan(deg,10);

}

search() {
  if ((orng=scan(deg-=84,10))) return cannon(deg,orng);
  else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
  else if ((orng=scan(deg+=126,10))) return cannon(deg,orng);
  else if ((orng=scan(deg+=21,10))) return cannon(deg,orng);
  else if ((orng=scan(deg-=168,10))) return cannon(deg,orng);
  else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
  else if ((orng=scan(deg+=210,10))) return cannon(deg,orng);
  else if ((orng=scan(deg-=231,10))) return cannon(deg,orng);
  else if ((orng=scan(deg+=252,10))) return cannon(deg,orng);
  else deg+=41;
}

spara() {
   ++t;
        if ((orng=scan(deg,10)) ) { 
                if (scan(deg-9,4)) { 
                        if (scan(deg-=13,4)) deg-=4;
			else ++deg;
                } else if(scan(deg+9,4)) deg+=13;

        }  else if ((orng=scan(deg-=21,10))) { 
                if (scan(deg-10,5)) deg-=5;
		else ++deg; 
        }  else if ((orng=scan(deg+=42,10))); 
	else return deg+=21;
        if (rng=scan(deg,10)){  
                cannon (deg, rng*135/(135+orng-rng) );
        }
}


sparafast()
{
	drive(dir,100);
        if ((orng=scan(deg,10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-8,10)) deg-=5;
                        }  else if (scan(deg-10,10)) deg-=8;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                }  else if(scan(deg+9,10)) deg+=6;
                else deg-=5;

        }  else if ((orng=scan(deg-=21,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=42,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=21,10)));
	else return search();
        if (rng=scan(deg,10)){  
                cannon (deg, rng*145/(145+orng-rng) ); 
        }  else if(rng=scan(deg-=21,10)) cannon(deg,rng); 
        else if(rng=scan(deg+=42,10)) cannon(deg,rng);
	else deg+=41;
} 

boom()
{
	fuoco(sparafast(dir=sc+40));
	    while(1) {
                if(orng>459) fuoco();
                if(orng>459) fuoco();
                if ((x=loc_x(y=loc_y()))>840 || x<160 || y>840 || y<160) {
			if(x>840) dir=165+30*(y>500);
                	else if (x<160) dir=345+30*(y<500);
                	else if (y>840) dir=255+30*(x<500);
                	else            dir=75+30*(x>500);
		}
		else if(orng<149) dir=((deg/90)+(b^=1))*90+180*(dam>85);
		else if(orng<640) dir=deg+80+(b^=1)*200+180*(dam>79);
		else              dir=deg+24+(b^=1)*(299-dam);
                dam=damage(sparafast());
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		sparafast();
            }
}
