/*
	- fastfood.r        by Ugolini Oscar 1994 -
	-------------------------------------------

	Ugolini Oscar

*/

int dir,rang,dam,idir,pran,pdir,no,rang1;

main()
{
	if (loc_y()<500) {
		drive(270,100);pran=1500;
		idir=540;dir=540;pdir=270;no=0;
		while(loc_y()>60) spara3();
		drive(270,0);while(speed()>49) spara();
		drive(180,100);
	} else {
		drive(90,100);pran=1500;
		idir=540;dir=540;pdir=90;no=2;
		while(loc_y()<940) spara3();
		drive(90,0);while(speed()>49) spara();
		drive(0,100);
	}
	while(1) {
		if (!no) {
		idir=540;while(loc_x()>60) spara();                  
		drive(180,0);while(speed()>49) spara2();
		aspetta();                    
		} else --no;

		if (!no) {
		idir=450;while(loc_y()<940) spara();                 
		drive(90,0);while(speed()>49) spara2();
		aspetta();         
		} else --no;

		if (!no) {
		idir=360;while(loc_x()<940) spara();                  
		drive(0,0);while(speed()>49) spara2();
		aspetta();                  
		} else --no;

		if (!no) {
		idir=630;while(loc_y()>60) spara();
		drive(270,0);while(speed()>49) spara2();
		aspetta();         
		} else --no;
	}
}

spara()
{
	if (rang=scan(dir,10)) {
		if (rang1=scan(dir-11,10)) {
			cannon(dir-11,rang1);
			dir-=11;
		} else {
			if (rang1=scan(dir+11,10)) {
				cannon(dir+11,rang1);
			} else if (rang>60) cannon(dir,rang-20);
		}
		pran=rang+100;
	} else {
		dir-=20;if (dir<idir-180) dir=idir;
	}
}
 
spara2()
{
	rang=scan(dir,10);
	if (rang && rang<pran) {
		if (rang1=scan(dir-12,10)) {
			cannon(dir-12,rang1);
			dir-=2;
		} else {
			if (rang1=scan(dir+12,10)) {
				cannon(dir+12,rang1);
				dir+=32;
			} else cannon(dir,rang);
		}
		pran=rang+50;
	} else {
		dir-=20;if (dir<idir-180) { dir=idir-90;pran=1500; }
	}
}

spara3()
{
	if (rang=scan(dir,10)) {
		cannon(dir+10,rang);pran=rang+100;
		dir+=70;if (!speed()) drive(pdir,100);
	} else {
		dir-=20;if (dir<idir-360) dir=idir;
	}
}

aspetta()
{
	if (pran>500) {
		if (rang=scan(idir-90,5)) cambiadir();
		dam=damage();while(dam==damage()) spara2();
		drive(idir-90,100);
	} else {
		drive(idir-90,100);
		dir+=40;if (dir>idir) dir=idir;
	}
}

cambiadir()
{
	pdir=idir-135;drive(pdir,100);
	if (idir==360) {
		while(loc_x()>60 && loc_y()>60) spara3();                  
	} else if (idir==450) {
		while(loc_x()<940 && loc_y()>60) spara3();                  
	} else if (idir==540) {
		while(loc_x()<940 && loc_y()>940) spara3();                  
	} else {
		while(loc_x()>60 && loc_y()<940) spara3();                  
	}
	drive(pdir,0);no=2;pran=1500;while(speed()>49) spara3();
	idir+=180;
}
