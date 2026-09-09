/* The Slayer */

/*
Nome: 		The Slayer
Versione: 	1.0
Autore: 	Antonio Valerio Miceli Barone.

Strategia: 	Inizialmente si dirige nell'angolo più vicino sparando a qualunque cosa si muova (o meno).
		Quindi incomincia ad oscillare sulla bisettrice dell'angolo sparando e contando periodicamente i nemici.
           	Se non ne rimane nessuno parte con l'attacco finale.

Attacco finale: Inizia attaccando l'avversario in linea retta, se prima che riesca ad avvicinarsi ha già subito un certo danno
           	attacca oscillando, altrimenti continua in linea retta.
	        
Commento: 	Questo è il mio primo crobot quindi non mi aspetto molto.
		In particolare in 4vs4 fa schifo mentre in f2f dovrebbe essere semi-decente.
		Le routine di fuoco sono derivate dalla Fuoco() di rudolf_6.r.
*/

int dir, deg, odeg, range, clock, cycles;
int c, d, x, y, startdeg, invdeg, dirdeg, idirdeg, i;
int dx, cx1, cx2;
int minrange, mindeg;
int px, py, nx, ny;
int r2;

/* Molte di queste variabili non servono */

slash() {
  if (range=scan(deg,10)) return cannon(deg,range);
  if (range=scan(deg+=340,10)) return cannon(deg,range);
  if (range=scan(deg+=40,10)) return cannon(deg,range);
  if (range=scan(deg+=300,10)) return cannon(deg,range);
  if (range=scan(deg+=80,10)) return cannon(deg,range);
  if (range=scan(deg+=260,10)) return cannon(deg,range);
  if (range=scan(deg+=120,10)) return cannon(deg,range);
  if (range=scan(deg+=220,10)) return cannon(deg,range);
  if (range=scan(deg+=160,10)) return cannon(deg,range);

  if (range=scan(deg+=180,10)) return cannon(deg,range);
  if (range=scan(deg+=200,10)) return cannon(deg,range);
  if (range=scan(deg+=140,10)) return cannon(deg,range);
  if (range=scan(deg+=240,10)) return cannon(deg,range);
  if (range=scan(deg+=100,10)) return cannon(deg,range);
  if (range=scan(deg+=280,10)) return cannon(deg,range);
  if (range=scan(deg+=60,10)) return cannon(deg,range);
  if (range=scan(deg+=320,10)) return cannon(deg,range);
  if (range=scan(deg+=20,10)) return cannon(deg,range);
  if (range=scan(deg+=180,10)) return cannon(deg,range);
}

/*punch() {
  if (range=scan(odeg=deg,10)) {
      if (!scan(deg+=355,5)) deg+=10;
      if (!scan(deg+=357,3)) deg+=6;
      cannon(deg+(deg-odeg),2*scan(deg,10)-range);        
  } 
  else {
  if (range=scan(deg,10)) return cannon(deg,range);
  if (range=scan(deg+=340,10)) return cannon(deg,range);
  if (range=scan(deg+=40,10)) return cannon(deg,range);
  if (range=scan(deg+=300,10)) return cannon(deg,range);
  if (range=scan(deg+=80,10)) return cannon(deg,range);
  if (range=scan(deg+=260,10)) return cannon(deg,range);
  if (range=scan(deg+=120,10)) return cannon(deg,range);
  if (range=scan(deg+=220,10)) return cannon(deg,range);
  if (range=scan(deg+=160,10)) return cannon(deg,range);

  if (range=scan(deg+=180,10)) return cannon(deg,range);
  if (range=scan(deg+=200,10)) return cannon(deg,range);
  if (range=scan(deg+=140,10)) return cannon(deg,range);
  if (range=scan(deg+=240,10)) return cannon(deg,range);
  if (range=scan(deg+=100,10)) return cannon(deg,range);
  if (range=scan(deg+=280,10)) return cannon(deg,range);
  if (range=scan(deg+=60,10)) return cannon(deg,range);
  if (range=scan(deg+=320,10)) return cannon(deg,range);
  if (range=scan(deg+=20,10)) return cannon(deg,range);
  if (range=scan(deg+=180,10)) return cannon(deg,range);
  }
}*/

