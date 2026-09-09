/*
Nome            : Jeeg


*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1,a1,a2;
int ang_pref;
int max,rng,mr,z,t,ang_p2;
int dove,oldr,rng,run,switch,dan,si;

int oang, range, posx, posy, b, dir;

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

	if ((flag1<3))
	{	
		boom();
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
        if((r=scan(ang_pref,10))){ a=ang_pref;}
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
	
	if ((r=scan(oang=a,10))) {
		if (scan(a-8,5))  { if (scan(a-=5,2)) ; else a-=4; return(cannon(a+(a-oang),2*scan(a,10)-r)); }
		if (scan(a+8,5))  { if (scan(a+=5,2)) ; else a+=4; return(cannon(a+(a-oang),2*scan(a,10)-r)); }
		if (scan(a,10))     { if (scan(a-=3,2)) ; else a+=6; return(cannon(a+(a-oang),2*scan(a,10)-r)); }
	} 
		if (r=scan(a+=340,10)) return cannon(a,3*scan(a,10)-2*r);
		if (r=scan(a+=40,10)) return cannon(a,3*scan(a,10)-2*r);
		a+=20;

}


boom()	/*attacco del f2f*/
{

	int b=0;
		while(1) {
			
                        if ((posx=loc_x(posy=loc_y()))>880 ) dir=160+40*(posy>500);
                        else if (posx<120 ) dir=340+40*(posy<500);
                        else if ((posy)>880 ) dir=250+40*(posx<500);
                        else if (posy<120) dir=70+40*(posx>500);                        
			else if (range>600) dir=ang+25+(b^=1)*235;
			else if (range<150) dir=ang+170+(b^=1)*25;
			else dir=ang+180*(b^=1);
					
			
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			fuoco(drive(dir,100));
			
			drive(dir,60);
                       
                }
            
}

