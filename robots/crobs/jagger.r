
/* Jagger.r                     */
/* programmed by Jeff Gibbons   */
/*               569-8403       */

  int d;
  int course;
  int range; 
  int orange;
  int dir;   
  int odir;  
  int crange;
  int cdir;  
  int ox,tx,cx;
  int oy,ty,cy;
  int xdif,ydif;
  int rx,ry;	
  int rxdelt,rydelt;

main()
{
  rydelt = 0;
  if(loc_x()<500) {
    course = 0;
    rxdelt = 40;
    }
  else {
    course = 180;
    rxdelt = -40;
    }

  dir = 0;

  while (1) {

	if(course<135) {
	  if(course<45) {
	    if(loc_x()>700) {
	      drive(0,40);
	      course = 270;
	      rxdelt = 0;
	      rydelt = -40;
	    }
	  }
	  else {	 
	    if(loc_y()>700) {
	      drive(90,40);
	      course = 0;
	      rxdelt = 40;
	      rydelt = 0;
	    }
	  }
	}
	else {
	  if(course<225) {
	    if(loc_x()<300) {
	      drive(180,40);
	      course = 90;
	      rxdelt = 0;
	      rydelt = 40;
	    }
	  }
	  else {
	    if(loc_y()<300) {
	      drive(270,40);
	      course = 180;
	      rxdelt = -40;
	      rydelt = 0;
	    }
	  }
	}
	if ((scan(dir,10))==0) {
	  if(scan(dir+341,10)>0) {
            if(scan(dir+341,3)>0) {
	      if ((scan(dir+351,10))>0) {
	        if(scan(dir+352,10)>0)     dir=dir+342;
                else                      dir=dir+340;
              }
              else {
	        if(scan(dir+349,10)>0)     dir=dir+339;
                else                      dir=dir+337;
              }
            }
            else {
              if (scan(dir+351,10)>0) {
                if(scan(dir+357,10)>0)     dir=dir+347;
                else                      dir=dir+344;
              }
              else {
                if(scan(dir+344,10)>0)     dir=dir+334;
                else                      dir=dir+331;
              }
            }
	  }
	  else if( scan(dir+19,10)>0 ) {
	    if ((scan(dir+29,10))>0) {
	      if(scan(dir+34,10)>0)     dir=dir+26;
              else                      dir=dir+21;
            }
            else {
	      if(scan(dir+24,10)>0)     dir=dir+16;
              else                      dir=dir+11;
            }
	  }
	  else if( scan(dir+322,10)>0 ) {
            if(scan(dir+332,10)>0)      dir=dir+322;
            else                        dir=dir+312;
	  }
	  else if( scan(dir+38,10)>0 ) {
            if(scan(dir+48,10)>0)       dir=dir+43;
            else                        dir=dir+33;
	  }
	  else if( scan(dir+303,10)>0 ) dir = dir + 303;
	  else if( scan(dir+57,10)>0 ) dir = dir + 57;
	  else if( scan(dir+284,10)>0 ) dir = dir +284;
	  else if( scan(dir+76,10)>0 ) dir = dir + 76;
	  else dir = dir + 190;
	}
	else {
          if(scan(dir+10,10)>0) {
	    if (scan(dir+15,10)>0) {
	      if(scan(dir+17,10)>0)     dir=dir+7;
              else                      dir=dir+5;
            }
            else {
	      if(scan(dir+13,10)>0)     dir=dir+3;
              else                      dir=dir+1;
            }
          }
          else {
	    if (scan(dir+5,10)>0) {
	      if(scan(dir+7,10)>0)      dir=dir+357;
              else                      dir=dir+355;
            }
            else {
	      if(scan(dir+3,10)>0)      dir=dir+353;
              else                      dir=dir+350;
            }
          }
          if(scan(dir+10,10)>0)         dir=dir+1;
          else                          dir=dir+359;
	}

	if(scan(dir+10,10)>0) dir = dir + 1;
        else                  dir = dir + 359;
	if(scan(dir+10,10)>0) dir = dir + 1;

	if( (range=scan(dir,10)) > 150 ) {
          rx = loc_x();
	  ry = loc_y();

          drive(course,100);
          dir = dir % 360;

          tx = rx + ((range*cos(dir))/100000);
          ty = ry + ((range*sin(dir))/100000);
          rx = ((tx-ox)*(650 + range))/870;
          ry = ((ty-oy)*(650 + range))/870;
          cx = tx + rx;
          cy = ty + ry;

	  rx = loc_x();
	  ry = loc_y();
          xdif = (cx-rx) - rxdelt;
          ydif = (cy-ry) - rydelt;

          crange = (sqrt( (xdif*xdif) + (ydif*ydif) ));

	  if( xdif == 0 ) xdif=1;
          cdir = atan( (100000*ydif)/xdif );
          if( xdif < 0 )
            cdir = cdir + 180;
          else if( cdir < 0 )
            cdir = cdir + 360;
          if (crange<50) crange=50;
          cannon(cdir,crange);

        }
        else {
          dir = dir % 360;
	  if (range>50)	cannon(dir,range);
	    else	cannon(dir,50);
          tx = loc_x();
          ty = loc_y();
	  drive(course,100);
	}

        ox = tx;
        oy = ty;

  } 

} /* end of jagger.r    */
