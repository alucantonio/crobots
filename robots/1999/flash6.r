/*
			###      Flash       ###
			###   versione 6.0   ###
			###  15 - 11 - 1999  ###

Autore: Lorenzo Ancarani

	Flash6 si sposta percorrendo in senso antiorario il perimetro
	del campo di battaglia, alla massima velocita'.
	L'algoritmo di fuoco e' ispirato da Tox
	per cui la documentazione relativa e' reperibile nella scheda
	tecnica di tale crobot. Alcune modifiche alla funzione di fuoco
	originali sono state apportate per velocizzare ed alleggerire il
	codice e nel contempo migliorare leggermente la precisione.
*/

int ang, dir;

main()
{
	ang=11;
	drive(dir=180,100);
	while (loc_x() > 150) fuoco();
	drive(dir=270,0);
	while (speed() > 49) ;
	drive(dir,100);
	while (1)
	{
		while (loc_y() > 150)  {
			fuoco();
		}
		stop(0);
		while (loc_x() < 850) {
			fuoco();
		}
		stop(90);
		while (loc_y() < 850) {
			fuoco();
		}
		stop(180);
		while(loc_x() > 150)   {
			fuoco();
		}
		stop(270);
	}
}

int   oang,range,orange,aa,rr;

trova()
{
	if(scan(ang-5,1)) ang-=5;
	if(scan(ang+5,1)) ang+=5;
	if(scan(ang-3,1)) ang-=3;
	if(scan(ang+3,1)) ang+=3;
	if(scan(ang-1,1)) ang-=1;
	if(scan(ang+1,1)) ang+=1;
}

ricerca() {
	if(scan(ang-=10,10));
	else if(scan(ang+=20,10));
	else ang+=40;
}

fuoco() /* fuoco() - routine di gestione del cannone */        
{
	if(scan(ang,10))
	{
		trova();
		if (orange=scan(oang=ang,5))
		{
			trova();
			if (range=scan(ang,10))
			{
				aa=(ang+(ang-oang)*((1150+range)>>9)-(sin(ang-dir)>>14));
				rr=(range*183/(183+orange-range-(cos(ang-dir)>>12)));
				cannon(aa,rr);
				if (range>700) ang+=30;
			}
		}
		else ricerca();
	}
	else ricerca();
}

stop(deg) { /* Fermati ed imposta la direzione successiva */
	drive(dir=deg,0);
	while (speed() > 49) if (range=scan(dir,10) > 50)
		cannon(dir,9*range/10);
	drive(dir,100); /* Riparti */
}
