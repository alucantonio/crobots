/*
Nome            : Eurialo - micro
Versione        : 1.0
Autore		: Simone Ascheri


Commento
========

Trattasi di Nemo... aggiornato????
Ho cambiato qualche costante ma non ho nemmeno testato
*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1;
int ang_pref;
int max,rng,mr;

main()
{
  ang_pref=180*((dy=(loc_y(max=80000)>500)*960+20)>500)+90*((dx=(loc_x(mr=850)>500)*960+20)!=dy);

  while (flag1=1)
      {


        if (max==80000)
	{
		ang=ang_pref-82;
		if ((ang_pref)%180)
			while(((loc_x(PallaDiFuoco(drive(ang,100)))%930)>70));
		else
			while(((loc_y(PallaDiFuoco(drive(ang,100)))%930)>70));

		ang=ang_pref;
	}

	Stop();

	drive(ang,100);
        while ((Dista(dx,dy)>3380))
                {if (h>6500) PallaDiFuoco(h<22000);}

        Stop(s_lim=(i_lim=ang_pref-40)+150);

        if (max==80000)
	{
		while ((i_lim+=20)<=s_lim) 
			flag1+=(scan(i_lim,10)>0);

		if (flag1<3)
		{	
                        mr=max=530000;
		}
	}
	

	drive(ang=ang_pref+38,100);
        while ((Dista(dx,dy)<max))
        	PallaDiFuoco(h>(max-20000));
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
             return cannon((oa+(a-oa)*3-(sin(a-ang)/18500)),(r*192/(192+or-r-(cos(a-ang)/4167))));
        }
    }      
  if((r=scan(a,10))&&(r<mr));
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



