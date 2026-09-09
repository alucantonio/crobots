/**

Sentry3 by Emanuele Marsigliani

Sentry3 e' Sentry2 ma con movimento verticale al centro dell'arena

*/

int ang;

degree(xx,yy)
int xx,yy;
{
    return (360+((xx-=loc_x())<0)*180+atan(((yy-loc_y())*100000)/xx));
}

fire(dir,v)
int dir,v;
{
    int range, oang;
	drive(dir,v);
	if (range=scan(oang=ang,10)) {
		if (scan(ang-8,5)) {
			if (scan(ang-=5,2)) ;
			else ang-=4;
		} else {
			if (scan(ang+8,5)) {
				if (scan(ang+=5,2)) ;
				else ang+=4;
			} else {
				if (scan(ang,1)) ;
				else if (scan(ang-=3,2)) ; else ang+=6;
			}
		}
		return(cannon((ang<<1)-oang, (scan(ang,10)<<1)-range));
	} else {
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else if(range=scan(ang+=60,10)) cannon(ang,range);
		else if(range=scan(ang-=80,10)) cannon(ang,range);
		else ang+=120;
	}
} 

corners(dir)
int dir;
{
    int deg, range;
    fire(dir,0);

    if (loc_y() < 500) {
        if ((range=scan(deg=degree(0,0),10))&& range<740);
        else
        if ((range=scan(deg=degree(999,0),10))&& range<740);
        else return fire(dir,100);
    } else {
        if ((range=scan(deg=degree(0,999),10))&& range<740);
        else
        if ((range=scan(deg=degree(999,999),10))&& range<740);
        else return fire(dir,100);
    }

    ang=deg; fire(dir,100);
}

main()
{

 while (loc_x()<450)
   fire(0,100);
 while (loc_x()>550)
   fire(180,100);
 
 while(1)
 {
    corners(90);
 while (loc_y()<880)
  {
   fire(90,100);
  }
    corners(270);
 while (loc_y()>120)
  {
   fire(270,100);
  }
 }
}
