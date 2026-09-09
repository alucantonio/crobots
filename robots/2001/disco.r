/***********************
 *                     *
 *    D I S C O .r     *
 *                     *
 ***********************


 Michelangelo Messina                         




        'cause my heart goes BOOM


dedicato ad Anna che mi sopporta mentre sto scrivendo questi commenti...


*/


int     deg,odeg, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        pt, /*contatore parziale*/
        rng, /*distanza*/
        dir, /*direzione*/
        att;
        int orng,x,y;
        int i,b;
        int sc;
        int dx,up;



main()
{
/*
All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
Prova a spostarsi piu' vicino possibile all'angolo, e resta fermo se i nemici
sono lontani.
Altrimenti oscilla prima con un movimento angolare a 90ø, poi sulla
bisettrice.
Se e' colpito cerca un eventuale angolo libero dove spostarsi.
L'attacco e' quello classico di boom.r con piccoli ritocchi.

That's all folks

*/

    vai(dx=(loc_x(up=(loc_y()>500))>500));
    while (i<360) {
        if (scan (i+=20, 10)) if(++pt==2) i=380;
    }
    if (pt<2) boom(t=att=1);

    while (dam=damage()+20) {
        if(up) {
                if(dx) sc=165;
                else sc=255;
        } else {
                if(dx) sc=75;
                else sc=345;
        }

        while ( (damage() < dam) ) { /*fino quando non e' colpito o limite di tempo*/
                /*dam=damage();*/
                if (up) ymin(yfmag());
                else ymag(yfmin());
                if (dx) xmin(xfmag());
                else xmag(xfmin());

		 /* se tutti sono lontani posso star fermo
		 altrimenti oscillo intorno all'angolo attuale*/ 

                while (!orng) {
                        if(++pt>50) attacco();                        
                        spara();
                }
        }

        if(up) {
                if(libero(260)) {yfmag(up=0);stop(270);}
                else fuggi();
   	} else {
                if(libero(80)) {yfmin(up=1);stop(90);}
                else fuggi();
	}
        pt=43;
    }
}

fuggi()
{
        if(dx) {
                if(libero(170)) {xfmag(dx=0);stop(180);}
                else angle();
        } else {
                if(libero(350)) {xfmin(dx=1);stop(360);}
                else angle();
        }
}

int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}


/* spostamento */
xmag() { while(loc_x()>125) spara(drive(180,100)); while(loc_x()>50) drive(180,100);stop(180); } 
xmin() { while(loc_x()<875) spara(drive(360,100)); while(loc_x()<950) drive(360,100);stop(360); } 
ymag() { while(loc_y()>125) spara(drive(270,100)); while(loc_y()>50) drive(270,100);stop(270); } 
ymin() { while(loc_y()<875) spara(drive(90,100)); while(loc_y()<950) drive(90,100);stop(90); } 

xfmin()  { spara(drive(dir=360,100));deg=dir;while(loc_x()<160) fuoco(drive(360,100));} 
xfmag()  { spara(drive(dir=180,100));deg=dir;while(loc_x()>840) fuoco(drive(180,100));}
yfmag()  { spara(drive(dir=270,100));deg=dir;while(loc_y()>840) fuoco(drive(270,100));} 
yfmin()  { spara(drive(dir=90,100));deg=dir;while(loc_y()<160) fuoco(drive(90,100));}

vai() {
    if(dx) xmin(); else xmag();
    if(up) ymin(); else ymag();
}


stop(dir) { spara(drive(dir,0));}

attacco()    
{
/* conta il nr dei nemici */

    i=sc+140;
    pt=b=0;
    while(i>sc) if (scan(i-=20,10)) ++b;
    if (b<2) {
        if(damage(att=t=1)<91) boom();
    } else if (t>1490) {
        t=1;
        if(b<3) {if (damage()<60) seek(att=80);}
        else if(damage()<40) seek(att=45);
    }
    return orng=1;
}

angle()
{
    if (up) {
        y=915;
        if (dx) dir=45;
        else dir=135;
    }
    else {
        y=85;
        if (dx) dir=315;
        else dir=225;
    }
    pt=orng=0;
    while(orng<800) {
        if(up) {
                spara(drive(dir+=180,100));
                while (loc_y()>y) spara(drive (dir,100));
                spara(drive (dir+=180,100));
                while (loc_y()<=y) spara(drive (dir,100));
        } else {
                spara(drive(dir+=180,100));
                while (loc_y()<=y) spara(drive (dir,100));
                spara(drive (dir+=180,100));
                while (loc_y()>y) spara(drive (dir,100));
        }
        if(++pt>7) {
                if(!orng) attacco(drive(dir,0));
                else pt=0;
        }
    }
    spara(drive(dir,0));
}


fuoco() {
  ++t;
  if (orng=scan(deg,10));
  else if (orng=scan(deg+=20,10));
  else if (orng=scan(deg-=40,10));
  else return deg+=80;

  if (scan(deg-=5,5)); else deg+=10;
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
                                if(!att) {orng=0;return deg+=41;}
                                return; 
                        } 
                } else { 
                        if (!(scan(deg+=21,10))) return deg+=40; 
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
        i=sc+140;
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
        b=0;
        drive(dir=deg,100);
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((i=loc_x())>910 ) dir=180;
                        else if (i<90 ) dir=360;
                        else if ((i=loc_y())>910 ) dir=270;
                        else if (i<90) dir=90;
                        else {
                                dir=deg+70+(b^=1)*215;/*65*/
                                if(orng<270) dir+=180;
                        }
                }
        }
        drive((dir+180),100);
        return vai(att=0);
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
                                dir=deg+65+(b^=1)*205+180*(orng<270);/*65*/
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>520) fuoco(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}
