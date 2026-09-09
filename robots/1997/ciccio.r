/*
                Ciccio.r
		...robot palermitano!
	        Versione del: 29/9/1997
                Partecipante al VII° torneo di MCmicrocomputer
                un Crobot di Francesco Passantino

Cicciuzzo si muove sul lato ovest del perimetro di gioco, restando
negli angoli finche' non e' colpito.
Adotta due differenti routine di tiro:
- la prima per il tiro in movimento, che usa uno scan da 45 gradi
- la seconda per il tiro da fermo, tratta dal robot godel.r di S. Biraghi

il robot perde spesso, pareggia molto e non vince mai!
*/


int dam,sdam,safe,K,k,DeltaR,i,orange,range,dir,DeltaD;

main()
{

sdam=1;
safe=20;

while (loc_x()<1000-safe)
	{
	drive(0,100);
	fuoco2();
	}

while(1)
	{
	while (loc_y()<1000-safe)
		{
		drive(90,100);
		fuoco2();
		}
	stop();

	while (loc_y()>safe)
		{
		drive(270,100);
		fuoco2();
		}
	stop();
	}
}

fuoco2()
{
if (range=scan(90,10)) 
	cannon(90,range);
if (range=scan(270,10))
	cannon(270,range);
if (range=scan(180,10))
	cannon(180,range);
if (range=scan(135,10))
	cannon(135,range);
if (range=scan(225,10))
	cannon(225,range);
}



stop()        
{
drive (0,0);
dam = damage()+sdam;
while (damage()< dam) fermo();
}


fermo ()    
{
    if(orange=scan(dir,10))
	{
	if (orange>700) { dir+=19;--k;K=1;return;}
	if (scan(dir,2))
		{
		if(scan(dir+=1,1));
		else dir+=359;
		}
	else if(scan(dir+6,4)) dir+=6; else dir+=354;
	if (K) {i=5;while(--i);}
	DeltaR=4;

        if (range=scan(dir,1)) DeltaD=0;

        else if(range=scan(dir+=4,2))
	      DeltaD=7;
        else if(range=scan(dir+=352,2))
	      DeltaD=353;
        else if(range=scan(dir+=12,2)) {
	      DeltaD=8;
	      DeltaR=3;
	      }
        else if(range=scan(dir+=344,2)) {
	      DeltaD=352;
	      DeltaR=3;
	      }
        else if(range=scan(dir+=20,2)) {
	      DeltaD=10;
	      DeltaR=3;
	      }
        else if(range=scan(dir+=336,2)) {
	      DeltaD=350;
	      DeltaR=3;
	      }
        else {dir+=330;K=1;return;}

        K=fuoco();

        k=30;

	}
	else
		{
		while (!(scan(dir+=19,10)));
		dir%=360;
	}
}

fuoco()
{
return !(cannon(dir+DeltaD,(815+(range-orange)*DeltaR)*range/800));
}
