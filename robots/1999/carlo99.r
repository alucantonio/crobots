/*
Nome del robot  : Carlo99.r
Autore          : Alessandro Tassara

Questo robot si muove velocemente lungo i lati di un piccolo quadrato
sito o nell`angolo S-E del campo di battaglia o in quello N-E.
Quando subisce un certo ammontare di danni controlla l' anglo opposto: se lo
trova libero lo raggiunge, altrimenti rimane al suo posto.
La strategia difensiva si basa sul movimento e sul continuo cambiamento di direzione.
L`attacco, che viene attivato solo nella fase finale del combattimento e solo se c' e' un
unico superstite e' basato su una semplice routine ispirata da Arale:
Il robot si porta alle coordinate (1000,500) e da li' oscilla a sinistra e a destra per
tutta la lunghezza dell' arena, sparando sempre con la routine di fuoco piu' precisa.

E' chiaramente basato su Carlo97 di Luigi Cimini.
Le modifiche riguardano:
- il movimento, che ora non e' piu' limitato all' angolo in basso a destra ma spazia
  anche su quello in alto.
- l' attacco finale che, come in AleZai17 e' basato sulla routine finale di Arale
- una delle due funzioni di fuoco, che ora si avvale della piu' precisa routine di
  Jedi, con modifiche tratte da Coppi dello stesso Luigi Cimini.

Dal momento che non penso si piazzera' molto bene, preferisco non fare dediche.
*/

int a,dir, dd,f,o,r,t,d,z,oa,anni,last;

main()
{
	while (1)
	{
		t=70;

		while(loc_x()<880)
		{
			drive(dir=0, 100);
			fire();
		}

		stop(0);

		if (loc_y()>500)
			z=0;
		else
			z=1;

		while(--t)                                      /*percorre un quadrilatero nell' angolo NE o SE*/
		{
			if (d>damage()-10)
			{
				if (z==0)
				{
					while(loc_y() < 910) {drive(90,100);cerca();}
					stop(90);
					while(loc_x() >880) {drive(dir=180,100);fire();}
					stop(180);
					while(loc_y() >880) {drive(dir=270,100);fire();}
					stop(270);
					while(loc_x() <910) {drive(0,100);cerca();}
					stop(0);
				}
				else
				{
					while(loc_y() > 90) {drive(270,100);cerca();}
					stop(270);
					while(loc_x() >880) {drive(dir=180,100);fire();}
					stop(180);
					while(loc_y() <120) {drive(dir=90,100);fire();}
					stop(90);
					while(loc_x() <910) {drive(0,100);cerca();}
					stop(0);
				}
			}
			else
			{
				if (loc_y()<500)		/*decide se cambiare angolo*/
				{
					if (!scan(90,10)) z=0;
				}
				else if(!scan(270,10)) z=1;
				d=damage();
			}
		}

		last=anni=10;					/*conta i superstiti*/
		while ((anni+=20)<390) last+=(scan(anni,10)>0);
		if (last<12)					/*attacco finale da Arale*/
		{
			if (loc_y()>500)
			{
				while (loc_y()>540)
				{
					drive(270,100);
					cerca();
				}
				stop(270);
			}
			else
			{
				while (loc_y()<460)
				{
					drive(90,100);
					cerca();
				}
				stop(90);
			}

			while (1)
			{
				if (loc_x()>500)
				{
					while (loc_x()>200)
					{	
						drive(dir=180,100);
						fire();
					}
				}
				else
				{
					while (loc_x()<800)
					{
						drive(dir=0,100);
						fire();
					}
				}
				stop(dir);
			}
		}
		else t=4;
	}
}

cerca()								/*questa e' piu' o meno quella di Cerlo97*/
{
	if ((o=scan(a,10))&&(o<770))
	{
		if (scan(a+6,6)) a+=6; else a-=6;
		if (scan(a+3,3)) a+=3; else a-=3;
		cannon(a,2*scan(a,10)-o);
	}
	else if (r=scan(a+=340,10)) cannon (a,r);
	else if (r=scan(a+=40,10)) cannon (a,r);
	else if (r=scan(a+=300,10)) cannon (a,r);
	else if (r=scan(a+=80,10)) cannon (a,r);
        else a+=40;
}

fire()								/*qui invece siamo su Jedi*/
  {
	if(o=scan(a,10))
	{
		if (o>700)
			return cerca();

                if (!scan(a-=5,10)) a+=10;

		if(scan(a+354,1)) a+=354;
		if(scan(a+6,  1)) a+=6;
		if(scan(a+356,1)) a+=356;
		if(scan(a+4,  1)) a+=4;
		if(scan(a+358,1)) a+=358;
		if(scan(a+2,  1)) a+=2;

		if (o=scan(oa=a,5))
		{

			if(scan(a+355,1)) a+=355;
			if(scan(a+5,  1)) a+=5;
			if(scan(a+357,1)) a+=357;
			if(scan(a+3,  1)) a+=3;
			if(scan(a+359,1)) a+=359;
			if(scan(a+1,  1)) a+=1;

			if (r=scan(a,10))
			{
                                cannon((a+(a-oa)*((1200+r)>>9)-(sin(a-dir)>>14)),(r*160/(160+o-r-(cos(a-dir)>>12))));
			}
		}
		else cerca();
	}
	else if (r=scan(a+=340,10)) cannon (a,r);
	else if (r=scan(a+=40,10)) cannon (a,r);
	else if (r=scan(dir,10)) cannon (a=dir,r);
  }

stop(dr)						/*classica fermata da Arale*/
int dr;
{

	drive(dr,0);
	while(speed() > 49)
		if ((r=scan(a,10))&&(r<770))
			cannon (a,r);
		else cerca();
}
