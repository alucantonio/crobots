/*
Robot programmato da Roberto Bevilacqua
Torneo di Crobots 2004.

Ire ha cambiato nome e sta cercando di dimagrire!.
*/

int park, ux, uy, dx, dy;                               /*Variabili posizionali*/
int flag, vang, ang, ang2;                              /*Variabili direzionali*/
int dan, timmax;                                        /*Variabili temporali*/
int dir, ango, oang, r, or;                     	/*Variabili balistiche*/
int dang, alfa, corr, anco, nrg, rg;
int max, clock, gira, time, klik, scn;
int a,oldr,rng,oa,ang_pref,dove,si,or,r,h;
int fx,fy,x1,y1;
main()                             
{

/*Calcola coordinate iniziali e agolo principale*/

dy=20+960*(y1=(loc_y(dx=20+960*(x1=(loc_x(max=65000)>500)))>500));
ang=(180+((fx=dx-loc_x(ang2=(y1)*180+(x1!=y1)*90))<0)*180+atan(((dy-loc_y())*100000)/(fx+(fx==loc_x()))));

/*Ciclo principale*/

while (corr=1)
{
	drive (ang+=180,100); 	                
	while ((h=Liquidazione(dx,dy))>5200)
		Sovrattassa(h<25000);

	Sovrattassa(Sovrattassa(drive(ang,0)));

	if (flag==45);
	else
	{
	dang=ang2-180;
	while((dang+=20)<=ang2+40) corr+=(scan(dang,10)>0);	

	
	if (corr<3) 
	{
		flag=45;
		max=1100000;
	}

	
	else
	if (damage()>70) flag=405;
	else flag=90-flag;
	}
	drive (ang_pref=ang=(ang2+flag),100);       /*Si allontana dall' origine*/
	while ((Liquidazione(dx,dy)<max))
		Sovrattassa();
   
	Sovrattassa(Sovrattassa(drive(ang,0)));

}

}

Liquidazione(nx,ny)                                            /*Calcola la distanza rispetto ad un punto dato*/
int nx, ny;
  {
     return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

Indaga(an)
int an;
  {
     return (scan(an+350,10))+(scan(an+10,10));
  }


Sovrattassa(si)
  {
  if (si);
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




