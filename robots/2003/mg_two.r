/*
   MM  MM  GGGGGG       TTTTTT  W WW W  000000
   MM  MM  G              TT    W WW W  0    0
   M MM M  G  GGG         TT    W WW W  0    0
   M    M  G    G         TT    W WW W  O    0
   M    M  GGGGGG _______ TT    WWWWWW  OOOOOO


   CROBOTS: MG_Two.r 

   Programmatore: Marco Garbujo

   Questa è l'evoluzione di MG_One, il mio primo Crobot.
   Nuovo robot, nuova strategia
   Una volta selezionato l'angolo più vicino, vado su e giù lungo il lato scelto
   scannando l'interno dell'arena.


   Story of my CRobots:
   15-10-2003: 	Partenza dalla versione MG_One
		Cambio tattita, mi sposto nell'angolo più vicino e vado su e giu in verticale
   22-10-2003:  Aggiunto loop per eseguire lo scan all'interno con incremento di 20 gradi
		ad ogni ciclo.
*/


int speed;
int dirclock;  /* gira in senso orario o antiorario */
int dirangle;
int danni;
int lastrange;

main()
{
  danni=0;
  lastrange=87;

  /* controlla l'angolo pi— vicino */
  resetpos();

  /*go round the square*/
  while (1) {
       	if (dirangle==1) {
	 	goY(10,950,0);
	 	dirangle=2;
       	} 
       
       	if (dirangle==2) {
	   	goY(10,50,0);
	   	dirangle=1;
	}

	if (dirangle==3) {
		goY(990,50,1);
	       	dirangle=4;
	}
	
	if (dirangle==4) {
	       	goY(990,950,1);
	       	dirangle=3;
	}
  }


}  /* end of main */


/* Sposta il robot nell'angolo pi— vicino */
resetpos() {
  int d_ang1;
  int d_ang2;
  int d_ang3;
  int d_ang4;

  d_ang1 = distance(loc_x(),loc_y(),20,20);
  d_ang2 = distance(loc_x(),loc_y(),20,980);
  d_ang3 = distance(loc_x(),loc_y(),980,980);
  d_ang4 = distance(loc_x(),loc_y(),980,20);

  dirclock=1;

  /* controlla l'angolo pi— vicino */
  if (d_ang1<=d_ang2 && d_ang1<=d_ang3 && d_ang1<=d_ang4) {
     /*Angolo in basso a sinistra*/
     cannon(315,20);
     go(20,20,135,90);
     dirangle=1;
     cannon(225,20);
  } else {
     if (d_ang2<=d_ang1 && d_ang2<=d_ang3 && d_ang2<=d_ang4) {
        /*Angolo in alto a sinistra*/
	cannon(225,20);
	go(20,980,45,0);
	dirangle=2;
	cannon(135,20);
     } else {
       if (d_ang3<=d_ang1 && d_ang3<=d_ang2 && d_ang3<=d_ang4) {
          /*Angolo in alto a destra*/
	  cannon(135,20);
	  go(980,980,315,270);
	  dirangle=3;
	  cannon(45,20);
       } else {
	  if (d_ang4<=d_ang1 && d_ang4<=d_ang2 && d_ang4<=d_ang3) {
             /*Angolo in basso a destra*/
	     cannon(45,20);
	     go(980,20,225,180);
	     dirangle=4;
	     cannon(315,20);
	  }
       }
    }
  }
}



/* go - go to the point specified
dest_x: Coordinata nell'asse x di arrivo
dest_y: Coordinata nell'asse y di arrivo
scan1:  Direzione di scansione 1
scan2:  Direzione di scansione 2
*/
go (dest_x, dest_y, scan1, scan2)
int dest_x, dest_y, scan1, scan2;
{
  int course;
  int range;

  course = plot_course(dest_x,dest_y);
  drive(course,87);
  while(distance(loc_x(),loc_y(),dest_x,dest_y) > 50) {

    if ((range=scan(scan1,2)) > 0 && range <= 700)  {
       cannon(scan1,range);
       lastrange=range;
    }

    if ((range=scan(scan2,2)) > 0 && range <= 700)  {
       cannon(scan2,range);
       lastrange=range;
    }
  }

  drive(course,0);
  while (speed() > 0)
    ;
}




goY (dest_x, dest_y, bDx)
int dest_x, dest_y, bDx;
{
  int course;
  int range;
  int posY;
  int degreescan;
  int nmargine;

  if (dest_y<60) {
	nmargine=1;
  } else {
	nmargine=-1;
  }

  posY=loc_y();
  while((posY>dest_y && dest_y<60) || (posY<dest_y && dest_y>940)) {
    course = plot_course(dest_x,dest_y);
    drive(course,40);

    /*Lato destro*/
    if (bDx==1) {
	
	degreescan=70;
	while(degreescan<=270) {
		degreescan=degreescan+20;	
 	   	if ((range=scan(degreescan,5)) > 0 && range <= 700 && range >= 15)  {
       			cannon(degreescan+nmargine,range);	
    		}
	}

    } else {

	degreescan=250;
	while(degreescan<=330) {
		degreescan=degreescan+20;	
 	   	if ((range=scan(degreescan,5)) > 0 && range <= 700 && range >= 15)  {
       			cannon(degreescan+nmargine,range);	
    		}
		if (degreescan==350) degreescan=10;
		if (degreescan==90) degreescan=350;
	}

    }


    posY=loc_y();
  }

  drive(course,0);
  while (speed() > 0)
    ;
}

/* distance formula */

distance(x1,y1,x2,y2)
int x1;
int y1;
int x2;
int y2;
{
  int x, y;

  x = x1 - x2;
  y = y1 - y2;
  d = sqrt((x*x) + (y*y));

  return(d);
}

/* plot_course - figure out which heading to go */

plot_course(xx,yy)
int xx, yy;
{
  int d;
  int x,y;
  int scale;
  int curx, cury;

  scale = 100000;  /* scale for trig functions */

  curx = loc_x();
  cury = loc_y();
  x = curx - xx;
  y = cury - yy;

  if (x == 0) {
    if (yy > cury)
      d = 90;
    else
      d = 270;
  } else {
    if (yy < cury) {
      if (xx > curx)
	    d = 360 + atan((scale * y) / x);
      else
	    d = 180 + atan((scale * y) / x);
    } else {
      if (xx > curx)
	    d = atan((scale * y) / x);
      else
	    d = 180 + atan((scale * y) / x);
    }
  }
  return (d);
}



/* end of MG_Two.r */
