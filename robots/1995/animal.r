/* Animal v. 1.00 */
/*   18-03-1995   */
/*
Autore: Lorenzo Ancarani
*/
/* E' una modifica del crobot americano SECRO. */
/* Ho aumentato l'offensivita' del crobot ...  */
/* o vince prima o muore prima! La tattica e'  */
/* la medesima: si guarda intorno, trova un    */
/* bersaglio e lo segue facendo fuoco tenendo  */
/* conto di eventuali correzioni al range e    */
/* all'angolo di gittata. Se viene colpito     */
/* cambia direzione di 90 gradi. Ho lievemente */
/* modificato (spero in meglio) l'angolo di    */
/* gittata e l'algoritmo che tiene il crobot   */
/* lontano dai muri. Non ho avuto tempo        */
/* (causa studi universitari) di rielaborarlo  */
/* ulteriormente, cosa che faro' per l'anno    */
/* successivo.                                 */

main()
{
 int range,orang,ang,oang,misf,dir,dam;

 ang=40;
 dir=0;
 while(1)
    {
     /* si guarda intorno */
     while(!(range=scan(ang,10)))
       {
	if (!speed()) dir=gira(dir,muri(dir));
	if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else if((range=scan(ang += 20,10))) ;
	else ang += 20;
       }

     /* fuoco */
     misf=cannon(ang,range);
     dam = damage();

     if (range>680) /* fuori range */
       {
	dir=gira(dir,muri(ang -= 10));
       }
     else  /* in range */
       {
	/* primo aggiustamento */
	if((orang=scan(ang,2)))             ;
	else if((orang=scan(ang -= 4,2)))   ;
	else if((orang=scan(ang += 8,2)))   ;
	else if((orang=scan(ang -= 12,2)))  ;
	else if((orang=scan(ang += 16,2)))  ;
	else if((orang=scan(ang -= 20,2)))  ;
	else if((orang=scan(ang += 24,2)))  ;
	else if((orang=scan(ang -= 28,2)))  ;
	else if((orang=scan(ang += 32,2)))  ;
	else if((orang=scan(ang -= 42,10))) ;
	else if((orang=scan(ang += 52,10))) ;

	/* secondo aggiustamento */
	drive(dir,0);
	if((range=scan(ang,2)))             ;        /*    0    -2 to   2  */
	else if((range=scan(ang -= 4,2)))   ;        /*   -4    -6 to  -2  */
	else if((range=scan(ang += 8,2)))   ;        /*    4     2 to   6  */
	else if((range=scan(ang -= 12,2)))  ;        /*   -8   -10 to  -6  */
	else if((range=scan(ang += 16,2)))  ;        /*    8     6 to  10  */
	else if((range=scan(ang -= 20,2)))  ;        /*  -12   -14 to -10  */
	else if((range=scan(ang += 24,2)))  ;        /*   12    10 to  14  */
	else if((range=scan(ang -= 28,2)))  ;        /*  -16   -18 to -14  */
	else if((range=scan(ang += 32,2)))  ;        /*   16    14 to  18  */
	else if((range=scan(ang -= 42,10))) ;        /*  -26   -36 to -16  */
	else if((range=scan(ang += 52,10))) ;        /*   26    16 to  36  */

	/* fire */
	if (range && orang)
	 if (range<100)
	  misf=cannon(ang+(ang-oang),range);
	 else
	  misf=cannon(ang+(ang-oang)*range/275,
		range+(range-orang)*range/300)+(speed()*cos(ang-dir)/100000);

	/* gira */
	if (dam != damage())
	    dir=gira(dir,muri(dir+90));
	else if (range<100)
	    dir=gira(dir,muri(ang+185));
	else if (range>450)
	    dir=gira(dir,muri(ang));
	else /* >100-<450 */
	    dir=gira(dir,muri(ang-(450-range)/3));

	/* sighting 3 */
	orang = range;
	oang = ang;
	if((range=scan(ang,2)))             ;
	else if((range=scan(ang -= 4,2)))   ;
	else if((range=scan(ang += 8,2)))   ;
	else if((range=scan(ang -= 12,2)))  ;
	else if((range=scan(ang += 16,2)))  ;
	else if((range=scan(ang -= 20,2)))  ;
	else if((range=scan(ang += 24,2)))  ;
	else if((range=scan(ang -= 28,2)))  ;
	else if((range=scan(ang += 32,2)))  ;
	else if((range=scan(ang -= 42,10))) ;
	else if((range=scan(ang += 52,10))) ;

	/* fire */
	if (range && orang)
	 if (range<100)
	   misf=cannon(ang+(ang-oang),range);
	 else
	  misf=cannon(ang+(ang-oang)*range/275, 
	  /* l'angolo e' ora in funzione anche del range */
		range+(range-orang)*range/300)+(speed()*cos(ang-dir)/100000);

	if (!speed()) dir=gira(dir,muri(dir));
       }
    }
}

/* nuova direzione */
gira (dir,newdir)
int dir,newdir;
{
 if (dir==newdir && speed()) return(dir);
 /* restituisce la vecchia e immutata direzione */
 if (speed()>49)
    {
     drive(dir,0);
     while (speed()>49);
    }
 drive(newdir,49);
 drive(newdir,100);
 return(newdir); /* restituisce la nuova direzione */
}

/* occhio ai muri */
muri (dir)
int dir;
{
 if (loc_x()<100)
       return(0);

 if (loc_x()>900)
       return(180);

 if (loc_y()<100)
       return(90);

 if (loc_y()>900)
       return(270);

 return(dir);
}
