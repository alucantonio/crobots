/*
+ --------------------------------------------------------------------------- +
+                                                                             +
+  Torneo di CRobots 2001                                                     +
+                                                                             +
+  CROBOT: SHARP2.R                                                           +
+                                                                             +
+  AUTORE: Lorenzi Davide                                                     +
+                                                                             +
+ --------------------------------------------------------------------------- +

 SCHEDA TECNICA:

 Il robots e' lo stesso dell'omonimo dell'anno scorso da cui ho tolto la routine
 di movimento e cambiato quella di sparo...
 E' un robots che non e' stato molto testato per mancanza di tempo e soffre
 probabilmente di parecchi bug nascosti.
 La sua massima performance e' un -20% da daryl.r :-(


 I miei piu' sentiti ringraziamenti agli organizzatori, agli amici della
 mailing list ed ai creatori dei crobots da cui ho preso parti di codice.

 Buon combattimento a tutti!
-------------------------------------------------------------------------------
*/

int rng, deg;
int orng, odeg;
int dir,dir45;
int ne;

int danni;
int i;
int c2;
int x,y;
int go,timeuntil;

main()
{
    vai (x=100+800*(loc_x()>500),y=85+830*(loc_y()>500));
    if (numEnemy()<2)
        if (numEnemy()<2)
            attacco();

    ne=3; c2=2; timeuntil=1;
    while (1) {
        angle ();
		vai(x,y);
    }        
}


vai (x,y)
{
    dir=ang (x,y);
    drive (dir,100);
    while (dist(x,y)>22500) {drive (dir,100); f1();}
    while (dist(x,y)>1600) {drive (dir,100);}
    drive (dir,0);
}

/* Angolo per andare in una certa direzione */
ang(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }

angle()
{
    /* setta i gradi di oscillazione */
    if (loc_y()<500) { 
        if (loc_x()<500) dir45=45;
        else dir45=135;
    }
    else { 
        if (loc_x()<500) dir45=315;
        else dir45=225;
    }

    danni=damage()+15;
    while (damage()<danni) {
        oscilla (5);
        
        if (--timeuntil<1) {
            if (!orng || orng>600) {
                timeuntil=numEnemy();
                if (ne<2) if (!--c2) attacco ();
            }
        }

        if (orng && orng<120) return;

        if (ne>1) {
            if (!orng || orng>600) lat();
        }
    }
}


lat ()
{
    go=!go;
    if (damage()<90) {
        if (go) {
            /* X */
            if (loc_x()<500) {
                if (!libero(0))
                    while (loc_x()<250) f1(drive (0,100));
                while (loc_x()>100) f1(drive (180,100));
            }
            else {
                if (!libero(180))
                    while (loc_x()>750) f1(drive (180,100));
                while (loc_x()<900) f1(drive (0,100));
            }
            drive (dir,0);
        }
        else {
            /* Y */
            if (loc_y()<500) {
                if (!libero(90))
                    while (loc_y()<250) f1(drive (90,100));
                while (loc_y()>100) f1(drive (270,100));
            }
            else {
                if (!libero(270))
                    while (loc_y()>750) f1(drive (270,100));
                while (loc_y()<900) f1(drive (90,100));
            }
            drive (dir,0);
        }

        /* si riposiziona correttamente */
        if (loc_x()<500)
            while (loc_x()<70) f1(drive (0,80));
        else
            while (loc_x()>930) f1(drive (180,80));

        drive(dir,0);
    }
}

oscilla (n)
{
	if (loc_y()<500) {
	    while (--n) {
			while (loc_y()<=y) f1(drive (dir45,100));
			dir45+=180;
			while (loc_y()>y) f1(drive (dir45,100));
			dir45-=180;
		}
	}
	else {
	    while (--n) {
			while (loc_y()>y) f1(drive (dir45,100));
			dir45+=180;
			while (loc_y()<=y) f1(drive (dir45,100));
			dir45-=180;
		}
	}
    drive (dir45,0);
}



/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!scan(gradi+350,10) && !scan(gradi+10,10));
}


/* rende il numero di avversari presenti */
/* all'interno della variabile ne */
numEnemy ()
{
    i=0; ne=0;
    while (i<360) {
        if (scan (i+=20, 10)) ++ne;
    }
    return ne;
}


attacco()
{
	while(speed()>0) f1_final(drive(dir,0));
    vai(500,500);
    drive(dir,0);
	while(speed()>0) f1_final();

    while(1) {
	    dir=100;
		while (loc_y()<500) f1_final(drive(dir,100));
	    dir=280;
		while (loc_y()>=500) f1_final(drive(dir,100));
    }
}

f2()
{
    /* cerca un nemico */
    if (orng=scan(deg,10)) {
		if (rng=scan(deg,1)) return cannon(deg,rng);
			else if (rng=scan(deg-5,4)) return cannon(deg-=3,rng);
			else if (rng=scan(deg+5,4)) return cannon(deg+=3,rng);

	}
    else if (orng=scan(deg-=21,10)) return cannon (deg,orng);
    else if (orng=scan(deg+=42,10)) return cannon (deg,orng);
    else {deg+=42; return;}
}


f1 ()
{
    /* cerca un nemico */
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=21,10));
    else if (orng=scan(deg+=42,10));
    else {deg+=42; return;}

    /* se e` vicino spara immediatamente */
    if (orng<150) {cannon(deg,orng); return;}
   	if ((orng>800)&&(ne>1)) {deg+=40; return;}

    if (!scan(deg+=355,5)) deg+=10;
	if (!scan(deg+=357,3)) deg+=6;
    cannon(deg,2*scan(deg,5)-orng); return;
}


f1_final ()
{
    /* cerca un nemico */
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=21,10));
    else if (orng=scan(deg+=42,10));
    else {deg+=42; return;}

    /* se e` vicino spara immediatamente */
    if (orng<150) {cannon(deg,orng); return;}

	odeg=deg;
	if (scan(deg+=5,5)); else deg-=10;
	if (scan(deg+=3,3)); else deg-=6;
	if (rng=scan(deg,10))
		cannon(deg+(deg-odeg),rng+(rng-orng)*2);
}
