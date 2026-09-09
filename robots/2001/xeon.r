/*
+ --------------------------------------------------------------------------- +
+                                                                             +
+  Torneo di CRobots 2001                                                     +
+                                                                             +
+  CROBOT: XEON.R                                                             +
+                                                                             +
+  AUTORE: Lorenzi Davide                                                     +
+                                                                             +
+ --------------------------------------------------------------------------- +

 SCHEDA TECNICA:

 Questo robot e' una mediocre imitazione del vincitore dell'anno scorso dal quale
 ho ripreso delle idee per la routine di oscillazione e di sparo.
 E' comunque ben distante dalla vetta della classifica :-(
 
 Scusatemi per la scarsa combattivita' dei robottini che ho inviato quest'anno
 ma proprio non ho avuto tempo...

 I miei piu' sentiti ringraziamenti agli organizzatori, agli amici della
 mailing list ed ai creatori dei crobots da cui ho preso parti di codice.

 Buon combattimento a tutti!
-------------------------------------------------------------------------------
*/

int rng,deg;
int orng,odeg;
int dir,dir45,edir,edir1,edir2;
int ne;

int danni;
int i,k;
int c2;
int x,y,sx,dw;
int timeuntil;


oscilla()
{
	while(speed()<20) drive(dir45,100);
	f2(f1(f2(f1(drive(dir45,100)))));

	while(speed()>50) f2(drive(dir45,0));
	drive(dir45+180,100); /*Cosi' torna indietro prima*/
	dir=ang(x,y);

	while(dist(x,y)>5200) f2(drive(dir,100));
	drive(dir45,0);
	while(speed()>50) f1();
}

lat()
{
	if (libero(dir=edir)) {ce();dir=edir;}

	/* attacco */
	while(speed()<20) drive(dir,100);

	f2(drive(dir,100));
	i=10; while(--i) f2();
	while(dist(x,y)<60000) f2();
	while(speed()>60) f0(drive(dir,50));

	dir+=180;
	
	/* ritorno alla base */
	while(speed()<100) f1(drive(dir,100));
	f1(f1(f1()));
	while(dist(x,y)>5200) f2(drive(dir,100));

	drive(dir+180,0);
	while(speed()>50) f2();
}

/* rende vero se il dato angolo e' libero */
libero (gradi)
{
    return (!scan(gradi+350,10) && !scan(gradi+10,10));
}


/* Cambia l'avversario puntato correntemente */
ce() {
	if (edir==edir1)
		deg=(edir=edir2)-10;
	else 
		deg=(edir=edir1)+10;
}


main()
{
	vai (x=980-960*(sx=(loc_x()<500)),y=980-960*(dw=(loc_y()<500)));
    if (numEnemy()<2)
        if (numEnemy()<2)
            attacco();

	dir45=225+180*dw+90*(sx^dw);
	edir1=dir45+35;
	edir2=dir45-35;
	deg=(edir=edir1);

    ne=3; c2=2; timeuntil=1; k=0;
    while (oscilla(oscilla(danni=damage()))) {
		if (orng>1000) {
			if (ne>1) ce();
		}
		else {
			if (orng>750) {
				if (ne>1 && (danni<80 || k>15)) lat(k=0);
			}
			if (damage()>danni+8) ce();
			else if (danni=damage()) ++k;
		}


		if ((!scan(edir1,10)) || (!scan(edir2,10))) {
			if (damage()<91) {
			    if (--timeuntil<1) {
		            if ((timeuntil=numEnemy())<2) {
						if (!--c2) attacco ();
					}
			    }
			}
			else {
				while(oscilla());
			}
		}
    }        
}

vai (x,y)
{
    dir=ang (x,y);
    drive (dir,100);
    while (dist(x,y)>22500) f0(drive (dir,100));
    while (dist(x,y)>1600) {drive (dir,100);}
    drive (dir,0);
}

/* Angolo per andare in una certa direzione */
ang(x,y) { return (180+((x-=(loc_x()))>0)*180+atan(((y-loc_y())*100000)/x)); }

/* Calcola la distanza rispetto ad un punto dato */
dist(x,y) { return (((x-=loc_x())*x+(y-=loc_y())*y)); }


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
	while(speed()>0) f0(drive(dir,0));
    vai(500,500);
    drive(dir,0);
	while(speed()>0) f0();

    while(1) {
	    dir=100;
		while (loc_y()<500) f0(drive(dir,100));
	    dir=280;
		while (loc_y()>=500) f0(drive(dir,100));
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
    if (orng<250) {cannon(deg,orng); return;}

    if (!scan(deg+=355,5)) deg+=10;
	if (!scan(deg+=357,3)) deg+=6;
    cannon(deg,2*scan(deg,5)-orng); return;
}


f0 ()
{
    /* cerca un nemico */
    if (orng=scan(deg,10));
    else if (orng=scan(deg-=21,10));
    else if (orng=scan(deg+=42,10));
    else {deg+=42; return;}

    /* se e` vicino spara immediatamente */
    if (orng<250) {cannon(deg,orng); return;}

	odeg=deg;
	if (scan(deg+=5,5)); else deg-=10;
	if (scan(deg+=3,3)); else deg-=6;
	if (rng=scan(deg,10))
		cannon(deg+(deg-odeg),rng+(rng-orng)*2);
}
