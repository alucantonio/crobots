/***************************************************************************/
/* SEcro.r by SEmrick.			   A big, fast, and hungry crobot. */
/* 1. Scan until target found, take a pot-shot, check damage.		   */
/* 2. If out of range, pursue.						   */
/* 3. If in range,							   */
/*	calcululate lead factors, fire, change direction, calculate lead,  */
/*	fire, check damage						   */
/***************************************************************************/
main()
{
 int range,orang,ang,oang,dir,dam,misf;

 ang=40;
 dir=0;
 while(1)
    {
     /* look for a target */
     while(!(range=scan(ang,10)))
       {
	if (!speed()) dir=walls(dir);		    /* offset  scan range */
	if((range=scan(ang += 20,10))) ;	    /*	 20    10 to  30  */
	else if((range=scan(ang += 20,10))) ;	    /*	 40    30 to  50  */
	else if((range=scan(ang += 20,10))) ;	    /*	 60    50 to  70  */
	else if((range=scan(ang += 20,10))) ;	    /*	 80    70 to  90  */
	else if((range=scan(ang += 20,10))) ;	    /*	100    90 to 110  */
	else if((range=scan(ang += 20,10))) ;	    /*	120    90 to 110  */
	else if((range=scan(ang += 20,10))) ;	    /*	140    90 to 110  */
	else if((range=scan(ang += 20,10))) ;	    /*	160    90 to 110  */
	else ang += 20;
       }  /* end while */

     /* fire */
     misf=cannon(ang,range);
     dam = damage();

     if (range>680) /* out of range */
       {
	dir=turn(dir,ang -= 10);
	if (!speed()) dir=walls(dir);
       } /* end if */
     else  /* in range */
       {
	/* sighting 1 */
	if((orang=scan(ang,2))) 	    ;	     /*    0	-2 to	2  */
	else if((orang=scan(ang -= 4,2)))   ;	     /*   -4	-6 to  -2  */
	else if((orang=scan(ang += 8,2)))   ;	     /*    4	 2 to	6  */
	else if((orang=scan(ang -= 12,2)))  ;	     /*   -8   -10 to  -6  */
	else if((orang=scan(ang += 16,2)))  ;	     /*    8	 6 to  10  */
	else if((orang=scan(ang -= 20,2)))  ;	     /*  -12   -14 to -10  */
	else if((orang=scan(ang += 24,2)))  ;	     /*   12	10 to  14  */
	else if((orang=scan(ang -= 28,2)))  ;	     /*  -16   -18 to -14  */
	else if((orang=scan(ang += 32,2)))  ;	     /*   16	14 to  18  */
	else if((orang=scan(ang -= 42,10))) ;	     /*  -26   -36 to -16  */
	else if((orang=scan(ang += 52,10))) ;	     /*   26	16 to  36  */

	/* sighting 2 */
	drive(dir,0);
	if((range=scan(ang,2))) 	    ;	     /*    0	-2 to	2  */
	else if((range=scan(ang -= 4,2)))   ;	     /*   -4	-6 to  -2  */
	else if((range=scan(ang += 8,2)))   ;	     /*    4	 2 to	6  */
	else if((range=scan(ang -= 12,2)))  ;	     /*   -8   -10 to  -6  */
	else if((range=scan(ang += 16,2)))  ;	     /*    8	 6 to  10  */
	else if((range=scan(ang -= 20,2)))  ;	     /*  -12   -14 to -10  */
	else if((range=scan(ang += 24,2)))  ;	     /*   12	10 to  14  */
	else if((range=scan(ang -= 28,2)))  ;	     /*  -16   -18 to -14  */
	else if((range=scan(ang += 32,2)))  ;	     /*   16	14 to  18  */
	else if((range=scan(ang -= 42,10))) ;	     /*  -26   -36 to -16  */
	else if((range=scan(ang += 52,10))) ;	     /*   26	16 to  36  */

	/* fire */
	if (range && orang)
	 if (range<100)
	  misf=cannon(ang+(ang-oang),range);
	 else
	  misf=cannon(ang+(ang-oang),range+(range-orang)*range/300)+(speed()*cos(ang-dir)/100000);

	/* turn */
	if (dam != damage())
	    dir=turn(dir,dir+90);
	else if (range<180)
	    dir=turn(dir,ang+185);
	else if (range>450)
	    dir=turn(dir,ang);
	else /* >180-<450 */
	    dir=turn(dir,ang-(450-range)/3);

	/* sighting 3 */
	orang = range;
	oang = ang;
	if((range=scan(ang,2))) 	    ;	     /*    0	-2 to	2  */
	else if((range=scan(ang -= 4,2)))   ;	     /*   -4	-6 to  -2  */
	else if((range=scan(ang += 8,2)))   ;	     /*    4	 2 to	6  */
	else if((range=scan(ang -= 12,2)))  ;	     /*   -8   -10 to  -6  */
	else if((range=scan(ang += 16,2)))  ;	     /*    8	 6 to  10  */
	else if((range=scan(ang -= 20,2)))  ;	     /*  -12   -14 to -10  */
	else if((range=scan(ang += 24,2)))  ;	     /*   12	10 to  14  */
	else if((range=scan(ang -= 28,2)))  ;	     /*  -16   -18 to -14  */
	else if((range=scan(ang += 32,2)))  ;	     /*   16	14 to  18  */
	else if((range=scan(ang -= 42,10))) ;	     /*  -26   -36 to -16  */
	else if((range=scan(ang += 52,10))) ;	     /*   26	16 to  36  */

	/* fire */
	if (range && orang)
	 if (range<100)
	   misf=cannon(ang+(ang-oang),range);
	 else
	  misf=cannon(ang+(ang-oang),range+(range-orang)*range/300)+(speed()*cos(ang-dir)/100000);

	if (!speed()) dir=walls(dir);
       } /* end else in range */
    } /* end while(1) */
} /* end prog */

/* turn to new course */
turn (dir,newdir)
int dir,newdir;
{
 if (dir==newdir && speed()) return(dir);
 /* get down to turning speed */
 if (speed()>49)
    {
     drive(dir,0);
     while (speed()>49)
	    ;
    }
 /* turn and pour on the gas */
 drive(newdir,49);
 drive(newdir,100);
 return(newdir);
}

/*  don't hit the walls   */
/* (at least bounce nice) */
walls (dir)
int dir;
{
 if (loc_x()<150)
     while (loc_x()<150)
       dir=turn(dir,0);

 if (loc_x()>850)
     while (loc_x()>850)
       dir=turn(dir,180);

 if (loc_y()<150)
     while (loc_y()<150)
       dir=turn(dir,90);

 if (loc_y()>850)
     while (loc_y()>850)
       dir=turn(dir,270);

 return(dir);
}
                                                        