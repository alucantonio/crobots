/*
Nome            : Nautilus
Versione        : NA_L_2K3_4.r
Autore		: Simone Ascheri


Commento
========

Nautilus altro non è che Nemo dotato di un diverso attacco finale e con un paio di ottimizzazioni aggiunte nell'avvicinamento ai lati dell'arena.

Strategia
=========

All'inizio del Match Nautilus raggiunge l'angolo più vicino, dove si prende una pausa per contare gli avversari.
Se ne trova solo uno, parte immediatamente con l'attacco finale. Descrive un quadrato al centro del campo di battaglia, utilizzando come fuoco un'evoluzione delle routine di puntamento già presenti lo scorso anno in Obelix.r.
La cosa appare talmente pazzesca che avevo pensato di battezzare tale comportamento 'Attacco trascendente', nel senso che il perchè un tale accrocchio funzioni è qualcosa che trascende le mie capacità di comprensione. 
Se, invece, scopre di non essere in uno scontro f2f, inizia il movimento difensivo.
Si tratta di una tattica molto banale, anzi, chiamarla tattica è un vero e proprio complimento. Nautilus si limita a disegnare un triangolo scaleno, per tutta la durata del match, senza curarsi della presenza o meno di avversari che possano dargli fastidio. 
Ogni volta che completa un ciclo conta il nemico. 
La sezione di codice che sceglie l'angolo verso cui dirigersi non esiste. Il robot, infatti, si muove SEMPRE verso quello seguente in senso antiorario. Questo fatto contribuisce a rendermelo molto antipatico, dal momento che lo considero un comportamento decisamente stupido, tuttavia una specie di motivazione alla base della scelta è pur sempre presente. Non so se si tratti di un bug del compilatore o, più probabilmente, dipenda dal modo in cui gli avversari decidono la propria oscillazione (pensandoci bene, potrebbe anche essere causato dalla modalità con cui le routine di fuoco ricercano il bersaglio), ma consentire a Nemo di spaziare su entrambi i lati dell'arena ne abbassa le prestazioni di un buon 8%.

Note Tecniche
=============

Si tratta dell'enesima, e probabilmente ultima, evoluzione del 'Progetto Z', nato nell'ormai lotano 1998 con Son-Goku.r.
Di quel robot rimangono ancora un paio di routine critiche e nulla più.
Il robot utilizza, inoltre, le toxiche e, stranamente, riesce a rendere discretamente anche contro gli avversari del MacroTorneo 2002. In aggiunta a ciò, in alcuni casi particolari utilizza un puntamento derivato da quello impiegato nell'attacco finale. Gli 0 inseriti nel codice servono per migliorare la temporizzazione dello sparo.

*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1;
int ang_pref;
int max,rng,mr,z;
int dove,oldr,rng;

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

	while (flag1<3)
	{	
		while((loc_x()<499)!=z) Fuoco(180*z);
		while((loc_y()<499)!=z) Fuoco(90+180*z);
		z^=1;
	}

	

	Fuo(ang+=38);Fuo(ang);

        while ((Dista(dx,dy)<90000))
        	PallaDiFuoco(h>(80000));
	Fuo(ang-=120);
	Fuo(ang);
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

Fuoco(dove)
{
    drive (dove,100);
    if (oldr=scan(a,10)) 
    {
           
           if (scan(a,2)){if ((cannon(a+0+0+0+0+0,3*scan(a,10)-2*oldr))) return;}
           else if (scan(a-=7,5)){if ((cannon(a-6+0+0,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=14,5)){if((cannon(a+7,2*scan(a,10)-oldr))) return;}
           else if (scan(a+=10,5)){if((cannon(a+7,2*scan(a,10)-oldr))) return;}
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




