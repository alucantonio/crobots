/* By Eric Sass */

int ang,range,course,wall,dest_x,dest_y;

main() {
    turn();
    while (1) {
        if (distance(loc_x(),loc_y(),dest_x,dest_y) < 100
            || !speed()) turn(); /* might have hit a wall while shooting!*/
        range = scan(ang,10);
        if (range > 40 && range < 800) shoot();
        else ang += 20;
    }
}  /* end of main */ 
            
shoot()
{
    int count;

/* first, scan 10ø at a time, scanning 20ø       (248) */
    ang -= 5;
    count = 2;
    while (count && !(range = scan(ang,5))) {
        ang += 10;
        --count;
    }
    if (!range) return;
    cannon(ang,range);
/* now at 2ø at a time, scanning 8ø */
    ang -= 4;
    count = 4;
    while (count && !(range = scan(ang,1))) {
        ang += 2;
        --count;
    }
    if (!range) return;
    while (!cannon(ang,range)) scan(222,0); /* wait and fire shot */
/* now at 1ø at a time, scanning 4ø */
    ang -= 2;
    count = 4;
    while (count && !(range = scan(ang,0))) {
        ++ang;
        --count;
    }
    if (!range) return;
    while (!cannon(ang,range)) scan(111,0); /* wait and fire shot */
}

turn()
{  
    drive (course,40); 
    wall = (wall + rand(3) + 1) % 4;
    if (wall == 0) {
        dest_x = 900;
        dest_y = rand(800) + 100;
    }
    if (wall == 1) {
        dest_x = rand(800) + 100;
        dest_y = 900;
    }
    if (wall == 2) {
        dest_x = 100;
        dest_y = rand(800) + 100;
    }
    if (wall == 3) {
        dest_x = rand(800) + 100;
        dest_y = 100;
    }
    course = plot_course (dest_x,dest_y);
    while (speed() > 40) 
        ; 
    drive (course,100);
}

distance(x1,y1,x2,y2)
int x1,y1,x2,y2;
{
  int x,y,d;

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

/* end of rabbit.r */
