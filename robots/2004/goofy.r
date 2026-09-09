/*
Nome            : Goofy
Versione        : m_8.r
Autore		: Simone Ascheri


Commento
========

Goofy è un pasticcione. Uno di quei personaggi che sono capaci fare solo guai. Non è tutta colpa sua, poverino"!
Il modo in cui è venuto al mondo non è certo dei migliori, tirato fuori da una costola di Frankie, che già non ara un buon cmbattente.
Qui l'erredità di Danica è ancora + pesante, dal momento che ne condivide anche l'attacco dinale, con pochissime varianti, se non nulle.
Sarà per l'anno prossimo (speriamo).

Strategia
=========

1)Goofy all'inizio del match si sposta nell'angolo piu' vicino è controlla se è rimasto solo.
In caso affermativo parte con l'attacco finale.

2)Se, invece, i due angoli adiacenti sono occupati, oscilla alternativamente lungo i lati dell'arena con brevi movimenti, utilizzando le routine di Danica.

3)Quando si accorge che uno degli angoli è disabitato, capisce che lo scontro è per lo meno a tre robot (un vero genio).
Conta quindi gli avversari, per vedere se puo' ricondurre (da vero matematico) la situazione a quella del punto 1. Nel qual caso, bello contento, parte con l'attacco finale.

4)Se, putacaso, trova invece altri due nemici, sfrutta la sua routine di attacco a tre nuova di zecca:
si dirige per un breve tratto verso l'angolo rimasto libero, piega in direzione del nemico nell'angolo adiacente, oscilla in quella direzione e torna indietro seguendo lo stasso percorso: non è un triangolo, non è una L, ma nnon è nemmeno tutto questo granchè.... 

Note Tecniche
=============

Nessuna.
*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h,a1,a2;
int ang_pref;
int max,rng,mr,z,t,ang_p2;
int dove,oldr,rng,run,switch,dan,si;

int xs,ys,rd,ren,sc1,sc2,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd;

main()
{
  ang_pref=180*((dy=(loc_y(xp=60+(xs=loc_x(yp=60+(ys=(loc_y(sc1=sc2=1))>499)*880)>499)*880)>500)*960+20)>500)+90*((dx=(loc_x()>500)*960+20)!=dy);

  drive(xd=180*xs,100); 

  yd=90+180*ys;

  while(1) {
    Run(xd,xp,2-xs);	
    Run(yd,yp,6-ys);	
    tre();

  }

}

Run(d,l,m) { 
  int r;
  
  while(r<2) {
  r+=drive(d,100);
  
  if (scan(d,10)) { a=d; while (scan(d,10)>840) ; } else while(Check(l,m)) ;
    
   
  Sparare(d,0);  
  while(speed()>49);
  ++m;  
  d+=180;
  } 
}

Check(l,m) {
  int c1;
  if (m<5) c1=loc_x(); else c1=loc_y();
  if (m%2) return (c1>l); else return (c1<l);	
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



tre()
int yy,xx,ang1,ang2,ang3,clock;
{	
	while	(1)

	{


		if ((scan(ang_pref-10,10)==0)&&(scan(ang_pref+10,10)==0))
		{
			conta(ang_pref-40);
			ang2=(ang1=ang_pref+10)+90;
			ang3=ang_pref+180;
		}	
		else
		{
			if ((scan(ang_pref+80,10))+(scan(ang_pref+100,10))) return;
			conta(ang_pref-40);
			ang2=(ang1=ang_pref+90-10)-90;
			ang3=ang_pref+270;
		}

		ang_p2=ang2;
		Sparare(ang=ang1,100);
		while ((Dista(dx,dy)<20000))
			PallaDiFuoco(h>(10000+0+0));
		Stop();

		xx=loc_x(yy=loc_y());
		
		Sparare(a=ang=ang2,100);

		max=30000+30000*(clock^=1);
		while ((Dista(xx,yy)<max))
			PallaDiFuoco(h>(40000+0+0));
		Stop();

		if (ang3%180)
			while(((loc_x(PallaDiFuoco(drive(ang,100)))%930)>70));
		else
			while(((loc_y(PallaDiFuoco(drive(ang,100)))%930)>70));

		Stop();

		Sparare(ang=ang3,100);
		while ((Dista(dx,dy)>3400))
			{if (h>6500) PallaDiFuoco(h<25000+0+0);}
		Stop();
	}
}

conta(angolo)
int conto;
	{
		while((angolo+=20)<ang_pref+140)	
			conto+=(scan(angolo,10)>0);
		if (conto<2) 
		{
			sc2=3;  ++ff;  
			while(sc1=5) 
			{
			      while (loc_x()<500+350*(rng<250)) Sparare(0,100);
			      while (loc_y()<500) Sparare(90,100);
			      while (loc_x()>499) Sparare(180,100);
			      while (loc_y()>499) Sparare(270,100);
			}

	}
}

/*# a Spari */

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


Sparare(dir,v)
{
  drive(dir,v);
  if (rng=scan(oa=a,10))  
  {    
    if (scan(a+350,10)) a-=sc1; else a+=sc1;
    if (scan(a+10,10)) a+=sc2; else a-=sc2; 
    cannon(a+(a-oa)*ff+0,(scan(a,10)<<1)-rng);
  } else {
      if (rng=scan(a+=340,10)) return cannon(a,rng); 
      if (rng=scan(a+=40,10))  return cannon(a,rng);  
      while (!(rng=scan(a+=20,10))) ; 
      cannon(a,rng);
  }
}

