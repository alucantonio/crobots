/*
Nome del robot  : AleZai17.r
Autore          : Alessandro Tassara

Il robot cerca di non farsi massacrare dai nemici standosene buono buono in un angolo.
Se lo infastidiscono salta sulla sua Peugeot106 e scappa in un altro angolo.
Tecnicamente e' un mosaico di robot, con pezzi prelevati a destra e a manca.
Il comportamento e' simile a quello di Goblin, vincitore dell' anno scorso.
I cambiamenti riguardano:
- lo spostamento d' angolo, che ora avviene anche lungo la diagonale
- la routine finale, che e' stata ispirata da Arale

Ovviamente il codice e' completamente diverso.

Ringrazio Simone Ascheri per avermi rotto le scatole due mesi per spingermi a
partecipare.
								Dedicato a Z.
*/

int oang,ndist,vdist,min;
int ang,dir,curx,cury,dan,anni,last,flag4;

main()
  {
	min=4000;				/*distanza minima del bordo*/
	last=curx=(1000*(loc_x()>500));
	cury=loc_y();				/*calcola posizione*/
	dir=180*(curx<loc_x());			/*e direzione per arrivare a destinazione*/
        Peugeot();
	curx=loc_x();
	cury=(1000*(loc_y()>500));
	dir=90+180*(cury<loc_y());
        Peugeot();
	curx=last;
	while(1)				/*inizia il loop, nel quale, con una routine copiata da goblin, calcola l' angolo*/
	  {
		if (loc_x()<500) if (loc_y()<500) dir=90; else dir=0;
				else if (loc_y()<500) dir=180; else dir=270;
		Vai();
		fire(0);
	  }
  }

Vai()
{
   if (((++anni)>20)&&(damage()<90))		/*controlla se per caso e' rimasto un solo superstite e in quel caso attacca*/
   {
     anni=10;
     last=0;
     while ((anni+=20)<390) last+=(scan(anni,10)>0);
     if (last==1)				/*surf nel mezzo dell' arena*/
	{
        	dir=90+180*(cury>500);
		cury=500;
                Peugeot();
		min=20000;
	}
     while (last==1)
           {
		dir=180*(curx>500);
		Viaggia();
           }
     anni=0;
   }
	if (Scan(dir))				/*controlla se l' angolo precedente e' libero*/
	{
		if((dan<damage()-4)||((vdist)&&(vdist<500))) Viaggia();
	}
	else if ((Scan(dir+270)))		/*controlla se l' angolo seguente e' libero*/
		{
			dir+=270;
			if ((dan<damage()-4)||((vdist)&&(vdist<500))) Viaggia();
		}
		else if (Scan(dir+315))		/*controlla se l' angolo opposto e' libero*/
			{
				dir+=315;
				if ((dan<damage()-4)||((vdist)&&(vdist<500))) Viaggia();
			}
}

Viaggia()
  {
	if (sin(dir)) cury=1000-cury;		/*calcola le nuove coordinate delle destinazioni*/
	if (cos(dir)) curx=1000-curx;
        Peugeot();                             /*va a destinazione*/
	dan=damage();
  }

Peugeot()  /*Si sposta verso le coordinate date*/
  {
	drive(dir,100);
	while((Loin(curx,cury)>27000)&&(speed()))
		fire(1);			/*quando e' lontano dai bordi usa le routine di Jedi*/
	drive(dir,80);
	while((Loin(curx,cury)>min)&&(speed()))
		fire2();			/*quando e' vicino ai bordi usa le routine di Drago6*/
	stop();
  }

/* Utilities per raccogliere il codice */

Scan(i)
int i;
{
    return ((scan(i+353,7)+scan(i+7,7))<400);	/*effettua una scansione allargata di 14 gradi*/
}


Loin(nx,ny) /*da Son-Goku (ciao Simo)*/
int nx, ny;
  {
	return (((nx-=loc_x())*nx+(ny-=loc_y())*ny));
  }

stop()  /*da Arale*/
  {
	drive(dir,0);
	while(speed() > 49)
		if ((ndist=scan(ang,10))&&(ndist<770)) cannon(ang,ndist);
		else Dove();
  }

/* Le routines d'attacco */

fire(si)    /* fire() - routine di sparo in movimento - generoso lascito di nonno Jedi */
int si;
  {
	if(vdist=scan(ang,10))
	  {
		if (vdist>700)
			return fire2();

                if (!scan(ang-=5,10)) ang+=10;

		if(scan(ang+354,1)) ang+=354;	/*tranne questo che viene da Coppi*/
		if(scan(ang+6,  1)) ang+=6;
		if(scan(ang+356,1)) ang+=356;
		if(scan(ang+4,  1)) ang+=4;
		if(scan(ang+358,1)) ang+=358;
		if(scan(ang+2,  1)) ang+=2;

		if (vdist=scan(oang=ang,5))
                  {
			if(scan(ang+354,1)) ang+=354;
			if(scan(ang+6,  1)) ang+=6;
			if(scan(ang+356,1)) ang+=356;
			if(scan(ang+4,  1)) ang+=4;
			if(scan(ang+358,1)) ang+=358;
			if(scan(ang+2,  1)) ang+=2;

			if (ndist=scan(ang,10))
			{
                                cannon((ang+(ang-oang)*((1200+ndist)>>9)-(si)*(sin(ang-dir)>>14)),(ndist*160/(160+vdist-ndist-(si)*(cos(ang-dir)>>12))));
			}
		   }
		else fire2();
		}
       else Dove();
  }

fire2() /*da Drago6*/
  {
	if((vdist=scan(ang,10))&&(vdist<770))
	  {
		if (!scan(ang+=355,5)) ang+=10;
		if (!scan(ang+=357,3)) ang+=6;
		cannon(ang,3*scan(ang,10)-2*vdist);
	  }
	else
	  if((ndist=scan(ang+=340,10)))
		cannon(ang,ndist);
	  else
		if((ndist=scan(ang+=40,10)))
			cannon(ang,ndist);
		else
			if((ndist=scan(ang+=300,10)))
				cannon(ang,ndist);
			else
				if((ndist=scan(ang+=80,10)))
					cannon(ang,ndist);
				else
					return (ang+=40);
  }

Dove() /*da Coppi, ma almeno qui c' e' del mio*/
{
    if((ndist=scan(ang+339,10))) cannon (ang+=339,ndist);
    else if((ndist=scan(ang+21,10))) cannon (ang+=21,ndist);
    else if (ndist=scan(dir,10))
           cannon (ang=dir,scan(ang,10));
    else return(ang+=40);
}

