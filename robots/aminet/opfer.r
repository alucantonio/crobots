/*Slayer Tech
thb*/
/* Victim */
/* This is Chuck Norris' digitized */
/* brother...                      */

int behind;
int course;
int dir;
int dist;
int scandir;
int dam;

main()
{

    scandir = 15;
    dir = rand( 359 );

    while( 1 ){

        course = setcourse();
        drive( course, 100 );

        dam = damage();

        while( speed() != 0 &&
               loc_y() > 100 && loc_y() < 900 &&
               loc_x() > 100 && loc_x() < 900 ){

            if( dam - damage() > 15 ){
                dodge();
                dam = damage();
            }
            baller();
        }
        slowdown();
   }

}  /* end of main */ 


baller()
{
    dist = scan( dir, 20 );
    if( dist != 0 ){
        cannon( dir, dist );
    } else {
        dist = scan( dir+10, 20);
        if( dist != 0 ){
            cannon( dir+10, dist );
            dir += 20;
        }
        dist = scan( dir-10, 20);
        if( dist != 0 ){
            cannon( dir-10, dist );
            dir -= 20;
        }
        behind = course + 180;
        dist = scan( behind, 20 );
        if( dist != 0 ){
            cannon( behind, dist );
            dir = behind;
        } else {
            dir += scandir;
        }
    }
}


dodge()
{
    int dc;

    slowdown();
    course = setcourse();
    drive( course, 100 );
    baller();

}


slowdown()
{
    drive(course,48);
    while( speed() >= 49 ) ;
}


plot(xx,yy)
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


int setcourse()
{
    int x;
    int curx;
    int y;
    int cury;
    int retval;
    int atn;

    curx = loc_x();
    cury = loc_y();

    if( curx < 150 || curx > 850 ||
        cury < 150 || cury > 850 ){
        x = rand(300) + 350;
        y = rand(300) + 350;
    } else {
        if( rand(4) > 2 ){
        /* horizontal */
            x = 150 + rand( 700 );
            if( loc_x() > 500 ){
                y = 150 + rand( 100 );
            } else {
                y = 750 + rand( 100 );
            }
        } else {
        /* vertikal */
            y = 150 + rand( 700 );
            if( loc_y() > 500 ){
                x = 150 + rand( 100 );
            } else {
                x = 750 + rand( 100 );
            }
        }
        
    }

    return( rand( 30 ) + plot( x, y ) );

}
 
/* end of opfer.r */
