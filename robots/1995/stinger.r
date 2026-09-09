
/* 
  
   CROBOT:  Stinger.r 
   
   AUTORE:  Guido Masotti

		    
			  SCHEDA TECNICA

   Il Robot si puo' comportare in diversi modi a seconda 
   dell' ammontare dei danni subiti: fintanto che essi sono
   inferiori al 72%, il robot cerca di stare fermo il piu'
   possibile in un angolo del campo di gioco. Quando viene
   colpito si sposta lungo un lato del campo e se
   durante tale spostamento subisce ulteriori danni conti-
   nua a muoversi, eventualmente cambiando lato se tale dan- 
   neggiamento e' troppo consistente (il lato su cui si e'
   spostato "scottava"...). Se rimane fermo in un angolo
   per un certo periodo senza venire colpito, esegue una ri-
   cerca nell'area di gioco per contare quanti avversari so-
   no rimasti (la esegue piu' volte per evitare errori dovu-
   ti alla presenza di piu' robot nella direzione di scan):
   se ne trova solo uno verifica il proprio stato di salute e
   se e' il caso (danni<50%) lo attacca.
   Se i danni subiti superano il 72%, Stinger comincia ad
   oscillare lungo il lato su cui si trova cercando di rende-
   re difficile la sua individuazione.
   Per colpire gli avversari Stinger utilizza tre routine (una 
   quando e' fermo, una quando si muove lungo un lato e una
   per il testa a testa finale contro un solo robot) cercando
   di fare delle correzioni sull'angolo e sul range di tiro.
   Purtroppo non ho avuto tempo per fare delle routine piu'
   efficienti e quindi il programma non dovrebbe essere molto
   competitivo, ma l'importante era partecipare.

   Nel caso non fosse possibile far competere entrambi i miei 
   robot, vorrei far giocare Archer.r

*/
   

int r1,dir,NR,NC,t;
int ang,d,corner,newdam=0,range,lato,lat90,olddam,dang,ang1,ang2,rangef,angf;

main()
{
  /*  Stinger si dirige nell'angolo in basso a destra */
  ang=170;
  drive(270,100);
  while (loc_y()>=60);
  drive(270,0);
  lat90=0;
  lato=0;
  corner=0;
  race();
  d=damage();
  ang=94;

  while (d<72)
  {
      if (scan(ang,5))
      {
	  if ((newdam=aim_at())!=d)   /* Spara da fermo */
	  {
	    olddam=d;                 /* Se viene colpito si muove */
	    race();
	    if (d>olddam+8)
	    {
	      test();
	      if ((d-newdam)>4)
		race();
	    }
	    ang=4+90*corner+lat90;
	  }
	  else
	    t+=1;
      }
      else
      {
	ang+=10;
	if ((newdam=damage())!=d)     /* Se viene colpito si muove */
	{
	  olddam=d; 
	  race();
	  if (d>olddam+8)
	  {
	    test(); 
	    if ((d-newdam)>4) 
	      race();
	  }
	  ang=4+90*corner+lat90;
	}
	else t+=1;
      }
      if (t>72)                       /* E' fermo da molto... */
      {
	if ( check() && (d<50))       /* Conta gli avversari  */
	{
	  NC+=1;
	  if (NC==4)
	  {
	    ang=angf;
	    toend();                  /* Fino alla fine... */
	  }
	}
	else
	  NC=0;
	NR=0;
      }
      if (ang>90*(corner+1)+lat90+4) ang=4+90*corner+lat90;
  }

  while (1)                           /* Si muove di continuo */
  {
    race();
  }
}

/*
 *  Routne di movimento su un lato.
 */