kick() {
  if (range=scan(odeg=deg,10)) {
      if (!scan(deg+=355,5)) deg+=10;
      if (!scan(deg+=357,3)) deg+=6;
      cannon(deg+(deg-odeg),2*scan(deg,10)-range);
  } 
  else {
  if (range=scan(deg,10)) return cannon(deg,range);
  if (range=scan(deg+=340,10)) return cannon(deg,range);
  if (range=scan(deg+=40,10)) return cannon(deg,range);
  if (range=scan(deg+=300,10)) return cannon(deg,range);
  if (range=scan(deg+=80,10)) return cannon(deg,range);
  if (range=scan(deg+=260,10)) return cannon(deg,range);
  if (range=scan(deg+=120,10)) return cannon(deg,range);
  if (range=scan(deg+=220,10)) return cannon(deg,range);
  if (range=scan(deg+=160,10)) return cannon(deg,range);
  deg+=180;
  }
}

/*bite() {
  if (range=scan(deg,10)) return cannon(deg,range);
  if (range=scan(deg+=340,10)) return cannon(deg,range);
  if (range=scan(deg+=40,10)) return cannon(deg,range);
  if (range=scan(deg+=300,10)) return cannon(deg,range);
  if (range=scan(deg+=80,10)) return cannon(deg,range);
  if (range=scan(deg+=260,10)) return cannon(deg,range);
  if (range=scan(deg+=120,10)) return cannon(deg,range);

  deg+=100;
}*/

dirchange() {
  drive(dir, 0);
  while(speed() > 49) {
    slash();
  }
  drive(dir, 100);
}

count() {
  minrange = (i = 0) + 999;
  deg = startdeg - 85;
  while (deg < startdeg + 65) {
    deg+=20;
    if (range=scan(deg, 10)) {
      drive(startdeg, 100);
      ++i;
      if (range < minrange) {
        minrange = range;
        mindeg = deg;
      }
    }
  }
  deg = mindeg;
  return 0+(i != 1);
}

corner5() {
  while (count()) {
    cycles = 0;
    if (c == 0) {
      while (cycles < 9) {
        ++cycles;
        while (loc_x() < 100) {drive(45, 100); kick();}
        while (loc_x() > 63) {drive(225, 100); kick();}
      }
    }
    else if (c == 1) {
      while (cycles < 9) {
        ++cycles;
        while (loc_x() > 900) {drive(135, 100); kick();}
        while (loc_x() < 937) {drive(315, 100); kick();}
      }
    }
    else if (c == 2) {
      while (cycles < 9) {
        ++cycles;
        while (loc_x() > 900) {drive(225, 100); kick();}
        while (loc_x() < 937) {drive(45, 100); kick();}
      }
    }
    else {
      while (cycles < 9) {
        ++cycles;
        while (loc_x() < 100) {drive(315, 100); kick();}
        while (loc_x() > 63) {drive(135, 100); kick();}
      }
    }
    drive(startdeg, 100);
  }
  slash(drive(startdeg, 100));

  d = damage(range = (clock = 0) + 999);

  while(range > 450 && damage() - d < 5) {
    slash(); slash(); slash(); slash();
    slash(); slash(); slash();

    dirchange(dir=deg);
  }
  if (damage() - d >= 5)
    while(1) {
      /*punch(); punch(); punch(); punch();*/
      kick(); kick(); kick(); kick(); kick();
      dirchange(dir=deg+80-160*((clock^=1) > 0));
    }
  else
    while(1) {
      slash(); slash(); slash(); slash();
      slash(); slash(); slash();
      dirchange(dir=deg);
    }
}

