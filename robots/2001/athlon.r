/*
Nome del robot  : Athlon
Nome del file   : Athlon.r
Autore          : Gianni Ino

Il robot all'inizio del match si reca nell'angolo piu' vicino, e controlla che
non sia uno scontro a singolar tenzone: se e' cosi' attacca con la routine fnale liberamente
ispirata a quella di marine.r.

Altrimenti utilizza la strategia di gioco di Daryl,r, campione uscente, leggermente
modificata per quanto riguarda i movimenti difensivi dopo l'80% di danni subiti.
Sono sparite le routine di fuoco ereditate da Tox, sostituite con quelle di
boom, che mi paiono piu' adatte contro avversari oscillanti.
A differenza di Pentium4.r, Athlon controlla ogni tanto se Š il caso di lasciare il
proprio angoletto. In caso si convinca che pu• farlo senza problemi scappa,
utilizzando una routine tratta da Vegeth.r

*/

int ang,verso,a,oang,r,or;
int dx,dy,sx,dw,x,y;
int inverti,how,count,dam;
int nrg,rg,t,b;
int park, ux, uy;               
int dan,vang;  
int dir, ango, oang, range, orange;     
int dang, alfa, corr, anco;

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
  while (Bus(dx,dy)<15000) spara(drive(verso,100));
  brakes();
  if (dan<damage()-10) {
        jump();
        dan=damage();
        dx=980-960*(sx=((x=loc_x(dy=980-960*(dw=((y=loc_y())<500))))<500));
        verso=225-180*dw+90*(sx^dw);
        }
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

brakes() { spara(drive(ang+=180,0));}

fire() {
  if (or=scan(a,10)) {
         if (r=scan(a,1))   return cannon(a,r);
    else if (r=scan(a-5,4)) return cannon(a-=3,r);
    else if (r=scan(a+5,4)) return cannon(a+=3,r);
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
            while(1) {
                         while(loc_x()>666) {drive(180,100); fire();}
                         while(loc_x()<666) {drive(0,100); fire();}
                         while(loc_y()<500) {drive(90,100); fire();}
                         while(loc_y()>500) {drive(270,100); fire();}
            }
}

Trova(mx,my)
int mx, my;
  {
     return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/mx)));
  }

jump()
  {
     if (!retrive(vang=verso+45))                 /*La scelta e' effettuata in maniera
                                                leggermente diversa dal solito*/
       {
         park=dy;
         dy=1000-dx;
         random(dx=park);
       }
     else
       if (!retrive(vang=verso-45))
         random(OooHoo(dy=park));
       else if (!retrive(vang=verso))
                  {
                     dy=1000-dy;
                     random(dx=1000-dx);
                  }
  }


random()
int f;
  {
     ux=loc_x(uy=loc_y());
     if (sin(vang)) uy=1000*(uy<500);                   /*Calcola le nuove coordinate della destinazione*/
     if (cos(vang)) ux=1000*(ux<500);
     while (Bus(ux,uy)>37000)
          {
               fuoco(vang+50);
               fuoco(vang-50);
          }
  }


OooHoo()                                                /*Effettua la rotazione degli angoli da controllare*/
  {
     park=dx;
     return(dx=(1000-dy));
  }

retrive(an)
int an;
  {
     return (scan(an+350,10))+(scan(an+10,10));
  }

Stop()                                                  /*Procedura di rallentamento speciale*/
  {                                                     
     drive (dir,40);
     ango+=10;
     while(!scan(ango+=21,10));
     fire();
  }

search()
  {
    if (TrovaB()) return 1;
    if (TrovaB(ango-=19)) return 1;
    if (TrovaB(ango+=38)) return 1;
    return 0;
  }


TrovaB()
{
if ( nrg = scan(ango,10) )  
 { if ( scan(ango+6,5) )
   {  if ( scan(ango+2,2) )
      {  if ( scan(ango+4,1) ) 
         {  if ( scan(ango+3,0) ) 
             ango+=3; 
	    else
             ango+=4;
	 }
	 else
            if ( scan(ango+2,0) )
             ango+=2; 
	    else
             ango+=1; 
      }
      else
      {  if ( scan(ango+8,1) ) 
         {  if ( scan(ango+7,0) ) 
             ango+=7; 
	    else
             ango+=9;
	 }
      else
         if ( scan(ango+6,0) )
            ango+=6; 
	 else
            ango+=5; 
      }
   }
   else
   {  if ( scan (ango-1,2) )
      {  if ( scan(ango-3,1) )
         {  if ( scan(ango-2,0) ) 
             ango-=2;
	    else
             ango-=3;        
	 }
	 else
           if ( scan(ango-1,0) )
            ango-=1;
	   else
            ango-=0;        
      }
      else
      {  if ( scan(ango-4,1) )
         {  if ( scan(ango-5,0) ) 
             ango-=5;
	    else
             ango-=4;        
	 }
	 else
           if ( scan(ango-6,1) )
            ango-=6;
	   else
            ango-=8;        
      }
   }
 return 1;
 }
return 0;
}

fuoco(a)
int a;
  {
     drive (dir=a,100);
     if (search())
       {
         drive(dir,100);
         shot();
       }
     else
         Stop();
  }

shot()
  {
     if (search(oang=ango))
       {    
         drive (dir,40);
         if (nrg<130)
           {
             if (nrg<50) return cannon(ango+(ango-oang)*3,2*scan(ango,10)-nrg);
             return fire();
           }
         corr=cos(alfa=(ango-dir)-((ango-dir)/360)*360);
         dang=ango+(ango-oang)*3-sin(alfa)/17600;
         if (rg=scan(ango,10))
           cannon (dang,rg*350/(350+nrg-rg-corr/3000));
         else   
            fire();
       }
     else
       Stop();
  }
