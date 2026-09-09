/*
		T r a k e r
  		  ver. 2

	di
		Antonio Gallo

TATTICA:
	L'autore di !.r diceva che il suo robot era invincibile.
	Tracker e' il frutto di 2 giorni (gli unici che purtroppo ho
	potuto dedicare a cRobots durante tutta l'estate) per dimostrare
	il contrario.

	TRAKER2 si muove sulle diagonali cercando di colpire !.r nell'angolo.
	In combattimenti a due (TRACKER2 contro !), tracker ha la meglio nel
	60% dei casi.

	TRACKER2, a differenza di TRACKER1, si butta addosso al nemico, con
	movimento a zig-zag, quando i danni superano il 70%

	TRACKER2 non ha paura dei robot basati su !.r
	TRACKER2 ha molta paura dei robor che si muovono lungo i bordi.
*/

/* Dichiarezione variabili*/
int dir, ang, dx, dy;
int range,orange,i,lato, D;
int r, nrg;
int dam;

main()
{
  /* Inizializza variabili */
  ang=360;
  dam = 0;	  
  dx  = 1;
  dy  = 1;
  /* Inizializza il movimento */
  change();
  /* Inizio ciclo di vita */
  while(1) {
    if (loc_y()<150) {
      dy=1;      
      change();
    } else {
      if (loc_y()>850) {
        dy=-1;	
        change();
      }
    }
    if (loc_x()<150) {
      dx=1;
      change();
    } else {
      if (loc_x()>850) {
        dx=-1;
	change();
      }
    }

    /* Cerca il bersaglio *(/
    track();

    /* Controlla se siamo stati colpiti */
    if (dam != damage() ) {

      /* Se i danni si fanno gravi allora: BANZAI ! */
      if ( damage() > 70 ) { 
        cantor(); 
      }

      /* altrimenti prova ad evitare altri colpi */      
      dam=damage();
      dir = dir + ( rand(90)-45 );
    }
    drive( dir, 100);
  }  
}

/* 
	CHANGE:
	Effettua un cambio di direzione se ci stiamo 
	avvicinando troppo al bordo del campo 
*/
change()
{
  if (dx==1) {
    if (dy==1) dir=45;
    else
    if (dy==-1) dir=315;
    else
    dir=0;
  } else {
    if (dx==-1) {
      if (dy==1) dir=135;
      else
      if (dy==-1) dir=225;
      else
      dir=180;
    } else {
      if (dy==1) dir=90;
      else
      if (dy==-1) dir=270;
    }
  }
}

/* 
	TRACK : 
	Cerca un bersaglio e spara
	La routine e stata presa da !.r (se ricordo bene)
*/
track()
{
  if (!(nrg=scan(ang,10))) 
    while (!(nrg=scan(ang+=20,10)));
  if (!scan(ang+=5,5)) ang-=10;
  if (!scan(ang+=3,3)) ang-=6;
  if (r=scan(ang,10)) {
    cannon(ang,r+r-nrg);
    ang-=40;
  };
}

/*
	CANTOR:
	Effettua il banzai (va addosso al nemico con movimento a zigzag)
	(presa da un'altro robot)
*/
cantor() 
{
 drive(D=270,100);
 lato=0;                         
 while(loc_y()>100) shoot();
 drive(D,50);
 while(loc_y()>20);              
 drive(D,20);
 while(loc_y()>1);

 while(1) {
  if (lato==0) {
    D=360;
    drive(D,100);
    while(loc_x()<900) 
      shoot();
    drive(D,50);
    while(loc_x()<990);
    drive(D,10);
    while(loc_x()<998);
    if((range=scan(D+180,10))==0) 
      lato=1; 
    else {
      D=180;
      drive(D,100);
      while(loc_x()>100)
        shoot();
      drive(D,0);
      while(speed()>49);
    }
  }
  if (lato==1) {D=90;
		drive(D,100);
		while(loc_y()<900) shoot();
		drive(D,50);
		while(loc_y()<990);
		drive(D,10);
		while(loc_y()<998);
		if((range=scan(D+180,10))==0) lato=2;
		  else {D=270;
			drive(D,100);
			while(loc_y()>100) shoot();
			drive(D,0);
			while(speed()>49);
		       }
		}

  if (lato==2) {D=180;
		drive(D,100);
		while(loc_x()>100) shoot();
		drive(D,50);
		while(loc_x()>10);
		drive(D,10);
		while(loc_x()>1);
		if((range=scan(D+181,10))==0) lato=3;
		  else {D=0;
			drive(D,100);
			while(loc_x()<990) shoot();
			drive(D,0);
			while(speed()>49);
		       }
		}

  if (lato==3) {D=270;
		drive(D,100);
		while(loc_y()>100) shoot();
		drive(D,50);
		while(loc_y()>10);
		drive(D,10);
		while(loc_y()>1);
		if((range=scan(D+180,10))==0) lato=0;
		  else {D=90;
			drive(D,100);
			while(loc_y()<990) shoot();
			drive(D,0);
			while(speed() > 49);
		       }
		}
 }
}

/*
	Shoot:
	Routine di tiro usata da cantor()
*/
shoot()
{
  drive(D,100);
  if((range=scan(D+180,10))>0) {
    dir=D+180;orange+=30;
  } else {
    if ((range=scan(D,10))>0) {
      dir=D;
      orange-=30;
  } else 
    if((range=scan(dir,10))==0) {
      dir+=20;
      return;
    }
  }
  cannon(dir,(695+(range>orange)*240)*range/800);
  orange=range;
}
