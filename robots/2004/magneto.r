/*
Nome: 	magneto.r	(micro)
Autore: 	Franco Cartieri

Torneo 2004

Magneto.r e' un microcrobots che prende spunto da Nemo.r che ha partecipato al torneo 2003.
All'inizio dell'incontro si posiziona nell'angolo piu' vicino e si muove lungo due triangoli disegnati 
sui lati dell'angolo.
Ad ogni ciclo controlla se sia rimasto solo un robot: in questo caso passa alla routine di attacco finale.
La routine di attacco finale consiste solamente nell'allungare i lati dei triangoli.
A differenza di Nemo.r, la strategia e' simmetrica.
*/

int ang_pref, dx, dy, angdir, md, mr;
int t, h, a, oa, r, or, cr, s_lim, i_lim;

main()
{
	s_lim=(ang_pref=180*((dy=(loc_y(md=250000)>500)*960+20)>500)+90*((dx=(loc_x(mr=770)>500)*960+20)!=dy))+110;
    	while(cr=1)
      {	
		if((angdir=ang_pref+180+90*((t+=1)%2))%180)
			while(((loc_y(Fuoco(drive(angdir,100)))%930)>75));
		else	while(((loc_x(Fuoco(drive(angdir,100)))%930)>75));
		angdir=ang_pref+270-90*(t%2);
		Stop();
		drive(angdir,100);
     	 	while((Distanza(dx,dy)>3400))
			if(h>6500) Fuoco(h<25000);	
		Stop(i_lim=ang_pref-40);
		if(md==250000)
		{
			while ((i_lim+=20)<=s_lim) 
				cr+=(scan(i_lim,10)>0);
			if(cr<3)
				md=mr=750000;
		}
		drive(angdir=ang_pref+20+50*(t%2),100);
		while((Distanza(dx,dy)<md))
			Fuoco(0);
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
  	if(meglio);
  	else if(scan(a,10))
    	{
      	if((or=Rivela(drive(angdir,100)))<mr)
        	{
          		if(r=Rivela())                
             		return cannon((oa+(a-oa)*3-(sin(a-angdir)/19500)),(r*220/(220+or-r-(cos(a-angdir)/4167))));
        	}
    	}      
  	if((r=scan(a,10))&&(r<mr));
  	else 	if((r=scan(a+=339,10)));
    		else 	if((r=scan(a+=42,10)));
      		else	if(r=scan(ang_pref,10)) a=ang_pref;
        			else return (a+=43);
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
