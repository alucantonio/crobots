/* CROBOTS: MG_One.r */
/* Programmer: Marco Garbujo */
/* It's my first robot (it's not the max) */
/* I'll use this robot to run around the square and destroy anything inside*/
/*
   Story of my CRobots:
   10-09-2002: Prima versione
   20-09-2002: Corretto bug di bloccaggio in un angolo
	       Portata la distanza dal bordo a 20
	       Portata la velocit… a 90%
	       Aggiunto scanner e cannone verso l'interno
	       Portata la velocit… a 87%
   30-09-2002: Corretto bug scansione angolare
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
    if (dirclock==1) {
       if (dirangle==1) {
	 goY(20,980,45,0,315);
	 dirangle=2;
       } else {
	 if (dirangle==2) {
	   goX(980,980,315,270,225);
	   dirangle=3;
	 } else {
	    if (dirangle==3) {
	       goY(980,20,225,180,135);
	       dirangle=4;
	    } else {
	       goX(20,20,135,90,45);
	       dirangle=1;
	    }
	 }
       }
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
     cannon(315,20);
     go(20,20,135,90);
     dirangle=1;
     cannon(225,20);
  } else {
     if (d_ang2<=d_ang1 && d_ang2<=d_ang3 && d_ang2<=d_ang4) {
	cannon(225,20);
	go(20,980,45,0);
	dirangle=2;
	cannon(135,20);
     } else {
       if (d_ang3<=d_ang1 && d_ang3<=d_ang2 && d_ang3<=d_ang4) {
	  cannon(135,20);
	  go(980,980,315,270);
	  dirangle=3;
	  cannon(45,20);
       } else {
	  if (d_ang4<=d_ang1 && d_ang4<=d_ang2 && d_ang4<=d_ang3) {
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


goX (dest_x, dest_y, scan1, scan2, scan3)
int dest_x, dest_y, scan1, scan2, scan3;
{
  int course;
  int range;
  int posX;
  int maxX;
  int minX;

  if (dest_x==20) {
     minX=70;
     maxX=1000;
  } else {
    minX=0;
    maxX=810;
  }
  course = plot_course(dest_x,dest_y);
  drive(course,87);
  posX=loc_x();
  while(posX>minX && posX<maxX) {
    if ((range=scan(scan1,5)) > 0 && range <= 700)  {
       cannon(scan1,range);
    }
    if ((range=scan(scan2,5)) > 0 && range <= 700)  {
       cannon(scan2,range);
    }
    if ((range=scan(scan3,5)) > 0 && range <= 700)  {
       cannon(scan3,range);
    }
    posX=loc_x();

  }

  drive(course,0);
  while (speed() > 0)
    ;
}


goY (dest_x, dest_y, scan1, scan2, scan3)
int dest_x, dest_y, scan1, scan2, scan3;
{
  int course;
  int range;
  int posY;
  int maxY;
  int minY;

  if (dest_y==20) {
     minY=70;
     maxY=1000;
  } else {
    minY=0;
    maxY=810;
  }

  course = plot_course(dest_x,dest_y);
  drive(course,87);

  posY=loc_y();
  while(posY>minY && posY<maxY) {
    if ((range=scan(scan1,5)) > 0 && range <= 700)  {
       cannon(scan1,range);
    }
    if ((range=scan(scan2,5)) > 0 && range <= 700)  {
       cannon(scan2,range);
    }
    if ((range=scan(scan3,5)) > 0 && range <= 700)  {
       cannon(scan3,range);
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

insisti(scan,range)
int scan,range;
{
  if (scan==90) {
   cannon(80,range);
  }
}



/* end of MG_One.r */
