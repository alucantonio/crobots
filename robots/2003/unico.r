/*
Robot programmato da Roberto Bevilacqua

Perchè non spingere oltre l'esperimento? A che livello può arrivare un robot del 1999 messo di fronte agli avversari del 2003?
Per scoprirlo Dario.r è stato sottoposto a un leggerissimo restyling, sostituendo il suo attacco finale con quello di un robot 2k3?

vincerà la sfida con il suo 'gemello'?!
*/

int dir,deg,odeg,rng,orng,dam,count;
int attack,normal,clock;
int hidd_x,hidd_y;
int sx,dw,far;
int dx,dy,a,oa,r,rng,or,oldr;

main() {
  int r1,r2;


  sx=loc_x(dw=loc_y()>(count=(deg=500)))>500;
  eludi(eludi());

  while(1) {

    if (attack);
    else accerta(dam=damage());


    if (((r1=scan(190+180*sx,10)+scan(169+180*sx,10))==0) && (sx)) eludi(1);
    else eludi((r2=scan(280+180*dw,10)+scan(259+180*dw,10)) && (r1<r2));
  }
}

accerta() {                                               
  int lim,sign,xor,three;

  while((!orng || (orng>550)) && (damage()<dam+4)) {

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


    if (count>10) {
      deg=532+180*dw+90*(xor=dw^sx);
      count=(three=24); while(three && (count>17))
        if (scan(deg+15*((--three)%8),7)) --count;


      if (count/=21) {
	if (damage()>(attack=90));else Multa();
          
        
      }

    }
    studia(1);
  }
}

studia(hidden) {

  if (orng=scan(deg,10));
  else if (orng=scan(deg-=21,10));
  else if (orng=scan(deg+=42,10));
  else {deg+=42; return --normal;}


  if (orng<150) return cannon(deg,orng);
  else if (attack);

  else if (orng>850) {++count; return deg+=42;}

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

      if (attack);
      else return count=0;
    }
  }
}


eludi(horz) {
  int sign,lim;

  if (horz) sign=2*(sx^=1)-1;
  else sign=2*(dw^=1)-1;

  lim=500*sign-350+far;
  drive(dir=90*(sign+2-horz),100);

  if (horz) {while((sign*loc_x())>lim) studia(); hidd_x=1;}
  else      {while((sign*loc_y())>lim) studia(); hidd_y=1;}

  studia(drive(dir+=180,0));
}

Multa()
int z;
  {
	while (1)
	{	
			dx=1000-loc_x();
			while((loc_x()>dx)==(z=(dx<500))) 
			{
				
				if(loc_y()>500)
				{
					autotutela(275-10*z);
				}
				else
				{
					autotutela(85+10*z);
				}
			}
	}

  }

autotutela(verso)
{
	drive (verso,100);
    if (or=scan(a,10)) {
           if (scan(a,2))		{if (cannon(a+0+0+0+0,3*scan(a,10)-2*or)) return;}
           else if (scan(a-=7,6))	{if (cannon(a-6,2*scan(a,10)-or)) return;}
           else if (scan(a+=14,6))	{if (cannon(a+6,2*scan(a,10)-or)) return;}
	   else a+=10;
	   return autotutela(verso);
    } 
    else {
        if (or=scan(a+=339,10))		cannon(a,or);
        else if (or=scan(a+=42,10))	cannon(a,or);
        else if (or=scan(a+=297,10))	cannon(a,or);
        else if (or=scan(a+=84,10))	cannon(a,or);
        else {a+=65;return autotutela(verso);}
    }
}