race()
{
  t=0;
  dir=lat90+180*corner;
  if (corner==0)
  {
    ang=4+lat90; 
    drive(dir,100);
    if (lato==0)
    {
      while (loc_x()<900)
	gunfire();
    }
    else
      if (lato==1)
      {
	while (loc_y()<900)
	  gunfire();
      }
      else
	if (lato==2)
	{  
	  while (loc_x()>100)
	    gunfire();
	}
	else
	{  
	  while (loc_y()>100)
	    gunfire();
	}
    drive(0,0);
    while (speed()>49);
    corner=1;
  }
  else
  {
    ang=176+lat90;
    drive(dir,100);
    if (lato==0)
    {
      while (loc_x()>100)
	gunfire();
    }
    else
      if (lato==1)
      {
	while (loc_y()>100)
	  gunfire();
      }
      else
	if (lato==2)
	{  
	  while (loc_x()<900)
	    gunfire();
	}
	else
	{  
	  while (loc_y()<900)
	    gunfire();
	}
    drive(180,0);
    while (speed()>49);
    corner=0;
  }  
  d=damage();   
}

/*
 * Routine di sparo da fermo
 */

int aim_at()
{
    if ( ((newdam=damage())==d)  )
    {
      if (getpos())
      {
	ang1=ang;
	r1=range;
      }
      if ((newdam=damage())!=d)
	return newdam;
    }
    else 
      return newdam;
  
    if (r1<700)
    {
      if (getpos())
      {
	angf=ang+(ang-ang1)*18/10;
	cannon(angf,range+(range-r1)*18/10);
	ang=angf;
      }
      else
	ang+=8;
      newdam=damage();
    }
    else
      ang+=8; 
  return newdam;
}

/*
 * Routine di definizione della posizione dell'avversario
 */

getpos()
{
   if ( scan(ang+3,2) )
      if ( scan(ang+4,1) ) 
	 { 
	 if ( scan(ang+3,0) ) 
	    ang+=3; 
	 else   
	    ang+=4;
	 }
      else
	 if ( scan(ang+2,0) )
	    ang+=2; 
	 else
	    ang+=1; 
   else
      if ( scan(ang-4,2) )
	 if ( scan(ang-2,1) ) 
	    ang-=2;
	 else
	    ang-=3;        
      else
	 if ( scan(ang-1,0) )
	    ang-=1;
	 else
	    ang-=0;           

   if (range=scan(ang,5))
     return 1;
   else return 0;
}

/*
 * Routine di sparo in movimento.
 */

gunfire()
{
   if (scan(ang,5))
   {
     if (getpos())
     {
       ang1=ang;
       r1=range;
       if (getpos())
       {
	 dang=ang-ang1;
	 rangef=range+(range-r1)*range/300;
	 angf=ang+dang*range/180;
	 cannon(angf,rangef); 
	 if (rangef<700) 
	   ang=angf; 
	 else 
	   ang+=8-corner*16;
       }
     }
   }
   else
   {
     ang+=10-corner*20;
     if (ang<lat90) 
       ang=176+lat90;
     else
       if (ang>180+lat90) 
	 ang=4+lat90;
   }
   if (speed()<50) drive(dir,100);
}

/*
 * Routine di gioco uno contro uno.
 */

toend()
{
  while(1) 
  {
     while (scan(ang,10) > 0) 
     {
	range=scan(ang,10);
	drive(ang,100);
	if (range>10) cannon(ang,range);
    }
    ang += 19;
    if (speed()<6) 
    { 
      ang-=40;
      while(!scan(ang,10)) ang+=20;
      drive(ang,49);
    }
  }
}

/*
 * Routine di conteggio degli avversari.
 */

check()
{
  ang1=4+90*corner+lat90;
  ang2=ang1+90;
  while(ang1<ang2) 
  {
     if (scan(ang1,10))
     {
	NR+=1;
	angf=ang1;
     }
     ang1+=19;
  }
  t=0;
  if(NR<2) 
    return 1;
  return 0;
}

/*
 * Routine di definizione del lato su cui spostarsi. 
 */

test()
{
  if (corner)
  {
    lato=(lato+1)%4; 
    corner=0;
  }
  else
  {
    lato=(lato+3)%4;
    corner=1;
  }
  lat90=90*lato;
}

/* End of Stinger */
