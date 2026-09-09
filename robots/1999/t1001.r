/* Pierpaolo Vittorini                                          */

int x, y, d, steps, cs, olda, angle, r, a, v, pa;
int ang,        /* Angolo di scanning                           */
    dir,        /* Direzione del cammino                        */
    count,      /* Contatore                                    */
    curx,cury,  /* Variabili temporanee salvaposizione          */
    maxcount,   /* Massimo numero di oscillazioni               */
    deg, range, diff, oang, orange, aa, rr, currcpu;

get_angle() {
  if ((loc_x()<200) && (angle==180)) { angle=0; v=100; steps=8; }
  else if ((loc_x()>800) && (angle==0)) { angle=180; v=100; steps=8; }
  else if ((loc_y()<200) && (angle==270)) { angle=90; v=100; steps=8; }
  else if ((loc_y()>800) && (angle==90)) { angle=270; v=100; steps=8; }
  else if (cs > steps) {
    r=rand(4);
    if (r<1) angle=0;
    else if (r<2) angle=90;
    else if (r<3) angle=180;
    else angle=270;
    cs=0;
    steps=3;
    v=100;
  } else { angle=olda; v=100; }
  return angle;
}

redrive() {
  ++currcpu;
  ++cs;
  get_angle();
  range=scan(angle,10);
  if (range > 0) get_angle();
  drive(angle,v);
  olda=angle;
}

scan_()
{
  if(scan(ang-5,1)) ang-=5;
  if(scan(ang+5,1)) ang+=5;
  if(scan(ang-3,1)) ang-=3;
  if(scan(ang+3,1)) ang+=3;
  if(scan(ang-1,1)) ang-=1;
  if(scan(ang+1,1)) ang+=1;
}

fire()
{
  if(range=scan(ang,5)) {
    cannon(ang,range);
    scan_();
    if (range=scan(ang,5)) {
      orange=range;
      oang=ang;
      scan_();
      if (range=scan(ang,10)) {
      	aa=(ang+(ang-oang)*((1200+range)>>9)-(sin(ang-dir)>>14));
      	rr=(range*160/(160+orange-range-(cos(ang-dir)>>12)));
      	while(!cannon(aa,rr));
      	if (range>700) ang+=30;
      }
      else if(scan(ang-=10,10));
      else if(scan(ang+=20,10));
      else ang+=40;
    }
    else if(scan(ang-=10,10));
    else if(scan(ang+=20,10));
    else ang+=40;
  }
  else if(scan(ang-=10,10));
  else if(scan(ang+=20,10));
  else ang+=40;
}

attack() {

	if (speed()) drive(dir,0);
	while (speed()) ;
	drive(180*(loc_x()>500),100);
	ang=336;
	diff=50;
	while(1)
	{
		ang+=328;
		while(!(range=scan(ang+=16,8)));
		cannon(ang,range);
		if(range>200) drive(dir=ang,100);
			while (range)  /* && range<700 */
			{
				if (range>200)
				{
					oang=ang;
					orange=range;
					ang+=4-(scan(ang-4,4) != 0)*8;
					ang+=2-(scan(ang-2,2) != 0)*4;
					ang+=1-(scan(ang-1,1) != 0)*2;
					if (range=scan(ang,10))
						cannon(ang+(ang-oang)*range/200,range+(range-orange+diff)*range/275);
					if (speed()<51 || ((ang-dir)*(ang-dir)>400))
					{
						drive(dir=ang,100);
						diff=25;
					}
					else diff=50;
				}
				else
				{
					ang+=20;
					while(range<300)
					{
						ang+=320;
						while(!(range=scan(ang+=20,10)));
						cannon(ang,range);
						if(speed()<50 || range>200) drive(dir=ang,100);
					}
				}
			}
	}
}

fast_fire () {
  if (d=scan(ang,10)) cannon(ang,d);
    else ang+=21;
}

main() {
  cs=0;
  steps=50;
  angle=90;
  drive(90,100);
  olda=90;
  v=100;
  currcpu=0;
  	
  ang=0;
  count=0;
  maxcount=60;
  deg=10;

  while(1) {
    if (currcpu > 2000) {
      if (loc_x()<200) angle=0;
      else if (loc_x()>800) angle=180;
      else if (loc_y()<200) angle=90;
      else if (loc_y()>800) angle=270;
        else
          while (!(range = scan (angle, 5))) angle += 5;

      drive (angle, 100);

      while (!cannon (angle,range));
      range = scan (angle+5,5);
      if (range > 0) angle += 5;
        else {
          range = scan (angle-5,5);
          if (range > 0) angle -= 5;
        }
    } else {
      redrive();
      d=damage();
      if (d > 80) fast_fire();
        else
      if (d > 30) attack();
        else fire();
    }
  }
}
