/********************
 *                  *
 *  C H A N G E .r  *
 *                  *
 ********************

Do You really want to change?


 Michelangelo Messina



*/


int     deg,odeg, /*angolo di sparo*/
        dam, /*percentuale di danni attuale*/
        t,   /*conta cicli di attesa per l'attacco*/
        rng, /*distanza*/
        dir,dir0; /*direzione*/
        int orng,x,y;
        int b;
        int sc,sk;
        int dx,up;
        int ne;
        int fp;



main()
{
/*
All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
Fino a quando non e' colpito, oscilla lungo i due lati principali dell'angolo
in modo rettilineo, con angolo non retto, avvicinandosi il piu' possibile ai 
bordi e senza fermarsi mai.
Se e' colpito cerca un eventuale lato non occupato dove spostarsi.
Se i due angoli adiacenti sono occupati, e ci sono solo 2 avversari (worst
case), essendo in pieno controllo dei nemici, decide di attaccare come un
folle (tanto in quella situazione non sarebbe sopravvissuto a lungo).
L'attacco e' quello classico di boom.r con piccoli ritocchi. In particolare
cambia per robot molto vicini, diventando lineare nel tentativo di girare
intorno all'avversario formando un quadrato.

That's all folks

*/
    b=1;
    attacco(dove(vai(dx=(loc_x(up=(loc_y(fp=3)>500))>500))));
    while (dam=damage()+10) {
        while ( (damage() < dam) ) { /*fino quando non e' colpito o limite di tempo*/
                if (up) ymin(xyf(dir=(dir0=270)+30-60*(dx)));
                else ymag(xyf(dir=(dir0=90)-30+60*(dx)));
                if(orng>740) if (ne==0||t>1200) attacco();
                if (dx) xmin(xyf(dir=(dir0=180)-30+60*(up)));
                else xmag(xyf(dir=(dir0=360)+30-60*(up)));
		attacco();

        }

        if(ne) b^=1;
        else {
		if(up) {
                        if(occupato(260)) fuggi(); 
			else step(1);
	   	} else {
                        if(occupato(80)) fuggi(); 
			else step(1);
		}
        }
    }
}

fuggi()
{
        if(dx) {
                if(occupato(170)) seek(101); 
		else step(0);
        } else {
                if(occupato(350)) seek(101); 
		else step(0);
        }
}

dove()
{
        if(up) {
                if(dx) sc=185;
                else sc=275;
        } else {
                if(dx) sc=95;
                else sc=365;
        }
}

step(w)
{
        if(w) { /*verticale*/
                if(up) while(loc_y()>600) spara(drive(dir=270,100));
                else while(loc_y()<400) spara(drive(dir=90,100));
                sc=320-180*(dx);
        } else { /*orizzontale */
                if(dx) { while(loc_x()>600) spara(drive(dir=180,100)); }
                else { while(loc_x()<400) spara(drive(dir=360,100)); }
                sc=50+180*(up);
        }
        spara(drive(dir,0));
        while(1) {
                spara(drive(dir+=180,100));
                spara(drive(dir,100));
                attacco(drive(dir,0));
        }
}

                




int occupato(w)
/* restituisce 1 se non ci sono nemici nella direzione w */
int w;
{
        return(((scan(w,10))||(scan(w+20,10))));
}


/* spostamento */
xmag() { while(loc_x()>86) spara(drive(dir,100)); while(loc_x()>50) drive(dir,100);stop(); } 
xmin() { while(loc_x()<914) spara(drive(dir,100));while(loc_x()<950) drive(dir,100);stop(); } 
ymag() { while(loc_y()>86) spara(drive(dir,100)); while(loc_y()>50) drive(dir,100);stop(); } 
ymin() { while(loc_y()<914) spara(drive(dir,100)); while(loc_y()<950) drive(dir,100);stop(); } 

