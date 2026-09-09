/*
Nome            : Dlrn.r
Autore		: Simone Ascheri

*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1,a1,a2;
int ang_pref;
int max,rng,mr,z,t,ang_p2;
int dove,oldr,rng,run,switch,dan,si;


int deg,odeg,dam,rng,dir,orng,x,y,b;

main()
{
  ang_pref=180*((dy=(loc_y()>500)*960+20)>500)+90*((dx=(loc_x()>500)*960+20)!=dy);

  while (1)
      {


	ang_p2=ang_pref+(a1=(ang_pref)%180);
	ang=ang_pref-90-a1;
	while(((loc_y(PallaDiFuoco(drive(ang,100)))%930)>70));

	flag1=Stop(ang=ang_pref+a1);

	drive(ang,100);
        while ((Dista(dx,dy)>3400))
        	{if (h>6500) PallaDiFuoco(h<25000);}

        Stop(s_lim=(i_lim=ang_pref-40)+150);

		while ((i_lim+=20)<=s_lim) 
			flag1+=(scan(i_lim,10)>0);

	if ((flag1<3) || (damage()>80 && flag1<4))
	{	
		att();
	}
	

	Fuo(ang=ang_pref+a1+38-76*(a1!=0));Fuo(ang);

        while ((Dista(dx,dy)<90000))
        	PallaDiFuoco(h>(80000+0+0));
	Fuo(ang=ang_pref-90-a1);
	Fuo(ang);
      } 
}

Dista(nx,ny)
int nx, ny;
  {
    return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }
 
Stop()
{
         PallaDiFuoco(PallaDiFuoco(drive(ang+=180,0)));
}

PallaDiFuoco(meglio)
int park,meglio;
{
  if (meglio);
  else if (scan(a,10))
    {
      if ((or=Rivela(drive(ang,100)))<850)
        {
          if (r=Rivela())                
             return cannon((oa+(a-oa)*3-(sin(a-ang)/19500)),(r*220/(220+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<850));
  else if((r=scan(a+=339,10)));
    else
      if((r=scan(a+=42,10)));
      else
        if((r=scan(ang_p2,10))){ a=ang_p2;}
        else
          return (a+=43);

  cannon (a,2*scan(a,10)-r);
}

Rivela()   
{
  if(scan((oa=a)-7,3)) a-=7;
  if(scan(a+7,3)) a+=7;
  if(scan(a-4,2)) a-=4;
  if(scan(a+4,2)) a+=4;
  if(scan(a-2,1)) a-=2;
  if(scan(a+2,1)) a+=2;
  return (scan(a,10));
}

Fuoco(dove)
{
    drive (dove,100);
    if (oldr=scan(a,10)) 
    {
           
           if (scan(a,2)){if ((cannon(a+0+0+0+0+0,3*scan(a,10)-2*oldr))) return;}
           else if (scan(a-=7,5)){if ((cannon(a-6+0+0,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=14,5)){if((cannon(a+7,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=10,5)){if((cannon(a+7,2*scan(a,10)-oldr))) return;}
	else a+=15;
    } 
        else if (rng=scan(a+=340,10)) return (cannon(a,rng));
        else if (rng=scan(a+=40,10))  return (cannon(a,rng));
        else if (rng=scan(a+=300,10)) return (cannon(a,rng));
        else if (rng=scan(a+=80,10))  return (cannon(a,rng));
        else if (rng=scan(a+=260,10)) return (cannon(a,rng));
        else if (rng=scan(a+=120,10)) return (cannon(a,rng));
        else if (rng=scan(a+=220,10)) return (cannon(a,rng));
        else if (rng=scan(a+=160,10)) return (cannon(a,rng));
        else if (rng=scan(a+=180,10)) return (cannon(a,rng));
	else a+=270;
	return Fuoco(dove);
}
Fuo(dove)
{
    drive (dove,100);
    if ((oldr=scan(a,10)) &&(oldr<850))
    {
           if (scan(a,2)){if ((cannon(a+0+0+0+0+0,3*scan(a,10)-2*oldr))) return;}
           else if (scan(a-=7,5)){if ((cannon(a-6+0+0,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=14,5)){if((cannon(a+7,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=10,5));
	   else a+=15;
	return Fuo(dove);
    } 
  else PallaDiFuoco(1);
}

fuoco() 
{
  if (scan(deg,10));
  else if (scan(deg+=21,10));
  else if (scan(deg-=42,10));
  else if (scan(deg+=63,10));
  else if (scan(deg-=84,10));
  else {
        if (orng=scan(deg+=105,10)) return cannon(deg,orng);
        else if (orng=scan(deg-=126,10)) return cannon(deg,orng);
        else if (orng=scan(deg+=147,10)) return cannon(deg,orng); 
        else if (orng=scan(deg-=168,10)) return cannon(deg,orng);
	else if ((orng=scan(deg+=189,10))) return cannon(deg,orng);
	else if ((orng=scan(deg-=210,10))) return cannon(deg,orng);
		else return deg-=100;
  }

  if (scan(deg-18,10)) deg=deg-7; else deg=deg+0; if (scan(deg+18,10)) deg=deg+7; else deg=deg+0;
  
  if (orng=refine()) {
    if (rng=refine(odeg=deg))
      return cannon(deg+(deg-odeg)*((1200+rng)>>9)-(sin(deg-dir)>>14),
                    rng*192/(190+orng-rng-(cos(deg-dir)>>12)));
  } 
}

refine() {
  if (scan(deg+13,10)) deg+=5; if (scan(deg-13,10)) deg-=5;
  if (scan(deg+12,10)) deg+=3; if (scan(deg-12,10)) deg-=3;
  if (scan(deg+10,10)) deg+=1; if (scan(deg-10,10)) deg-=1;
  return scan(deg,10);

}

spara()
{
    drive(dir,100);
	
       if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,5)) deg-=5;
                                else ++deg;
                        }  else if (scan(deg-5,5)) deg-=5;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                        else --deg;
                }  else if(scan(deg+4,5)) deg+=5;
                else deg-=5;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=20,10)));
	else {
		if ((orng=scan(deg-=81,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=122,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=164,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=21,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=206,10))) return cannon(deg,orng);
		else return deg+=100;
	}
        if (rng=scan(deg,10)){  
                cannon (deg, 2*rng-orng); /*rng*145/(145+orng-rng) ); */
        }  else if (rng=scan(deg-=20,10)) cannon(deg,rng); 
		else if (rng=scan(deg+=40,10)) cannon(deg,rng); 
		else deg+=40;
} 


att()
{
	if (loc_y(x=(loc_x()>500))>500) {
        if (x) deg=195; else deg=285;
    } else {
        if (x) deg=105; else deg=375;
    }
	spara(dir=180*x);
	
    while(1) {
		if (orng>580) dir=deg+25+(b^=1)*225;
		else if (orng>100) dir=deg+80+(b^=1)*200;
        else dir=(deg/90)*90;                               
       
		if ((x=loc_x(y=loc_y()))>835) dir=165+30*(y>500);
        else if (x<165) dir=345+30*(y<500);
        else if (y>835) dir=255+30*(x<500);
        else if (y<165) dir=75+30*(x>500);
		else if(dam>75) dir+=180;
        
		dam=damage(spara());
		
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		
		spara();
        
		if(orng>485) fuoco(drive(dir,100));
    }
}
