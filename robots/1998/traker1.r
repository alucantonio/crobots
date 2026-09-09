/*
		T r a k e r
  		  ver. 1

	di
		Antonio Gallo

TATTICA:
	L'autore di !.r diceva che il suo robot era invincibile.
	Tracker e' il frutto di 2 giorni (gli unici che purtroppo ho
	potuto dedicare a cRobots durante tutta l'estate) per dimostrare
	il contrario.

	TRACKER1 si muove sulle diagonali cercando di colpire !.r nell'angolo.
	In combattimenti a due (TRACKER1 contro !), tracker ha la meglio nel
	60% dei casi.

	TRACKER non ha paura dei robot basati su !.r
	TRACKER ha molta paura dei robor che si muovono lungo i bordi.
*/

/* Dichiarezione variabili*/
int dir, dx, dy, an1, an2, ap;
int deg, rng, r, dam;

main()
{
  /* Inizializziazione variabili */
  dam = 0;
  deg = 0;
  rng=0;
  r=0;
  an1 = 0;
  an2 = 0;
  ap  = 10;
  dx  = 1;
  dy  = 1;

  /* Inizializziazione direzione di movimento */
  change();

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

    /* Cerca il bersaglio */
    track();

    /* Se viene colpito cambia leggermente direzione */
    if (dam != damage() ) {
      dam=damage();
      dir = dir + ( rand(90)-45 );
    }

    drive(dir,100);
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
  if (!(rng=scan(deg,10))) 
    while (!(rng=scan(deg+=20,10)));
  if (!scan(deg+=5,5)) deg-=10;
  if (!scan(deg+=3,3)) deg-=6;
  if (r=scan(deg,10)) { 
    cannon(deg,r+r-rng); 
    deg-=40; 
  };

}