xyf()  {
        if(orng>710){
                deg=dir0;
                sk=1;
        }
        spara(drive(dir,100));
        if(b&&damage()<60) fuoco();
        spara(drive(dir,100));
	sk=0;
        stop(dir+=180);
}


vai() {
    if(dx) xmin(dir=360); else xmag(dir=180);
    if(up) ymin(dir=90); else ymag(dir=270);
}


stop() { 
        spara(drive(dir,0));
}

attacco()    
{
/* conta il nr dei nemici */

    ne=4-(  (!scan(sc+100,10))+
        (!scan(sc+80,10))+
        (!scan(sc+60,10))+
        (!scan(sc+40,10))+
        (!scan(sc+20,10))+
        (!scan(sc,10)));

    if (ne<0) boom(fp=t=sk=5);
    else if (t>1580) {
        if(ne<1) {if (damage(t=1)<60) return seek(75);}
        else {if(damage()<40) return seek(60);
        else t*=(damage()<60);}
    } else t+=2;
}

fuoco() {
  t+=2;
  if (scan(deg,10));
  else { if (scan(deg+=20,10));
        else { if (scan(deg-=40,10));
                else { if (scan(deg+=60,10));
                        else { if (scan(deg-=80,10));
                                else {
                                        if (scan(deg+=100,10)) return;
                                        else if (scan(deg-=120,10)) return;
                                        /*else if (scan(deg+=140,10)) return; 
                                        else if (scan(deg-=160,10)) return;*/
                                        return deg+=180;
                                }
                        }
               }
       }
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
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,fp)) deg-=fp;
                                else ++deg;
                        }  else if (scan(deg-fp,fp)) deg-=fp;
                } else if(scan(deg+9,fp)) { 
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
        }  else if ((orng=scan(deg+=20,10)));
	else if(sk) {
		if ((orng=scan(deg-=80,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=160,10))) return cannon(deg,orng);
		else return deg+=260;
	} else if ((orng=scan(dir0,10))) {
        	if (orng>850) {
                        return deg+=40;
                } else deg=dir0;
        } else { 
                if ((orng=scan(deg+=20,10))) return cannon(deg,orng); 
                return deg+=40;  
	} 
        if (rng=scan(deg,10)){  
                cannon (deg, rng*145/(145+orng-rng) ); 
                if(sk); else if(rng>740) if(rng>orng || rng>900) {
                                return deg+=40;
                        }
        }  else if(scan(deg-20,10)) deg-=20; 
        else if(scan(deg+=20,10));
	else deg+=40; 
} 

seek(att) {
        if(scan(sc+105,10)) deg=sc+105;
        else deg=sc+15;
        fp=5;
        drive(sk=dir=deg,100);
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>914) dir=155+50*(y>500);
                        else if (x<86) dir=335+50*(y<500);
                        else if (y>914) dir=245+50*(x<500);
                        else if (y<86) dir=65+50*(x>500);
                        else {
                                if(orng<180) dir=deg+95+(b^=1)*155;
                                else if(orng<400) dir=deg+50+(b^=1)*220;
                                else dir=deg+20+(b^=1)*275;
                        }
                }
                if(orng); else {
                        if(ne) --ne;
                        else boom(t=1);
                }
        }
        fp=3;
        return vai(sk=0);
}


boom()
{
            while(1) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>860) dir=155+50*(y>500);
                        else if (x<140) dir=335+50*(y<500);
                        else if (y>860) dir=245+50*(x<500);
                        else if (y<140) dir=65+50*(x>500);
                        else {
                                if(orng<210) dir=(deg/90)*90;/*65*/
                                else if (orng<680) dir=deg+80+(b^=1)*190;/*65*/ 
                                else dir=deg+15+(b^=1)*235;/*65*/
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>410) {
                                spara(drive(dir,100));
                                fuoco(drive(dir,100));
                        }
                        else spara(drive(dir,100));
                }
            }
}






