/*
A T A M A N

Crobot   	: Ataman
Type			: Micro
Version 	: 1.01
Author		: Olga S
Begin			: 18-12-2010
Revision	: 25-12-2010

Ataman is a russian word which means "the bandit leader" aka "pest" (... little
babies or pets)

It comes from the 2000 microbot Carletto with some 2004 Rat-Man contaminations.
It's my first robot to learn (remember & improve ...) the ANSI C language.
*/

int posy,posx,ang,oang,range,orange,t,d,deg,en,limit,f2f;

int unsafe() /* Make safer the wall approaching */
{
  return (((loc_x()%800)<200)||((loc_y()%800)<200));
}

/* Rat-Man fire routines with minor changes */
_scan_()  
{
  if(scan((oang=ang)-7,3)) ang-=7;
  if(scan(ang+7,3)) ang+=7;
  if(scan(ang-4,2)) ang-=4;
  if(scan(ang+4,2)) ang+=4;
  if(scan(ang-2,1)) ang-=2;
  if(scan(ang+2,1)) ang+=2;
  return (scan(ang,10));
}

int fire(dir)
{
 drive(dir,100);
 if (unsafe());
 else
 if (scan(ang,10))
    {
      if ((orange=_scan_())<limit)
        {
          if (range=_scan_())               
             return cannon((oang+(ang-oang)*3-(sin(ang-dir)/19500)),(range*220/(220+orange-range-(cos(ang-dir)/4167))));
        }
    }     
  if ((range=scan(ang,10))&&(range<limit));
  else
    if((range=scan(ang+=339,10)));
    else
      if((range=scan(ang+=42,10)));
      else
        if((range=scan(dir,10))) ang=dir;
        else
          return (ang+=40);
  cannon (ang,2*scan(ang,10)-range);
}

/* Main routine */
main()
{
	posy=loc_y(posx=loc_x(limit=850)<500)<500;

	while (t=en=deg=10)
	{
		while(--t)					/* It runs fast around the nearest corner */
		{
			if (d>damage()-26) /* until damage limit has reached */
			{
				while(loc_y() <910-posy*790) {fire(90);}
				while(loc_x() >880-posx*790) {fire(180);}
				while(loc_y() >880-posy*790) {fire(270);}
				while(loc_x() <910-posx*790) {fire();}
			}
			else /* change corner */
			{
				if (scan(90+posy*180,10))
				if (scan(posx*180,10)); else posx^=1;
				else  posy^=1;
				d=damage();
			}
	    drive (0,0); /* stop */
		}

		while ((deg+=20)<390) en+=(scan(deg,10)>0); /* scan whole arena */

		if(en<12)					/* Arale f2f routine */
		{
		  limit=9999;
		  while(1)
		  {
  			if ((loc_y()<440)||(loc_y()>560))
  			{
  				fire(270-180*posy);
  			}
  			else
  			{
          while (loc_x()>200) fire(180);
          while (loc_x()<800) fire();
  			}      
      }
		}
	}
}