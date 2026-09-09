/*
Nome            : Ravatto.r
Versione        : Rev_1.r
Autore		: Simone Ascheri


Commento
========

Ravatto cerca di mantenere defe al suo nome. Infatti fa proprio schifo, e sembra messo in piedi in 10 minuti.
Tutte malignità, dal momento che tra assemblaggio e test ho investito la bellezza di 1050 minuti uomo per realizzarlo.
Tecnicamente si tratta di Nemo, che non attacca piu' ma, se dopo un certo periodo vede che il suo angolo preferenziale di oscillazione è occupato, vi si sposta . 

Strategia
=========

Vedere Nemo.r
Non attacca. 
Al massimo, agni colta che cambia angolo aumenta l'ampiezza dell'oscillazione.

Note Tecniche
=============
Ma dove?

*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1;
int ang_pref;
int max,rng,mr,park;

main()
{
  ang_pref=180*((dy=(loc_y()>500)*960+20)>500)+90*((dx=(loc_x(max=90000)>500)*960+20)!=dy);

  while (park=dx)
      {



	if (flag1>5)
	{	
		dx=1000-dy;
		dy=park;
		ang=ang_pref;
		ang_pref+=90;
		flag1=0;
	} 
	else
	{	
		
		if ((ang_pref)%180)
			while(((loc_x(PallaDiFuoco(drive(ang_pref-82,100)))%930)>70));
		else
			while(((loc_y(PallaDiFuoco(drive(ang_pref-82,100)))%930)>70));

		ang=ang_pref;

		Stop();
	} 

	drive(ang,100);
        while ((Dista(dx,dy)>3400))
        	{if (h>6500) PallaDiFuoco(h<25000);}

        Stop();
	if ((!scan(ang_pref-10,10))&&(!scan(ang_pref+10,10))) ++flag1;else --flag1;
	
	if (flag1>5)max+=50000;
	else
	{	
		drive(ang=ang_pref+38,100);
        	while ((Dista(dx,dy)<max))
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


