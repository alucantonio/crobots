/*
Nome del robot  : Attila
Nome del file   : Attila.r
Autore          : Gianni Ino

Il robot all'inizio del match si reca nell'angolo piu' vicino, e controlla che
non sia uno scontro a singolar tenzone: se e' cosi' attacca con la routine finale che è identica
a quella dei miei due microbi.

Altrimenti utilizza la strategia di gioco di Athlon.r, leggermente
modificata.
Inoltre non controlla più se deve cambiare angolo.... non si stacca da quello iniziale.

*/

int ang,verso,a,oang,r,or;
int dx,dy,sx,dw,x,y;
int inverti,how,count,dam;
int nrg,rg,t,b;
int park, ux, uy;               
int dan,vang;  
int dir, ango, oang, range, orange;     
int dang, alfa, corr, anco,dir,ang;

main() {
  int delta;
  dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));

  if (x-=dx) a=540+180*(x>0)+atan(((y-dy)*100000)/x);
  else a=630-180*dw;

  drive(ang=a+180,100);
  while(Bus(dx,dy)>5200) spara();
  brakes();

  cache(ang=(verso=225-180*dw+90*(sx^dw)));

  how=65000; delta=45;
  dan=damage();

  while(cache()) {
    if (or && (or<770)) {
      dam=damage();
      loop(verso+90*inverti-45);
      if (damage()>dam+8) {how=65000; delta=21-delta; inverti^=1;}
    }
    else if ((r=scan(verso+delta-21,10)+scan(verso+delta,10))&&(r<770)) {
      loop(a=verso+90*(inverti^=1)-45);
      how=65000; delta=21-delta;
    }

    else {
      if (scan(verso-delta,10)+scan(verso-delta+21,10)) {
        if (r);
        else if (scan(verso,10));
        else f2f();

        branchprediction();
      }
      else if (r) {
        if (scan(verso,10));
        else f2f();

        how=65000; delta=21-delta;
        branchprediction(inverti^=1);
      }
      else f2f();
    }

    if (damage()>80)
      while (1) cache();
  }
}

Bus(nx,ny)
int nx, ny;
  {
    return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

loop(look) {
  count=2;

  while(count) {
    cache();

    if (or && (or<770)) count=2;
    else if ((r=scan(look,10)) && (r<770)) {a=look; count=2;}
    else --count;
  }
}

cache() {
  spara(spara(fire(fire(spara(fire(drive(verso,100)))))));
  brakes();
  Trova(dx,dy);
  while (Bus(dx,dy)>7200) spara(drive(ang,100));
  brakes();
  return ang=verso;
}

branchprediction() {
  a=verso+90*inverti-45;

  fire(drive(ang+=60*inverti-30,100));
  while(Bus(dx,dy)<how)
    if (r>800) spara(); else fire();
  brakes(how+=1000);

  fire(drive(ang,100));
  while(Bus(dx,dy)>5200) spara();
  brakes();

  return ang=verso;
}

brakes() { spara(spara(drive(ang+=180,0)));}

fire() {
  if (or=scan(a,10)) {
         if (r=scan(a,1))   return cannon(a,2*scan(a,10)-r);
    else if (r=scan(a-5,4)) return cannon(a-=3,2*scan(a,10)-r);
    else if (r=scan(a+5,4)) return cannon(a+=3,2*scan(a,10)-r);
  }
  else if (r=scan(a-=20,10)) return cannon(a,r);
  else if (r=scan(a+=40,10)) return cannon(a,r);
  else return a+=40;
}


f2f() {
  int three;

  oang=verso-53;
  count=(three=16); while(three && (count>11))
    if (scan(oang+15*((--three)%8),7)) --count;

  if (count>=14)
      pipeline();
}

spara()
{ 
        ++t; 
        if (find());
        else if (find(a-=20));
        else if (find(a+=40));
        else if (!(r=scan(a+=20,10))) { 
                if ((r=scan(a+=21,10))) { 
                        if (r>800) {
                                cannon (a,700);
                                return; 
                        } 
                } else { 
                        if (!(scan(a+=21,10))) a+=40; 
                        return; 
                } 
	} 
        if (nrg=or=scan(a,10)){  
                cannon (a, or*165/(165+r-or) ); 

        }  else if(scan(a-20,10)) a-=20; 
        else if(!scan(a+=21,10)) a+=57; 
} 

find()
{
        if ((r=scan(a, 10)) ) { 

                if (scan(a-8,4)) { 
                        if (scan(a-=8+3,2)) { 
                                if(scan(a+=3-2,1)) a-=2;
                        }  else if (scan(a-3,2)) a-=3;
                } else if(scan(a+8,4)) { 
                        if (scan(a+=8+3,2)) a+=3;
                        else --a;
                }  else if(scan(a+3,2)) a+=3; 
                else --a;
               return 1;
             }
         else return 0;
}

pipeline()
int an;
{
                       b=0;
                       dir=45+180*(loc_y()>500)+90*((loc_x()>500)==(loc_y()<500));
                       ang=dir+180*(loc_x()>500);

                       while (1)
                       {
                          if (loc_x()<500) fire(drive(dir=ang,100));
                          else fire(drive(dir=ang+180,100));	
                       }
}

Trova(mx,my)
int mx, my;
  {
     return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/mx)));
  }

retrive(an)
int an;
  {
     return (scan(an+350,10))+(scan(an+10,10));
  }

