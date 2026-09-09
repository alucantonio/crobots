/*
Robot programmato da Roberto Bevilacqua
Torneo di crobots 2004

Si tratta di ire con un attacco finale che si svolge lungo la diagonale.
*/

int park, ux, uy, dx, dy;                               /*Variabili posizionali*/
int flag, vang, ang, ang2;                              /*Variabili direzionali*/
int dan, timmax;                                        /*Variabili temporali*/
int dir, ango, oang, r, or;                     	/*Variabili balistiche*/
int dang, alfa, corr, anco, nrg, rg;
int max, clock, gira, time, klik, scn;
int a,oldr,rng,oa,ang_pref,dove,si,or,r,h;
main()                             
{

/*Calcola coordinate iniziali e agolo principale*/

Accertamento(dx=(loc_x()>500)*960+20,dy=(loc_y()>500)*960+20);
ang2=180*(dy>500)+90*(dx!=dy)+90;

/*Ciclo principale*/

max=65000;
while (corr=1)
{
	drive (ang,100);                 
	while ((h=Liquidazione(dx,dy))>5200)
		if (h>35000) Sovrattassa(h<25000);
	Sovrattassa(Sovrattassa(drive(ang,0)));

	dang=ang2-180;
	while((dang+=20)<=ang2+40) corr+=(scan(dang,10)>0);	

	if (corr<3) 
	{
		flag=315;
		max=1100000;
	}

	else if (damage()>70) flag=315;
	else 
	if (or=Indaga(ang2+630))
	{
		if ((or=Indaga(ang2+630))&&(Indaga(ang2+630)==or)) flag=630;
	}
	if (!flag)
	{
		if (Indaga(ang2))
		{
			flag=630;
			if ((r=Indaga(ang2))&&(Indaga(ang2)==r)) flag=0;
			else if (!or)
			{
				if (time>66) flag=0;
			}
			else if (r>or) flag=0;
		}
		else if ((or)&&(time>66)) flag=630;
	}

	drive (a=ang_pref=ang=(ang2+flag),100);       /*Si allontana dall' origine*/
	while ((Liquidazione(dx,dy)<max))
		Sovrattassa();
   
	Sovrattassa(Sovrattassa(drive(ang+=180,0)));

++time;
}

}

Accertamento(mx,my)                                            /*Individua l' angolazione necessaria per raggiungere un punto dato*/
int mx, my;
  {
     return (ang=(360+((mx-=loc_x())<0)*180+atan(((my-loc_y())*100000)/(mx+(mx==loc_x())))));
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




