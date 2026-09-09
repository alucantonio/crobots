/*
Robot programmato da Roberto Bevilacqua
Torneo di crobots 2004!

L'irpef ha cambiato nome.
Quindi pure Il robottino deve adeguarsi!
Con qualche innseto dal vincitore dello scorso anno.
*/

int park, ux, uy, dx, dy;                               /*Variabili posizionali*/
int flag, vang, ang, ang2;                              /*Variabili direzionali*/
int dan, timmax;                                        /*Variabili temporali*/
int dir, ango, oang, r, or;                     	/*Variabili balistiche*/
int dang, alfa, corr, anco, nrg, rg;
int max, clock, gira, time, klik, scn;
int a,oldr,rng,oa,ang_pref,dove,si,or,r,h,run;
main()                             
{

/*Calcola coordinate iniziali e agolo principale*/

Accertamento(dx=(loc_x()>500)*960+20,dy=(loc_y()>500)*960+20);
ang2=180*(dy>500)+90*(dx!=dy)+90;

/*Ciclo principale*/

while (corr=1)
{
	drive (ang,100);                 
	while ((h=Liquidazione(dx,dy))>5200)
		if (h>35000) Sovrattassa(h<25000);

	Sovrattassa(Sovrattassa(drive(ang,0)));

	dang=ang2-180;
	while((dang+=20)<=ang2+40) corr+=(scan(dang,10)>0);	

	if (corr<3) Multa();

	if (damage()>70) flag=315;
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

	drive (ang_pref=ang=(ang2+flag),100);       /*Si allontana dall' origine*/
	while ((Liquidazione(dx,dy)<95000))
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

Multa()
  {
  
  while(1)
 {
	dan=damage();
	if ((oldr>400)) 
	{
	while (loc_x()<500) Fire(drive(0,100));
	Fire(drive(90,0)); 
	while (loc_y()<500) Fire(drive(90,100));
	Fire(drive(180,0)); 
	while (loc_x()>499) Fire(drive(180,100));
	Fire(drive(270,0));     
	while (loc_y()>499) Fire(drive(270,100));
	Fire(drive(0,0)); 
	}
 	else 
	{
		while (loc_x()<509) Fuoco(0);
		while (loc_y()<509) Fuoco(90);
		while (loc_x()>492) Fuoco(180);
		while (loc_y()>492) Fuoco(270);  
	}
  }

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


Fire()
{
  if (oldr=scan(oa=a,10))
  {    
    if (scan(a+350+0,10)) a+=355; else a+=5;
    if (scan(a+350,10)) a+=357; else a+=3; 
    
    cannon(a+a-oa,(2*scan(a,10))-oldr); 

  } else {
        if (scan(a+=340,10)) return Fire();
        if (scan(a+=40,10))  return Fire();
        if (scan(a+=300,10)) return Fire();
        if (scan(a+=80,10))  return Fire();
        if (scan(a+=260,10)) return Fire();
        if (scan(a+=120,10)) return Fire();
        if (scan(a+=220,10)) return Fire();
        if (scan(a+=160,10)) return Fire();
        if (scan(a+=180,10)) return Fire();
        a+=270; 
  }
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



