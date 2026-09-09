/*
Nome            : Nemo
Versione        : NM_D_2K3_8.r
Autore		: Simone Ascheri


Commento
========

Nemo è l'ennesiomo esempio del mio cronico anno di ritardo nello sviluppo dei robot.
Il 90% delle idee che lo animano mi erano venute prima del torneo 2002. L'implementazione di allora, tuttavia,
lasciava molto a desiderare e l'efficienza era, pertanto, bassina. Quest'anno non pare andare molto meglio, dati i tremendi risultati raggiunti dal diabolico Nuzzo con i suoi combattenti, però di più non sono proprio riuscito a fare. 

Strategia
=========

All'inizio del Match Nemo raggiunge l'angolo più vicino, dove si prende una pausa per contare gli avversari.
Se ne trova solo uno, parte immediatamente con l'attacco finale. Forse chiamarlo attacco finale è esagerato, in quanto 
il robot si limita a correre avanti e indietro su una retta inclinata di 38° (o 52°, a seconda dell'asse scelto come
riferimento), sparando a tutto ciò che si muove.
Se, invece, scopre di non essere in uno scontro f2f, inizia il movimento difensivo.
Si tratta di una tattica molto banale, anzi, chiamarla tattica è un vero e proprio complimento. Nemo si limita a disegnare un triangolo scaleno, per tutta la durata del match, senza curarsi della presenza o meno di avversari che possano dargli fastidio. Ogni volta che completa un ciclo conta il nemico. 
La sezione di codice che sceglie l'angolo verso cui dirigersi non esiste. Il robot, infatti, si muove SEMPRE verso quello seguente in senso antiorario. Questo fatto contribuisce a rendermelo molto antipatico, dal momento che lo considero un comportamento decisamente stupido, tuttavia una specie di motivazione alla base della scelta è pur sempre presente. Non so se si tratti di un bug del compilatore o, più probabilmente, dipenda dal modo in cui gli avversari decidono la propria oscillazione (pensandoci bene, potrebbe anche essere causato dalla modalità con cui le routine di fuoco ricercano il bersaglio), ma consentire a Nemo di spaziare su entrambi i lati dell'arena ne abbassa le prestazioni di un buon 8%.

Note Tecniche
=============

Si tratta dell'enesima, e probabilmente ultima, evoluzione del 'Progetto Z', nato nell'ormai lotano 1998 con Son-Goku.r.
Di quel robot rimangono ancora un paio di routine critiche e nulla più.
Il robot utilizza, inoltre, le toxiche e, stranamente, riesce a rendere discretamente anche contro gli avversari del MacroTorneo 2002.
*/

int ang, dx, dy;
int a, oa, r, or, s_lim, i_lim;
int h, flag1;
int ang_pref;
int max,rng,mr;

main()
{
  ang_pref=180*((dy=(loc_y(max=90000)>500)*960+20)>500)+90*((dx=(loc_x(mr=850)>500)*960+20)!=dy);

  while (flag1=1)
      {


        if (max==90000)
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
        while ((Dista(dx,dy)>3400))
        	{if (h>6500) PallaDiFuoco(h<25000);}

        Stop(s_lim=(i_lim=ang_pref-40)+150);

        if (max==90000)
	{
		while ((i_lim+=20)<=s_lim) 
			flag1+=(scan(i_lim,10)>0);

		if (flag1<3)
		{	
			mr=max=330000;
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
             return cannon((oa+(a-oa)*3-(sin(a-ang)/19500)),(r*220/(220+or-r-(cos(a-ang)/4167))));
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


