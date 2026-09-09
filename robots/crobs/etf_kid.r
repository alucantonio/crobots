/* etf_kid - created by KOSTA DIMOVSKI   Skopje, Macedonia */

main()
{ while(1)
   { postavi(500,100,0);
     postavi(850,700,0); 
     postavi(150,700,60);
     postavi(300,150,180);
     postavi(850,300,300);       /* destination points */
     postavi(700,850,30);
     postavi(100,500,110);
     postavi(700,150,210);
     postavi(500,900,330);
     postavi(150,300,100);
     postavi(900,500,240);
     postavi(300,850,30);
   }
}

distance(x1,y1,x2,y2)
int x1,y1;
int x2,y2;
{ int x,y;
  int d;
  x=x1-x2;
  y=y1-y2;
  d=sqrt(x*x+y*y);
  return(d);
}

/* course function */

kurs(celx,cely)
int celx,cely;    /* (celx,cely) is destination */
{ int a;
  int x,y;
  int scl;
  int sega_x,sega_y;
  scl=100000;
  sega_x=loc_x();
  sega_y=loc_y();
  x=sega_x-celx;
  y=sega_y-cely;
  if(x==0)
      if(cely>sega_y)
          a=90;
       else
          a=270;
   else
     if(cely<sega_y)
        if(celx>sega_x)
           a=360+atan(scl*y/x);
         else
           a=180+atan(scl*y/x);
      else 
        if(celx>sega_x)
           a=atan(scl*y/x); 
	 else
           a=180+atan(scl*y/x);      
  return(a);
}

postavi(xk,yk,ak)
int xk,yk,ak;
{ int agl;     /* angle heading to destination (xk,yk) */
  int dd;      /* direction */
  int rg;      /* range to target */
  drive(ak,0);
  dd=0;        
  agl=kurs(xk,yk);
  drive(agl,100);
  while(distance(loc_x(),loc_y(),xk,yk)>45)
    { if((rg=scan(agl+dd,9))>0)
        cannon(agl+dd,rg); 
      if(rg<700&&rg>0)
        dd-=7;
       else dd+=21;         
      drive(agl,100);
    }
  drive(agl,0);
}
