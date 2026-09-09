/*
Nome            : Frankie
Versione        : V_al_6.5.r
Autore		: Simone Ascheri


Commento
========

Frankie è uno dei peggiori robot che abbia mai messo in piedi. Regge il confronto solo ed esclusivamente il mitico
Zifnab, montato con pezzi di scarto trovati a destra e a sinistra. 
Quest'anno, complice il tempo tiranno, ho messo insieme la mia armata (di cui Frankie è per ora l'unico esemplare)
andando a recuperare tutto quello che potevo sul libero mercato della licenza GNU/GPL.
Quindi, assemblando un pezzo di Danica, 2 quarti di Alcadia e inventando una tattica per gli scontri a tre che mi pare, se non altro, inedita, nell'incredibile spazio di 5 giorni è nato il mostro.
Direi che non avrei potuto presentarmi a difendere il titolo in maniera peggiore.
Sarà per l'anno prossimo (speriamo).

Strategia
=========

1)Frankie all'inizio del match si sposta nell'angolo piu' vicino è controlla se è rimasto solo.
In caso affermativo parte con l'attacco finale, che per ora è esattamente quello di Alcadia. Spero, nelle prox due ore, di
mettere insieme qualche cosa di vagamente piu' originale.

2)Se, invece, i due angoli adiacenti sono occupati, oscilla alternativamente lungo i lati dell'arena con brevi movimenti, utilizzando le routine di Danica.

3)Quando si accorge che uno degli angoli è disabitato, capisce che lo scontro è per lo meno a tre robot (un vero genio).
Conta quindi gli avversari, per vedere se puo' ricondurre (da vero matematico) la situazione a quella del punto 1. Nel qual caso, bello contento, parte con l'attacco finale.

4)Se, putacaso, trova invece altri due nemici, sfrutta la sua routine di attacco a tre nuova di zecca:
si dirige per un breve tratto verso l'angolo rimasto libero, piega in direzione del nemico nell'angolo adiacente, oscilla in quella direzione e torna indietro seguendo lo stasso percorso: non è un triangolo, non è una L, ma nnon è nemmeno tutto questo granchè.... 

Note Tecniche
=============

1)Il nome del robot non è riferito nè a Frankie Raykard ( si scriverà cosi'? che figure) nè a Frankie Goes to Holliwood, ma al buon vecchio mostro di Frankestain, visto il modo in cui ha visto la luce.
2)Il conto degli avversari viene fatto in maniera inusuale: anzichè adoperare un ciclo vengono effettuate materialmente tutte le scansioni e tutte le somme, per guadagnare velocità di esecuzione e partire all'attacco prima dei nemici. Sarebbe un'ottima cosa, disponendo di un attacco finale degno di questo nome.
*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h,a1,a2;
int ang_pref;
int max,rng,mr,z,t,ang_p2;
int dove,oldr,rng,run,switch,dan,si;

int a,rng,oa,xs,ys,en,rd,ren,timer,sc1,sc2,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd;

main()
{
  ang_pref=180*((dy=(loc_y()>500)*960+20)>500)+90*((dx=(loc_x()>500)*960+20)!=dy);


  xp=60+(xs=loc_x(yp=60+(ys=(loc_y())>499)*880)>499)*880;
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
  drive(d,100);
  
  ++r;
  if (++timer>440+damage()) en=1; 
  
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

att()
{
  
  run=2;
  while(1)
 {
	dan=damage();
	if ((oldr>400)&&(run>0)) 
	{
	while (loc_x()<500) Fire(drive(0,100));
	Fire(drive(90,0)); 
	while (loc_y()<500) Fire(drive(90,100));
	Fire(drive(180,0)); 
	while (loc_x()>499) Fire(drive(180,100));
	Fire(drive(270,0));     
	while (loc_y()>499) Fire(drive(270,100));
	Fire(drive(0,0)); 
	if (dan<damage()-15) --run;
	}
 	else 
	{
		while (loc_x()<509) Fuoco(0);
		while (loc_y()<509) Fuoco(90);
		while (loc_x()>492) Fuoco(180);
		while (loc_y()>492) Fuoco(270);  
		if (dan<damage()-20) ++run;
	}
  }

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



tre()
int yy,xx,ang1,ang2,ang3,clock;
{	
	while	(1)

	{


		if ((scan(ang_pref-10,10)==0)&&(scan(ang_pref+10,10)==0))
		{
			conta();
			ang1=ang_pref;
			ang_p2=ang2=ang1+100;
			ang3=ang_pref+180;
		}	
		else
		{
			if ((scan(ang_pref+80,10))+(scan(ang_pref+100,10))) return;
			conta();
			ang1=ang_pref+90;
			ang_p2=ang2=ang1-100;
			ang3=ang_pref+270;
		}
		Sparare(ang=ang1,100);ang_p2=ang2;
		while ((Dista(dx,dy)<30000))
			PallaDiFuoco(h>(20000+0+0));
		Stop();

		xx=loc_x(yy=loc_y());
		Sparare(ang_p2=ang=ang2,100);

		max=30000+30000*(clock^=1);

		while ((Dista(xx,yy)<max))
			PallaDiFuoco(h>(40000+0+0));
		Stop();
		ang_p2=ang2;
		if (ang3%180)
			while(((loc_x(PallaDiFuoco(drive(ang,100)))%930)>70));
		else
			while(((loc_y(PallaDiFuoco(drive(ang,100)))%930)>70));

		Stop();

		ang_p2=ang2;
		Sparare(ang=ang3,100);
		while ((Dista(dx,dy)>3400))
			{if (h>6500) PallaDiFuoco(h<25000+0+0);}
		Stop();
	}
}

conta()
	{
		if(((!scan(ang_pref-30,10))+
			(!scan(ang_pref-10,10))+
			(!scan(ang_pref+10,10))+
			(!scan(ang_pref+30,10))+
			(!scan(ang_pref+50,10))+
			(!scan(ang_pref+70,10))+
			(!scan(ang_pref+90,10))+
			(!scan(ang_pref+110,10))+
			(!scan(ang_pref+130,10)))>7)
				att();

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


Sparare(dir,v)
{
  drive(dir,v);
  if (rng=scan(a,10))  
  {    
    if (scan(a+350,10)) a-=1; else a+=1;
    if (scan(a+10,10)) a+=1; else a-=1; 
    cannon(a+0+0+0+0,(scan(a,10)<<1)-rng);
  } else {
      if (rng=scan(a+=340,10)) return cannon(a,rng); 
      if (rng=scan(a+=40,10))  return cannon(a,rng);  
      while (!(rng=scan(a+=20,10))) ; 
      cannon(a,rng);
  }
}

