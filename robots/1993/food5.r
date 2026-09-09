/* --------------------------------------------------------------------
							  << food5.r >>
	by
	Ugolini Oscar 

	Ho 20 anni e frequento il terzo anno del corso di laurea in
	scienze dell'informazione all'università di bologna.
-------------------------------------------------------------------- */

int dir,rang,prec,step,idir,fdir,tp,dam;

main()
{
	dam=damage();
	prec=9;step=18;idir=270;fdir=0;dir=idir;tp=180;
	while(dam==damage()) spara();                   /* spara da fermo */
	drive(0,100);
	rang=1;while(rang>0 && loc_x()<920) {
		rang=scan(0,10);                            /* spara avanti */
		if (rang>20) cannon(0,rang-15); 
	}
	rang=1;while(rang>0 && loc_x()<920) {
		rang=scan(180,10);                          /* spara dietro */
		if (rang>30) cannon(180,rang-25); 
	}
	while(loc_x()<920) spara();                     /* spara a 180 */
	drive(0,0);while(speed()>48) spara();           /* curva a 90 gradi */
	drive(270,100);
	while(1) {
		idir=90;fdir=0;
		rang=1;while(rang>0 && loc_y()>80) {
			rang=scan(270,10);                      /* spara avanti */
			if (rang>20) cannon(270,rang-15); 
		}
		rang=1;while(rang>0 && loc_y()>80) {
			rang=scan(idir,10);                     /* spara dietro */
			if (rang>30) cannon(idir,rang-25); 
		}
		while(loc_y()>80) spara();                  /* spara a 180 */
		dam=damage();drive(270,0);tp=90;
		while(dam==damage()) spara();               /* spara a 90 */
		tp=180;while(speed()>48) spara();
		drive(180,100);idir=0;fdir=0;
		rang=1;while(rang>0 && loc_x()>80) {
			rang=scan(0,10);                        /* spara avanti */
			if (rang>20) cannon(180,rang-15); 
		}
		rang=1;while(rang>0 && loc_x()>80) {
			rang=scan(idir,10);                     /* spara dietro */
			if (rang>30) cannon(idir,rang-25); 
		}
		while(loc_x()>80) spara();                  /* spara a 180 */
		dam=damage();drive(180,0);tp=90;
		while(dam==damage()) spara();               /* spara a 90 */
		tp=180;while(speed()>48) spara();
		drive(90,100);idir=270;fdir=0;
		rang=1;while(rang>0 && loc_y()<920) {
			rang=scan(270,10);                      /* spara avanti */
			if (rang>20) cannon(90,rang-15); 
		}
		rang=1;while(rang>0 && loc_y()<920) {
			rang=scan(idir,10);                     /* spara dietro */
			if (rang>30) cannon(idir,rang-25); 
		}
		while(loc_y()<920) spara();                 /* spara a 180 */
		dam=damage();drive(90,0);tp=90;
		while(dam==damage()) spara();               /* spara a 90 */
		tp=180;while(speed()>48) spara();
		drive(0,100);idir=180;fdir=0;
		rang=1;while(rang>0 && loc_x()<920) {
			rang=scan(idir,10);                     /* spara avanti */
			if (rang>20) cannon(0,rang-15); 
		}
		rang=1;while(rang>0 && loc_x()<920) {
			rang=scan(idir,10);                     /* spara dietro */
			if (rang>30) cannon(idir,rang-25); 
		}
		while(loc_x()<920) spara();                 /* spara a 180 */
		dam=damage();drive(0,0);tp=90;
		while(dam==damage()) spara();               /* spara a 90 */
		tp=180;while(speed()>48) spara();
		drive(270,100);
	}
}

spara()
{
	rang=scan(dir,prec);
	if (rang>40 && rang<800) { 
		cannon(dir,rang);
		if (rang<50) {
			step=10;prec=4;
		} else if (rang<100) {                  /* corregge lo step */
			step=12;prec=6;                     /* e la precisione  */
		} else if (rang<300) {
			step=14;prec=7;
		} else if (rang<500) {
			step=16;prec=8;
		} else {
			step=18;prec=9;                     
		}
		dir=dir-45;if (dir<idir) { dir=idir;fdir=0; } else fdir=dir-idir;
	} else {
		if (rang>=800) { step=18;prec=9; }
		dir+=step;fdir+=step;
		if (fdir>tp) {                              /* azzera variabili */
			fdir=0;dir=idir;step=12;prec=6;     
		}
	}    
}