/*sw() {
  range = scan(90, 10);
  r2 = scan(0, 10);
  if ((r2) && (!range)) {
    while (++cycles < 8) {
      while (loc_y() < 88) {drive(90, 100); kick();}
      while (loc_y() > 85) {drive(270, 100); kick();}
    }
    drive(90, 100);
  }
  else if ((range) && (!r2)) {
    while (++cycles < 8) {
      while (loc_x() < 88) {drive(0, 100); kick();}
      while (loc_x() > 85) {drive(180, 100); kick();}
    }
    drive(0, 100);
  }
  else {
    while (++cycles < 8) {
      while (loc_x() < 66) {drive(45, 100); kick();}
      while (loc_x() > 63) {drive(225, 100); kick();}
    }
    drive(45, 100);
  }
}

se() {
  range = scan(90, 10);
  r2 = scan(180, 10);
  if ((r2) && (!range)) {
    while (++cycles < 8) {
      while (loc_y() < 88) {drive(90, 100); kick();}
      while (loc_y() > 85) {drive(270, 100); kick();}
    }
    drive(90, 100);
  }
  else if ((range) && (!r2)) {
    while (++cycles < 8) {
      while (loc_x() > 912) {drive(180, 100); kick();}
      while (loc_x() < 915) {drive(0, 100); kick();}
    }
    drive(180, 100);
  }
  else {
    while (++cycles < 8) {
      while (loc_x() > 934) {drive(135, 100); kick();}
      while (loc_x() < 937) {drive(315, 100); kick();}
    }
    drive(135, 100);
  }
}

ne() {
  range = scan(180, 10);
  r2 = scan(270, 10);
  if ((r2) && (!range)) {
    while (++cycles < 8) {
      while (loc_x() > 912) {drive(180, 100); kick();}
      while (loc_x() < 915) {drive(0, 100); kick();}
    }
    drive(180, 100);
  }
  else if ((range) && (!r2)) {
    while (++cycles < 8) {
      while (loc_y() > 912) {drive(270, 100); kick();}
      while (loc_y() < 915) {drive(90, 100); kick();}
    }
    drive(270, 100);
  }
  else {
    while (++cycles < 8) {
      while (loc_x() > 934) {drive(225, 100); kick();}
      while (loc_x() < 937) {drive(45, 100); kick();}
    }
    drive(225);
  }
}

nw() {
  range = scan(0, 10);
  r2 = scan(270, 10);
  if ((r2) && (!range)) {
    while (++cycles < 8) {
      while (loc_x() < 88) {drive(0, 100); kick();}
      while (loc_x() > 85) {drive(180, 100); kick();}
    }
    drive(0, 100);
  }
  else if ((range) && (!r2)) {
    while (++cycles < 8) {
      while (loc_y() > 912) {drive(270, 100); kick();}
      while (loc_y() < 915) {drive(90, 100); kick();}
    }
    drive(270, 100);
  }
  else {
    while (++cycles < 8) {
      while (loc_x() < 66) {drive(315, 100); kick();}
      while (loc_x() > 63) {drive(135, 100); kick();}
    }
    drive(315, 100);
  }
}

corner6() {
  if (!count()) engage();
  while (count(cycles = 0)) {
    if (c == 0) {
      sw();
    }
    else if (c == 1) {
      se();
    }
    else if (c == 2) {
      ne();
    }
    else {
      nw();
    }
  }
}

engage() {
  slash(drive(startdeg, 100));

  d = damage(range = (clock = 0) + 999);

  while(range > 450 && damage() - d < 5) {
    slash(); slash(); slash(); slash();
    slash(); slash(); slash();

    dirchange(dir=deg);
  }
  if (damage() - d >= 5)
    while(1) {
      kick(); kick(); kick(); kick();
      dirchange(dir=deg+80-160*((clock^=1) > 0));
    }
  else
    while(1) {
      slash(); slash(); slash(); slash();
      slash(); slash(); slash();

      dirchange(dir=deg);
    }
}*/

dist(xx, yy) {
  return (loc_x()-xx)*(loc_x()-xx)+(loc_y()-yy)*(loc_y()-yy);
}

angle(xx, yy) {
  return 180+180*((dx=loc_x()-xx) < 0)+atan(100000*(loc_y()-yy)/dx);
}


main() {
  if (loc_y() < 500)
    if (loc_x() < 500) {
      dir = angle((cx1 = 100), (cx2 = 63), (idirdeg = startdeg = 45), (c = 0), 50, 50);
      while (dist(50, 50) > 2500) {slash(drive(dir, 100));}
    }
    else {
      dir = angle((cx1 = 937), (cx2 = 900), (idirdeg = 180 + (startdeg = 135)), (c = 1), 950, 50);
      while (dist(950, 50) > 2500) {slash(drive(dir, 100));}
    }
  else
    if (loc_x() >= 500) {
      dir = angle((cx1 = 937), (cx2 = 900), (idirdeg = 180 + (startdeg = 225)), (c = 2), 950, 950);
      while (dist(950, 950) > 2500) {slash(drive(dir, 100));}
    }
    else {
      dir = angle((cx1 = 100), (cx2 = 63), (idirdeg = startdeg = 315), (c = 3), 50, 950);
      while (dist(50, 950) > 2500) {slash(drive(dir, 100));}
    }
  corner5(drive(dir, 0));
}
