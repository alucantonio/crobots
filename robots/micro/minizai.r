/*
Nome del robot	: MiniZai.r
Autore		: Alessandro Tassara

Il robot cerca di non farsi massacrare dai nemici standosene buono buono in un angolo.
Se lo infastidiscono salta sulla sua Peugeot106 e scappa in un altro angolo.
Tecnicamente e' una rielaborazione di AleZai17, senza le Toxiche.
Il codice e' notevolmente piu' compatto.
								Dedicato a Z.
*/

int z,vdist;
int ang,dir,dor,dan,anni,last,flag4;

main()
  {
	Peugeot(180*(loc_x(anni=2000)<500));
	Peugeot(90+180*(loc_y()<500));
	while(--anni)							/*inizia il loop, nel quale, con una routine copiata da goblin, calcola l' angolo*/
	  {
		fire();
		if(dan<damage())
		{
			if (Scan(dor=180*(loc_x(dan=damage())>500)))	/*controlla se l' angolo precedente e' libero*/
			{
				Peugeot(dor);
			}
			else if ((Scan(dor=90+180*(loc_y()>500))))		/*controlla se l' angolo seguente e' libero*/
			{
				Peugeot(dor);
			}
		}
	  }
	Peugeot(90+180*(loc_y(z=450)>500));
	while (1)
	{
		Peugeot(180*(loc_x()>500));
	}
  }

Peugeot(k)  /*Si sposta verso le coordinate date*/
int k;
  {
	if ((dir=k)>180)
		while (loc_y()>100+z) fire(100);
	else if (dir>90)
		while (loc_x()>100) fire(100);
	else if (dir>0)
		while (loc_y()<900-z) fire(100);
                   else
		while (loc_x()<900) fire(100);
  }

/* Utilities per raccogliere il codice */

Scan(y)
int y;
  {
	return ((scan(y+353,7)+scan(y+7,7))<400);			/*effettua una scansione allargata di 14 gradi*/
  }


fire(vel)
int vel;
  {
	drive(dir,vel);
	if((vdist=scan(ang,10))&&(vdist<770))
		cannon(ang+=10*(scan(ang+5,10)>0)+355,2*scan(ang,10)-vdist);
	else
	  if(scan(ang+=340,10));
	  else
		if(scan(ang+=40,10));
		else
			return (ang+=40);
  }

