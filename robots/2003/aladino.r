/**********************
 *                    *
 *  A L A D I N O .r  *
 *                    *
 **********************

Make it right now!


 Michelangelo Messina


e non chiamatelo cordless...


dedicato ad Anna che mi sopporta mentre sto scrivendo questi commenti...


*/


int     deg,odeg, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        rng, /*distanza*/
        dir, /*direzione*/
        att;
        int orng,x,y;
        int i,b;
        int sc,sk;
        int dx,up;
        int ne;
        int fp;



main()
{
/*
All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
FIno a quando non e' colpito, oscilla lungo i due lati principali dell'angolo
in modo rettilineo, avvicinandosi il piu' possibile ai bordi e senza fermarsi
mai.
Se e' colpito cerca un eventuale angolo libero dove spostarsi.
Se i due angoli adiacenti sono occupati, e ci sono solo 2 avversari (worst
case), essendo in pieno controllo dei nemici, decide di attaccare come un
folle (tanto in quella situazione non sarebbe sopravvissuto a lungo).
L'attacco e' quello classico di boom.r con piccoli ritocchi. In particolare
cambia per robot molto vicini, diventando lineare nel tentativo di girare
intorno all'avversario formando un quadrato.

That's all folks

*/

    attacco(dove(vai(dx=(loc_x(up=(loc_y(fp=3)>500))>500))));
    while (dam=damage()+5) {
        while ( (damage() < dam) ) { /*fino quando non e' colpito o limite di tempo*/
                if (up) ymin(xyf(deg=dir=270));
                else ymag(xyf(deg=dir=90));
                if(orng>740) if (ne==2||t>1200) attacco();
                if (dx) xmin(xyf(deg=dir=180));
                else xmag(xyf(deg=dir=360));
		attacco();

        }

        if(ne==2) {
		if(up) {
        	        if(libero(260)) dove(ymag(up=0));
                	else fuggi();
	   	} else {
        	        if(libero(80)) dove(ymin(up=1));
                	else fuggi();
		}
	}
    }
}

fuggi()
{
        if(dx) {
                if(libero(170)) dove(xmag(dx=0));
                else seek(att=100);
        } else {
                if(libero(350)) dove(xmin(dx=1));
                else seek(att=100);
        }
}

dove()
{
        if(up) {
                if(dx) sc=165;
                else sc=255;
        } else {
                if(dx) sc=75;
                else sc=345;
        }
}


int libero(i)
/* restituisce 1 se non ci sono nemici nella direzione i */
int i;
{
        return(!((scan(i,10))||(scan(i+20,10))));
}


/* spostamento */
xmag() { while(loc_x()>93) spara(drive(180,100)); while(loc_x()>50) drive(180,100);stop(180); } 
xmin() { while(loc_x()<907) spara(drive(360,100));while(loc_x()<950) drive(360,100);stop(360); } 
ymag() { while(loc_y()>93) spara(drive(270,100)); while(loc_y()>50) drive(270,100);stop(270); } 
ymin() { while(loc_y()<907) spara(drive(90,100)); while(loc_y()<950) drive(90,100);stop(90); } 

xyf()  { sk=1;spara(drive(dir,100)); if(t>1200&&damage()<40) fuoco(drive(dir,100));spara(drive(dir,100));sk=0;stop(dir);} 

vai() {
    if(dx) xmin(); else xmag();
    if(up) ymin(); else ymag();
}


stop(dir) { 
        spara(drive(dir,0));
}

attacco()    
{
/* conta il nr dei nemici */

    i=sc+140;
    ne=0;
    while(i>sc) if (scan(i-=20,10)) ++ne;
    if (ne<2) boom(att=t=sk=1);
    else if (t>1560) {
        if(ne<3) {if (damage(t=1)<60) seek(att=75);}
        else if(damage()<40) seek(att=60);
        else if(damage()>59) t=1;
    } else t+=2;
}

fuoco() {
  t+=2;
  if (scan(deg,10));
  else if (scan(deg+=20,10));
  else if (scan(deg-=40,10));
  else {
        if (scan(deg+=60,10)) return;
        else if (scan(deg-=80,10)) return;
        else if (scan(deg+=100,10)) return;
        else if (scan(deg-=120,10)) return;
        else if (scan(deg+=140,10)) return;
        else if (scan(deg-=160,10)) return;
        return deg+=260;
  }

  if (scan(deg-10,8)) deg-=8;
  if (scan(deg+10,8)) deg+=8;
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
{
        ++t;
        if ((orng=scan(deg, 10)) ) { 

                if (scan(deg-9,4)) { 
                        if (scan(deg-=9+4,4)) { 
                                if(scan(deg+=4-2,2)) deg-=2;
                                else ++deg;
                        }  else if (scan(deg-4,4)) deg-=4;
                } else if(scan(deg+9,4)) { 
                        if (scan(deg+=9+4,4)) deg+=4;
                        else --deg;
                }  else if(scan(deg+4,fp)) deg+=fp;
                else --deg;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=9-4,3)) deg-=4;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=9; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=9;
        }  else if ((orng=scan(deg+=20,10)));
	else { 
                if(att) {
			if ((orng=scan(deg-=80,10))) return cannon(deg,orng);
			else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
			else if ((orng=scan(deg+=120,10))) return cannon(deg,orng);
			else if ((orng=scan(deg+=20,10))) return cannon(deg,orng);
			else if ((orng=scan(deg-=160,10))) return cannon(deg,orng);
			else return deg+=260;
		}
                if ((orng=scan(dir,10))) {
                        if (orng>850) {
                                if(sk) return deg=dir;
                                return deg+=40;
                        } else deg=dir;
                } else { 
                        if ((orng=scan(deg+=20,10))) return cannon(deg,orng); 
                        return deg+=40; 
                } 
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*165/(165+orng-rng) ); 
                if(rng>740) if(!sk) if(rng>orng || rng>900) {
                                return deg+=40;
                        }
        }  else if(scan(deg-20,10)) deg-=20; 
        else if(!scan(deg+=20,10)) deg+=40; 
} 

seek() {
        if(scan(sc+105,10)) deg=sc+105;
        else deg=sc+15;
        fp=4;
        drive(sk=dir=deg,100);
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>914) dir=145+70*(y>500);
                        else if (x<86) dir=325+70*(y<500);
                        else if (y>914) dir=235+70*(x<500);
                        else if (y<86) dir=55+70*(x>500);
                        else {
                                if(orng<180) dir=deg+95+(b^=1)*155;
                                else if(orng<400) dir=deg+50+(b^=1)*220;
                                else dir=deg+20+(b^=1)*275;
                        }
                }
                if(!orng) {
                        if(ne==2) boom(t=fp=5);
                        --ne;
                }
        }
        fp=3;
        return vai(att=sk=0);
}


boom()
{
        fp=5;
            while(1) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>860) dir=145+70*(y>500);
                        else if (x<140) dir=325+70*(y<500);
                        else if (y>860) dir=235+70*(x<500);
                        else if (y<140) dir=55+70*(x>500);
                        else {
                                if(orng<350) dir=(deg/90)*90;/*65*/
                                else if (orng<680) dir=deg+80+(b^=1)*190;/*65*/ 
                                else dir=deg+25+(b^=1)*235;/*65*/
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>380) {
                                spara(drive(dir,100));
                                fuoco(drive(dir,100));
                        }
                        else spara(drive(dir,100));
                }
            }
}
