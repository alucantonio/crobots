/*
Nome            : Doom2099
Versione        : M_05
Autore		: Simone Ascheri

Preludio
========

Un tempo, quasi 100 anni da adesso.
Un luogo, l'Europa Centrale.
Un popolo oppresso, che reclama giustizia.

Il mondo è cambiato: gli Stati-Nazione ancora esistono, ma sono solo una facciata, la copertura
per i loschi traffici delle Multinazionali: La Alchemax, la Stark-Fujukawa e poche altre grandi
compagnie, grazie alla loro superiorità tecnologica, detengono in realtà il vero potere, fanno
e disfano governi, mettono fantocci alla testa di nazioni un tempo fiere.
Tyger Wilde, emissario della Alchemax, è uno di questi: la sua capricciosa volontà e' legge, il
suo potere assolutamente arbitrario, la sua crudeltà, leggendaria.
Ma dalle nebbie del tempo, un'ombra torna per reclamare quel trono che era suo di diritto,
un nome un tempo temuto, odiato, ma che oggi appare l'unica speranza di salvezza.
Un fuorilegge, ricercato dalle polizie di tutto il mondo e combattuto dai più grandi eroi del
suo tempo, si erge ora a paladino della sua amata Latveria e dell'umanità tutta.
Nessuno sa se si tratti della leggenda ora tornata in vita o di un impostore.
La sua stessa memoria è frammentaria, ricorda il passato remoto ma non gli eventi più recenti
che lo hanno trasportato in quest'epoca: solo la sua missione è ben presente nei suoi pensieri.
Attacca, la sua tecnologia e le sue armi sono vecchie, antiquate, inadatte: viene sconfitto e
quasi ucciso.
Ma come i suoi nemici di un tempo sanno bene, la sua caparbietà è seconda solo alla sua intelligenza:
lavora duro, impara, crea nuove armi, e ora è pronto a ritornare.
Tyger Wilde e la Alchemax si pentiranno ben presto di aver incrociato la spada con Victor von Doom,
Il DOttor Destino!


Commento
========

Questo robot altro non è che Burrfoot, microbo che ho spedito nella passata edizione del Torneo,
con un attacco derivato da quello di Rudolf6.
Per questa ragione, non credo che farà molta strada. L'unca cosa che ottarà, penso, sarà di stare
davanti, anche nel torno dei microbi, al fratello Idefix.

Strategia
=========

E' identica a quella di Burrfoot:
si reca nell'angolo più vicino, conta i superstiti da posizione esposta, attacca o difende in base al
numero dei nemici che trova.
La difesa è il solito quadrato: Per evitare di fare proprio una figura ridicola, ho cambiato
leggermente le temporizzazioni che estendono il raggio d'azione, ma le modifiche sono solo queste.
L'attacco e' derivato da Rudolf6, ibridato con le routine di fuoco dell'Attacco FiduciosoXP, Fizban,
2001.

Note Tecniche
=============

L'unica novità, peraltro comune a Idefix, è che il robot utilizza un unico ciclo di while, che
inverte il proprio segno a seconda dell'occorrenza.

*/

int vel,r_coord,x_pos,y_pos;
int ang,oang,a,r,or,clock,don,dan;
int time,run,d,gradi,conta;
int si,z,oa,lim,cl,discr;
int ly,ul,ll,b,tempo,oscar,aq,xora,aa,count,dax,flag,flag1,nas,dri,oor,over,dver,danni,dor,daa,mm,ang,dr,do,aq,rng,t,dir,oldr,deg,odeg,dist,yora,xora;
int ang,pivot,pivot1,clock,corr;
main()
{
        r_coord=822;
	run-=8;
        while (run+=conta=gradi=10)
             {
                if (damage(vel=100)>80) {time=0;r_coord=822;}
                x_pos=(loc_y(y_pos=(loc_x()<500)*(r_coord-=10*(++time>5)))<500)*r_coord;

                while (--run)
                     { 
                        while(loc_y() <910-x_pos) CucchiaioKender(90);
                        while(loc_x() >r_coord-y_pos+90) CucchiaioKender(180);
                        while(loc_y() >r_coord-x_pos+90) CucchiaioKender(270);
                        while(loc_x() <910-y_pos) CucchiaioKender(0);
                     }
                CucchiaioKender(vel=0);

                while (((gradi+=21)<390))
			conta+=(scan(gradi,10)>0);
                while (conta<12)
                     {	
			discr=80+(loc_y()<500)*840;
			while((loc_y()>discr)==(z=(discr<500))) 
			{
				
				if(loc_x()>500)
				{
					Fuoco(170+20*z);
				}
				else
				{
					Fuoco(370-20*z);
				}
			}
		}
            }
}

CucchiaioKender(dir)
int dir;
  {
     drive (dir,vel);
     if((or=scan(oa=a,10))&&(or<850))
        {
           if (r=scan(a,3));
           else if (r=scan(a-=7,3));
           else if (r=scan(a+=14,3));
           else return a+=21;
	   cannon (a,r);
        }
     else
       if(scan(a+=21,10));
       else
         if(scan(a-=42,10));
         else
           if(scan(dir,10)) a=dir;
           else
             return (a+=84);
  }  

Fuoco(verso)
{
	drive (verso,100);
    if (oldr=scan(a,10)) {
           if (scan(a,2)) cannon(a,3*scan(a,10)-2*oldr);
           else if (scan(a-=7,6)) { cannon(a-5,2*scan(a,10)-oldr);}
           else if (scan(a+=14,6)) { cannon(a+5,2*scan(a,10)-oldr);}
	else return Fuoco(verso);
    } 
    else {
        if (oldr=scan(a+=339,10))	cannon(a,oldr);
        else if (oldr=scan(a+=42,10))	cannon(a,oldr);
        else if (oldr=scan(a+=297,10))	cannon(a,oldr);
        else if (oldr=scan(a+=84,10))	cannon(a,oldr);
        else a+=65;
    }
}




