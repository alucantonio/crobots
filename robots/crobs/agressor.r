/*Agressor Robot for use with CROBOTS*/
/*Agressor is programmed to locate targets quickly and destroy*/
main()  /*define main routine*/
{
  int degrees;  /*scanning direction*/
  int n;  /*distance from target*/
  int a;  /*direction of motion*/
  int dam;  /*damage check results*/
  while (1) {  /*infinite loop*/
    while (scan (degrees,10) < 40) {  /*scan 20 deg at a time until true*/
      dam = damage () + 15;  /*damage check, set damage toleration*/
      degrees += 20;
      }
    degrees -= 10;  /*Adjustment*/
    n = 0;
    while (n < 40) {  /*pinpoint target*/
      degrees += 1;
      n = scan (degrees,0);
      if (dam < damage ()) {  /*check damage, if excessive gosub evade*/
        n = 1000;  /*reset scanning*/
        evade ();
        }
      if (speed () > 0) {  /*if moving gosub look*/
        look (a);
        }
      }
    if (n > 600) {  /*if target is nearly or totally out of range,*/
      drive (degrees,100);  /*move towards target*/
      a = degrees;
      }
    while (n > 40 && n < 700) {  /*fire if target in sight and range*/
        cannon (degrees,n);
        if (speed () > 0) {  /*if moving gosub look*/
          look (a);
          }
        n = scan (degrees,4);
        if (dam < damage ()) {  /*check damage, if exessive gosub evade*/
          n = 1000;  /*cease fire, reset scanning*/
          evade ();
          }
        }
      degrees = 0;  /*reset scanning*/
    }
  }    
look (a)  /*look ahead*/
{
  int m;
  int a;
  m = scan (a,1);
  if (m < 400) {  /*avoid proximity with walls or robots*/
    drive (0,0);
    }
  }
evade ()  /*evasive menuvers*/
{
  int i;
  i = 0;
  if (loc_x () < 500) {  /*test x position*/
    drive (0,100);       /*move east*/
    while (i ++ < 75);   /*delay*/
    }
  if (loc_x () > 500) {  /*test x position*/
    drive (180,100);     /*move west*/
    while (i ++ < 75);   /*delay*/
    }
  drive (0,0);           /*stop*/
  }
/*end*/
  