/*
MARKO.R

Serino Marco

Tattica:

Dato che non sono un ottimo programmatore questo robot e` il connubio perfetto
della mia genialita` e della tecnica programmatica di mio fratello. Questo
robot non e` nient`altro che la sublimazione di Goblin ed e` sostanzialmente
statico. Il comportamento e` molto simile a quello di Dario eccettuato il
fatto che non si espone mai (nemmeno con soli due superstiti) e che quando fugge
in un angolino occupato sceglie quello in cui trova il nemico piu` lontano.
Per tutte le informazioni implementative e` inutile che sia io a spiegarvele
dato che non ci capisco troppo, quindi fate riferimento a mio fratello.
*/

int dir,deg,odeg,rng,orng,dam,count;
int attack,normal;
int hidd_x,hidd_y;
int sx,dw,xor;

main() {
  sd(sx=loc_x(du(dw=loc_y()>(count=(deg=500))))>500);

  while(1) {
    xor=dw^sx;

    if (attack);
    else stop(dam=damage()+4);

    if (escape(20*xor)) sd();
    else du();
  }
}

escape(xor20) {
  int r1,r2;

  if (((r1=scan(190+180*sx-xor20,10))==0) && (sx));
  else return ((r2=scan(260-180*dw+xor20,10)) && (r1>r2));
}

stop() {
  int lim,sign;
  int clock,i;

  while((!orng || (orng>550)) && (damage()<dam)) {
    if (hidd_x) {
      lim=500*(sign=2*sx-1)-490;
      hidd_x^=drive((dir=270+90*sign)+180,40);
      while((sign*loc_x())>lim);
      drive(dir,0);
    }
  
    if (hidd_y) {
      lim=500*(sign=2*dw-1)-490;
      hidd_y^=drive((dir=90*sign)+180,40);
      while((sign*loc_y())>lim);
      drive(dir,0);
    }

    if (count>8) {
      deg=532+180*dw+90*xor;
      count=(i=24); while(i && (count>20))
        if (scan(deg+15*((--i)%8),7)) --count;

      if (count/=21) {
        if (dam>(attack=90)) return;
        else {
          dir=deg+53;
  
          while(normal=3) {
            drive(dir%=360,100);
  
            if (dir>=270)      while(focus() && loc_y()>280);
            else if (dir>=180) while(focus() && loc_x()>280);
            else if (dir>=90)  while(focus() && loc_y()<720);
            else               while(focus() && loc_x()<720);
  
            if (normal) dir+=180;
            else        dir=( ((deg+180)/90) + (clock^=1) )*90;
        
            bomb();
          }
        }
      }
    }
    focus(1);
  }
}

focus(hidden) {
  if (orng=scan(deg,10));
  else if (orng=scan(deg-=21,10));
  else if (orng=scan(deg+=42,10));
  else {deg+=42; return --normal;}

  if (orng<150) return cannon(deg,orng);
  else if (attack);
  else if (orng>735) {++count; return deg+=42;}

  if (scan(deg-=5,5)); else deg+=10;
  if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
  if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
  if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;
  if (orng=scan(odeg=deg,5)) {
    if (scan(deg+5,2)) deg+=5; if (scan(deg-5,2)) deg-=5;
    if (scan(deg+3,1)) deg+=3; if (scan(deg-3,1)) deg-=3;
    if (scan(deg+1,1)) deg+=1; if (scan(deg-1,1)) deg-=1;

    if (rng=scan(deg,10)) {
      if (hidden)
        cannon(deg+(deg-odeg)*((1200+rng)>>9),rng*172/(172+ orng-rng));
      else
        cannon(deg+(deg-odeg)*((1200+rng)>>9)- (sin(deg-dir)>>14),
               rng*172/(172+ orng-rng- (cos(deg-dir)>>12)));

      if (attack)
        if (deg==odeg) return normal>>=1;
        else return --normal;
      else return count=0;
    }
  }
}

bomb(newdir) {
  drive(dir+newdir,0);

  while (speed()>50)
    if (orng=scan(deg,10)) {
      if (rng=scan((deg=(6*(scan((deg+=(10*(scan((odeg=deg)+10,10)>0)-5))+10,10)>0)-3)+deg),10))
        cannon(deg+(deg-odeg),rng+(rng-orng)*2);
    }
    else if (scan(deg-=21,10));
    else if (scan(deg+=42,10));
    else deg+=42;
}

sd() {
  int sign,lim;

  lim=500*(sign=2*(sx^=1)-1)-350;
  drive(dir=90+90*sign,100);
  while((sign*loc_x())>lim) focus();

  return hidd_x=bomb(180);
}

du() {
  int sign,lim;

  lim=500*(sign=2*(dw^=1)-1)-350;
  drive(dir=180+90*sign,100);
  while((sign*loc_y())>lim) focus();

  return hidd_y=bomb(180);
}
