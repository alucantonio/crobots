/*
 * PROGRAM  : Random.R
 * AUTHOR   : Richard Doust
 *
 * Randomly fires into the aether.  Constantly checks to see if he's been
 * hit and only if so does he move.
 *
 */
main()
{

int dam,range,i,degree;

dam = degree = 0;

  while(1) {

    range = i = 0;

    while (!range) {
      if (loc_x() < 20 && loc_y() > 979 && degree < 270)
	degree = 270;
      else if (loc_x() > 979 && loc_y() > 979 && (degree < 180 || degree > 270))
	degree = 180;
      else if (loc_x() < 20 && loc_y() < 20 && degree > 90)
	degree = 0;
      else if (loc_x() > 979 && loc_y() < 20 && (degree < 90 || degree > 180))
	degree = 90;
      if (range = scan(degree,10)) {
	cannon(degree,range);
	drive(degree,50);
	degree -= 10;
	if (degree < 0)
	  degree = 0;
	while ((range = scan(degree,0)) == 0 && i != 20) {
	  ++degree;
	  ++i;
	}
	if (range) {
	  while (!(cannon(degree,range)))
	    ;
	  while (cannon(degree,range))
	    ;
	}
	if (speed() < 51) {
	  drive(degree,50);
	}
      } else {
	degree += 20;
	if (speed() > 0)
	  if (loc_x() < speed() && degree > 90 && degree < 270)
	    drive(0,0);
	  else if ((999 - loc_x()) < speed() && (degree < 90 || degree > 270))
	    drive(0,0);
	  else if (loc_y() < speed() && degree > 180)
	    drive(0,0);
	  else if ((999 - loc_y()) < speed() && degree < 180)
	    drive(0,0);
      }
      degree %= 360;
    }

    if (dam != damage()) {
      dam = damage();
      degree += 180;
      if (range)
	cannon(degree,range);
      if (speed() < 50)
	drive(degree,100);
    }

    while (!(cannon(degree,range)))
      ;
    while (cannon(degree,range))
      ;
  }
}

