/******************************
 *                            *
 *    M O V E  O N baby.r     *
 *                            *
 ******************************


 Michelangelo Messina



omaggio alla miglior dance di tutti i tempi...

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
        int ne;



main()
{
/*
Il robot e' molto simile a Yerba e, a dire il vero, rende un po' meno
in quasi tutti i test.
Rappresenta lo step intermedio nel passaggio da Disco a Yerba.
Le differenze principali sono 2:
 - L'attacco e' molto piu' simile (come comportamento e come rendimento) a
 quello di disco.
 - Se i nemici sono lontani si ferma nell'angolo, mentre Yerba continua nel
 moto perpetuo.


All'inizio dell'incontro il robot si reca nell'angolo piu' vicino e controlla
se si tratta di un f2f.
Prova a spostarsi piu' vicino possibile all'angolo, e resta fermo se i nemici
sono lontani, altrimenti oscilla lungo i due lati principali dell'angolo
in modo rettilineo.
Se e' colpito cerca un eventuale angolo libero dove spostarsi.
Se i due angoli adiacenti sono occupati, e ci sono solo 2 avversari (worst
case), essendo in pieno controllo dei nemici, decide di attaccare come un
folle (tanto in quella situazione non sarebbe sopravvissuto a lungo).
L'attacco e' quello classico di boom.r con piccoli ritocchi.

That's all folks

*/

    attacco(dove(vai(dx=(loc_x(up=(loc_y()>500))>500))));
    while (dam=damage()+20) {
        while ( (damage() < dam) ) { /*fino quando non e' colpito o limite di tempo*/
                /*dam=damage();*/
                if (up) ymin(yfmag(840));
                else ymag(yfmin(160));
                if (dx) xmin(xfmag(840));
                else xmag(xfmin(160));

		 /* se tutti sono lontani posso star fermo
		 altrimenti oscillo intorno all'angolo attuale*/ 

                pt=0;
                while (!orng) {
                        spara();
                        if(++pt>6) attacco(++t);
                }
        }

        if(up) {
                if(libero(260)) {ymag();dove(up=0);}
                else fuggi();
   	} else {
                if(libero(80)) {ymin();dove(up=1);}
                else fuggi();
	}
    }
}

fuggi()
{
        if(dx) {
                if(libero(170)) {xmag();dove(dx=0);}
                else if(ne==2) seek(att=100);
        } else {
                if(libero(350)) {xmin();dove(dx=1);}
                else if(ne==2) seek(att=100);
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
xmag() { while(loc_x()>125) spara(drive(180,100)); while(loc_x()>50) drive(180,100);stop(180); } 
xmin() { while(loc_x()<875) spara(drive(360,100)); while(loc_x()<950) drive(360,100);stop(360); } 
ymag() { while(loc_y()>125) spara(drive(270,100)); while(loc_y()>50) drive(270,100);stop(270); } 
ymin() { while(loc_y()<875) spara(drive(90,100)); while(loc_y()<950) drive(90,100);stop(90); } 

xfmin(a)  { spara(drive(dir=360,100));deg=dir;while(loc_x()<a-80) fuoco(drive(360,100));while(loc_x()<a) drive(360,100);stop(360);} 
xfmag(a)  { spara(drive(dir=180,100));deg=dir;while(loc_x()>a+80) fuoco(drive(180,100));while(loc_x()>a) drive(180,100);stop(180);}
yfmag(a)  { spara(drive(dir=270,100));deg=dir;while(loc_y()>a+80) fuoco(drive(270,100));while(loc_y()>a) drive(270,100);stop(270);} 
yfmin(a)  { spara(drive(dir=90,100));deg=dir;while(loc_y()<a-80) fuoco(drive(90,100));while(loc_y()<a) drive(90,100); stop(90);}

vai() {
    if(dx) xmin(); else xmag();
    if(up) ymin(); else ymag();
}


stop(dir) { spara(drive(dir,0));}

attacco()    
{
/* conta il nr dei nemici */

    i=sc+140;
    ne=0;
    while(i>sc) if (scan(i-=20,10)) ++ne;
    if (ne<2) boom(t=att=1);
    else if (t>1160) {
        if(ne<3) {if (damage(t=1)<60) seek(att=65);}
        else if(damage()<40) seek(att=45);
        else if(damage()>59) t=1;
    }
    return orng=1;
}

fuoco() {
  ++t;
  if (scan(deg,10));
  else if (scan(deg+=20,10));
  else if (scan(deg-=40,10));
  else {
        if (orng=scan(deg+=60,10)) return;
	else if (scan(deg+=20,10)) return;
	else if (scan(deg+=20,10)) return;
	else if (scan(deg+=20,10)) return;
	else if (scan(deg+=20,10)) return;
	else if (scan(deg+=20,10)) return;
	return deg+=40;
  }

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
                if(att) i=deg-80;
                else i=dir;
                if ((orng=scan(i,10))) {
                        if (orng>850) {
                                if(att) return deg=i;
                                orng=0;
                                return deg+=40;
                        } else deg=i;
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
        if(scan(sc+105,10)) deg=sc+105;
        else deg=sc+15;
        drive(dir=deg,100);
        while(damage(spara(drive(dir,100)))<att) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>890) dir=145+70*(y>500);
                        else if (x<110) dir=325+70*(y<500);
                        else if (y>890) dir=235+70*(x<500);
                        else if (y<110) dir=55+70*(x>500);
                        else {
                                if(orng<250) dir=deg+95+(b^=1)*155;
                                else if(orng<500) dir=deg+50+(b^=1)*220;
                                else dir=deg+25+(b^=1)*265;
                        }
                }
        }
        return vai(att=0);
}


boom()
{
            while(1) {
                if(t%2) {
                        if ((x=loc_x(y=loc_y()))>890) dir=145+70*(y>500);
                        else if (x<110) dir=325+70*(y<500);
                        else if (y>890) dir=235+70*(x<500);
                        else if (y<110) dir=55+70*(x>500);
                        else {
                                if(orng<330) dir=deg+95+(b^=1)*155;
                                else if (orng<530) dir=deg+60+(b^=1)*210;
                                else dir=deg+25+(b^=1)*235;
                        }
                        spara(drive(dir,100));
                } else {
                        if(orng>480) fuoco(drive(dir,100));
                        else spara(drive(dir,100));
                }
            }
}

/*
Take the chance 
Give it all that you can 
Cause he doesn't feel a thing for you 
You can try to move on 
So nothing will go wrong 
Maybe he will be back 
To search for you 

Back on track 
It's me yeah, and I fixed it 
I proved my point, now we mix it 
Yeah the A double L star, fresh and I got together 
To make the track flow better 
That's why we stand strong, now you know what's up 
If I'm on the move, 
I can't stop 
The beat is simple, but you can't refuse it, 
That's why I love music. 

Move on baby 
Move on baby 
Move on baby 
And we get together 

Again and again I keep going with the swing 
I stay funky like this and I bring 
Beats to move you, 
So I can prove you 
That I can rock a microphone like I used to 
I love music yeah, can you feel it 
Check me out 
This is how I deal it 
The bass, the mid, the treble 
I just fuse it together 
Cause I love music. 

*/

