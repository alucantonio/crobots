/*
Nome            : Goldrake
Autore		: Simone Ascheri

*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1;
int ang_pref;
int max,rng,mr,z,t;
int dove,oldr,rng,run,switch,dan,si;

int oang, range, posx, posy, b, dir;

main()
{
  ang_pref=180*((dy=(loc_y()>500)*960+20)>500)+90*((dx=(loc_x()>500)*960+20)!=dy);

  while (ang=ang_pref-82)
      {

		if ((ang_pref)%180)
			while(((loc_x(PallaDiFuoco(drive(ang,100)))%930)>70));
		else
			while(((loc_y(PallaDiFuoco(drive(ang,100)))%930)>70));

		

	flag1=Stop(ang=ang_pref);

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
	

	if ((flag1>3))
	{	
	Fuo(ang+=38);Fuo(ang);

        while ((Dista(dx,dy)<90000))
        	PallaDiFuoco(h>(80000));
	Fuo(ang-=120);
	Fuo(ang);
	}
	else
	{	
	Fuo(ang);Fuo(ang);

        while ((Dista(dx,dy)<60000))
        	PallaDiFuoco();
	      }
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
        if((scan(ang_pref,10))) a=ang_pref;
        else
    a+=20;
}

fuoco()
{
	
	if ((range=scan(oang=ang,10))) {
		if (scan(ang-8,5))  { if (scan(ang-=5,2)) ; else ang-=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang+8,5))  { if (scan(ang+=5,2)) ; else ang+=4; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
		if (scan(ang,10))     { if (scan(ang-=3,2)) ; else ang+=6; return(cannon(ang+(ang-oang),2*scan(ang,10)-range)); }
	} 
	else {
		if (range=scan(ang+=340,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=40,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=300,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=80,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=260,10)) return cannon(ang,3*scan(ang,10)-2*range);
		if (range=scan(ang+=120,10)) return cannon(ang,3*scan(ang,10)-2*range);
		ang+=80;
	}
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

