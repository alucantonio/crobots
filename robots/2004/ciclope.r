/*
Nome: 	ciclope.r	(micro)
Autore: 	Franco Cartieri

Torneo 2004

Ciclope.r e' un microcrobots che deriva da Kyash_3m.r che ha partecipato al torneo 2003.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo i lati di un triangolo.
Ad ogni ciclo controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
La routine di attacco finale e' un triangolo molto allungato su un lato del campo di gioco.
Rispetto a Kyash_3.r e' stata cambiata la routine di fuoco e la routine di attacco finale.
*/

int ang_pref, dx, dy, angdir, s_lim, i_lim, cr;
int a, oa, r, or, h, md, mr, f2f;

main()
{
	f2f=0;
	s_lim=(ang_pref=180*((dy=(loc_y(md=100000)>500)*960+20)>500)+90*((dx=(loc_x(mr=770)>500)*960+20)!=dy))+110;
    	while(cr=1)
	{
		angdir=ang_pref+135+(45*f2f);
		if(ang_pref%180)
			while(((loc_y(Fuoco(drive(angdir,100)))%930)>75));
		else	while(((loc_x(Fuoco(drive(angdir,100)))%930)>75));
		Stop(angdir=ang_pref+270);
		drive(angdir,100);
     	 	while ((Distanza(dx,dy)>3400))
			if (h>6500) Fuoco(h<25000);
		Stop(i_lim=ang_pref-40);
		if(f2f==0)
		{	
			while((i_lim+=20)<=s_lim) 
				cr+=(scan(i_lim,10)>0);
			if (cr<3)
			{	
				f2f=1;
				md=mr=750000;
			}
		}
		drive(angdir=ang_pref+(70*f2f),100);
	      while(Distanza(dx,dy)<md)
			Fuoco(h>(md-20000));
	}
}

Distanza(nx,ny)
int nx, ny;
{
   	return (h=((nx-=loc_x())*nx+(ny-=loc_y())*ny));
}
 
Stop()
{
	Fuoco(Fuoco(drive(angdir,0)));
}

Fuoco(meglio)
int meglio;
{
  	if (meglio);
  	else if (scan(a,10))
    	{
      	if ((or=Rivela(drive(angdir,100)))<mr)
        	{
          		if (r=Rivela())                
             		return cannon((oa+(a-oa)*3-(sin(a-angdir)/19500)),(r*220/(220+or-r-(cos(a-angdir)/4167))));
        	}
    	}      
  	if((r=scan(a,10))&&(r<mr));
  	else 	if((r=scan(a+=339,10)));
    		else	if((r=scan(a+=42,10)));
      		else	if(r=scan(angdir,10)) a=angdir;
        			else	return (a+=43);
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
