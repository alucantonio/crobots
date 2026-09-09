/********************************************************/
/* CROBOT: LosEndos.r                                   */
/* AUTORE: Bernardi Leonardo                            */
/********************************************************/



int ang;
int min,max;
int oldrange,old1;
int range;
int flag;
int oldang;
int displace;
int limmax;
int limmin;
int velmax;
int dir;
int cicli;
int oldamage;
int d;


main()

 {
   velmax = 90;
   limmax= 930;
   limmin = 70;

  /* inizializzazione */
  cicli=0;
  if (loc_x() > 500) dir = 180;
  d=0;
  oldamage=damage();

  /* si muove orizzontalmente fino a che non subisce danni eccessivi */
  while ((d / (++cicli)) <= 2)
   {
     drive(dir,100);
     if (!dir) 
      while ((loc_x() < 750) && (speed())) semplice2();
     else 
      while ((loc_x() > 250) && (speed())) semplice2();
     drive(dir,0);
     dir = (dir + 180) % 360;
     while (speed() > 40) semplice2();
     if (cicli % 7) {
	d=damage()-oldamage;
     }
     else {
      cicli=0;
      d=0;
      oldamage=damage();
     }
   }

  /* spostamento sul lato superiore */
  if (loc_y() < limmax)
   {
    drive(90,velmax);
    ang=0;
    min=0;
    max=359;
    while (speed() && (loc_y() < limmax))
     semplice();
    drive(90,0);
    while (speed() > 30);
   }

  
  while (1)
   {
       if (loc_x() < limmax)
	{

         /* si sposta verso angolo superiore destro e si ferma. Il controllo */
         /* passa alla routine 'stop' */
	 drive(0,velmax);
	 min=180;
	 max=360;
	 ang=min;
	 while (speed() && (loc_x() < limmax))
	  semplice();
	 drive(0,0);
	 stop(180);
	}

       /* continua nello spostamento in senso orari lungo il perimetro */
       if (loc_y() > limmin)
	{
         drive(270,velmax);
	 min=90;
	 max=270;
	 ang=min;
	 while (speed() && (loc_y() > limmin))
	  semplice();
	 drive(270,0);
	 stop(90);
	}

       if (loc_x() > limmin)
	{
	 drive(180,velmax);
	 min=0;
	 max=180;
	 ang=min;
	 while (speed() && (loc_x() > limmin))
	  semplice();
	 drive(180,0);
	 stop(0);
	}

       if (loc_y() < limmax)
	{
	 drive(90,velmax);
	 min=270;
	 max=450;
	 ang=min;
	 while (speed() && (loc_y() < limmax))
	  semplice();
	 drive(90,0);
	 while (speed() > 35);
	 stop(270);
	}
   }               
	 
  }


   stop(angle)
   int angle;

   /* routine per la gestione della strategia di fuoco con crobot fermo negli angoli */
   
    {
     int d;
     int i;

     /* fissa range angolare */
     ang=angle;
     min=angle;
     max=min+90;
     oldrange=350;
     i=1;
     oldamage=damage();
     /* ogni ciclo "i" = 100 cicli cpu circa */
     /* spara finchä non subisce ripetuti danni */
     while ((((damage()-oldamage)*10 / i) <= 2) || (++i < 30)) castiga();
    }


    castiga()

    {
	int rangecorr;
	int angcorr;

	if (((range=scan(min,6))) && (range < 850)) spara(min);
	else if (((range=scan(max,6))) && (range < 850))  spara(max);
	 else {
	  if ((range=scan(ang,5)) && (range < 850));
	   else if (((range=scan((ang -= 10),5))) && (range < 850));
	    else if (((range=scan((ang += 20),5))) && (range < 850));
	      else ang += 10;
	  if ((range < 850) && (range))
	   {
	    
	    displace=(ang-oldang);
	    rangecorr=range+flag*70*sqrt(cos(displace)*cos(displace))*(range-old1)/24/100000;
	    angcorr=ang+displace*flag;
	    if (rangecorr < 50) rangecorr = 50;
	    cannon (angcorr,rangecorr);
	    oldang=ang;
	    old1=range;
	    flag=1;
	   }
          /* 'flag' permette di non applicare i correttivi di mira basati */
          /* su range e direzione 'precedenti' nel caso in cui l'avversario */
          /* nel mirino ha una alta probabilitÖ di non essere quello inquadrato */
          /* in precedenza */
	  else flag=0;
	  if ((ang > max) || (ang < min)) ang=min;
	 }
    }

   semplice()
   /* routine di fuoco utilizzata dal crobot durante lo spostamento */
   /* perimetrale */

   {

    if (((range=scan(min,6))) && (range < 850)) semplice_sub(min);
    else if (((range=scan(max,6))) && (range < 850)) semplice_sub(max);
	 else if (((range=scan(ang,9))) && (range < 850)) semplice_sub(ang);
	      else if ((ang += 18) > max + 9) ang = min;
   }

  spara (minmax)
  int minmax;
  /* routine di fuoco utilizzata dal crobot durante le soste negli angoli */
  /* nel caso in cui l'avversario inquadrato si muova lungo il perimetro */

  {
     flag=0;
     if (range < 50) range = 50;
     cannon (minmax,range+range*(range-oldrange)/220+10);
     oldrange=range;
     oldang=minmax;
  }

semplice_sub(minmax)
int minmax;
 {
     if (range < 60) range = 60;
     cannon (minmax,range+range*(range-oldrange)/480);
     oldrange=range;
 }

semplice2()
/* routine di fuoco utilizzata durante lo spostamento orizzontale iniziale */
{
 if ((range=scan(ang,10)) && (range < 850)) spara2();
 else {
  if ((range=scan(ang += 340,10)) && (range < 850)) spara2();
  else {
   if ((range=scan(ang += 40,10)) && (range < 850)) spara2();
   else {
    if ((range=scan(ang += 300,10)) && (range < 850)) spara2();
    else {
      ang += 80;
      flag=0;
    }
   }
  }
 }
 ang %= 360;
}

spara2()
 {
  cannon(ang,range+flag*(range-oldrange));
  flag=1;
  oldrange=range;
 }
