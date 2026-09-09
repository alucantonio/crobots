/*
Nome del robot	: Carletto.r
Autore		: Alessandro Tassara

Il robot cerca di non farsi massacrare dai nemici descrivendo un quadrato nell' angolo scelto per defilarsi..
Quando subisce troppi danni cerca una nuova casetta e vi si trasferisce.
Tecnicamente e' una rielaborazione di Carlo99, senza le Toxiche e con la possibilita' di spaziare su tutti e4 gli angoli del' arena.
Il codice e' notevolmente piu' compatto.
								Dedicato a Z.
*/

int z,k,a,r,t,d,anni,last;

main()
{
	z=loc_y(k=loc_x()<500)<500;

	while (t=last=anni=10)
	{
		while(--t)					/*Percorre un quadrilatero in uno dei 4 angoli*/
		{
			if (d>damage()-26)
			{
				while(loc_y() <910-z*790) {fire(90);}
				while(loc_x() >880-k*790) {fire(180);}
				while(loc_y() >880-z*790) {fire(270);}
				while(loc_x() <910-k*790) {fire();}
			}
			else
			{
				if (scan(90+z*180,10))
				if (scan(k*180,10)); else k^=1;
				else  z^=1;
				d=damage();
			}
	                drive (0,0);
		}

		while ((anni+=20)<390) last+=(scan(anni,10)>0);

		while(last<12)					/*Attacco finale da Arale*/
		{
			if ((loc_y()<440)||(loc_y()>560))
			{
				fire(270-180*z);
			}
			else
			{
                                while (loc_x()>200) fire(180);
                                while (loc_x()<800) fire();
			}
		}
	}
}

fire(dir)							/*Questa e' piu' o meno comune*/
int dir;
{
	drive (dir,100);
	if((r=scan(a,10))&&(r<770)) cannon (a,2*scan(a,10)-r);
	else
		if(r=scan(a+=339,10)) cannon (a,r);
		else
			if(r=scan(a+=42,10)) cannon (a,r);
			else
                                return (a+=41);
}

