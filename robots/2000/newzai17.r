/*
Nome del robot  : AleZai17.r
Autore          : Alessandro Tassara

NewZai17 in realt… ha poche parentele con il mio vecchio robottino:
innanzitutto all'inizio della partita, raggiunto l'angolo piu' vicino, conta
i nemici, e se ne ha solo uno attacca.
Inoltre non sta mai fermo, dal momento che tale comportamento mi pare poco
raccomandabile in un universo dove tutti stanno cercando di farti la pelle.
Oscilla alternativamente in direzione di un nemico o brevemente lungo la
diagonale (in stile dav46).
L'unica particolarita' e' rappresentata dall'ampiezza dell'oscillazione, che
viene calcolata al volo in modo di non arrivare mai a meno di 600 metri dal
nemico.
Se comunque lo infastidiscono troppo salta sulla sua Peugeot106 (che per motivi
di budget ancora non ha potuto cambiare, nonostante ormai mostri tutti i suoi
anni) e scappa in un altro angolo.
La routine finale e' il robot Satana di Dario Serino.
Immagino che quest'anno le scuole di pensiero saranno due:
- Satana like
- Anti Satana.
Dal momento che non sono riuscito nella seconda mi accontento della prima.

Quest'anno l'efficienza dei miei robottini e' veramente scandalosa, ragion per
cui non dovrei fare dediche, tuttavia.....
                                          ......................Dedicato a Z.
*/

int oang,ndist,vdist,min;
int ang,dir,curx,cury,dan,anni,last,flag4;
int normal,rng,orng;
int l,noia,str,a,oa,vista, clock;

main()
  {
	min=4000;				/*distanza minima del bordo*/
	last=curx=(1000*(loc_x()>500));
	cury=loc_y();				/*calcola posizione*/
	dir=180*(curx<loc_x());			/*e direzione per arrivare a destinazione*/
        Peugeot();
        stop();
        curx=loc_x();
	cury=(1000*(loc_y()>500));
	dir=90+180*(cury<loc_y());
        Peugeot();
        stop();
	curx=last;
/*        anni=20;
        Vai();
  */      while(1)                                /*inizia il loop, nel quale, con una routine copiata da goblin, calcola l' angolo*/
	  {
                if (loc_x()<500) if (loc_y()<500) dir=90; else dir=0;
                            else if (loc_y()<500) dir=180; else dir=270;
                str=dir;
                if (++noia<12)
                {
                        dir+=315;
                        while (Loin(curx,cury)<12000) {drive (dir,100);fire(1);}
                        dir=(360+((curx-loc_x())<0)*180+atan(((cury-loc_y())*100000)/(curx-loc_x())));
                }
                else
                {
                        if ((scan(dir,10))<scan(dir+270,10)) dir+=270;
                        l=scan(dir,10)-700;
                        if ((l*=l)>45000) l=45000;
                        if (l<12000) l=12000;
                        while (Loin(curx,cury)<l) {drive (dir,100);fire(1);}
                        dir+=180;
                }
                if (noia>20) noia=0;
                while (speed()>49) drive (dir,0);
                min=11000;
                Peugeot();
                drive (dir,0);
                min=4000;
                if (noia==11) while (Loin(curx,cury)>5000) drive(dir,40);
                dir=str;
		Vai();
	  }
  }

Vai()
{
   if (((++anni)>20)&&(damage()<90))		/*controlla se per caso e' rimasto un solo superstite e in quel caso attacca*/
   {
           stop();
           anni=10;
           last=0;
           while ((anni+=20)<750) last+=(scan(anni,10)>0);
           if (last<3)                            
                   mainsat();
           anni=0;
   }

   if((dan<damage()-24)||((vdist)&&(vdist<500)))
   {
	if (Scan(dir))				/*controlla se l' angolo precedente e' libero*/
	{
                Viaggia();
	}
	else if ((Scan(dir+270)))		/*controlla se l' angolo seguente e' libero*/
		{
			dir+=270;
                        Viaggia();
		}
		else if (Scan(dir+315))		/*controlla se l' angolo opposto e' libero*/
			{
				dir+=315;
                                Viaggia();
			}
        dan=damage();
    }
}

Viaggia()
  {
	if (sin(dir)) cury=1000-cury;		/*calcola le nuove coordinate delle destinazioni*/
	if (cos(dir)) curx=1000-curx;
        Peugeot();                             /*va a destinazione*/
        stop();
  }      

Peugeot()  /*Si sposta verso le coordinate date*/
  {
	drive(dir,100);
	while((Loin(curx,cury)>27000)&&(speed()))
		fire(1);			/*quando e' lontano dai bordi usa le routine di Jedi*/
	drive(dir,80);
	while((Loin(curx,cury)>min)&&(speed()))
		fire2();			/*quando e' vicino ai bordi usa le routine di Drago6*/
  }

/* Utilities per raccogliere il codice */

Scan(i)
int i;
{
    return ((scan(i+350,10)+scan(i+10,10))<400);   /*effettua una scansione allargata di 14 gradi*/
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

mainsat() {

  while(normal=3) {
    if (dir==270)     while(focus(loc_y()<275));
    else if (dir==90) while(focus(loc_y()>725));
    else if (dir)     while(focus(loc_x()<275));
    else              while(focus(loc_x()>725));

    if (normal) drive((dir+180)%=360,50);
    else        drive(dir=(( ((a+180)/90) + (clock^=1) )*90)%360,50);

    while (speed()>50)
         Dove();

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
