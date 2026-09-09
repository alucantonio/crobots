/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots di IoProgrammo (2001)                                 */
/*                                                                          */
/*  CROBOT: DNABlack.r                                                      */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*
  Il robot oscilla nell'angolo più vicino lungo la bisettrice; a meta incontro comincia 
  ad attaccare i robot negli angoli adiacenti e alla fine attacca.
  Durante l'incontro se c'e' un solo avversario attacca.
  La routine offensiva consiste in un movimento a forma di quadrato al centro dell'arena.
  Differisce da DNA.r x la routine di fuoco.
*/

int deg,rng,dir,odeg,orng,n;
int ax,ay,av,ah,ad,d1,d2,d,f,i,x,y;
int rv,rh,wsec,dam,t;

main()
{
/*  if (Radar2()<=1) Attacca();  */

  ah=180-180*((ax=980-960*(loc_x()<500))<500);
  av=270-180*((ay=980-960*(loc_y()<500))<500);

  drive(dir=DirTo(ax,ay),100);
  while(From(ax,ay)>4800) QFire();
  if (ah-av==-270) ad=315; else ad=(ah+av)/2;
  while(From(ax,ay)>1200) ;
  drive(dir,0);
  
  if (Radar(ad)<=1) Attacca();
  
  Wave45();
  
  while (1) {
    if (rv) {
      if (rh) {
        Wave45();
      } else {
      	if (wsec)
      	  VWaveIn();
      	else
      	  Wave45();    
      }
    } else {
      if (rh) {
      	if (wsec)
      	  HWaveIn();
      	else
      	  Wave45();    
      } else {
        if (Radar(ad)<=1) Attacca();
        Wave45();
      }
    }
  }

}

DirTo(x,y)    
int x,y;
{
  return 360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x);
}

From(x,y) 
int x,y;
{
  return (((x-=loc_x())*x+(y-=loc_y())*y));
}

Radar(d)
int d;
{
  n=0;
  if (scan(d,10)) ++n;
  if (scan(d-20,10)) ++n;
  if (scan(d+20,10)) ++n;
  if (scan(d-40,10)) ++n;
  if (scan(d+40,10)) ++n;
  return n;
}

Wave45()
{
  drive(dir=ad,100);
  
/*  dam=damage();*/
  rh=scan(ah,10);
  rv=scan(av,10); 
  if (rv && (rv<rh)) deg=av; 
  else deg=ah;

  while (((y=loc_y())<70) || (y>930) || ((x=loc_x())<70) || (x>930) ) {
    drive(dir,100);
    QFire(); 
  }
  while (speed()>75) drive(dir,0);
  
  drive(dir+=180,100);
  
  while (((y=loc_y())>70) && (y<930) && ((x=loc_x())>70) && (x<930) ) {
    drive(dir,100);
    QFire(); 
  }
  while (speed()>80) drive(dir,0);
  if ((damage()<80) && ((++t)>150)) { 
    if (t>240) { 
      if (t>270) Attacca();
      if (damage()<=40) Attacca();
    }
    wsec=1;  
  } else wsec=0;
  

}

HWaveIn()
{
  drive(dir=ah,100);
  
  wsec=0;
  rh=scan(ah,10);
  rv=scan(av,10); 
  deg=ah;
    
  if (ah==180) {  
    while (loc_x()>800) {
      drive(dir,100);
      Firef2f(); 
    }
    while (loc_x()>750) {
      drive(dir,100);
      QFire(); 
    }
  } else {
    while (loc_x()<200) {
      drive(dir,100);
      Firef2f(); 
    }
    while (loc_x()<250) {
      drive(dir,100);
      QFire(); 
    }
  }
  
  while (speed()>60) drive(dir,0);
  
  drive(dir+=180,100);
  
  if (ah==180) { 
/*    while (loc_x()<850) {
      drive(dir,100);
      Firef2f(); 
    } */
    while (loc_x()<900) {
      drive(dir,100);
      QFire(); 
    }
  } else {
/*    while (loc_x()>150) {
      drive(dir,100);
      Firef2f(); 
    } */
    while (loc_x()>100) {
      drive(dir,100);
      QFire(); 
    }
  }
  while (speed()>80) drive(dir,0);

}

