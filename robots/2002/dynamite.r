/*


Dynamite ver. 0.5 (C) Lorenzo Ancarani 2002


Architettura: ClassicBot


Strategia   : il suddetto esemplare raggiunge l'angolo piu' vicino e poi oscilla
              in una delle due direzioni, preferibilmente in quella con il nemico
              più lontano. 
              La lunghezza dell'attacco dipende dalla distanza del nemico;
              ogni certo numero di oscillazioni conta i superstiti, e se ha un unico nemico lo
              attacca con microdna.


*/



int tempo,b,clock,d,dx,dy,dir,p1,p2,a,oa,or,r,ext,str;
int a,rng,dir,oa,orng,n,xm,ym,t,clk;


main() {
   
aree(dx=20+960*(p1=(loc_x()>500)),dy=20+960*(p2=(loc_y()>500)));
   while (1) { 
      b=(p2)*180+(p1!=p2)*90;
      while (dist(dx,dy)>5000) shot(d>28000);
      drive (dir+=180,0);
      if ((++t%15)==1) Banzai();


      if (scan(dir=b,10)>scan(90+b,10)) dir+=90;
      ext=(or-=245)*or;
      if ((ext<10000)||(ext>80000)) ext=10000;


      while(dist(dx,dy)<ext) shot(1);
      drive(dir+=180,0);
   }
}



aree(x,y)
int x,y;
{
   return(dir=(360+((x-=loc_x())<0)*180+atan(((y-loc_y())*100000)/x)));
}


dist(x,y) /* Distanza al quadrato (evita una sqrt())   */
int x,y;
{
        return (d=((x-=loc_x())*x+(y-=loc_y())*y));
}



int shot(best)
int best;
{
 drive(dir,100);
 if (best)
  if (scan(a,10))
    {
      if ((or=scan_())<850)
        {
          if (r=scan_())                
             return cannon((oa+(a-oa)*3-(sin(a-dir)/19500)),(r*200/(200+or-r-(cos(a-dir)/4167))));
        }
    }      
         if ((or=scan(a,10))&&(or<850)) {
            if (scan(a+353,4)) a+=350;
            else if (scan(a,4)) ;
            else if (scan(a+7,4)) a+=10;
            cannon(a,3*scan(a,10)-2*or);}
  else
    if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(dir,10))) a=dir;
        else
          return (a+=40);
  cannon (a,2*scan(a,10)-r);
}


scan_()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}



Banzai()
{
  
        oa=n=0;
        while((oa+=20)<=360) if (scan(oa,10)) ++n;      
  while (n<=1) {
    
    while (loc_x()<=500) {
      shot(dir=360);
    }
    Turn(90);


    while (loc_y()<=500) {
      shot(dir=90);
    }
    Turn(180);


    while (loc_x()>500) {      
      shot(dir=180);
    }
    Turn(270);


    while (loc_y()>500) {     
      shot(dir=270);
    }
    Turn(0);
  }


}


Turn(d)
{
  while (speed()>65) drive(d,0);
  dir=d;
}