/*
Nome del robot  : Carlo2k.r
Autore          : Alessandro Tassara

Innanzitutto Carlo2k conta i rivali e se ne ha solo uno lo attacca.
Secondariemante, come tattica di difesa, questo robot si muove velocemente
lungo i lati di un piccolo quadrato sito in uno qualsiasi degli angoli
dell'arena.
Quando subisce un certo ammontare di danni controlla gli angoli adiacenti: se
uno dei due e' libero lo raggiunge, altrimenti rimane al suo posto.
La strategia difensiva si basa sul movimento e sul continuo cambiamento di direzione.
L`attacco, che viene attivato solo nella fase finale del combattimento e solo se c' e' un
unico superstite e' sostanzialmente Satana.r.

E' una fusione di Carlo99 e Carletto.
Le specifiche sono:

- il movimento  : spazia ora su tutti e quattro gli angoli.
- lo sparo      : quando si allontana dai bordi spara preciso, quando si
                  avvicina invece spara rapido.
- l' attacco    : e' il robot Satana, di Dario Serino.

*/

int dir, z,k,a,oa,o,r,t,d,anni,last;
int normal,rng,orng;
int p1,p2,vista, clock, primo;

main()
{
        p2=z=loc_y(p1=k=loc_x(t=10)<500)<500;
        primo=1;
	while (t=last=anni=10)
	{
		while(--t)					/*Percorre un quadrilatero in uno dei 4 angoli*/
		{
                if (p1==k)
                {
                        while(loc_y(z=p2) <910-z*790) {drive (dir=90,100);if (z) fire();else cerca();}
                        stop();
                }
                if (p2==z)
                {
                        while(loc_x(k=p1) >880-k*790) {drive (dir=180,100);if (k) cerca();else fire();}
                        stop();
                }
                if (p1==k)
                {
                        while(loc_y(z=p2) >880-z*790) {drive (dir=270,100);if (z) cerca();else fire();}
                        stop();
                }
                if (p2==z)
                {
                        while(loc_x(k=p1) <910-k*790) {drive (dir=0,100);if (k) fire();else cerca();}
                        stop();
                }
                if (primo) {primo=0;mainsat();}
		}

                mainsat();
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
        else trova();
}

trova()
{
        if (r=scan(a+=340,10)) cannon (a,r);
        else if (r=scan(a+=40,10)) cannon (a,r);
        else if (r=scan(dir,10))  cannon (a=dir,r);
        else if (r=scan(a+=300,10)) cannon (a,r);
        else if (r=scan(a+=80,10)) cannon (a,r);
        else return a+=40;
}

fire()                                                          /*qui invece siamo su Jedi*/
  {
     if (scan(a,10));
     else if (scan(a+=20,10));
     else if (scan(a-=40,10));
     else return a+=80;
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
                else trova();
	}
        else trova();
  }

stop()                                                /*classica fermata da Arale*/
{
        drive(dir,0);
	while(speed() > 49)
             cerca();
        if (((loc_x()%910)<90)&&((loc_y()%910)<90))
        {
                if (d<damage()-26)
                {
                       if (scan(80+z*180,10)||scan(100+z*180,10))
                       if (scan(10+k*180,10)||scan(k*180-10,10)); else p1=k^1;
                       else  p2=z^1;
                       d=damage();
                }
        }
}

mainsat() {
  while ((anni+=20)<390) last+=(scan(anni,10)>0);
  if (last>11) return;

  while(normal=3) {
    if (dir==270)     while(focus(loc_y()<275));
    else if (dir==90) while(focus(loc_y()>725));
    else if (dir)     while(focus(loc_x()<275));
    else              while(focus(loc_x()>725));

    if (normal) drive((dir+180)%=360,50);
    else        drive(dir=(( ((a+180)/90) + (clock^=1) )*90)%360,50);

    while (speed()>50)
         cerca();

    drive(dir,100);
  }
}

focus(exit) {
  if (exit) return 0;
  else {
    drive(dir,100);

    if (scan(a,10));
    else if (scan(a+=21,10));
    else if (scan(a-=42,10));
    else {a+=84; return --normal;}

    if (scan(a-=5,5)); else a+=10;
    if (scan(a+5,2)) a+=5; if (scan(a-5,2)) a-=5;
    if (scan(a+3,1)) a+=3; if (scan(a-3,1)) a-=3;
    if (scan(a+1,1)) a+=1; if (scan(a-1,1)) a-=1;
    if (orng=scan(oa=a,5)) {
      if (scan(a+13,10)) a+=5; if (scan(a-13,10)) a-=5;
      if (scan(a+12,10)) a+=3; if (scan(a-12,10)) a-=3;
      if (scan(a+10,10)) a+=1; if (scan(a-10,10)) a-=1;

      if (rng=scan(a,10))
        cannon(a+ (a-oa)*((1200+rng)>>9)- (sin(a-dir)>>14),
               rng*192/(192+ orng-rng- (cos(a-dir)>>12)));

      if (a==oa) return normal>>=1;
    }
    return --normal;
  }
}