VWaveIn()
{
  drive(dir=av,100);
  
  wsec=0;
  rh=scan(ah,10);
  rv=scan(av,10); 
  deg=av;
  
  if (av==90) {  
    while (loc_y()<200) {
      drive(dir,100);
      Firef2f(); 
    }
    while (loc_y()<250) {
      drive(dir,100);
      QFire(); 
    }
  } else {
    while (loc_y()>800) {
      drive(dir,100);
      Firef2f(); 
    }
    while (loc_y()>750) {
      drive(dir,100);
      QFire(); 
    }
  }

  while (speed()>60) drive(dir,0);
  
  drive(dir+=180,100);
  
  if (av==90) {  
/*    while (loc_y()>150) {
      drive(dir,100);
      QFire(); 
    } */
    while (loc_y()>100) {
      drive(dir,100);
      QFire(); 
    }
  } else {
/*    while (loc_y()<850) {
      drive(dir,100);
      QFire(); 
    } */
    while (loc_y()<900) {
      drive(dir,100);
      QFire(); 
    } 
  }
  while (speed()>80) drive(dir,0);

}


QFire()
{
    if (orng=scan(deg,10))
    {
        if (!scan(deg-=6,6)) deg+=12; 
        if (!scan(deg-=3,3)) deg+=6; 
                
        cannon(deg,(scan(deg,10)<<1)-orng);
/*        if (orng>770) deg+=40;  */

     }
     else
     {
        if (scan(deg-=20,10)) return QFire();
        if (scan(deg+=40,10)) return QFire();
        deg+=40; 
     }
}



Radar2()
{
  int rdeg;
  rdeg=0; n=0;
  while(rdeg<360) {
    if (scan(rdeg,10)) {
      cannon(rdeg,scan(rdeg,10));
      ++n;	
    }
    rdeg+=20;
  }
  return n;
}


Attacca()
{
  dir=0;
  while(1) {
    while (loc_x()<505) {
      Firef2f(drive(0,100));
    }
    while (speed()>65) drive(90,0);
    dir=90;

    while (loc_y()<505) {
      Firef2f(drive(90,100));
    }
    while (speed()>65) drive(180,0);
    dir=180;

    while (loc_x()>495) {      
      Firef2f(drive(180,100));
    }
    while (speed()>65) drive(270,0);
    dir=270;

    while (loc_y()>495) {     
      Firef2f(drive(270,100));
    }
    while (speed()>65) drive(0,0);
    dir=0;

  }
}

Firef2f()
{
    if (orng=scan(deg,10))
    {
        if (orng<620) 
        {
          if (orng<100) return cannon(deg,orng);
          if (scan(deg-10,6)) deg-=10;
          else if (scan(deg+10,6)) deg+=10;
          return cannon(deg,(scan(deg,10)<<1)-orng);   
        }
        if (!scan(deg-=6,6)) deg+=12; 

        if(scan(deg-7,3)) deg-=7;
        if(scan(deg+7,3)) deg+=7;
        if(scan(deg-4,2)) deg-=4;
        if(scan(deg+4,2)) deg+=4;
        if(scan(deg-2,1)) deg-=2;
        if(scan(deg+2,1)) deg+=2;

        if (orng=scan(odeg=deg,5))
        {
            if(scan(deg-7,3)) deg-=7;
            if(scan(deg+7,3)) deg+=7;
            if(scan(deg-4,2)) deg-=4;
            if(scan(deg+4,2)) deg+=4;
            if(scan(deg-2,1)) deg-=2;
            if(scan(deg+2,1)) deg+=2;

            cannon(deg+(deg-odeg)*((1200+(rng=scan(deg,10)))>>9)-(sin(deg-dir)>>14),
                   rng*250/(250+orng-rng-(cos(deg-dir)>>12))); 
        } 
     }
     else
     {
        if (scan(deg-=20,10)) return Firef2f();
        if (scan(deg+=40,10)) return Firef2f();
        if (scan(deg-=60,10)) return Firef2f();
        if (scan(deg+=80,10)) return Firef2f();
        if (scan(deg-=100,10)) return Firef2f();
        if (scan(deg+=120,10)) return Firef2f();
        if (scan(deg-=140,10)) return Firef2f();
        if (scan(deg+=160,10)) return Firef2f();
        if (scan(deg-=180,10)) return Firef2f();
        deg+=180; 
     }
}